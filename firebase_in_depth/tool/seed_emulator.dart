import 'dart:convert';
import 'dart:io';

/// Upserts the course catalog into the local Firestore emulator.
/// Auth users come from gitignored `tool/emulator-users.local.tsv` when present.
/// Firestore writes bypass rules with the emulator `owner` token.
/// Auth users exist only in the Auth emulator (UI: http://127.0.0.1:4000/auth),
/// not in the cloud Firebase Console.
const _project = 'fir-in-depth-813e4';
const _base =
    'http://127.0.0.1:8080/v1/projects/$_project/databases/(default)/documents';
const _authBase = 'http://127.0.0.1:9099/identitytoolkit.googleapis.com/v1';
const _authKey = 'fake-api-key';

final _tutor = _map({
  'name': _str('Noir'),
  'employedSince': _arr([_int(2020), _int(4), _int(1)]),
});

void main() async {
  final client = HttpClient();
  try {
    final accounts = _loadAccounts();
    for (final account in accounts) {
      final uid = await _ensureAuthUser(client, account);
      await _patch(client, 'users/$uid', {
        'fields': {'email': _str(account.email), 'role': _str(account.role)},
      });
      stdout.writeln(
        'user ${account.email} ($uid) ${account.role} ${account.provider}',
      );
    }
    for (final course in _courses) {
      await _patch(client, 'courses/${course.id}', {
        'fields': _courseFields(course),
      });
      stdout.writeln('course ${course.id}');
      if (course.lessons.isEmpty) continue;
      for (final lesson in course.lessons) {
        await _patch(client, 'courses/${course.id}/lessons/${lesson.id}', {
          'fields': {
            'description': _str(lesson.description),
            'duration': _str(lesson.duration),
            'seqNo': _int(lesson.seqNo),
          },
        });
      }
      stdout.writeln('  ${course.lessons.length} lessons');
    }
  } finally {
    client.close(force: true);
  }
}

Future<void> _patch(
  HttpClient client,
  String path,
  Map<String, Object?> body,
) async {
  final request = await client.patchUrl(Uri.parse('$_base/$path'));
  request.headers.set(HttpHeaders.authorizationHeader, 'Bearer owner');
  request.headers.contentType = ContentType.json;
  request.write(jsonEncode(body));
  final response = await request.close();
  final text = await response.transform(utf8.decoder).join();
  if (response.statusCode >= 400) {
    throw StateError('${response.statusCode} $path $text');
  }
}

Future<String> _ensureAuthUser(HttpClient client, _AuthSeed account) async {
  if (account.password != null) {
    return _ensurePasswordUser(
      client,
      email: account.email,
      password: account.password!,
    );
  }
  return _ensureGoogleUser(client, email: account.email);
}

Future<String> _ensurePasswordUser(
  HttpClient client, {
  required String email,
  required String password,
}) async {
  final signUp = await _authPost(client, 'accounts:signUp', {
    'email': email,
    'password': password,
    'returnSecureToken': true,
  });
  if (signUp.statusCode < 400) {
    return _localId(signUp.body);
  }
  if (signUp.body.contains('EMAIL_EXISTS')) {
    final signIn = await _authPost(client, 'accounts:signInWithPassword', {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    });
    if (signIn.statusCode >= 400) {
      throw StateError('auth sign-in ${signIn.statusCode} ${signIn.body}');
    }
    return _localId(signIn.body);
  }
  throw StateError('auth sign-up ${signUp.statusCode} ${signUp.body}');
}

/// Auth emulator accepts a JSON claims blob as a fake Google ID token.
/// Same `sub` + email always maps to the same emulator user.
Future<String> _ensureGoogleUser(
  HttpClient client, {
  required String email,
}) async {
  final claims = jsonEncode({
    'sub': 'google-$email',
    'email': email,
    'email_verified': true,
    'name': email,
  });
  final signIn = await _authPost(client, 'accounts:signInWithIdp', {
    'requestUri': 'http://localhost',
    'postBody':
        'id_token=${Uri.encodeQueryComponent(claims)}&providerId=google.com',
    'returnIdpCredential': true,
    'returnSecureToken': true,
  });
  if (signIn.statusCode >= 400) {
    throw StateError('auth google ${signIn.statusCode} ${signIn.body}');
  }
  return _localId(signIn.body);
}

Future<({int statusCode, String body})> _authPost(
  HttpClient client,
  String path,
  Map<String, Object?> body,
) async {
  final uri = Uri.parse(
    '$_authBase/$path',
  ).replace(queryParameters: {'key': _authKey});
  final request = await client.postUrl(uri);
  request.headers.contentType = ContentType.json;
  request.write(jsonEncode(body));
  final response = await request.close();
  final text = await response.transform(utf8.decoder).join();
  return (statusCode: response.statusCode, body: text);
}

String _localId(String body) {
  final json = jsonDecode(body) as Map<String, dynamic>;
  return json['localId'] as String;
}

class _AuthSeed {
  const _AuthSeed({
    required this.email,
    required this.role,
    required this.provider,
    this.password,
  });

  final String email;
  final String? password;
  final String role;
  final String provider;
}

const _usersPath = 'tool/emulator-users.local.tsv';

List<_AuthSeed> _loadAccounts() {
  final file = File(_usersPath);
  if (!file.existsSync()) {
    stdout.writeln(
      'No $_usersPath — skip Auth seed. Copy '
      'tool/emulator-users.example.tsv to $_usersPath and fill the password column.',
    );
    return const [];
  }

  final lines = file
      .readAsLinesSync()
      .map((line) => line.trim())
      .where((line) => line.isNotEmpty && !line.startsWith('#'))
      .toList();
  if (lines.isEmpty) return const [];

  final header = lines.first.split('\t');
  if (header.length < 4 ||
      header[0] != 'email' ||
      header[1] != 'password' ||
      header[2] != 'role' ||
      header[3] != 'provider') {
    throw StateError(
      '$_usersPath must start with: email\\tpassword\\trole\\tprovider',
    );
  }

  return [for (final line in lines.skip(1)) _accountFromRow(line.split('\t'))];
}

_AuthSeed _accountFromRow(List<String> cells) {
  if (cells.length < 4) {
    throw StateError('$_usersPath row needs email, password, role, provider');
  }
  final email = cells[0].trim();
  final password = cells[1].trim();
  final role = cells[2].trim();
  final provider = cells[3].trim();
  if (email.isEmpty || role.isEmpty) {
    throw StateError('$_usersPath row needs email and role');
  }
  if (provider == 'google') {
    return _AuthSeed(email: email, role: role, provider: provider);
  }
  if (provider != 'password') {
    throw StateError('$_usersPath unknown provider "$provider"');
  }
  if (password.isEmpty) {
    throw StateError('$_usersPath: fill password for $email');
  }
  return _AuthSeed(
    email: email,
    password: password,
    role: role,
    provider: provider,
  );
}

Map<String, Object?> _courseFields(_CourseSeed course) {
  return {
    'description': _str(course.description),
    'longDescription': _str(course.longDescription),
    'url': _str(course.url),
    'seqNo': _int(course.seqNo),
    'lessonsCount': _int(course.lessonsCount),
    'price': _int(course.price),
    'categories': _arr([_str(course.category)]),
    'icon': _str(course.icon),
    'participants': _int(0),
    'tutor': _tutor,
  };
}

Map<String, Object> _str(String value) => {'stringValue': value};
Map<String, Object> _int(int value) => {'integerValue': '$value'};
Map<String, Object> _arr(List<Object> values) => {
  'arrayValue': {'values': values},
};
Map<String, Object> _map(Map<String, Object> fields) => {
  'mapValue': {'fields': fields},
};

class _LessonSeed {
  const _LessonSeed({
    required this.id,
    required this.description,
    required this.duration,
    required this.seqNo,
  });

  final String id;
  final String description;
  final String duration;
  final int seqNo;
}

class _CourseSeed {
  const _CourseSeed({
    required this.id,
    required this.description,
    required this.longDescription,
    required this.url,
    required this.seqNo,
    required this.lessonsCount,
    required this.price,
    required this.category,
    required this.icon,
    this.lessons = const [],
  });

  final String id;
  final String description;
  final String longDescription;
  final String url;
  final int seqNo;
  final int lessonsCount;
  final int price;
  final String category;
  final String icon;
  final List<_LessonSeed> lessons;
}

const _courses = [
  _CourseSeed(
    id: 'hiragana-from-zero',
    description: 'Hiragana from Zero',
    longDescription: 'Learn the 46 hiragana.',
    url: 'hiragana-from-zero',
    seqNo: 1,
    lessonsCount: 3,
    price: 29,
    category: 'BEGINNER',
    icon: 'purple',
    lessons: [
      _LessonSeed(
        id: 'vowels',
        description: 'Vowels',
        duration: '06:05',
        seqNo: 1,
      ),
      _LessonSeed(
        id: 'k-row',
        description: 'The k-row',
        duration: '07:40',
        seqNo: 2,
      ),
      _LessonSeed(
        id: 'dakuten',
        description: 'Dakuten',
        duration: '05:20',
        seqNo: 3,
      ),
    ],
  ),
  _CourseSeed(
    id: 'katakana-bootcamp',
    description: 'Katakana Bootcamp',
    longDescription: 'Loanwords, signs, and the second kana chart.',
    url: 'katakana-bootcamp',
    seqNo: 2,
    lessonsCount: 10,
    price: 29,
    category: 'BEGINNER',
    icon: 'turquoise',
  ),
  _CourseSeed(
    id: 'kanji-with-the-dragon',
    description: 'Kanji with the Dragon',
    longDescription: 'Radicals first, then the kanji that show up everywhere.',
    url: 'kanji-with-the-dragon',
    seqNo: 3,
    lessonsCount: 3,
    price: 35,
    category: 'BEGINNER',
    icon: 'green',
    lessons: [
      _LessonSeed(
        id: 'radicals-first',
        description: 'Radicals first',
        duration: '08:10',
        seqNo: 1,
      ),
      _LessonSeed(
        id: 'numbers-1-10',
        description: 'Numbers 1–10',
        duration: '06:30',
        seqNo: 2,
      ),
      _LessonSeed(
        id: 'day-and-sun',
        description: 'Day and sun',
        duration: '07:00',
        seqNo: 3,
      ),
    ],
  ),
  _CourseSeed(
    id: 'wa-vs-ga',
    description: 'は vs が (and friends)',
    longDescription: 'The particles that make or break a beginner sentence.',
    url: 'wa-vs-ga',
    seqNo: 4,
    lessonsCount: 12,
    price: 29,
    category: 'BEGINNER',
    icon: 'light_purple',
  ),
  _CourseSeed(
    id: 'konbini-survival',
    description: 'Konbini Survival',
    longDescription: 'Ordering, paying, and the phrases on every fridge door.',
    url: 'konbini-survival',
    seqNo: 5,
    lessonsCount: 8,
    price: 39,
    category: 'BEGINNER',
    icon: 'green',
  ),
  _CourseSeed(
    id: 'keigo-without-panic',
    description: 'Keigo without panic',
    longDescription: 'Honorifics for work, without the textbook spiral.',
    url: 'keigo-without-panic',
    seqNo: 6,
    lessonsCount: 3,
    price: 49,
    category: 'INTERMEDIATE',
    icon: 'purple',
    lessons: [
      _LessonSeed(
        id: 'desu-masu',
        description: 'Desu and masu',
        duration: '06:15',
        seqNo: 1,
      ),
      _LessonSeed(
        id: 'sonkeigo',
        description: 'Sonkeigo',
        duration: '08:00',
        seqNo: 2,
      ),
      _LessonSeed(
        id: 'kenjougo',
        description: 'Kenjougo',
        duration: '07:45',
        seqNo: 3,
      ),
    ],
  ),
  _CourseSeed(
    id: 'one-fish-two-fish',
    description: 'One fish, two fish, 三匹',
    longDescription: 'Counters, and the days you still count on your fingers.',
    url: 'one-fish-two-fish',
    seqNo: 7,
    lessonsCount: 9,
    price: 45,
    category: 'INTERMEDIATE',
    icon: 'turquoise',
  ),
  _CourseSeed(
    id: 'dokidoki-japanese',
    description: 'ドキドキ Japanese',
    longDescription: 'Onomatopoeia that textbooks mention once and drop.',
    url: 'dokidoki-japanese',
    seqNo: 8,
    lessonsCount: 11,
    price: 49,
    category: 'INTERMEDIATE',
    icon: 'light_purple',
  ),
  _CourseSeed(
    id: 'newspaper-japanese',
    description: 'Newspaper Japanese',
    longDescription: 'Headlines, keigo in print, and the grammar papers skip.',
    url: 'newspaper-japanese',
    seqNo: 9,
    lessonsCount: 3,
    price: 59,
    category: 'EXPERTS',
    icon: 'turquoise',
    lessons: [
      _LessonSeed(
        id: 'headlines-first',
        description: 'Headlines first',
        duration: '07:20',
        seqNo: 1,
      ),
      _LessonSeed(
        id: 'the-grammar-papers-skip',
        description: 'The grammar papers skip',
        duration: '08:45',
        seqNo: 2,
      ),
      _LessonSeed(
        id: 'reading-a-column',
        description: 'Reading a column',
        duration: '09:10',
        seqNo: 3,
      ),
    ],
  ),
  _CourseSeed(
    id: 'bungo-for-modern-readers',
    description: 'Bungo for modern readers',
    longDescription:
        'Classical grammar that still shows up in novels, lyrics, and exams.',
    url: 'bungo-for-modern-readers',
    seqNo: 10,
    lessonsCount: 6,
    price: 69,
    category: 'EXPERTS',
    icon: 'green',
  ),
  _CourseSeed(
    id: 'n1-listening-lab',
    description: 'N1 Listening Lab',
    longDescription:
        'Fast speech, overlapping talk, and news you cannot pause.',
    url: 'n1-listening-lab',
    seqNo: 11,
    lessonsCount: 8,
    price: 79,
    category: 'EXPERTS',
    icon: 'purple',
  ),
];

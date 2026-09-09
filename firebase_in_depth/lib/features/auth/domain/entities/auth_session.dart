enum AuthRole { student, tutor }

class AuthSession {
  const AuthSession({
    required this.uid,
    required this.email,
    this.role = AuthRole.student,
  });

  final String uid;
  final String email;
  final AuthRole role;

  String get initials {
    final local = email.split('@').first.trim();
    if (local.isEmpty) return '?';
    return local[0].toUpperCase();
  }
}

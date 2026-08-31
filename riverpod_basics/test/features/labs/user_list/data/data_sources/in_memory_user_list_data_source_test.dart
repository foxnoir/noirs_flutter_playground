import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_basics/features/labs/user_list/data/data_sources/in_memory_user_list_data_source.dart';

void main() {
  test('fetchUsers returns JSON models, not entities', () async {
    const source = InMemoryUserListDataSource(delay: Duration.zero);

    final models = await source.fetchUsers();

    expect(models, hasLength(2));
    expect(models.first.username, 'Grace');
    expect(models.last.id, 11);
  });
}

import 'package:riverpod_basics/features/labs/user_list/data/data_sources/in_memory_user_data_source.dart';
import 'package:riverpod_basics/features/labs/user_list/data/models/user_model.dart';

class FakeUserDataSource implements UserDataSource {
  const FakeUserDataSource({this.models = const [], this.error});

  final List<UserModel> models;
  final Exception? error;

  @override
  Future<List<UserModel>> fetchUsers() async {
    final thrown = error;
    if (thrown != null) {
      throw thrown;
    }
    return models;
  }
}

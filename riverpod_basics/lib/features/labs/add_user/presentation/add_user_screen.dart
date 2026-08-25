import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basics/features/labs/add_user/domain/entities/user.dart';
import 'package:riverpod_basics/features/labs/add_user/presentation/providers/add_user_provider.dart';
import 'package:riverpod_basics/l10n/app_localizations.dart';
import 'package:riverpod_basics/shared_widgets/full_width_elevated_button.dart';

class AddUserScreen extends ConsumerStatefulWidget {
  const AddUserScreen({super.key});

  @override
  ConsumerState<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends ConsumerState<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _idController;
  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _emailController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (ref.read(addUserProvider).users.isNotEmpty) return;
      ref.read(addUserProvider.notifier).fetchUsers();
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final userState = ref.watch(addUserProvider);

    ref.listen(addUserProvider.select((state) => state.isAdded), (_, isAdded) {
      if (!isAdded) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(l10n.userAdded)));
      _idController.clear();
      _nameController.clear();
      _ageController.clear();
      _emailController.clear();
      ref.read(addUserProvider.notifier).acknowledgeAdded();
    });

    ref.listen(addUserProvider.select((state) => state.error), (_, error) {
      if (error == null) return;
      final message = switch (error) {
        duplicateUserIdError => l10n.duplicateUserId,
        fetchUsersError => l10n.fetchUsersFailed,
        _ => error,
      };
      showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(l10n.errorTitle),
            content: Text(message),
          );
        },
      );
      ref.read(addUserProvider.notifier).clearError();
    });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.addUser)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: TextFormField(
                  controller: _idController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: l10n.id,
                  ),
                  validator: (value) => _requiredNumber(l10n, value),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: l10n.username,
                  ),
                  validator: (value) => _requiredText(l10n, value),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: TextFormField(
                  controller: _ageController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: l10n.age,
                  ),
                  validator: (value) => _requiredNumber(l10n, value),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: TextFormField(
                  controller: _emailController,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: l10n.email,
                  ),
                  validator: (value) => _requiredEmail(l10n, value),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(
                child: FullWidthElevatedButton(
                  label: l10n.addUser,
                  onPressed: userState.isLoading ? null : _addUser,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
              if (userState.isLoading)
                const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                SliverList.builder(
                  itemCount: userState.users.length,
                  itemBuilder: (context, index) {
                    final user = userState.users[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(user.username),
                      subtitle: Text('${user.email} · ${user.age}'),
                      leading: Text('${user.id}'),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _addUser() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    ref
        .read(addUserProvider.notifier)
        .addUser(
          User(
            id: int.parse(_idController.text.trim()),
            username: _nameController.text.trim(),
            age: int.parse(_ageController.text.trim()),
            email: _emailController.text.trim(),
          ),
        );
  }

  String? _requiredText(AppLocalizations l10n, String? value) {
    if (value == null || value.trim().isEmpty) return l10n.fieldRequired;
    return null;
  }

  String? _requiredNumber(AppLocalizations l10n, String? value) {
    final requiredError = _requiredText(l10n, value);
    if (requiredError != null) return requiredError;
    if (int.tryParse(value!.trim()) == null) return l10n.invalidNumber;
    return null;
  }

  String? _requiredEmail(AppLocalizations l10n, String? value) {
    final requiredError = _requiredText(l10n, value);
    if (requiredError != null) return requiredError;
    if (!value!.contains('@')) return l10n.invalidEmail;
    return null;
  }
}

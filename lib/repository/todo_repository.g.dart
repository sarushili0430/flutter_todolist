// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoRepositoryHash() => r'a1ec406bfe23ccff42a7d7c96c7931921b5c820c';

/// See also [TodoRepository].
@ProviderFor(TodoRepository)
final todoRepositoryProvider =
    AsyncNotifierProvider<TodoRepository, List<Todo>>.internal(
  TodoRepository.new,
  name: r'todoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoRepository = AsyncNotifier<List<Todo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
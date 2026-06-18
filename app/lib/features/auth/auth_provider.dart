import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_provider.g.dart';

@riverpod
Stream<AuthState> authState(AuthStateRef ref) =>
    Supabase.instance.client.auth.onAuthStateChange;

@riverpod
User? currentUser(CurrentUserRef ref) =>
    Supabase.instance.client.auth.currentUser;

@riverpod
Future<Map<String, dynamic>?> currentProfile(CurrentProfileRef ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  final response = await Supabase.instance.client
      .from('profiles')
      .select()
      .eq('id', user.id)
      .maybeSingle();
  return response;
}

import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

bool isAuthenticated() {
  Session? session = supabase.auth.currentSession;
  bool isExpired = session?.isExpired ?? true;

  return session != null && !isExpired;
}
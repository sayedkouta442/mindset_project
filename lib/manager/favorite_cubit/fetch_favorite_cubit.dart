import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FetchFavoritesCubit extends Cubit<List<Map<String, dynamic>>> {
  FetchFavoritesCubit(this.supabaseClient, this.userId) : super([]);

  final SupabaseClient supabaseClient;
  final String userId;

  Future<void> fetchFavorites() async {
    final response = await supabaseClient
        .from('favorites')
        .select('*, products(*)')
        .eq('user_id', userId);

    if (response != null) emit(List<Map<String, dynamic>>.from(response));
  }
}

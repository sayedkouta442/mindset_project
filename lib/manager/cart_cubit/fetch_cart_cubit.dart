import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FetchCartCubit extends Cubit<List<Map<String, dynamic>>> {
  FetchCartCubit(this.supabaseClient, this.userId) : super([]);

  final SupabaseClient supabaseClient;
  final String userId;

  Future<void> fetchCartItems() async {
    final response = await supabaseClient
        .from('cart_items')
        .select('*, products(*)')
        .eq('user_id', userId);

    if (response != null) emit(List<Map<String, dynamic>>.from(response));
  }
}

import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesCubit extends Cubit<void> {
  final SupabaseClient supabase;
  FavoritesCubit(this.supabase, String userId) : super(null);

  Future<void> addToFavorites({
    required String productId,
    required String userId,
  }) async {
    await supabase.from('favorites').insert({
      'product_id': productId,
      'user_id': userId,
    });
  }

  fetchFavorites() {}
}

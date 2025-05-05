import 'package:bloc/bloc.dart';
import 'package:mindset_project/manager/favorite_cubit/favorites_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final SupabaseClient supabase;
  final String userId;

  FavoritesCubit(this.supabase, this.userId) : super(FavoritesLoading());

  Future<void> fetchFavorites() async {
    emit(FavoritesLoading());
    try {
      final response = await supabase
          .from('favorites')
          .select('*, products(*)')
          .eq('user_id', userId);

      emit(FavoritesLoaded(List<Map<String, dynamic>>.from(response)));
    } catch (e) {
      emit(FavoritesError('Failed to load favorites'));
    }
  }

  Future<void> addToFavorites({
    required String productId,
    required String userId,
  }) async {
    try {
      final existing =
          await supabase
              .from('favorites')
              .select()
              .eq('product_id', productId)
              .eq('user_id', userId)
              .maybeSingle();

      if (existing == null) {
        await supabase.from('favorites').insert({
          'product_id': productId,
          'user_id': userId,
        });
        await fetchFavorites();
      }
      // else: item already in favorites, no need to re-add
    } catch (e) {
      emit(FavoritesError('Failed to add to favorites'));
    }
  }

  Future<void> removeFromFavorites(String productId) async {
    try {
      await supabase
          .from('favorites')
          .delete()
          .eq('user_id', userId)
          .eq('product_id', productId);
      await fetchFavorites();
    } catch (e) {
      emit(FavoritesError('Failed to remove from favorites'));
    }
  }
}

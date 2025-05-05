import 'package:bloc/bloc.dart';
import 'package:mindset_project/manager/cart_cubit/cart_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartCubit extends Cubit<CartState> {
  final SupabaseClient supabase;
  final String userId;

  CartCubit(this.supabase, this.userId) : super(CartLoading());

  Future<void> fetchCartItems() async {
    emit(CartLoading());
    try {
      final response = await supabase
          .from('cart_items')
          .select('*, products(*)')
          .eq('user_id', userId);

      emit(CartLoaded(List<Map<String, dynamic>>.from(response)));
    } catch (e) {
      emit(CartError('Failed to load cart items'));
    }
  }

  Future<void> addToCart({
    required String productId,
    required String userId,
    required int quantity,
    required String selectedColor,
  }) async {
    try {
      await supabase.from('cart_items').insert({
        'product_id': productId,
        'user_id': userId,
        'quantity': quantity,
        'selected_color': selectedColor,
      });
      await fetchCartItems();
    } catch (e) {
      emit(CartError('Failed to add to cart'));
    }
  }

  Future<void> removeFromCart(String cartItemId) async {
    try {
      await supabase
          .from('cart_items')
          .delete()
          .eq('id', cartItemId)
          .eq('user_id', userId);
      await fetchCartItems();
    } catch (e) {
      emit(CartError('Failed to remove item from cart'));
    }
  }
}

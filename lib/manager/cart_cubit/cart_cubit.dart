import 'package:bloc/bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartCubit extends Cubit<void> {
  final SupabaseClient supabase;
  CartCubit(this.supabase, String s) : super(null);

  Future<void> addToCart({
    required String productId,
    required String userId,
    required int quantity,
    required String selectedColor,
  }) async {
    await supabase.from('cart_items').insert({
      'product_id': productId,
      'user_id': userId,
      'quantity': quantity,
      'selected_color': selectedColor,
    });
  }
}

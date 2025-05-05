// cubit/product_details_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  final supabase = Supabase.instance.client;

  Future<void> fetchProductDetails(String productId) async {
    emit(ProductDetailsLoading());

    try {
      if (productId.isEmpty) {
        throw Exception("Invalid product ID.");
      }

      final response =
          await supabase.from('products').select().eq('id', productId).single();

      // if (response == null) {
      //   throw Exception("Product not found.");
      // }

      emit(ProductDetailsLoaded(response));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }
}

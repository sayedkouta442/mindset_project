import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final response = await Supabase.instance.client
          .from('products')
          .select('id, title, price, image_url');

      if (response.isEmpty) {
        throw Exception("No products found.");
      }

      emit(ProductLoaded(response));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}

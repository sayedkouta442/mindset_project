// lib/cubits/categories_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  Future<void> fetchCategories() async {
    emit(CategoriesLoading());
    try {
      final response = await Supabase.instance.client
          .from('categories')
          .select()
          .order('created_at');

      final categories =
          response.map<Map<String, dynamic>>((cat) {
            return {
              'title': cat['name'],
              'image': cat['icon_url'],
              'color': Color(
                int.parse(cat['color']),
              ), // Ensure this is a valid color string
            };
          }).toList();

      if (!isClosed) emit(CategoriesLoaded(categories));
    } catch (e) {
      if (!isClosed) emit(CategoriesError(e.toString()));
    }
  }
}

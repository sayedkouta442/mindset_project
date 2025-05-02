import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindset_project/constants.dart';
import 'package:mindset_project/manager/favorite_cubit/favorite_cubit.dart';
import 'package:mindset_project/manager/favorite_cubit/fetch_favorite_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              FetchFavoritesCubit(Supabase.instance.client, Constants.userId)
                ..fetchFavorites(),
      child: Scaffold(
        appBar: AppBar(title: Text('Favorites')),
        body: BlocBuilder<FetchFavoritesCubit, List<Map<String, dynamic>>>(
          builder: (context, favorites) {
            if (favorites.isEmpty)
              return Center(child: Text('No favorites yet.'));
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (_, index) {
                final product = favorites[index]['products'];
                return ListTile(
                  leading: Image.network(product['image_url']),
                  title: Text(product['title']),
                  subtitle: Text('\$${product['price']}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

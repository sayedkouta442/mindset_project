import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindset_project/constants.dart';
import 'package:mindset_project/manager/favorite_cubit/favorite_cubit.dart';
import 'package:mindset_project/manager/favorite_cubit/favorites_state.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              FavoritesCubit(Supabase.instance.client, userId)
                ..fetchFavorites(),
      child: Scaffold(
        appBar: AppBar(title: Text('Favorites'), centerTitle: true),
        body: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FavoritesError) {
              return Center(child: Text(state.message));
            } else if (state is FavoritesLoaded) {
              final favorites = state.favorites;
              if (favorites.isEmpty) {
                return Center(child: Text('No favorites yet.'));
              }
              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (_, index) {
                  final product = favorites[index]['products'];
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListTile(
                      leading: SizedBox(
                        width: 70,
                        child: Image.network(product['image_url']),
                      ),
                      title: Text(product['title']),
                      subtitle: Text('\$${product['price']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: primaryColor),
                        onPressed: () {
                          context.read<FavoritesCubit>().removeFromFavorites(
                            product['id'],
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

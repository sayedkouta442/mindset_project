import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindset_project/constants.dart';
import 'package:mindset_project/manager/cart_cubit/cart_cubit.dart';
import 'package:mindset_project/manager/cart_cubit/cart_state.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => CartCubit(Supabase.instance.client, userId)..fetchCartItems(),
      child: Scaffold(
        appBar: AppBar(title: Text('Cart'), centerTitle: true),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            } else if (state is CartLoaded) {
              final cartItems = state.items;
              if (cartItems.isEmpty) {
                return Center(child: Text('Cart is empty.'));
              }
              return ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (_, index) {
                  final item = cartItems[index];
                  final product = item['products'];
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListTile(
                      leading: SizedBox(
                        width: 70,
                        child: Image.network(product['image_url']),
                      ),
                      title: Text(product['title']),
                      subtitle: Text('Qty: ${item['quantity']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: primaryColor),
                        onPressed: () {
                          context.read<CartCubit>().removeFromCart(item['id']);
                        },
                      ),
                    ),
                  );
                },
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

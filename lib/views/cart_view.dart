import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindset_project/constants.dart';
import 'package:mindset_project/manager/cart_cubit/fetch_cart_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              FetchCartCubit(Supabase.instance.client, Constants.userId)
                ..fetchCartItems(),
      child: Scaffold(
        appBar: AppBar(title: Text('Cart')),
        body: BlocBuilder<FetchCartCubit, List<Map<String, dynamic>>>(
          builder: (context, cartItems) {
            if (cartItems.isEmpty) return Center(child: Text('Cart is empty.'));
            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (_, index) {
                final product = cartItems[index]['products'];
                return ListTile(
                  leading: Image.network(product['image_url']),
                  title: Text(product['title']),
                  subtitle: Text('Qty: ${cartItems[index]['quantity']}'),
                  trailing: Text('\$${product['price']}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

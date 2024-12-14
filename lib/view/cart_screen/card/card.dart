import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shopping_app_ui/controller/cartscreencontroller.dart';
import 'package:shopping_app_ui/model/cartmodel.dart';


class CardWidget extends StatelessWidget {
  final Cartmodel cartItem; 
  final int index; 

  const CardWidget({super.key, required this.cartItem, required this.index});

  @override
  Widget build(BuildContext context) {
    final cartController = context.read<Cartscreencontroller>();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey.shade400,
                      image: DecorationImage(
                        image: NetworkImage(cartItem.image ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartItem.title.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          cartItem.des ?? '',
                          softWrap: true,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          cartController.incrementproduct(index);
                        },
                        icon: const Icon(Icons.add),
                      ),
                      Text(
                        '${cartItem.quantity}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        onPressed: () {
                          cartController.decrementproduct(index);
                        },
                        icon: const Icon(Icons.remove),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.red,
                ),
                child: TextButton(
                  onPressed: () {
                    cartController.removeproducts(index);
                  },
                  child: const Text(
                    "Remove",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

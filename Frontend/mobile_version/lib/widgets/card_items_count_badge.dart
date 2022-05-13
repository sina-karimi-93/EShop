import 'package:flutter/material.dart';

class CardItemsCountBadge extends StatelessWidget {
  const CardItemsCountBadge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Theme.of(context).colorScheme.secondary,
            ),
            borderRadius: BorderRadius.circular(500),
          ),
          child: const Icon(
            (Icons.shopify),
            size: 35,
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            maxRadius: 10,
            child: Text(
              "12",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}

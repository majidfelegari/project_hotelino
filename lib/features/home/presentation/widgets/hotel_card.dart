import 'package:flutter/material.dart';
import 'package:hotelino/core/utils/price_formatter.dart';
import 'package:hotelino/features/home/data/models/hotel.dart';
import 'package:hotelino/features/home/presentation/provider/favorite_item_provider.dart';
import 'package:provider/provider.dart';

class HotelCard extends StatelessWidget {
  Hotel hotel;

  HotelCard({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteItemProvider>(context);
    final isFavorite = favoriteProvider.isFavorite(hotel.id);

    return SizedBox(
      width: 280,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      SizedBox(height: 8,),
                      Icon(Icons.star, color: Colors.amber, size: 20,),
                      SizedBox(width: 4,),
                      Text("${hotel.rating} (${formatPrice(hotel.reviewCount)})"),
                    ],

                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
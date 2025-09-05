import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hotelino/core/constants/constants.dart';
import 'package:hotelino/features/home/data/models/hotel.dart';

class JsonDataService {
  Future<List<Hotel>> loadHotles() async {
    final String response = await rootBundle.loadString(AppConstants.hotelsData);
    final Map<String, dynamic> jsonData = json.decode(response);

    final List<dynamic> hotelList = jsonData["hotels"];

    return hotelList.map(
      (hotel) => Hotel.fromJson(hotel as Map<String, dynamic>),
    ).toList();
    }
}
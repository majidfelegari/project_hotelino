import 'package:flutter/material.dart';
import 'package:hotelino/core/constants/constants.dart';
import 'package:hotelino/features/home/data/models/homepage_data.dart';
import 'package:hotelino/features/home/data/models/hotel.dart';
import 'package:hotelino/features/home/repositories/hotel_repository.dart';

class HomeProvider extends ChangeNotifier{
  final HotelRepository _hotelRepository;
  
  HomeProvider(this._hotelRepository) {
    fetchHotels();
  }

  List<Hotel> _hotels = [];
  List<Hotel> get hotels => _hotels;

  final HomepageData _homepageData = HomePageDataConstants.homePageData;
  HomepageData get homePageData => _homepageData;

  fetchHotels() async {
    _hotels = await _hotelRepository.fetchHotels();
    notifyListeners();
  }

  // filter methods

  List<Hotel> getPopularHotels() {
    return _hotels.where((hotel) => _homepageData.popular.contains(hotel.id)).toList();
  }

  List<Hotel> getSpecialOffersHotels() {
    return _hotels.where((hotel) => _homepageData.specialOffers.contains(hotel.id)).toList();
  }

  List<Hotel> getNewestHotels() {
    return _hotels.where((hotel) => _homepageData.newest.contains(hotel.id)).toList();
  }

  // Story section

  List<String> getStoryImage() {
    final shuffledHotels = List<Hotel>.from(_hotels)..shuffle();
    return shuffledHotels.take(3).map((hotel) => hotel.images[0]).toList();
  }

  final List<String> _storyTitles = [
    "امکانات رفاهی کامل",
    "اقامت در قلب شهر",
    "لوکس ترین هتل ها"
  ];

  List<String> get storyTitles => _storyTitles;
}
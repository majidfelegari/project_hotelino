import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hotelino/core/utils/network.dart';

class StoryCarousel extends StatefulWidget {
  final List<String> images;
  final List<String> titles;

  const StoryCarousel({super.key, required this.images, required this.titles});

  @override
  State<StoryCarousel> createState() => _StoryCarouselState();
}

class _StoryCarouselState extends State<StoryCarousel> {
  int _currentIndex = 0;
  late Timer _timer;
  final CarouselSliderController _carouselController = CarouselSliderController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stateAutoSlide();
  }
  
  
  void _stateAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer)
    {
      if (_currentIndex < widget.images.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      _carouselController.animateToPage(_currentIndex);
      setState(() {
        
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();  
    super.dispose();
  }

  void _nextImage(){
    setState(() {
      if (_currentIndex < widget.images.length -1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      _carouselController.animateToPage(_currentIndex);
    });
  }

  void _pervImage() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
      } else {
        _currentIndex = widget.images.length - 1;
      }
      _carouselController.animateToPage(_currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlay: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              }
            ),
            items: widget.images.map((imageUrl) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(networkUrl(imageUrl), fit: BoxFit.cover),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.75),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(widget.images.length, (index) {
                  return Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(microseconds: 500),
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: _currentIndex >= index ? Colors.white : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Text(
              widget.titles[_currentIndex],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: 100,
            child: GestureDetector(
              onTap: _nextImage,
              child: CircleAvatar(
                backgroundColor: Colors.white.withValues(alpha: 0.6),
                child: const Icon(Icons.chevron_right, color: Colors.black),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 100,
            child: GestureDetector(
              onTap: _pervImage,
              child: CircleAvatar(
                backgroundColor: Colors.white.withValues(alpha: 0.6),
                child: const Icon(Icons.chevron_left, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
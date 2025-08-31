import 'package:flutter/material.dart';
import 'package:hotelino/features/onboarding/presentation/onboarding_provider.dart';
import 'package:hotelino/features/onboarding/presentation/widgets/onboarding_item.dart';
import 'package:provider/provider.dart';

class Onboardingpage extends StatefulWidget {
  const Onboardingpage({super.key});

  @override
  State<Onboardingpage> createState() => _OnboardingpageState();
}

class _OnboardingpageState extends State<Onboardingpage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final onbordingProvider = Provider.of<OnboardingProvider>(context);

    final onboardingData = onbordingProvider.onboardingData;
    final int totalPages = onboardingData.length;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: totalPages,
              onPageChanged: onbordingProvider.updateCurrentPage,
              itemBuilder: (context, index){
                final data = onboardingData[index];
                return OnboardingItem(title: data["title"]!, description: data["description"]!, image: data["image"]!);
              },
            ),
          )
        ],
      ),
    );
  }
}
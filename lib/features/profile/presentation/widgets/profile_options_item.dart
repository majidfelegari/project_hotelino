import 'package:flutter/material.dart';
import 'package:hotelino/core/constants/constants.dart';

class ProfileOptionsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ProfileOptionsItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios_new_rounded, size: 14),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFFF4EAE2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: AppColors.darkFocuseBorder),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

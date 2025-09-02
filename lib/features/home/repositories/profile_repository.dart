import 'package:hotelino/features/home/data/models/profile.dart';

class ProfileRepository {
  Future<Profile> fetchUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 100));

    return Profile(
      id: "795425841",
      name: "مجید فعله گری",
      email: "majidfelegari@gmail.com",
      avatarUrl: "https://dunijet.ir/content/projects/hotelino/profile_pic.png",
      phoneNumber: "+989123456789",
      location: "تهران تهران",
      bio: "عاشق سفر و دوست دار طبیعت",
      booking: 12,
      favorites: 5,
      notifications: 3,
    );
  }
}

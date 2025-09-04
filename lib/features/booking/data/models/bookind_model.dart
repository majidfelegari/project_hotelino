import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class BookingModel {
  String fullName;
  String destination;
  JalaliRange? checkInOutRangsDate;

  String numberOfGuests;
  String phoneNumber;

  BookingModel(
    {this.fullName = '',
    this.destination = '',
    this.checkInOutRangsDate,
    this.numberOfGuests = '',
    this.phoneNumber = ''}
  );
}
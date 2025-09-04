import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class BookindModel {
  String fullName;
  String destination;
  JalaliRange? checkInOutRangsDate;

  String numberOfGuests;
  String phoneNumber;

  BookindModel(
    {this.fullName = '',
    this.destination = '',
    this.checkInOutRangsDate,
    this.numberOfGuests = '',
    this.phoneNumber = ''}
  );
}
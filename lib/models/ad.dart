import 'package:myxlo/models/address.dart';

class Ad {
  List<dynamic> images;
  String title;
  String description;
  Address address;
  num price;
  bool hidePhone;

  // campos não oriundos da VIACEP
  DateTime dateCreated = DateTime.now();

  @override
  String toString() {
    return '$images, $title, $description, $address, $price, $hidePhone, $dateCreated';
  }
}

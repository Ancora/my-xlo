class Address {
  String place;
  //String number;
  //String complement;
  String district;
  String city;
  String postalCode;
  String federativeUnit;

  @override
  String toString() {
    //return super.toString();
    return '$place, $district, $city, $postalCode, $federativeUnit';
  }

  Address({
    this.place,
    //this.number,
    //this.complement,
    this.district,
    this.city,
    this.postalCode,
    this.federativeUnit,
  });
}

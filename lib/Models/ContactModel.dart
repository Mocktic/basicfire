class ContactModel {
  String name;
  String address;
  String companyName;
  String email;
  String phone;
  String socialMediaLink;
  bool isSelected;
  String id;
  ContactModel({
    this.address,
    this.companyName,
    this.email,
    this.name,
    this.phone,
    this.id,
    this.socialMediaLink,
    this.isSelected = false,
  });
}

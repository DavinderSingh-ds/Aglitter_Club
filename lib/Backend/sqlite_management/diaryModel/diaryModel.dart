// ignore_for_file: file_names, unnecessary_this

class DogModel {
  int? id;
  String dogName;
  String date;
  String dogAge;
  String dogBreed;
  String dogColor;
  DogModel({
    this.id,
    required this.dogName,
    required this.date,
    required this.dogAge,
    required this.dogBreed,
    required this.dogColor,
  });
  factory DogModel.fromdatabaseJson(Map<String, dynamic> data) => DogModel(
      id: data['id'],
      dogName: data['transactioncategorytype'],
      date: data['date'],
      dogAge: data['amount'],
      dogBreed: data['description'],
      dogColor: data['transactionType']);
  Map<String, dynamic> todatabaseJson() => {
        'id': this.id,
        'transactioncategorytype': this.dogName,
        'date': this.date,
        'amount': this.dogAge,
        'description': this.dogBreed,
        'transactionType': this.dogColor,
      };
}

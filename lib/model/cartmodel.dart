import 'package:hive/hive.dart';
    part 'cartmodel.g.dart';
@HiveType(typeId: 1)
class Cartmodel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String ?title;
  @HiveField(2)
  String? des;
  @HiveField(3)
  double? price;
  @HiveField(4)
  int? quantity=1;
  @HiveField(5)
  String? image;

  Cartmodel({
   this.id,
   this.title,
     this.des,
     this.price,
     this.quantity,
     this.image,
  });
}

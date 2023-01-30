import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(
  typeId: 1,
)
class ImageModel {
  @HiveField(
    0,
  )
  final String image;

  ImageModel({required this.image});
}

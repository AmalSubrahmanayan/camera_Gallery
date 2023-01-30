import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/data_model.dart';

ValueNotifier<List<ImageModel>> imageListNotifier = ValueNotifier(
  [],
);
Future<void> createDatabase() async {
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ImageModelAdapter().typeId)) {
    Hive.registerAdapter(
      ImageModelAdapter(),
    );
  }
}

Future<void> addImage(ImageModel value) async {
  final cameraDB = await Hive.openBox<ImageModel>('camera_db');
  cameraDB.add(value);
  imageListNotifier.value.add(value);
  imageListNotifier.notifyListeners();
}

Future<void> getAllImages() async {
  final camearaDB = await Hive.openBox<ImageModel>('camera_db');
  imageListNotifier.value.clear();
  imageListNotifier.value.addAll(
    camearaDB.values,
  );
  imageListNotifier.notifyListeners();
}

Future<void> deleteList(int index) async {
  final studentDB = await Hive.openBox<ImageModel>('camera_db');
  await studentDB.deleteAt(index);
  getAllImages();
}

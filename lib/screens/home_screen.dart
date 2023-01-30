import 'dart:io';
import 'package:camera_app/screens/show_photo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../functions/db_functions.dart';
import '../model/data_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getAllImages();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            getimage();
          },
          icon: const Icon(
            Icons.camera,
            size: 30,
          ),
          label: const Text('Take Photo'),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Gallery',
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: imageListNotifier,
          builder: (BuildContext context, List<ImageModel> imagelist,
              Widget? child) {
            return Padding(
              padding: const EdgeInsets.all(
                10,
              ),
              child: imagelist.isEmpty
                  ? Center(
                      child: Text(
                        'No Files',
                        style: TextStyle(fontSize: 25, color: Colors.grey[500]),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 3,
                        mainAxisSpacing: 3,
                      ),
                      itemBuilder: (ctx, index) {
                        return InkWell(
                          child: Image.file(
                            File(
                              imagelist[index].image,
                            ),
                            fit: BoxFit.fill,
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ShowImage(
                                      image: imagelist[index].image,
                                      index: index,
                                    )));
                          },
                        );
                      },
                      itemCount: imagelist.length,
                    ),
            );
          }),
    );
  }

  File? _image;

  Future<void> getimage() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (image == null) {
      return;
    } else {
      final imageTemp = File(
        image.path,
      );
      setState(() {
        _image = imageTemp;
      });
    }
    final camera = ImageModel(
      image: _image!.path,
    );
    await addImage(
      camera,
    );
  }
}

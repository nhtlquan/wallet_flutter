import 'dart:ffi';
import 'dart:io';
export 'dart:io';

import 'package:flutter/material.dart';
import 'package:PitWallet/src/widgets/LineBaseWidget.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

import 'Constant.dart';
typedef VoidOnAction = void Function();
typedef VoidOnChooseImage = void Function(File image);

class ChooseImageHelper {
  //Loading request permission
  VoidOnAction onShowLoading;
  VoidOnAction onActionTakePicture;
  VoidOnAction onHideLoading;
  VoidOnChooseImage onChooseImage;

  final BuildContext context;
  var isCrop;
  String title;

  ChooseImageHelper({@required this.context, this.onActionTakePicture, this.isCrop = false});

  void show() async {
    showDialog(
      context: context,
      builder: (BuildContext bc) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                //padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 60,
                      alignment: Alignment.center,
                      child: Text(
                        title ?? "",
                        style: TextStyle(
                          color: Constant.TEXTCOLOR_BLACK_2B,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    LineBaseWidget(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(bc);
                        _chooseImage(ImageSource.camera);
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          'Take Photo',
                          style: TextStyle(
                            color: Constant.TEXTCOLOR_BLUE_1A,
                            fontSize: 16,
                           fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    LineBaseWidget(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(bc);
                        if (onActionTakePicture != null)
                          onActionTakePicture();
                        else
                          _chooseImage(ImageSource.gallery);
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          'Choose Photo',
                          style: TextStyle(
                            color: Constant.TEXTCOLOR_BLUE_1A,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    LineBaseWidget(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(bc);
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          'Close',
                          style: TextStyle(
                            color: Constant.TEXTCOLOR_BLACK_62,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  _chooseImage(ImageSource imageSource) async {
    if (onShowLoading != null) {
      onShowLoading();
    }
    final file = await ImagePicker.pickImage(source: imageSource);
    if (file == null) {
      return;
    }
    if (onHideLoading != null) {
      onHideLoading();
    }
    if (isCrop) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotoPickerAndCropPage(
            file: file,
            onCropImage: (imageFileCrop) {
              if (onChooseImage != null) {
                onChooseImage(imageFileCrop);
              }
            },
          ),
        ),
      );
    } else {
      if (onChooseImage != null) {
        onChooseImage(file);
      }
    }
  }
}

typedef VoidOnCropImage = void Function(File fileCrop);

class PhotoPickerAndCropPage extends StatefulWidget {
  final File file;
  final VoidOnCropImage onCropImage;

  PhotoPickerAndCropPage({Key key, this.file, this.onCropImage}) : super(key: key);

  @override
  _PhotoPickerAndCropPageState createState() => new _PhotoPickerAndCropPageState();
}

class _PhotoPickerAndCropPageState extends State<PhotoPickerAndCropPage> {
  final cropKey = GlobalKey<CropState>();
  File _file;
  File _sample;
  File _lastCropped;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _file = this.widget.file;
    _sample = this.widget.file;
    print("file: " + _file.path);

    //_createImageCrop();
  }

  @override
  void dispose() {
    super.dispose();
    //_file?.delete();
    //_sample?.delete();
    //_lastCropped?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          color: Colors.black,
          child: _sample == null ? _buildOpeningImage() : _buildCroppingImage(),
        ),
      ),
    );
  }

  Widget _buildOpeningImage() {
    return Center(child: _buildOpenImage());
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(
            _sample,
            key: cropKey,
            aspectRatio: 1,
            maximumScale: 1,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
                ),
                onPressed: () => _cropImage(),
              ),
              //_buildOpenImage(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOpenImage() {
    return FlatButton(
      onPressed: () {},
      child: Text(
        'Open Image',
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.blue),
      ),
      //onPressed: () => _openImage(),
    );
  }

//  11:37:34.062
//  11:37:40.088
//
//  Future<void> _createImageCrop() async {
//    final sample = await ImageCrop.sampleImage(
//      file: _file,
//      preferredSize: context.size.longestSide.ceil(),
//    );
//
//    _sample?.delete();
//    _file?.delete();
//  }
//
//  Future<void> _openImage() async {
//    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
//    final sample = await ImageCrop.sampleImage(
//      file: file,
//      preferredSize: context.size.longestSide.ceil(),
//    );
//
//    _sample?.delete();
//    _file?.delete();
//
//    setState(() {
//      _sample = sample;
//      _file = file;
//    });
//  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
//    final sample = await ImageCrop.sampleImage(
//      file: _file,
//      preferredSize: (2000 / scale).round(),
//    );
    await new Future.delayed(const Duration(milliseconds: 100));
    print("Quynh an c: " + _file.path);
    final file = await ImageCrop.cropImage(
      file: _file,
      area: area,
      scale: 1,
    );
    print("Quynh an cut: " + file.path);
    //await new Future.delayed(const Duration(milliseconds: 200));

    //await new Future.delayed(const Duration(milliseconds: 200));
//    print(sample);
//    this.widget.file.delete();
    //sample.delete();

//    _lastCropped?.delete();
//    _lastCropped = file;
    Navigator.pop(context);
    if (this.widget.onCropImage != null) {
      this.widget.onCropImage(file);
    }
    //debugPrint('$file');
  }
}

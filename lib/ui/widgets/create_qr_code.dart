import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CreateQrCode extends StatefulWidget {
  String title;
  CreateQrCode({super.key, required this.title});

  @override
  State<CreateQrCode> createState() => _CreateQrCodeState();
}

class _CreateQrCodeState extends State<CreateQrCode> {
  String url = '';
  final _urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue,
      title: Text("Create QR-Code for ${widget.title}"),
      content: url == '' ? Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _urlController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15,),
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  hintText: "Enter Text",
                  hintStyle: TextStyle(color: Colors.white)
                ),
              ),
            ),
            SizedBox(height: 20,),
            
            ElevatedButton(onPressed: (){
              setState(() {
                if(_urlController.text != null && _urlController.text.isNotEmpty){
                  url = _urlController.text;
                }
              });
            }, child: Text("Generate"))
          ],
        ),
      ) : Container(
        width: 300,
          height: 300,
          child:  Column(
            children: [
              QrImageView(data: url,size: 250,version: QrVersions.auto,backgroundColor: Colors.white,),
              const SizedBox(height: 10,),
              InkWell(
                onTap: _saveQrCode,
                child: Icon(Icons.save_alt,size: 40,),
              )
            ],
          )),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Cancel")),
      ],
    );
  }

  Future<void> _saveQrCode() async {
    // Ruxsatlarni so'rash
    await _requestPermission();

    // QR kodni yaratish va uni sur'atga aylantirish
    final qrValidationResult = QrValidator.validate(
      data: "https://www.example.com",
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    final qrCode = qrValidationResult.qrCode;

    final painter = QrPainter.withQr(
      qr: qrCode!,
      color: Color(0xFF000000),
      emptyColor: Color(0xFFFFFFFF),
      gapless: true,
    );

    final picData = await painter.toImageData(200);
    final buffer = picData!.buffer.asUint8List();

    // QR kodni galereyaga saqlash
    final result = await ImageGallerySaver.saveImage(buffer);
    print(result);
  }

  Future<void> _requestPermission() async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }
}

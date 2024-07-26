import 'dart:io';

import 'package:dars_65/bloc/scaner_bloc/scaner_bloc.dart';
import 'package:dars_65/bloc/scaner_bloc/scaner_event.dart';
import 'package:dars_65/bloc/scaner_bloc/scaner_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class QrCodeScaner extends StatefulWidget {
  const QrCodeScaner({super.key});

  @override
  State<QrCodeScaner> createState() => _QrCodeScanerState();
}

class _QrCodeScanerState extends State<QrCodeScaner> {
  final _qrKey = GlobalKey(debugLabel: "QR");
  Barcode? result;
  QRViewController? controller;
  bool isScanned = false;

  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRView(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        controller.stopCamera();
        context.read<ScanerBloc>().add(ScaneredQRCodeScanerEvent(result!.code.toString()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ScanerBloc,ScanerState>(
          builder: (context,state) {
            if(state is LoadingScanerState){
              return const Center(child: CircularProgressIndicator(color: Colors.red,),);
            }

            if (state is InitialScanerState) {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: QRView(
                      key: _qrKey,
                      onQRViewCreated: _onQRView,
                      overlay: QrScannerOverlayShape(
                        borderColor: Colors.green,
                        borderWidth: 10,
                      ),
                    ),
                  ),
                ],
              );
            }

            if(state is ErrorScanerState){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Kechirasiz internetda bunday manba topilmadi"),
                    const SizedBox(height: 20,),
                    ElevatedButton(onPressed: (){
                      context.read<ScanerBloc>().add(GetScanerQRCodeScanerEvent());
                    }, child: const Text("Qaytadan skaner qilish")),
                  ],
                ),
              );
            }

            if (state is LoadedScanerState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Data ${state.url}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(onPressed: () async{
                          context.read<ScanerBloc>().add(SearchQRCodeLinkScanerEvent(state.url));

                        }, child: Text("Share")),
                        const SizedBox(width: 50,),
                        FilledButton(onPressed: (){
                          context.read<ScanerBloc>().add(GetScanerQRCodeScanerEvent());
                        }, child: Text("Cancel")),
                      ],
                    )
                  ],
                ),
              );
            }

            return Container();
          }
        )
    );
  }
}

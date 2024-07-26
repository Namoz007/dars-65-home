import 'package:dars_65/ui/widgets/create_qr_code.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class QrCodeGenerateScreen extends StatefulWidget {
  const QrCodeGenerateScreen({super.key});

  @override
  State<QrCodeGenerateScreen> createState() => _QrCodeGenerateScreenState();
}

class _QrCodeGenerateScreenState extends State<QrCodeGenerateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code Generate"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (context) => CreateQrCode(title: "text"),barrierDismissible: false);
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.amber,width: 2),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.center,
                    child: const Text("T",style: TextStyle(fontSize: 50,color: Colors.amber),),
                  ),
                ),
                const SizedBox(width: 20,),
                InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (context) => CreateQrCode(title: "web site"),barrierDismissible: false);
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.amber,width: 2),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.language,color: Colors.amber,size: 70,),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

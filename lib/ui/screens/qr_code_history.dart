import 'package:dars_65/bloc/urls_bloc/url_bloc.dart';
import 'package:dars_65/bloc/urls_bloc/url_event.dart';
import 'package:dars_65/bloc/urls_bloc/url_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QrCodeHistory extends StatefulWidget {
  const QrCodeHistory({super.key});

  @override
  State<QrCodeHistory> createState() => _QrCodeHistoryState();
}

class _QrCodeHistoryState extends State<QrCodeHistory> {
  
  void initState(){
    super.initState();
    context.read<UrlBloc>().add(GetAllUrlsUrlEvent());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code Scannered history"),
      ),
      body: BlocConsumer<UrlBloc, UrlState>(
        listener: (context,state){
          if (state is ErrorUrlState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Kechirasiz,internetda bunday manba topilmadi!")));
            context.read<UrlBloc>().add(GetAllUrlsUrlEvent());
          }
        },
        builder: (context, state) {
          if (state is LoadingUrlState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          if(state is InitialUrlState){
            return const Center(child: Text("Hozirda Skaner qilingan QR-Codelar mavjud emas"),);
          }

          if (state is LoadedUrlState) {
            return ListView.builder(
              itemCount: state.urls.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Data ${state.urls[index]}"),
                  trailing: Icon(Icons.arrow_right),
                  onTap: (){
                    context.read<UrlBloc>().add(SearchQRCodeLinkUrlEvent(state.urls[index]));
                  },
                );
              },
            );
          }

          return Container();
        },
      )
    );
  }
}

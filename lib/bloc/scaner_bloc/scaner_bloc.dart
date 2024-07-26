import 'package:bloc/bloc.dart';
import 'package:dars_65/bloc/scaner_bloc/scaner_event.dart';
import 'package:dars_65/bloc/scaner_bloc/scaner_state.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanerBloc extends Bloc<ScanerEvent,ScanerState>{
  ScanerBloc() : super(InitialScanerState()){
    on<GetScanerQRCodeScanerEvent>(_getScanerQRCode);
    on<ScaneredQRCodeScanerEvent>(_scaneredQRCode);
    on<SearchQRCodeLinkScanerEvent>(_searchQRCodeLink);
  }

  void _searchQRCodeLink(SearchQRCodeLinkScanerEvent event,emit) async{
    emit(LoadingScanerState());
    try{
      !await launchUrl(Uri.parse(event.url));
      final pref = await SharedPreferences.getInstance();
      final data = pref.getStringList('urls');
      if(data != null && data!.length != 0){
        data!.add(event.url);
        await pref.setStringList('urls', data);
      }else{
        await pref.setStringList('urls', [event.url]);
      }
      emit(InitialScanerState());
    }catch(e){
      emit(ErrorScanerState());
    }
  }

  void _scaneredQRCode(ScaneredQRCodeScanerEvent event,emit){
    emit(LoadedScanerState(event.url));
  }

  void _getScanerQRCode(GetScanerQRCodeScanerEvent event,emit){
    emit(InitialScanerState());
  }


}
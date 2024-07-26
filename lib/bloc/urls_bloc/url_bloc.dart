import 'package:bloc/bloc.dart';
import 'package:dars_65/bloc/urls_bloc/url_event.dart';
import 'package:dars_65/bloc/urls_bloc/url_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlBloc extends Bloc<UrlEvent,UrlState>{
  List<String> _urls = [];
  UrlBloc() :  super(InitialUrlState()){
    on<GetAllUrlsUrlEvent>(_getAllUrls);
    on<SearchQRCodeLinkUrlEvent>(_searchQRCodeLink);
  }
  void _searchQRCodeLink( event,emit) async{
    emit(LoadingUrlState());
    try{
      !await launchUrl(Uri.parse(event.url));
      emit(LoadedUrlState(_urls));
    }catch(e){
      emit(ErrorUrlState());
    }
  }


  void _getAllUrls(GetAllUrlsUrlEvent event,emit) async{
    emit(LoadingUrlState());
    final pref = await SharedPreferences.getInstance();
    final data = pref.getStringList("urls");
    if(data == null || data.length == 0){
      emit(InitialUrlState());
    }else{
      _urls = data;
      emit(LoadedUrlState(data));
    }
  }
}
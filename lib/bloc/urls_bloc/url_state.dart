sealed class UrlState{}

final class InitialUrlState extends UrlState{}

final class LoadingUrlState extends UrlState{}

final class LoadedUrlState extends UrlState{
  List<String> urls;

  LoadedUrlState(this.urls);
}

final class ErrorUrlState extends UrlState{}
sealed class UrlEvent{}

final class GetAllUrlsUrlEvent extends UrlEvent{}

final class SearchQRCodeLinkUrlEvent extends UrlEvent{
  String url;

  SearchQRCodeLinkUrlEvent(this.url);
}
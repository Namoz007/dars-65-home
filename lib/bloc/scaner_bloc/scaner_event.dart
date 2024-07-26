sealed class ScanerEvent{}

final class GetScanerQRCodeScanerEvent extends ScanerEvent{}

final class ScaneredQRCodeScanerEvent extends ScanerEvent{
  String url;

  ScaneredQRCodeScanerEvent(this.url);
}

final class SearchQRCodeLinkScanerEvent extends ScanerEvent{
  String url;

  SearchQRCodeLinkScanerEvent(this.url);
}
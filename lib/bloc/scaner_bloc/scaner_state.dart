sealed class ScanerState{}


final class InitialScanerState extends ScanerState{}

final class LoadingScanerState extends ScanerState{}

final class LoadedScanerState extends ScanerState{
  String url;

  LoadedScanerState(this.url);
}

final class ErrorScanerState extends ScanerState{}
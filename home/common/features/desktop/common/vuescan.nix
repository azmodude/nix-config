{
  pkgs,
  user,
  ...
}: {
  sops.secrets.vuescan-license = {
    sopsFile = ../../../../${user.name}/secrets.yaml;
    path = ".vuescanrc";
  };
  home.file = {
    ".vuescan/vuescan.ini" = {
      text = ''
        [VueScan]
        [Input]
        Source=Officejet Pro 8730
        Options=2
        DefaultFolder=/home/azmo/Pictures/sync/scans
        TIFFFileName=YYYY-MM-DD-0001+.tif
        [Input-File-Flatbed]
        AutoMedia=1
        [Filter-File-Flatbed]
        AutoFlatten=1
        [Prefs]
        WindowMaximized=1
        WindowXOffset=0
        WindowYOffset=32
        WindowXSize=1920
        WindowYSize=1048
        NetworkScanners=2
        IPAddress=172.29.50.7
        USBVendorID=03f0
        USBProductID=7a12
        [Output]
        DefaultFolder=/home/azmo/Pictures/sync/scans
        TIFFFileName=YYYY-MM-DD-0001+.tif
        TIFFMultiPage=1
        RawOutputWith=2
        [Output-File-Flatbed]
        TIFFFile=1
        PDFFile=0
        [Input-OfficejetPro8730-Flatbed]
        Media=4
        AutoMedia=1
        ScanResolution=4
        AutoRotate=1
        FineMode=1
        HolePunchRemoval=1
        [Filter-OfficejetPro8730-Flatbed]
        AutoFlatten=1
        [Output-OfficejetPro8730-Flatbed]
        TIFFFile=1
        PDFFile=0
        [Input-OfficejetPro8730-DocFeeder]
        Media=4
        AutoMedia=1
        ScanResolution=2
        AutoScan=3
        FineMode=1
        HolePunchRemoval=1
        BlankPageRemoval=1
        [Filter-OfficejetPro8730-DocFeeder]
        AutoFlatten=1
        [Output-OfficejetPro8730-DocFeeder]
        TIFFFile=1
        PDFFile=0
        [Input-OfficejetPro8730-DuplexFeeder]
        Media=4
        AutoMedia=1
        ScanResolution=2
        AutoScan=3
        FineMode=1
        HolePunchRemoval=1
        BlankPageRemoval=1
        [Filter-OfficejetPro8730-DuplexFeeder]
        AutoFlatten=1
        [Input-OfficejetPro8730]
        Mode=2
        [Output-OfficejetPro8730-DuplexFeeder]
        TIFFFile=1
        PDFFile=0
      '';
    };
  };

  home.packages = with pkgs; [vuescan];
}

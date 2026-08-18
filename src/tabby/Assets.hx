package tabby;

import sys.io.File;

enum FilePreprocess {
  ToBytes;
  ToString;
  ToCustom(f: File->Any);
}

@:build(tabby.Assets.build("./assets/")) // use config or class config file
@:expose("tabby.Assets")
class Assets {
  public var PREPROCESS: Map<String, FilePreprocess> = [
    "png" => ToBytes
  ];
}
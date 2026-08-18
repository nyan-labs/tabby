package tabby;

import haxe.io.Bytes;
import sys.io.File;
import haxe.io.Path;
import sys.FileSystem;
import haxe.macro.Context;
import haxe.macro.Expr;

using haxe.io.Path;
using StringTools;

class Assets {
  public static function read_directory_recursive(read_path: String): Array<String> {
    var files = new Array<String>();

    for(file_path in FileSystem.readDirectory(read_path)) {
      final full_file_path = Path.join([read_path, file_path]);

      switch FileSystem.isDirectory(full_file_path) {
        case true:
          for(file_name in read_directory_recursive(full_file_path))
            files.push(Path.join([file_path, file_name]));

        case false: 
          files.push(file_path);
      }
    }

    return files;
  }

  inline static function path_to_var(path: String) 
    return path.toLowerCase()
      .replace(" ", "_")
      .replace("/", "_")
      .replace("-", "_")
      .replace(".", "_");

  public static function build(assets_path: String): Array<Field> {
    trace(assets_path);
    var fields = Context.getBuildFields();
    
    final assets = read_directory_recursive(assets_path);

    for(asset_path in assets) {
      final asset_full_path = Path.join([assets_path, asset_path]);

      // final content = File.getBytes(Path.join([asset_path, asset]));

      fields.push({
        name: path_to_var(asset_path),
        access: [Access.APublic, Access.AStatic, Access.AInline],
        kind: FieldType.FVar(macro: String, macro $v{asset_full_path}), 
        pos: Context.currentPos(),
      });
    }
    
    return fields;
  }
}
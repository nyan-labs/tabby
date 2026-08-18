package tabby;

import tabby.utils.Texture;
import love.Data;
import love.image.ImageData;
import tabby.Object;

// rename?
@:expose("tabby.Entity")
class Entity extends Object {
  public var texture: Null<Texture>;

  public function new() {
    super();
    texture = null;
  }
}
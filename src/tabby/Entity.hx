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

  override public function draw() {
    Graphics.push();
    Graphics.setColor(1, 0, 1);
    Graphics.rectangle(Fill, position.x, position.y, size.x, size.y);
    Graphics.pop();
    Graphics.setColor(1, 1, 1); // idk

    super.draw();
  }
}
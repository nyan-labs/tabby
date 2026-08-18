package tabby;

import tabby.fun.EmptyCanvas;
import love.graphics.Font;
import tabby.Canvas;

@:publicFields
@:expose("tabby.Tabby")
class Tabby {
  static var camera: Camera = new Camera();
  static var canvas: Canvas = new EmptyCanvas();
  static var font: Font; // todo
}
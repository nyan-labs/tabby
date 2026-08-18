package tabby;

import love.graphics.GraphicsModule;
import tabby.inputs.Mouse;
import love.Application;

class Game extends Application {
  public function new() {
    super();

    // adds to Input.listeners
    // var listener = Input.on.keypress((key) -> trace(key));
    // // on detach this will stop listening by removing itself
    // listener.attach(this);
  }

  // override function load() {}
  override function draw() {
    Tabby.canvas.draw();
  }

  override function update(delta: Float) {
    Tabby.canvas.update(delta);
  }

  override function mousemoved(x:Float, y:Float, dx:Float, dy:Float, istouch:Bool) {
    super.mousemoved(x, y, dx, dy, istouch);
    
    Mouse.mousemoved(x, y, dx, dy, istouch);
  }

  override function mousepressed(x:Float, y:Float, button:Float, istouch:Bool, presses:Float) {
    super.mousepressed(x, y, button, istouch, presses);

    Mouse.mousepressed(x, y, button, istouch, presses);
  }

  override function mousereleased(x:Float, y:Float, button:Float, istouch:Bool, presses:Float) {
    super.mousereleased(x, y, button, istouch, presses);

    Mouse.mousereleased(x, y, button, istouch, presses);
  }
}
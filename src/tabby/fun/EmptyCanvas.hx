package tabby.fun;

import tabby.inputs.Mouse;
import love.mouse.MouseModule;
import lua.Table;

class EmptyCanvas extends Canvas {
  var vert = [];

  public function new() {
    super();
  }

  override public function draw() {
    // if(vert.length >= 3) Graphics.polygon(Line, ...vert);
    Graphics.print('your did it ${vert.join(', ')}');
    Graphics.print('${Mouse.x}, ${Mouse.y}, ${Mouse.pressed}:${Mouse.is_pressed}, ${Mouse.released}:${Mouse.is_released}', 0, 50);
  }

  // var just_pressed = false;
  override public function update(delta) {
    // switch Mouse.just_pressed {
    //   case LEFT:
    //     trace("hi");
    //   case _: 
    //     trace("bye");
    // }
    // if(MouseModule.isDown(1)) {
      // if(!just_pressed) just_pressed = true;
    // }

    // trace(just_pressed);
    // if(just_pressed) {
      // vert.push(MouseModule.getX());
      // vert.push(MouseModule.getY());
    // }
  }
}
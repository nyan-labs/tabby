package tabby.inputs;

enum abstract MouseButtons(Float) {
  final NONE = 0; 
  final LEFT = 1; 
  final MIDDLE = 2; 
  final RIGHT = 3; 
}

@:allow(tabby.Game)
class Mouse {
  static public var x(default, null): Float = 0;
  static public var y(default, null): Float = 0;

  static public var pressed(default, null): MouseButtons;
  static public var is_pressed(default, null) = false;

  static public var released(default, null): MouseButtons;
  static public var is_released(default, null) = false;

  static public var presses(default, null): Float;



	static function mousemoved(x: Float, y: Float, dx: Float, dy: Float, istouch: Bool) {
    Mouse.x = x;
    Mouse.y = y;
  }

	static function mousereleased(x: Float, y: Float, button: Float, istouch: Bool, presses: Float) {
    Mouse.x = x;
    Mouse.y = y;

    Mouse.is_pressed = false;
    Mouse.is_released = true;
    Mouse.released = cast button;
    Mouse.presses = presses;
  }

	static function mousepressed(x: Float, y: Float, button: Float, istouch: Bool, presses: Float) {
    Mouse.x = x;
    Mouse.y = y;

    Mouse.is_released = false;
    Mouse.is_pressed = true;
    Mouse.pressed = cast button;
    Mouse.presses = presses;
  }
}
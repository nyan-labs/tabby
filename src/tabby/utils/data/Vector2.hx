package tabby.utils.data;

// abstract? to vector (size 2)?
@:structInit
@:expose("tabby.utils.data.Vector2")
class Vector2 { 
  public var x: Float;
  public var y: Float;

  public function new(?x: Float = 0, ?y: Float = 0) {
    this.x = x;
    this.y = y;
  }
}
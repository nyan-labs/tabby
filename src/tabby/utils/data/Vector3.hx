package tabby.utils.data;

// abstract? to vector (size 3)?
@:structInit
@:expose("tabby.utils.data.Vector3")
class Vector3 { 
  public var x: Float;
  public var y: Float;
  public var z: Float;

  public function new(?x: Float = 0, ?y: Float = 0, ?z: Float = 0) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}
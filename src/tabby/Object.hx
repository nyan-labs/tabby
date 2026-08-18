package tabby;

import tabby.utils.Component;
import tabby.impl.Destructable;
import lua.Lua;
import tabby.impl.Drawable;
import tabby.utils.data.Vector3;
import tabby.utils.data.UniqueArray;

@:expose("tabby.Object")
class Object implements Drawable implements Destructable {
	public var exists(default, null): Bool;
  
  public var position: Vector3;
  public var size: Vector3;
  public var rotation: Vector3;

  public var alive: Bool;

  public var parent: Null<Object>;
  public var children: UniqueArray<Object>;
  public var components: UniqueArray<Component<Object>>;

  public function new() {
    position = new Vector3();
    size = new Vector3();
    rotation = new Vector3();

    alive = true;

    parent = null;
    children = new UniqueArray();
  }

  public function load(): Void {}

  public function update(delta: Float): Void {}

  public function draw(): Void {}

  // love.Object methods
  public function release()
    return false;

  public function type()
    return Type.getClassName(Type.getClass(this));

  public function typeOf(name: String)
    return type() == name;

  public function destroy(): Bool {
    if(!exists) 
      return false;

    if(parent != null)
      parent.children.delete(this);

    for(component in components)
      component.detach();

    exists = false;
    return true;
  }
}
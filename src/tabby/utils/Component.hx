package tabby.utils;

import tabby.impl.Destructable;
import tabby.Object;
import tabby.impl.Attachable;

class Component<T: Object = Object> implements Attachable<T> implements Destructable {
	public var target: T;
	public var exists(default, null): Bool;

  public function new() {}

  public function detach() {
    this.target.components.delete(cast this);
  }

  public function attach(target: T) {
    this.target = target;
    this.target.components.add(cast this);
  }

  public function destroy() {
    if(!exists) 
      return false;
    
    detach();

    exists = false;
    return true;
  }
}
package tabby.utils;

import tabby.Object;

/**
  a `tabby.Group` holds many objects or anything that `extends Object`.

  these objects can be put in many groups, not just one. (but this does mean said object *will not* have its `.parent` set to any group)
**/
@:expose("tabby.utils.Group")
class Group<T: Object = Object> extends Object {
  var objects: Array<T>;
  
  public function new() {
    super();

    objects = new Array();
  }

  public function add(x: T) {
    objects.push(x);
  }

  override public function update(delta: Float) {
    for(object in objects)
      object.update(delta);
  }

  override public function draw() {
    for(object in objects)
      object.draw();
  }
}
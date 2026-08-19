package tabby.utils.data;

@:forward(iterator)
@:expose("tabby.utils.data.UniqueArray")
abstract UniqueArray<T>(Array<T>) {
  public function new(?array: Array<T>) {
    this = array ?? new Array<T>();
  }

  public function add(x: T) {
    trace(x);
    if(!has(x)) this.push(x);
  }

  public function has(x: T) {
    for(item in this) 
      if(item == x) return true;

    return false;
  }

  public function delete(x: T) {
    this.remove(x);
  }
}
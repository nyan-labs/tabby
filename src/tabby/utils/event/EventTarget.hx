package tabby.utils.event;

@:build(tabby.utils.event.EventTarget.build())
class EventTarget {
  public function new() {

  }

  @event public function change(balls: Int);

  @event public function kill(who: String);
  
  @event public function eat(what: String);
}
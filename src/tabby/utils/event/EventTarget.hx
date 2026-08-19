package tabby.utils.event;

import haxe.Rest;

typedef EventListener = Rest<Any> -> Void;
typedef EventListeners = Map<String, Array<EventListener>>;
typedef TypeListeners = {
  final once: EventListeners;
  final on: EventListeners;
}

@:build(tabby.utils.event.EventTarget.build())
class EventTarget {
  public function new() {

  }

  @event public function change(balls: Int);

  @event public function kill(who: String);
  
  @event public function eat(what: String);
}
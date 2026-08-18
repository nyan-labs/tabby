package tabby.utils.event;

import tabby.Object;

// an event listener (maybe abstract) (with special event type EventListener<CustomEvent>) needs to be able to be a component, which is created from like Input.on.event(), which this function would add to Input.listeners, which Game.lua.hx will listen for speicific tings

class EventListener extends Component<Object> {
  // override function attach() {
    
  // }
}
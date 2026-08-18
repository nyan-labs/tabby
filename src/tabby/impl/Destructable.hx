package tabby.impl;

interface Destructable {
  var exists(default, null): Bool;

  function destroy(): Bool;
}
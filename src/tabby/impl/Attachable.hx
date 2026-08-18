package tabby.impl;

interface Attachable<T: Object> {
  var target: T;

  function attach(target: T): Void;
  function detach(): Void;
}
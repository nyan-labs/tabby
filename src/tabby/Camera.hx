package tabby;

import tabby.Object;
import tabby.utils.data.Vector3;

// multiple cameras/viewports? they bassically are just scene wrappers that crop to any position, rotation and whatnot
class Camera {
  var canvas: Canvas = null;
  
  public function new() {
    // super();
  }

  function draw() {
    Graphics.push();
    // Graphics.translate(position.x, position.y);
    // Graphics.rotate(otation.z / (180/Math.PI));

    canvas.draw();
    
    Graphics.pop();
  }
}
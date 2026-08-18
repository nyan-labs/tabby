package tabby.ui;

import love.graphics.Text as LoveText;

// text wrapping like letter-breaks and stuff
class Text extends Entity {
  var text: LoveText;

  var content(default, set): String;
  inline function set_content(content: String) {
    text.set(content);

    return this.content = content;
  }

  public function new(content: String) {
    super();

    text = Graphics.newText(Tabby.font, this.content);
    
    this.content = content;
  }
  
  override function draw() {
    super.draw();

    Graphics.draw(text);
  }
}
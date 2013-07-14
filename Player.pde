// character image from 'http://usui.moo.jp/rpg_chadot21_30.html'

class Player implements LumiObject {

  private PImage[] img;
  private float x, y;
  private float width, height;
  private int direction;
  

  Player(float x, float y, float width, float height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;

    img = new PImage[4];
    for (int i = 0; i < img.length; i++) {
      img[i] = loadImage("player0" + (i+1) + ".png");
    }
  }

  private void update() {
    float vx = 1;
    float vy = 1;
    
    if (key == 'j') {
      y += vy;
      direction = 0;
    }
    if (key == 'k') {
      y -= vy;
      direction = 2;      
    }
    if (key == 'h') {
      x -= vx;
      direction = 1;
    }
    if (key == 'l') {
      x += vx;
      direction = 3;
    }
  }

  @Override
  public void draw(PGraphics[] screens) {
    update();

    for (int i = 0; i < screens.length; i++) {
      PGraphics s = screens[i];
      s.beginDraw();

      s.imageMode(CENTER);

      s.pushMatrix();
      s.translate(x, y);
      s.rotate(i*-HALF_PI);
      int d = (i+direction) % 4;
      s.image(img[d], 0, 0, width, height);
      s.popMatrix();

      s.endDraw();
    }
  }
}
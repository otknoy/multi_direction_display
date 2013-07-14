import java.awt.Point;

Lumisight lumi;
Player player;

void setup() {
  size(400*4, 300, P3D);
  colorMode(HSB, 360, 100, 100);

  lumi = new Lumisight(this, 240, 240, 4);
  player = new Player(0, 0, 24, 24);
}

void draw() {
  println(frameRate);

  background(0, 0, 0);
  
  PGraphics[] screens = lumi.getScreens();
  for (int i = 0; i < screens.length; i++) {
    PGraphics s = screens[i];
    s.beginDraw();

    s.background(255);
    s.rect(75, 100, 150, 80);
    float x = 64 * cos(radians(frameCount)) + 100;
    float y = 64 * sin(radians(frameCount)) + 200;
    s.ellipse(x, y, 8, 8);

    s.endDraw();
  }

  player.draw(lumi.getScreens());

  lumi.update();
}



Point selected;

void mousePressed() {
  Display[] displays = lumi.getDisplays();
  double minDist = Double.MAX_VALUE;
  for (Display display: displays) {
    for (Point p : display.getVertices()) {
      double d = p.distance(new Point(mouseX, mouseY));
      if (d < minDist) {
	minDist = d;
	selected = p;
      }
    }
  }
}

void mouseDragged() {
  selected.setLocation(mouseX, mouseY);
}

void mouseReleased() {
  selected = null;
}

import java.awt.Point;

class Display {

  private PGraphics pg;
  private Point[] v;

  public Display(PGraphics pg, int x, int y, int width, int height, int orient) {
    this.pg = pg;

    int[] edgeOrder = (new int[][]{{0, 1, 2, 3},
				   {2, 0, 3, 1},
				   {3, 2, 1, 0},
				   {1, 3, 0, 2}})[orient-1];

    Point[] v = new Point[4];
    v[edgeOrder[0]] = new Point(x, y);
    v[edgeOrder[1]] = new Point(x+width, y);
    v[edgeOrder[2]] = new Point(x, y+height);
    v[edgeOrder[3]] = new Point(x+width, y+height);
    this.v = v;
  }

  public Display(int x, int y, int width, int height, int orient) {
    this(null, x, y, width, height, orient);
  }

  public void draw(PGraphics pg) {
    noStroke();
    beginShape(QUAD_STRIP);
    texture(pg);
    int n = 128;
    for (int i = 0; i <= n; i++) {
      float ratio = i / (float)n;

      float x = v[0].x + ratio * (v[1].x - v[0].x);
      float y = v[0].y + ratio * (v[1].y - v[0].y);
      vertex(x, y, ratio*pg.width, 0);

      x = v[2].x + ratio * (v[3].x - v[2].x);
      y = v[2].y + ratio * (v[3].y - v[2].y);
      vertex(x, y, ratio*pg.width, pg.height);
    }
    endShape(CLOSE);

    stroke(0);
    for (int i = 0; i < this.v.length; i++) {
      Point v = this.v[i];

      fill(map(i, 0, this.v.length, 0, 360), 100, 100);
      ellipse(v.x, v.y, 8, 8);
    }
  }
  
  public void draw() {
    draw(this.pg);
  }


  public Point[] getVertices() {
    return v;
  }
}
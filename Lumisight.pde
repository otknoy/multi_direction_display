public class Lumisight {

  private PApplet parent;
  private Display[] displays;
  private PGraphics[] screens;


  public Lumisight(PApplet parent, int width, int height, int screenNum) {
    this.parent = parent;

    float screenWidth  = this.parent.width  / (float)screenNum;
    Display[] displays = new Display[screenNum];
    for (int i = 0; i < displays.length; i++) {
      float x = i * screenWidth  + ((screenWidth  - width) / 2.0);
      float y = (parent.height - height) / 2.0;;
      
      displays[i] = new Display((int)x, (int)y, width, height, i+1);
    }
    this.displays = displays;
    
    PGraphics[] screens = new PGraphics[displays.length];
    for (int i = 0; i < screens.length; i++) {
      screens[i] = createGraphics(width, height, P2D);
    }
    this.screens = screens;
  }

  public void update() {
    for (int i = 0; i < screens.length; i++) {
      displays[i].draw(screens[i]);
    }
  }

  public PGraphics[] getScreens() {
    return screens;
  }

  public Display[] getDisplays() {
    return displays;
  }
}
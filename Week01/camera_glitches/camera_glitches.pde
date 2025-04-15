import processing.video.*;
Capture cam;

void setup() {
  size(640, 480);
  String[] cameras = Capture.list();
  for (int s=0; s<cameras.length; s++) {
    println(cameras[s]);
  }
  cam = new Capture(this, cameras[0]);
  cam.start();
}
void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  tint(255, 255);
  image(cam, 0, 0, width, height);

  loadPixels();
  for (int y=0; y<height; y++) {
    for (int x=0; x<width; x++) {
      int index = x + (y*width);
      color c = pixels[index];
      if (index - width > 0 && red(c)>150) {
        pixels[index] = pixels[index - width];
      } else if (brightness(c) < 100) {
        pixels[index] = color(0,0);
      }
    }
  }
  updatePixels();

  surface.setTitle(str(frameRate));
}

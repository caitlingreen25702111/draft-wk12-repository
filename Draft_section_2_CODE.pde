float AngleStart = 0;  // where outer ring starts
float AngleBump = 0;   // added rotation of each ringfloat Speed = .7
color RedColor = color(50, 0, 0);
color BlueColor = color(200, 0, 0);

void setup() {
  size (800,800);
  background(color(0, 0, 0));
  smooth();  
  //noloop();
}
void draw(){
  background(color(127, 0, 0));
  translate(width/2,height/2);
  for(int a=0; a<360; a+=2) {
    float x = random(50,150);
    float xx = random (150, 350);
    color RedColor = color(100, 0, 0);
    color BlueColor = color(200, 0, 0);
    pushMatrix();
    rotate(radians(a));
    line(x,0,xx,0);
    popMatrix();
  }
}

void keyPressed() {
  redraw();
}

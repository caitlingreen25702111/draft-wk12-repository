// Number of stars in the animation
int numStars = 500;

// Array to hold all Star objects
Star[] stars = new Star[numStars];

// List to hold Firework objects after explosion
ArrayList<Firework> fireworks = new ArrayList<Firework>();

// Variables to control timing and state changes
float startTime;        // records when the animation began
boolean exploded = false;  // true once stars turn into fireworks
boolean blackout = false;  // true once fireworks finish
boolean redScreen = false; // true once screen should turn red


// setup() runs once when the sketch starts

void setup() {
  size(800, 600);   // create a window 800px wide and 600px tall
  
  // create each star and store it in the array
  for (int i = 0; i < numStars; i++) {
    stars[i] = new Star();
  }
  
  // record the start time in milliseconds
  startTime = millis();
}

// draw() runs on animation loop

void draw() {
  // calculate how many seconds have passed since the start
  float elapsed = (millis() - startTime) / 1000.0;

  // star movement portion
  if (!exploded && elapsed < 20) {
    background(0);                 // black background
    translate(width/2, height/2);  // move origin to the screen centre
    
    // update and draw each star
    for (Star s : stars) {
      s.update();
      s.show();
    }
  }
  
  // fireworks begin (at 15 seconds)
  else if (!exploded && elapsed >= 15) {
    exploded = true; // mark that explosion has begun
    
    // create a firework at every stars position
    for (Star s : stars) {
      fireworks.add(new Firework(s.x, s.y));
    }
  }
  
  // firework portion
  else if (exploded && !blackout) {
    background(0, 20);   // mostly black but with transparency for trails
    translate(width/2, height/2);
    
    // update and draw all fireworks
    for (int i = fireworks.size()-1; i >= 0; i--) {
      Firework f = fireworks.get(i);
      f.update();
      f.show();
      
      // remove fireworks that have finished
      if (f.done()) fireworks.remove(i);
    }
    
    // when all fireworks are gone, start blackout
    if (fireworks.isEmpty()) blackout = true;
  }
  
  // Black screen portion
  else if (blackout && !redScreen) {
    background(0);  // full black
    delay(1000);    // small pause before turning red
    redScreen = true;
  }
  
  //Red screen portion
  else if (redScreen) {
    background(127, 0, 0);  // full red
  }
}

// Represents a single moving star in space

class Star {
  float x, y, z; // 3D position values
  
  // Constructor: gives each star a random position
  Star() {
    x = random(-width, width);
    y = random(-height, height);
    z = random(width);
  }
  
  // update(): moves the star closer to the viewer
  void update() {
    z -= 10; // speed of movement (smaller z = closer)
    
    // if the star passes the viewer, reset its position
    if (z < 1) {
      z = width;
      x = random(-width, width);
      y = random(-height, height);
    }
  }
  
  // show(): draws the star on screen
  void show() {
    fill(255);      // white colour
    noStroke();     // no outline
    
    // map 3D coordinates to 2D screen space
    float sx = map(x / z, 0, 1, 0, width);
    float sy = map(y / z, 0, 1, 0, height);
    
    // stars appear larger when closer (small z)
    float r = map(z, 0, width, 8, 0);
    ellipse(sx, sy, r, r); // draw star as a circle
  }
}

// A firework is made up of multiple coloured particles

class Firework {
  ArrayList<Particle> particles = new ArrayList<Particle>();
  
  // Constructor: create a burst of particles from one point
  Firework(float x, float y) {
    int count = int(random(30, 60)); // number of particles in each explosion
    for (int i = 0; i < count; i++) {
      particles.add(new Particle(x, y));
    }
  }
  
  // update(): move all particles
  void update() {
    for (Particle p : particles) p.update();
  }
  
  // show(): draw all particles
  void show() {
    for (Particle p : particles) p.show();
  }
  
  // done(): check if all particles have faded out
  boolean done() {
    for (Particle p : particles) {
      if (!p.done()) return false;
    }
    return true;
  }
}


// Each firework particle has motion, colour, and lifespan
class Particle {
  PVector pos;   // position
  PVector vel;   // velocity
  float life = 255; // transparency (fades out over time)
  color c;       // particle colour
  
  // Constructor: assign random direction and colour
  Particle(float x, float y) {
    pos = new PVector(x, y);
    float angle = random(TWO_PI);  // random direction (0–360°)
    float speed = random(2, 6);    // random speed
    vel = new PVector(cos(angle), sin(angle)).mult(speed);
    c = color(255); //white colour 
  }
  
  // update(): move the particle, apply gravity and fading
  void update() {
    pos.add(vel);     // move based on velocity
    vel.mult(0.95);   // slow down slightly each frame (air resistance)
    vel.y += 0.1;     // simulate gravity pulling down
    life -= 4;        // fade out over time
  }
  
  // show(): draw the particle
  void show() {
    noStroke();
    fill(c, life);    // apply transparency using 'life' value
    ellipse(pos.x, pos.y, 4, 4);
  }
  
  // done(): check if particle has completely faded
  boolean done() {
    return life <= 0;
  }
}
float AngleStart = 0;  // where outer ring starts
float AngleBump = 0;   // added rotation of each ringfloat Speed = .7
color RedColor = color(50, 0, 0);
color BlueColor = color(200, 0, 0);
// part just entered
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

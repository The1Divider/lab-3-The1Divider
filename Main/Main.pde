import java.lang.Math;

Cloud cloud;
PFont MonoCorsiva;
int width = 450, height = 400;
int cloudMarker;
int cloudMarker2;
Cloud[] cloudArray;

void setup() {
  size(450, 400);

  stroke(0, 0, 0);
  ellipseMode(CENTER);
  
  MonoCorsiva = createFont("MonotypeCorsiva-48", 48);
  textFont(MonoCorsiva);
  
  fill(5, 255, 107);
  ellipse(225, 220, 20, 250);

  beginShape();
  fill(165, 129, 0);
  vertex(0, 390);
  bezierVertex(45, 275, 405, 275, 450, 390);
  vertex(450, 400);
  vertex(0, 400);
  endShape();
  
  Leaf leaf = new Leaf();
  
  textAlign(CENTER);
  text("Summer", 225, 370);
  
  cloudMarker = 300;
  cloudMarker2 = 25;
  
  cloudArray = new Cloud[2];
  cloudArray[0] = new Cloud(cloudMarker, 100);
  cloudArray[1] = new Cloud(cloudMarker2, 50);
   
}

void draw() {
  background(103, 231, 255);
  for (Cloud cloud: cloudArray) {
    cloud.draw(cloud.cloudMarker);
    
    if (cloud.cloudMarker > -100) {
      cloud.cloudMarker -= 1;
    } else {
      cloud.cloudMarker = 450;
    }
  }
  fill(219, 255, 64);
  ellipse(225, 100, 40, 40);
  
  Petals petals = new Petals();
}

class Cloud {
  PVector currentPoint;
  int cloudMarker;
  int y;
  
  Cloud(int marker, int y) {
   colorMode(RGB);
   fill(255, 255, 255);
   stroke(0, 0, 0);
   
   cloudMarker = marker;
   this.y = y;
  }
  
  void draw(int x) {
   
   currentPoint = new PVector(x, this.y);
   PVector P1 = new PVector(currentPoint.x + 40, currentPoint.y - 20);
   PVector P2 = new PVector(currentPoint.x + 80, currentPoint.y - 15);
   PVector P3 = new PVector(currentPoint.x + 87, currentPoint.y + 10);
   PVector P4 = new PVector(currentPoint.x + 60, currentPoint.y + 20);
   PVector P5 = new PVector(currentPoint.x + 30, currentPoint.y + 20);
   beginShape();
   fill(255, 255, 255);
   vertex(currentPoint.x, currentPoint.y);
   bezierVertex(currentPoint.x - 10, currentPoint.y - 20, P1.x - 2, P1.y - 5, P1.x, P1.y /* P1 */);
   bezierVertex(P1.x + 10, P1.y - 10, P2.x - 10, P2.y - 15, P2.x, P2.y /* P2 */);
   bezierVertex(P2.x + 15, P2.y + 10, P3.x + 10, P3.y - 10, P3.x, P3.y /* P3 */);
   bezierVertex(P3.x + 2, P3.y + 10, P4.x + 10, P4.y + 10, P4.x, P4.y /* P4 */);
   bezierVertex(P4.x - 2, P4.y + 15, P5.x - 5, P5.y + 15, P5.x, P5.y /* P5 */);
   bezierVertex(P5.x - 15, P5.y + 10, currentPoint.x - 5, currentPoint.y + 15, currentPoint.x, currentPoint.y /* start point */);
   endShape();
  }
}
  


void rotate2D(PVector v, float theta) {
  float xTemp = v.x;
  v.x = v.x*cos(theta) - v.y*sin(theta);
  v.y = xTemp*sin(theta) + v.y*cos(theta);
}


class Petals {
  PVector pos, dir;
  int[] colours = {10, 220, 0};

  Petals() {
    // petal logic
    // fun math for fill -> multicoloured flower
    pos = new PVector(225, 100); // initial pos
    dir = new PVector(0, 20); 
    float petalWidth = 40,  petalHeight= 60; 
    colorMode(HSB, 359, 99, 99);
    for (int i = 0; i < 36; i++) {
      colours = changeColour(colours); // colour in hsb?
      fill(colours[0], colours[1], colours[2]);
      
      pushMatrix(); // rotation + draw per petal
      translate(pos.x, pos.y-20); // pushes petals 'up'
      rotate(atan2(dir.x, dir.y)); // rotate based on vector
      translate(0, 40);
      ellipse(dir.x, dir.y, petalWidth, petalHeight); // draw
      popMatrix();
      
      rotate2D(dir, radians(10*i)); // rotate petal
    }
  }
  
  int[] changeColour(int[] colours) { // add conditions to filter colours
    for (int j = 0; j < 3; j++) {
      boolean notInRange = true;
      while (notInRange) {
        colours[j] = (int) (Math.random() * 338);
        notInRange = !inColourRange(colours, j); 
      }
    }
    return colours;
  }
  
  boolean inColourRange (int[] colours, int value) { //<>//
    switch (value) {
      case 0:
        int h = colours[0];
        if ((h > 70 && h < 170) || h < 50) {
          return false;
        } else {return true;}
        
      case 1:
        int s = colours[1];
        if (s < 35 || s > 60 || s > 99) {
          return false;
        } else {return true;}
        
      case 2:
        int b = colours[2];
        if (b < 80 || b > 99) {
          return false;
        } else {return true;}
        
      default:
        return false;
    }
  }
}

class Leaf {
  Leaf() {
    colorMode(HSB, 359, 99, 99);
    int[] colours = {0, 0, 0};
    colours = colourLeaf(colours);
    System.out.println(colours[0]);
    System.out.println(colours[1]);
    System.out.println(colours[2]);
    
    PVector leafDim = new PVector(70, 20);
    PVector anchor = new PVector(230, 200);
    PVector anchor2 = new PVector(anchor.x + leafDim.x, anchor.y - 20);
    PVector dir = new PVector(0, 20);
    
    beginShape();
    fill(colours[0], colours[1], colours[2]);
    vertex(anchor.x, anchor.y);
    bezierVertex(anchor.x + 10, anchor.y - leafDim.y, anchor2.x - 10, anchor2.y - leafDim.y, anchor2.x, anchor2.y);
    bezierVertex(anchor2.x - 10, anchor2.y + leafDim.y, anchor.x + 10, anchor.y + leafDim.y, anchor.x, anchor.y);
    endShape();
    
    beginShape();
    stroke(colours[0], colours[1], colours[2]-30);
    vertex(anchor.x, anchor.y);
    vertex(anchor2.x, anchor2.y);
    endShape();
  }
  
  int[] colourLeaf(int[] colours) {
    for (int i = 0; i < 3; i++) {
      while (true) {
        int value = (int) (Math.random() * (150 - 85) + 85);
        if (i == 0) {
          colours[i] = value;
          break;
        } else if (i == 1 && value > 60 && value < 100) {
           colours[i] = value;
           break;
        } else if (i == 2 && value > 80 && value < 100) {
           colours[i] = value;
           break;
        }
      }
    }
    return colours;
  }
}
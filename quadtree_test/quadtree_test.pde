// Andrew Craigie
// quadtree_test.pde

// Test sketch used to develop and test a QuadTree in Processing
// A port of on Daniel Shiffman's QuadTree implementation here
// https://github.com/CodingTrain/QuadTree/blob/master/examples/visualize_qtree/sketch.js

import java.awt.Rectangle;
import java.awt.Point;

QuadTree qtree;

int pointCount = 0;

void setup() {
  size(800, 800);

  qtree = new QuadTree(new Rectangle(0, 0, 800, 800), 4);

  for (int i = 0; i < 1000; i++) {

    int pX = int((randomGaussian() * 100) + 400);
    int pY = int((randomGaussian() * 100) + 400);
    Point newtploc =  new Point(pX, pY);
    //Point newtploc =  new Point(int(random(5, 795)), int(random(5, 795)));
    color c = color(random(255), random(255), random(255));
    TransPixel newtp = new TransPixel(newtploc, c);
    qtree.insert(newtp);
  }
}

void show(QuadTree qt) {

  stroke(127, 127, 127, 100);
  noFill();
  strokeWeight(1);
  //rectMode(CENTER);
  rectMode(CORNER);
  rect(qt.bounds.x, qt.bounds.y, qt.bounds.width, qt.bounds.height);

  for (int i = 0; i < qt.tPixels.size(); i++) {
    TransPixel p = qt.tPixels.get(i);
    stroke(255);
    strokeWeight(1);
    //fill(p.c);
    fill(255);
    ellipse(p.loc.x, p.loc.y, 2, 2);
    pointCount++;
  }

  if (qt.divided) {
    show(qt.northwest);
    show(qt.northeast);
    show(qt.southwest);
    show(qt.southeast);
  }
}

void draw() {
  background(0);
  show(qtree);

  noFill();
  stroke(255, 255, 0);
  int cX = mouseX;
  int cY = mouseY;
  int w = 200;
  int h = 150;
  rectMode(CENTER);

  rect(cX, cY, w, h);

  Rectangle r = new Rectangle(cX - w/2, cY - h/2, w, h);
  ArrayList<TransPixel> ps = new ArrayList<TransPixel>();
  
  // Query the QuadTree to retreive points with the dragged rectangle
  ps = qtree.query(r, ps);

  for (int i = 0; i < ps.size(); i++) {
    TransPixel p = ps.get(i);
    stroke(p.c);
    strokeWeight(4);
    point(p.loc.x, p.loc.y);
  }
}

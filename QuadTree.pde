// Andrew Craigie
// A port of on Daniel Shiffman's QuadTree implementation here
// https://github.com/CodingTrain/QuadTree/blob/master/examples/visualize_qtree/sketch.js

import java.awt.Rectangle;
import java.awt.Point;

class QuadTree {

  ArrayList<TransPixel> tPixels;

  Rectangle bounds;
  int capacity;
  boolean divided;

  QuadTree northeast;
  QuadTree northwest;
  QuadTree southeast;
  QuadTree southwest;

  QuadTree(Rectangle boundary, int cap) {
    this.bounds = boundary;
    this.capacity = cap;
    this.tPixels = new ArrayList<TransPixel>();
    this.divided = false;
  }

  void subdivide() {
    int x = this.bounds.x;
    int y = this.bounds.y;
    int w = this.bounds.width;
    int h = this.bounds.height;

    Rectangle nw = new Rectangle(x, y, w/2, h/2);
    Rectangle ne = new Rectangle(x + w/2, y, w/2, h/2);
    Rectangle sw = new Rectangle(x, y + h/2, w/2, h/2);
    Rectangle se = new Rectangle(x + w/2, y + h/2, w/2, h/2);
    
    this.northeast = new QuadTree(ne, capacity);
    this.northwest = new QuadTree(nw, capacity);
    this.southeast = new QuadTree(se, capacity);
    this.southwest = new QuadTree(sw, capacity);

    this.divided = true;
  
  }

  boolean insert(TransPixel tPix) {
        
    if (!this.bounds.contains(tPix.loc)) {
      return false;
    }

    if (this.tPixels.size() < this.capacity) {
      this.tPixels.add(tPix);
      return true;
    }

    if (!this.divided) {
      this.subdivide();
    }

    return (this.northeast.insert(tPix) ||
      this.northwest.insert(tPix) ||
      this.southeast.insert(tPix) ||
      this.southwest.insert(tPix));
      
  }

  ArrayList<TransPixel> query (Rectangle range, ArrayList<TransPixel> found) {
    
    // When used remember to pass in an empty ArrayList<TransPixel>

    if (range.intersects(bounds) == false) {
      return found;
    }

    for (int i = 0; i < tPixels.size(); i++) {
      TransPixel p = tPixels.get(i);
      if (range.contains(p.loc)) {
        found.add(p);
      }
    }

    if (divided == true) {
      this.northwest.query(range, found);
      this.northeast.query(range, found);
      this.southwest.query(range, found);
      this.southeast.query(range, found);
    }

    return found;
  }
}

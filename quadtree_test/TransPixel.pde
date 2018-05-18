// Andrew Craigie
// TransPixel

// A class to store pixel location and color values
// Developed to be used in blurring filters

import java.awt.Point;

class TransPixel{

  Point loc;
  color c;

  TransPixel(Point tpLoc, color col) {
    this.loc = tpLoc;
    this.c = col;
  }

  int r(){
   return QColor.r(c);
  }
  int g(){
    return QColor.g(c);
  }
  int b(){
    return QColor.b(c);
  }
  int a(){
    return QColor.a(c);
  }

}

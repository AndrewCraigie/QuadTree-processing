// Andrew Craigie
// Qcolor
// Static class to hold methods to quickly access color data

static class QColor {
  static int r(color forR) {
    return (forR >> 16) & 0xFF;
  }
  static int g(color forG) {
    return (forG >> 8) & 0xFF;
  }
  static int b(color forB) {
    return (forB & 0xFF);
  }
  static int a(color forA) {
    return (forA >> 24) & 0xFF;
  }
}

class dot {
  int x, y, halfsize, ID;

  int col=int(random(100));

  dot(int tempx, int tempy, int tempsize, int tempID) {
    x=tempx;
    y=tempy;
    halfsize=tempsize;
    ID=tempID;
    colorMode(HSB, 100);
  }

  void check() {
    if (mouseX>x-halfsize && mouseX< x+halfsize 
      && mouseY>y-halfsize&&mouseY<y+halfsize && mousePressed) {
      movethisID=ID;
    }
  }
  void update() {
    if (movethisID==ID) {
      x=mouseX;
      y=mouseY;
    }
    fill(col, 100, 100);
    ellipse(x, y, 2*halfsize, 2*halfsize);
  }
}


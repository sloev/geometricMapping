class dot {
  int x, y, halfsize, ID;

  int col=40;
  int colb=20;

  dot(int tempx, int tempy, int tempsize, int tempID) {
    x=tempx;
    y=tempy;
    halfsize=tempsize;
    ID=tempID;
  }

  void check() {
    if (mouseX>x-halfsize && mouseX< x+halfsize 
      && mouseY>y-halfsize&&mouseY<y+halfsize ) {
      if (mousePressed) {
        movethisID=ID;
      }
      col=100;
    }
    else {
      col=40;
    }
  }
  void update() {
    if (movethisID==ID) {
      x=mouseX;
      y=mouseY;
    }
    colorMode(HSB, 100);

    stroke(colb, 100, 100);
    fill(colb, 100, col);
    ellipse(x, y, 2*halfsize, 2*halfsize);
    noStroke();
  }
}


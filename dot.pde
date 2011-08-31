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
      colorMode(HSB, 100);


      if (mousePressed) {
        movethisID=ID;
      }
      else {
        stroke(colb, 100, 100);
        noFill();
        ellipse(x, y, 2*halfsize, 2*halfsize);
      }
      col=100;
    }
    else {
      col=40;
    }
  }
  void update() {
    colorMode(HSB, 100);
    if (movethisID==ID) {
      x=mouseX;
      y=mouseY;
      stroke(colb, 100, 100);
      noFill();
      ellipse(x, y, 2*halfsize, 2*halfsize);
    }
    fill(colb, 100, 100);
    noStroke();
    ellipse(x, y, halfsize, halfsize);
  }
}


class triangular {
  int p1, p2, p3;
  triangular(int temp1, int temp2, int temp3) {
    p1=temp1;
    p2=temp2;
    p3=temp3;
  }

  void display() {
    fill(100, 100);
    beginShape();
    vertex(dots[p1].x, dots[p1].y,0);
    vertex(dots[p2].x, dots[p2].y,0);
    vertex(dots[p3].x, dots[p3].y,0);
    endShape();
  }
}


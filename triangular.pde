class triangular {
  int p1, p2, p3, thismovie;
  int thresh;
  int col=int(random(100));
  triangular(int temp1, int temp2, int temp3) {
    p1=temp1;
    p2=temp2;
    p3=temp3;
    findmovie();

    thresh=0;
    counter();
  }

  void display() {
    colorMode(HSB, 100);
    //fill(100, 0, 100);

    //tint(perlincolor(), 100, 100, 100);
    if ((int)checkdots.arrayValue()[0]==0) {
      stroke(20, 100, 100, 100);
    }
    else {
      noStroke();
    }
    beginShape(TRIANGLES);
    texture(movie[thismovie]);
    vertex(dots[p1].x, dots[p1].y, 0, movie[thismovie].width/2, 0);
    vertex(dots[p2].x, dots[p2].y, 0, 0, movie[thismovie].height);
    vertex(dots[p3].x, dots[p3].y, 0, movie[thismovie].width, movie[thismovie].height);
    endShape();
    noTint();
    counter();
  }

  void findmovie() {
    thismovie=int(random(movie.length));
  }

  void counter() {
    if (millis()>thresh) {
      thresh=millis()+int(random(5, 25)*1000);
      findmovie();
    }
  }

  int perlincolor() {
    col+=2*noise(millis());
    if (col>100) {
      col=0;
    }
    if (col<0) {
      col=100;
    }
    return col;
  }
}


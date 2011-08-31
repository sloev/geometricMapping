import controlP5.*;

ControlP5 controlp5;

//all dots in geometric corners
dot [] dots;

RadioButton radios;

int newtrianglefinnished=0;

int myColorBackground = color(0, 0, 0);

int movethisID=-1;

void setup() {
  size(400, 400);
    
  dots = new dot[0];
  

  controlp5 = new ControlP5(this);

  radios = controlp5.addRadioButton("radios", 20, 160);
  radios.setColorForeground(color(120));
  radios.setColorActive(color(255));
  radios.setColorLabel(color(255));
  radios.setSpacingColumn(50);

  addToRadioButton(radios, "triangular", 1);
  addToRadioButton(radios, "rectangular", 2);
  addToRadioButton(radios, "polygon", 3);
}

void draw() {
  background(myColorBackground);

  for (int i=0;i<dots.length;i++) {
    dots[i].check();
  }
  for (int i=0;i<dots.length;i++) {
    dots[i].update();
  }
}

void mouseReleased() {
  movethisID=-1;

}

void mousePressed() {
    switch(int(radios.value())) {
  case 0:
    break;
    //make triangles
  case 1:
  if(newtrianglefinnished>0){
        dots =(dot []) expand(dots, dots.length+1);

      dots[dots.length-1]=new dot(mouseX, mouseY, 10, dots.length-1);
 

      println(dots.length+" "+dots[dots.length-1].ID);
  
    //    dots = (CheckBox) expand(dots,dots.size()+1);

    //    print(dots.size());
  }
    newtrianglefinnished++;
    if (newtrianglefinnished>3) {
      newtrianglefinnished=0;
      radios.deactivateAll();
    }
    break;
    //make rectangles
  case 2:
    break;
    //make other stuff
  case 3:
  }
}

//radiobutton debugging

void addToRadioButton(RadioButton theRadioButton, String theName, int theValue ) {
  Toggle t = theRadioButton.addItem(theName, theValue);
  t.captionLabel().setColorBackground(color(80));
  t.captionLabel().style().movePadding(2, 0, -1, 2);
  t.captionLabel().style().moveMargin(-2, 0, 0, -3);
  t.captionLabel().style().backgroundWidth = 46;
}




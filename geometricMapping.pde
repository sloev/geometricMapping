import controlP5.*;
import processing.opengl.*;

ControlP5 controlp5;

//all dots in geometric corners
dot [] dots;
//for checking which dot you are moving
int movethisID=-1;

//for loading and saving configs
DropdownList p1;
Textfield myTextfield;

//menu
RadioButton radios;

//triangle stuff
//to control when drawing of a triangle is finnished
int newtrianglefinnished=0;
triangular [] triangulars;

//triangle stuff
//to control when drawing of a triangle is finnished
int newrectanglefinnished=0;
rectangular [] rectangulars;

//for hiding buttons
int myColorBackground = color(0, 0, 0);


void setup() {
  size(400, 400, OPENGL);
  smooth();

  //init of my geometric arrays
  dots = new dot[0];
  triangulars = new triangular[0];
  rectangulars = new rectangular[0];

  //init of controlp5 and creation of menus 
  controlp5 = new ControlP5(this);

  //geometric menu
  radios = controlp5.addRadioButton("radios", 20, 160);
  radios.setColorForeground(color(120));
  radios.setColorActive(color(255));
  radios.setColorLabel(color(255));
  radios.setSpacingColumn(50);
  addToRadioButton(radios, "triangular", 1);
  addToRadioButton(radios, "rectangular", 2);
  addToRadioButton(radios, "polygon", 3);

  //saving field
  myTextfield = controlp5.addTextfield("texting", 160, 100, 200, 20);
  myTextfield.setFocus(false);
  myTextfield.setAutoClear(false);
  myTextfield.keepFocus(false);
  myTextfield.setText("write savename and enter");

  //loading dropdown
  p1 = controlp5.addDropdownList("P1", 100, 100, 100, 120);
  customize(p1);
}

void draw() {
  colorMode(RGB, 255);
  background(myColorBackground);

  for (int i=0;i<dots.length;i++) {
    dots[i].check();
  }
  for (int i=0;i<dots.length;i++) {
    dots[i].update();
  }
  for (int i=0;i<triangulars.length;i++) {
    triangulars[i].display();
  }
  for (int i=0;i<rectangulars.length;i++) {
    rectangulars[i].display();
  }
}

// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } 
  else {
    // If it's not a directory
    return null;
  }
}

void mouseReleased() {
  //when mouse is released no dot is touched
  movethisID=-1;
}

void mousePressed() {
  switch(int(radios.value())) {//listens to the geometric menu
  case 0://nothing happens when no menu is selected
    break;
  case 1://make triangles
    if (newtrianglefinnished>0) {//this is done to avoid creating a point the same instance you click a menu item
      //expand the array
      dots =(dot []) expand(dots, dots.length+1);
      dots[dots.length-1]=new dot(mouseX, mouseY, 10, dots.length-1);//create new dot
    }
    newtrianglefinnished++;//move toward creation of a triangle
    if (newtrianglefinnished>3) {//if the triangle is finnished
      newtrianglefinnished=0;//init
      radios.deactivateAll();//deselct menu items
      //create triangle of past 3 dots
      triangulars = (triangular [] ) expand(triangulars, triangulars.length+1);
      triangulars[triangulars.length-1]=new triangular(dots.length-3, dots.length-2, dots.length-1);
      int a=triangulars.length-1;
      println("triangle number "+a+" created");
    }
    break;
    //make rectangles
  case 2:
    if (newrectanglefinnished>0) {//this is done to avoid creating a point the same instance you click a menu item
      //expand the array
      dots =(dot []) expand(dots, dots.length+1);
      dots[dots.length-1]=new dot(mouseX, mouseY, 10, dots.length-1);//create new dot
    }
    newrectanglefinnished++;//move toward creation of a triangle
    if (newrectanglefinnished>4) {//if the triangle is finnished
      newrectanglefinnished=0;//init
      radios.deactivateAll();//deselct menu items
      //create triangle of past 3 dots
      rectangulars = (rectangular [] ) expand(rectangulars, rectangulars.length+1);
      rectangulars[rectangulars.length-1]=new rectangular(dots.length-4, dots.length-3, dots.length-2, dots.length-1);
      int a=rectangulars.length-1;
      println("rectangle number "+a+" created");
    }
    break;
    //make other stuff
  case 3:
  }
}

//costomize the dropdown
void customize(DropdownList ddl) {
  //make list of saved files in data directory
  String path = sketchPath;
  String[] filenamesdata = listFileNames(path+"/data/");

  ddl.clear();
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.captionLabel().set("load config");
  ddl.captionLabel().style().marginTop = 3;
  ddl.captionLabel().style().marginLeft = 3;
  ddl.valueLabel().style().marginTop = 3;
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));

  //add all the previous saved files
  for (int i=0;i<filenamesdata.length;i++) {
    p1.addItem(filenamesdata[i], i);
  }
}

//radiobutton creation
void addToRadioButton(RadioButton theRadioButton, String theName, int theValue ) {
  Toggle t = theRadioButton.addItem(theName, theValue);
  t.captionLabel().setColorBackground(color(80));
  t.captionLabel().style().movePadding(2, 0, -1, 2);
  t.captionLabel().style().moveMargin(-2, 0, 0, -3);
  t.captionLabel().style().backgroundWidth = 46;
}

void controlEvent(ControlEvent theEvent) {
  // PulldownMenu is if type ControlGroup.
  // A controlEvent will be triggered from within the ControlGroup.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message from controlP5.

  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    if (theEvent.group().name().equals("P1")) {
      println("loading "+theEvent.group().stringValue()+" config file");
      loading(theEvent.group().stringValue());
    }
  } 
  //if enter is pressed in the textfield try to save
  else if (theEvent.controller() instanceof Textfield) {
    //if there is anything to save
    if (dots.length>3) {
      saving(theEvent.controller().stringValue());
    }
    ((Textfield)theEvent.controller()).setText("write savename and enter");
  }
}

//the loading mechanism
void loading(String loadname) {
  //init all geometric arrays
  dots = new dot[0];
  triangulars = new triangular[0];
  rectangulars = new rectangular[0];

  //make an empty string array
  String [] lines = loadStrings(sketchPath+"/data/"+loadname);
  int form=1;

  for (int i=0;i < lines.length;i++) {
    /*if (lines[i].equals("\n")) {
     form++;
     }
     else {
     switch(form) {
     case 1:*/
    String[] pieces = split(lines[i], ',');
    println(pieces);
    if (pieces.length == 9) {
      dots =(dot []) expand(dots, dots.length+1);
      dots[dots.length-1]=new dot(Integer.parseInt(pieces[1]), Integer.parseInt(pieces[2]), 10, dots.length-1);

      dots =(dot []) expand(dots, dots.length+1);
      dots[dots.length-1]=new dot(Integer.parseInt(pieces[4]), Integer.parseInt(pieces[5]), 10, dots.length-1);

      dots =(dot []) expand(dots, dots.length+1);
      dots[dots.length-1]=new dot(Integer.parseInt(pieces[7]), Integer.parseInt(pieces[8]), 10, dots.length-1);

      triangulars = (triangular [] ) expand(triangulars, triangulars.length+1);
      triangulars[triangulars.length-1]=new triangular(dots.length-3, dots.length-2, dots.length-1);
    }
    //break;
    //case 2:
    //String[] pieces2 = split(lines[i], ',');
    //println(pieces2);
    else if (pieces.length == 12) {
      dots =(dot []) expand(dots, dots.length+1);
      dots[dots.length-1]=new dot(Integer.parseInt(pieces[1]), Integer.parseInt(pieces[2]), 10, dots.length-1);

      dots =(dot []) expand(dots, dots.length+1);
      dots[dots.length-1]=new dot(Integer.parseInt(pieces[4]), Integer.parseInt(pieces[5]), 10, dots.length-1);

      dots =(dot []) expand(dots, dots.length+1);
      dots[dots.length-1]=new dot(Integer.parseInt(pieces[7]), Integer.parseInt(pieces[8]), 10, dots.length-1);

      dots =(dot []) expand(dots, dots.length+1);
      dots[dots.length-1]=new dot(Integer.parseInt(pieces[10]), Integer.parseInt(pieces[11]), 10, dots.length-1);

      rectangulars = (rectangular [] ) expand(rectangulars, rectangulars.length+1);
      rectangulars[rectangulars.length-1]=new rectangular(dots.length-4, dots.length-3, dots.length-2, dots.length-1);
    }
    //break;
    //}
    // }
  }
}

void saving(String savename) {
  String[] tri = new String[triangulars.length];
  for (int i = 0; i < triangulars.length; i++) {
    tri[i] = triangulars[i].p1+","+dots[triangulars[i].p1].x+","+dots[triangulars[i].p1].y+","+
      triangulars[i].p2+","+dots[triangulars[i].p2].x+","+dots[triangulars[i].p2].y+","+
      triangulars[i].p3+","+dots[triangulars[i].p3].x+","+dots[triangulars[i].p3].y;
  }
  tri[triangulars.length-1]+="\n";

  String[] rec = new String[rectangulars.length];
  for (int i = 0; i < rectangulars.length; i++) {
    rec[i] = rectangulars[i].p1+","+dots[rectangulars[i].p1].x+","+dots[rectangulars[i].p1].y+","+
      rectangulars[i].p2+","+dots[rectangulars[i].p2].x+","+dots[rectangulars[i].p2].y+","+
      rectangulars[i].p3+","+dots[rectangulars[i].p3].x+","+dots[rectangulars[i].p3].y+","+
      rectangulars[i].p4+","+dots[rectangulars[i].p4].x+","+dots[rectangulars[i].p4].y;
  }
  String [] lines = concat(tri, rec);

  saveStrings(sketchPath+"/data/"+savename, lines); //replace tri with lines
  customize(p1);
}


import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

Kinect2 kinect2;

int cols = 96;
int rows;
int scale = 30;
int circw = 5;
int w = 1450;
int h = 1000;
int r = 1;
int space = 30;
boolean checkside = true;
int side=0; // which side enter from

int colorCount = 0; // counting colored area

float move = 0;  
float [][] grid; 
float linesL;
float linesR;
color[][] colors;
float still;

int mode = 0;

int savedTime;
int passedTime;
int totalTime = 5000;

PImage img;


void setup () {
  size (1450, 1000, P3D);
  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
  rows = h/scale;
  img = createImage(kinect2.depthWidth, kinect2.depthHeight, RGB);
  grid = new float [cols][rows];
  colors = new color[cols][rows];
  savedTime = millis();


  for (int i=2; i<cols; i++) {
    for (int j=1; j<rows; j++) {
      colors[i][j] = color(255); // set color to white
    }
  } 
}

void draw () {
  background(255);
  frameRate(60);
  translate(-40, -30);
 
  img.loadPixels();
  
  int[] depth = kinect2.getRawDepth();
  
  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;
  
  for(int x = 0; x < kinect2.depthWidth; x++){
    for(int y = 0; y < kinect2.depthHeight; y++){
      int offset = x + y * kinect2.depthWidth;
      int d = depth[offset];
      
      if(d > 480 && d < 830){
        sumX += x;
        sumY += y;
        totalPixels++;
      }
    }
  }
  
  float avgX = sumX / totalPixels;
  float avgY = sumY / totalPixels;
  
  int person_box_x = (int) avgX/8;
  int person_box_y = (int) avgY/8;
  
  float person_percise_x = avgX * (width-2)/512;
 
  // animating z coordinate
  move += 0.05;  
  float yoff = move;
  for (int x = 0; x < cols; x++) {
    float xoff = 0;
    for (int y = 0; y < rows; y++) {
      grid[x][y] = map(sin(yoff), 0, 1, -10, 10);
      xoff += 0.3;
    }
    yoff += 0.3;
  }
  
  // modes
  if (mode == 0) {
    colorCount = 0;
    for (int i=2; i<cols; i++) {
        for (int j=1; j<rows; j++) {
         colors[i][j] = color(255); // set color to white
        }
     } 
    // check side of entry
    if (checkside == true) {
     if (overRect(0,0,width/2,height)== true) {
       side = 1;   //if enter from left side
       checkside = false;
     } else if (overRect(width/2,0,width,height)== true) {
       side = 2; //if enter from right side
       checkside = false;
     } 
     pointgrid();
    }
  
    //grid lines
    if (side == 1) {
        linegridL();
        pointgrid();
    } else if (side == 2) {
        linegridR();
        pointgrid();
    }
    
  } else if (mode == 1) {
    colorAdd();
    side = 0;
  } else if (mode == 2) {
    popEffect();
    checkside = true;
  }  else if (mode == 3) {
    disappear();
  } else if (mode == 4) {
    pointgrid();
        passedTime = millis() - savedTime;
        if (passedTime > 2000) {
          println("5 seconds have passed!");
          //savedTime = millis(); // restart the timer
          mode = 0;
        }
  }
  
}
   
void linegridL() {
  float percentl = map(mouseX, 0, 2000, 0, 1);
  float linesL = lerp(0, cols, percentl);
  //linesL = max(newlinesL, linesL);'
  
  // set mode to next mode
  if (linesL > 68 && mode == 0) {
    mode=1;
    linesL = 0;
    //newlinesL = 0;
  }  
  fill(255);
  stroke(0);
  float lineCount = linesL;
  
  if (mode > 0) {
    lineCount = cols;
  } 
  float z;
  for (int i = 2; i < lineCount; i++) {
    for (int j = 1; j < rows; j++) {
      for (int y = j-1; y < j; y++) {
        beginShape(QUAD_STRIP);
        for (int x = i-2; x < i; x++) { 
          z = grid[x][y];
          vertex(x*(scale), height - y*(scale), z);
          vertex(x*(scale), height - (y+1)*(scale), z); 
        }
        endShape();
      }
    }
  }
}


void linegridR() {
  float percentr = map(mouseX, 0, 2800, 0, 1);
  float linesR = lerp(0, cols, percentr);
  //linesR = min(linesR, newlinesR);
  
  if (linesR < 1 && mode == 0) {
    mode=1;
    linesR = 0;
    //newlinesL = 0;
  }
  
  fill(255);
  stroke(0);
  float lineCount = linesR;
  if (mode > 0) {
    lineCount = 0;
  }
  
   for (int j = 1; j < rows; j++) {
     for (int i = cols; ((i >=2) && (i > lineCount)); i--) {
       for (int y = j-1; y < j; y++) {
       beginShape(QUAD_STRIP);
       for (int x = i-2; x < i; x++) {
         vertex(x*scale, height-y*(scale), grid[x][y]);
         vertex(x*(scale), height-(y+1)*(scale), grid[x][y]); 
       }
     endShape();
     }  
    }
   }
}

// grid of points
void pointgrid() {

 for (int y = 0; y < rows; y++) {
    for (int x=0; x < cols; x++) {
      pushMatrix();
      fill(0);
      lights();
      translate(x*(scale), height - y*(scale), grid[x][y]);
      ellipse(0,0,r,r);
      popMatrix();
    }
  }
}

void colorAdd() {
  float z;
  for (int i=2; i<cols; i++) {
    for (int j=1; j<rows; j++) {
       for (int y = j-1; y < j; y++) {
       beginShape(QUAD_STRIP);
       for (int x = i-2; x < i; x++) {
        fill(colors[i][j]);
        z = grid[x][y];
        int c = x*scale-40;
        int r = height-y*scale-100;
        if (mouseX > (c-scale) && mouseX < (c + 2*scale) && mouseY > (r) && mouseY < (r + 3*scale)) {          
          if (colors[i][j] == color(255)) {
            colors[i][j] = color(#4c4491);
            colorCount+=1;
            //print(colorCount + "   ");
            if (colorCount > 1626) {
              mode = 2;
            }
          }
          if (colors[i][j] == color(#4c4491)) {
            z +=20;
          }
        }
       
         vertex(x*scale, height-y*(scale), z);
         vertex(x*(scale), height-(y+1)*(scale), z); 
       }
     endShape();
     } 
    } 
    
  }
}

void popEffect() {
  background(#f15e64);
  float z; 
  float w = 2; // width of reacting area
  float h = 1.7; //height of reacting area
  for (int i=2; i<cols; i++) {
    for (int j=1; j<rows; j++) {
       for (int y = j-1; y < j; y++) {
       beginShape(QUAD_STRIP);
       for (int x = i-2; x < i; x++) {
        fill(#4c4491);
        z = grid[x][y];
        int c = x*scale-40;
        int r = height-y*scale-100;
        if (mouseX > c && mouseX < (c + w*scale) && mouseY > r && mouseY < (r + h*scale)) {
          still = 20 + 8*sin(PI/2);
          z = still;
          if (mousePressed == true) {
            z += random(20,50);
            passedTime = millis() - savedTime;
            if (passedTime > totalTime) {
              println("5 seconds have passed!");
              savedTime = millis(); // restart the timer
              mode = 3;
            }  
          }
        }
        vertex(x*scale, height-y*(scale), z);
        vertex(x*(scale), height-(y+1)*(scale), z);  
       }
     endShape();
     } 
    } 
  }
}

void mousePressed () {
  savedTime = millis();
}

void disappear(){
  background(#f15e64);
  float z;
  for (int i=2; i<cols; i++) {
    for (int j=1; j<rows; j++) {
       for (int y = j-1; y < j; y++) {
       beginShape(QUAD_STRIP);
       for (int x = i-2; x < i; x++) {
        fill(#4c4491);
        z = grid[x][y];
        int c = x*scale-40;
        int r = height-y*scale-20;
        z += random(20,50);  
        passedTime = millis() - savedTime;
        if (passedTime > totalTime) {
           println("5 seconds have passed!");
           savedTime = millis(); // restart the timer
           mode = 4;
        }
        vertex(x*scale, height-y*(scale), z);
        vertex(x*(scale), height-(y+1)*(scale), z);  
       }
     endShape();
     } 
    } 
    
  }
}



boolean overRect(int xi, int yi, int wi, int hi) {
  if ((mouseX > xi) && (mouseX < xi+wi) && (mouseY > yi) && (mouseY < yi+hi)) {
    return true;
  } else { 
    return false;
  }
}
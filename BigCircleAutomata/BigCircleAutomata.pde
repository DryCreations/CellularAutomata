
boolean[] rule = new boolean[8];
boolean[] cells;
int gen = 0;
float cl;

//int numRule = (int)random(256);
int numRule=(int)random(256);
int len = (int)random(50,200);
int starts = (int)random(2,50);

PGraphics g;

void setup() {
  
  g = createGraphics(10000, 10000, JAVA2D);
  g.beginDraw();
  
  size(600,600);
  
  g.background(255);
  
  cl = PI*g.width/len;
  cells = new boolean[len];
  for ( boolean cell : cells) {
    cell = false;
  }
  for (int i = 0; i < starts; i++){
    cells[(len*i)/starts] = true;
  }
  for(int i = rule.length - 1; i >= 0; i--) {
    numRule -= pow(2, i);
    if (numRule >= 0) {
      rule[rule.length - i - 1] = true;
      
    } else {
      rule[rule.length - i - 1] = false;
      numRule += pow(2, i);
      
    }
  }
  
}

void draw() {
  g.noStroke();
  //stroke(255);
  boolean[] newCells = new boolean[cells.length];
  for (int i = 0; i < cells.length; i++) {
    PVector c = new PVector(g.width/2,g.height/2);
    PVector pos1, pos2, pos3, pos4;
    pos1 = c.copy().add(PVector.fromAngle(i*TWO_PI/len).mult(1/(gen*(cl/((g.width/2f)*(g.width/2f)-cl*(g.width/2f))) + 1/(g.width/2f))));
    pos2 = c.copy().add(PVector.fromAngle((i+1)*TWO_PI/len).mult(1/(gen*(cl/((g.width/2f)*(g.width/2f)-cl*(g.width/2f))) + 1/(g.width/2f))));
    pos3 = c.copy().add(PVector.fromAngle((i+1)*TWO_PI/len).mult(1/((gen+1)*(cl/((g.width/2f)*(g.width/2f)-cl*(g.width/2f))) + 1/(g.width/2f))));
    pos4 = c.copy().add(PVector.fromAngle(i*TWO_PI/len).mult(1/((gen+1)*(cl/((g.width/2f)*(g.width/2f)-cl*(g.width/2f))) + 1/(g.width/2f))));
    
    g.fill(cells[i] ? color(0) : color(255));
    
    g.quad(pos1.x,pos1.y,pos2.x,pos2.y,pos3.x,pos3.y,pos4.x,pos4.y);
    
    int neighborhood = 0;
    
    neighborhood += i > 0 ? cells[i - 1] ? 0 : 1 : cells[cells.length - 1] ? 0 : 1;
    neighborhood += cells[i] ? 0 : 2;
    neighborhood += i < cells.length - 1 ? cells[i + 1] ? 0 : 4 : cells[0] ? 0 : 4;
    
    newCells[i] = rule[neighborhood];
  }
  cells = newCells;
  
  gen++;

  if (gen % 20 == 0) {
    drawSmall();
  }

  //if (gen == 1000) keyPressed();
  //if (gen == (width/2)/cellLength) saveFrame(gen + rule.toString() + ".png");
}

void drawSmall() {
    PImage img = g.get(0, 0, g.width, g.height);
    img.resize(width,height);
    image(img,0,0);
}

void keyPressed() {
//saveFrame("" + numRule + len + starts + gen + ".png");

  g.endDraw(); // finish drawing  
  g.save(""+gen+numRule+len+starts+".tif");

gen = 0;

numRule = (int)random(256);
len = (int)random(20,50);
starts = (int)random(2,20);

setup();
}

boolean[] rule = new boolean[8];
boolean[] cells;
int gen = 0;
float cl;

int len = 80;
float w;
int count =0;

PVector center;

PGraphics g;

void setup() {
  
  g = createGraphics(10000, 10000, JAVA2D);
  g.beginDraw();
  
  size(600,600);
  
  g.background(255);
  
  w = (g.width - 100)/16f;
  
  newInitial(w,count,8);
  
}

void draw() {
  g.noStroke();
  if(gen == 64) {
    if (count == 255) g.save("poster.tif");
    count++;
    gen = 0;
    newInitial(w,count,8);
  }
  drawGen(center);
  
  
  gen++;

  if (gen == 64) {
    drawSmall();
  }

}

void drawGen(PVector center) {
    boolean[] newCells = new boolean[cells.length];
  for (int i = 0; i < cells.length; i++) {
    PVector c = center;
    PVector pos1, pos2, pos3, pos4;
    pos1 = c.copy().add(PVector.fromAngle(i*TWO_PI/len).mult(1/(gen*(cl/((w/2f)*(w/2f)-cl*(w/2f))) + 1/(w/2f))));
    pos2 = c.copy().add(PVector.fromAngle((i+1)*TWO_PI/len).mult(1/(gen*(cl/((w/2f)*(w/2f)-cl*(w/2f))) + 1/(w/2f))));
    pos3 = c.copy().add(PVector.fromAngle((i+1)*TWO_PI/len).mult(1/((gen+1)*(cl/((w/2f)*(w/2f)-cl*(w/2f))) + 1/(w/2f))));
    pos4 = c.copy().add(PVector.fromAngle(i*TWO_PI/len).mult(1/((gen+1)*(cl/((w/2f)*(w/2f)-cl*(w/2f))) + 1/(w/2f))));
    
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
}

void newInitial(float dia, int numRule, int starts) {
  cl = PI*dia/len;
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
  center = new PVector(w/2 + w*(count%16) + 100/17f + 100*(count%16)/17f,w/2 + w*(count/16) + 100/17f + 100*(count/16)/17f);
}

void drawSmall() {
    PImage img = g.get(0, 0, g.width, g.height);
    img.resize(width,height);
    image(img,0,0);
}
boolean[] rule = {true,true,true,false,false,false,false,true};
boolean[] cells;
int len = 100;
int gens = 50, gen = 0;
int cellLength = 7;
void setup() {
  size(1000,1000);
  background(255);
  cells = new boolean[len];
  for ( boolean cell : cells) {
    cell = false;
  }
  cells[len/2] = true;
}

void draw() {
  //noStroke();
  stroke(0);
  boolean[] newCells = new boolean[cells.length];
  for (int i = 0; i < cells.length; i++) {
    PVector c = new PVector(width/2,height/2);
    PVector pos1, pos2, pos3, pos4;
    pos1 = c.copy().add(PVector.fromAngle(i*TWO_PI/len).mult(width/2 - gen*cellLength));
    pos2 = c.copy().add(PVector.fromAngle((i+1)*TWO_PI/len).mult(width/2 - gen*cellLength));
    pos3 = c.copy().add(PVector.fromAngle((i+1)*TWO_PI/len).mult(width/2 - (gen+1)*cellLength));
    pos4 = c.copy().add(PVector.fromAngle(i*TWO_PI/len).mult(width/2 - (gen + 1)*cellLength));
    
    fill(cells[i] ? color(0) : color(255));
    
    quad(pos1.x,pos1.y,pos2.x,pos2.y,pos3.x,pos3.y,pos4.x,pos4.y);
    
    int neighborhood = 0;
    
    neighborhood += i > 0 ? cells[i - 1] ? 0 : 1 : cells[cells.length - 1] ? 0 : 1;
    neighborhood += cells[i] ? 0 : 2;
    neighborhood += i < cells.length - 1 ? cells[i + 1] ? 0 : 4 : cells[0] ? 0 : 4;
    
    newCells[i] = rule[neighborhood];
  }
  cells = newCells;
  
  gen++;
  if (gen == (width/2)/cellLength) saveFrame(gen + rule.toString() + ".png");
  if (gen == 3*(width/2)/cellLength) saveFrame(gen + rule.toString() + ".png");
}
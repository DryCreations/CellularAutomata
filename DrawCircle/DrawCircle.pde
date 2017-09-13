boolean[] cells;
int len = 100;
int gen = 0, gens = 100;

void setup() {
  size(1000,1000);
  cells = new boolean[len];
  for (int i = 0; i < cells.length; i++) {
    cells[i] = i % 2 == 0 ? true : false;
  }
}

void draw() {
  for (int i = 0; i < cells.length; i++) {
    PVector c = new PVector(width/2,height/2);
    PVector pos1, pos2, pos3, pos4;
    pos1 = c.copy().add(PVector.fromAngle(i*TWO_PI/len).mult(width/2 - gen*10));
    pos2 = c.copy().add(PVector.fromAngle((i+1)*TWO_PI/len).mult(width/2 - gen*10));
    pos3 = c.copy().add(PVector.fromAngle((i+1)*TWO_PI/len).mult(width/2 - (gen+1)*10));
    pos4 = c.copy().add(PVector.fromAngle(i*TWO_PI/len).mult(width/2 - (gen + 1)*10));
    
    fill(cells[i] ? color(0) : color(255));
    
    quad(pos1.x,pos1.y,pos2.x,pos2.y,pos3.x,pos3.y,pos4.x,pos4.y);
  }
  gen++;

}
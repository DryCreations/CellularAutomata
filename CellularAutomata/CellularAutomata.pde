boolean[] rule = {false,true,false,true,true,false,true,false};
boolean[] cells;
int len = 1000;
int gens = 500, gen = 0;
void setup() {
  size(2000,1000);
  cells = new boolean[len];
  for ( boolean cell : cells) {
    cell = false;
  }
  cells[len/2] = true;
}

void draw() {
  noStroke();
  boolean[] newCells = new boolean[cells.length];
  for (int i = 0; i < cells.length; i++) {
    fill(cells[i] ? color(0) : color(255));
    rect(i*((float)width/len),gen*((float)height/gens),width/len,height/gens);
    
    int neighborhood = 0;
    
    neighborhood += i > 0 ? cells[i - 1] ? 0 : 1 : cells[cells.length - 1] ? 0 : 1;
    neighborhood += cells[i] ? 0 : 2;
    neighborhood += i < cells.length - 1 ? cells[i + 1] ? 0 : 4 : cells[0] ? 0 : 4;
    
    newCells[i] = rule[neighborhood];
  }
  cells = newCells;
  
  gen++;
}
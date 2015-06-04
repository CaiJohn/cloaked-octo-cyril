class Main {
void main() {
  Int a;
  Int b;
  Int c;
  Int d;
  Int e;
  Int f;
  Int g;
  Int h;
  Compute compute1;
  Compute compute2;
  Compute compute3;
  Compute compute4;
  a = 1;
  b = 2; 
  compute1 = new Compute(); 
  compute2 = new Compute();
  compute3 = new Compute();
  compute4 = new Compute();
  c = 3;
  d = 4;
  e = 5;
  f = a+b+c+d+e; 
  g = a+b+c+d+e+f;   
  h = a+b+c+d+e+g-f;
  compute1.i = compute2.i + compute3.i + compute3.i; // compute2 compute3 spill
  // Consecutive LDR below
  c = b + d; // c,b,d are spilled!
  c = b + d;
  c = b + d;
  // Consecutive STR-LDR below  
  c = a;
  f = c;
  c = a;
  f = c;
  c = a;
  f = c;
  // Consecutive STR below
  compute1.i = a;
  compute1.i = b;
  compute1.i = a;
  compute1.i = a;
}
}

class Compute {
Int i;
Int compute(Int x, Int y) {
   return x+y; 
}
}

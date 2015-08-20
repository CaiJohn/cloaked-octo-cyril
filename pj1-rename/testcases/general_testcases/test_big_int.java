class Main {

void main() {
  Int a;
  Int b;
  Int c;
  Int d;
  Compute com;
  c = 1020;
  b = 1025;
  a = 1020 + b + 3000;
  println(123 * 10000); 
  d = -12345;
  if (d < -10000) {
     println("d < -10000");
  }
  else {
     println("d < 10000");
  }
  d = d * d;
  d = d + d;
  com = new Compute();
  com.compute(2,a,32455,1000,10000);
  com.c = com.c;
}
}

class Compute {

Compute c;

void compute (Int x, Int y, Int z, Int u, Int v) {
  println (x+y+z+u+v); // should print 48502
}

}

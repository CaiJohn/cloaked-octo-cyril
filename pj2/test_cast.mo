// Test all kinds of type casting for parser, so it may have some type error

class Main {

void main(){
  // Must have at least one stmt
    Int a;
    Int b;
    a = (Bool) b;
    b = (Int)(Bool) b+a;// It means (Int)((Bool) b)
    b = (Test)a + b;
    b = a + (Test)b;
    b = (Test)a + (Test)b;
    b = (TestA)((Test)a + (Test)b);
    c = (Test)(a + b);

    b = (TestA)((Test)a + (Test)b) * c;
    b = (TestA)(((Test)a + (Test)b) * c);

    // Cast from function call
    a = test(a,b); 
    a = (NewClass)test(a,b);
    a = (NewClass)(test(a,b));
    // . has higher priority than the casting
    c = (NewClass)a.test(a,b);
    

 }
}

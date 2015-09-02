// Test all kinds of type casting for parser, so it may have some type error

class Main {

void main(){
  // Must have at least one stmt
    Int a;
    Int b;
    TestSon ts;
    Test t;
    TestGrandson tgs;
    Test new_t;
    // Test upcasting 
    t = ts;
    t = tgs;

    // Test Downcasting
    new_t = new TestSon();
    ts = (TestSon)new_t;
    
    // Test private attr
    // a = tgs.pr;

    // Test public attr
       a = tgs.pu;
    ts =new TestSon();

    // Test upcasting in parameter
    ts.test2(ts);
    return;
 }
}

class Test {
  Int test(){
      Int a;
      TestSon ts;
      Test t;
      ts = new TestSon();
      
      // Test private method
      //ts.priTestSon(t);
      
      // Test public method
      ts.test2(ts);

      a = 0;
      return 0;
      }
}

class TestSon extends Test{
  Int test2(Test t){
      Int a;
      TestSon ts;

      // Test private
      ((TestSon) t).priTestSon(t);
      ts.priTestSon(t);
      priTestSon(t);

      return a;
      }
      
  private Int priTestSon(Test t){
     Int b;
     b = b + 1;
     return b;
     }
}

class TestGrandson extends TestSon{
   private Int pr;
   Int pu;
   void test3(){
     Int b;
     return;
   }
}

class Main {

void main(Int i, Int a, Int b,Int d){
 Int t1;
 Int t2;
 return;
 }
}


class Test{

 Int t1;
 Int t2;
 Bool b1;
 void method1(){
 
	Int a;
	return;
 }

 Int test_method1(){
     Bool b;
     return t1;
  }
      

}

class TestSon extends Test{
  
  // Test overriding attribute
  Int t1;
  Int s1;

  void method1(){
       Int b;
       return;
  }

  void method1(Int a){
       Int b;
       method1();
       b = a+1;
       return;
  }

  Int method2(){
    Int a;
    // Type checking for super word
    a=super.t1;
    
    return a;
    }
}
class Main {

void main(){
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

 Int test_method1(Int c){
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
       //method1(3);
       return;
  }

  void method1(Int a){
       Int b;
       //method1();
       Test t;
       t.method1();
       if(b>0){
	t.test_method1(b);
	}
	else{
	  method1();
	}
       t=new TestSon();
       ((TestSon)t).method1();
       method1(3);
       b = a+1;
       return;
  }

  Int method2(){
    Int a;
    // Type checking for super word
    a=super.t1;
    //method1(3);
    
    return a;
    }
}
class P1
{
    void main ()
    {
        Int a;
        B b;
        b = new B();
        a = 1;
        a = b.func_B_1(a);
        println("Goodbye again and again cruel world!");
    }
}

class B
{
    Int a;

    Int func_B_1(Int b)
    {
        a = 5;
        return b;
    }
}

class P1
{
    void main ()
    {
        Int a;
        B b;
        b = new B();
        a = 1;
        a = b.func_B_1(a, 2+3, a, 4, a, a/7);
        println("Goodbye again and again cruel world!");
    }
}

class B
{
    Int a;

    Int func_B_1(Int a, Int b, Int c, Int d, Int e, Int f)
    {
        Int g;
        g = (a-b) / f * (c + d) / (e * 10);
        println("Goodbye again and again cruel world!");
        return g;
    }
}

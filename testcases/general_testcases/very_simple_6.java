class P1
{
    void main ()
    {
        Int a;
        B b;
        b = new B();
        a = 1;
        a = b.func_B_1(a, 7);
        println("Goodbye again and again cruel world!");
    }
}

class B
{
    Int a;

    Int func_B_1(Int a, Int b)
    {
        Int c;
        Int d;
        Int e;
        Int f;
        Int g;
        a = 1;
        b = a + 3;
        c = a * b / 3;
        d = a - 7 + b / c;
        e = a - (8 + b) * c - d * 9;
        f = (a-b) * (c + d) / (e * 10);
        return g;
    }
}

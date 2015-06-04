/*
 * Original C code obtained from
 * http://programminggeeks.com/c-code-for-towers-of-hanoi/
 */

class Main
{
    void main ()
    {
        Int num_discs;
        Hanoi hanoi;

        num_discs = 10;
        hanoi = new Hanoi();
        hanoi.initialize(num_discs);
        hanoi.start("A", "C", "B");
    }
}

class Hanoi
{
    Int n;

    void initialize(Int num_discs)
    {
        n = num_discs;
    }

    void start(String src, String dest, String aux)
    {
        hanoi(n, src, dest, aux);
    }

    void print_move(Int disk, String from, String to)
    {
        println("Move disk ");
        println(disk);
        println(" from peg ");
        println(from);
        println(" to peg ");
        println(to);
        println("*EOL*");
    }

    void hanoi(Int n, String src, String dest, String aux)
    {
        if ( 1 == n )
        {
            print_move(n, src, dest);
            return;
        }
        else
        {
            n = n;
        }

        hanoi( n - 1, src, aux, dest );
        print_move(n, src, dest);
        hanoi( n - 1, aux, dest, src );

        return;
    }
}


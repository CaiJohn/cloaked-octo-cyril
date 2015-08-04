class Main
{
    void main ()
    {
        IntArray a;
        Util u;
        ShellSort shell_sort;
        a = new IntArray();
        u = new Util();
        shell_sort = new ShellSort();
        a.create(100);
        println("===== Before Sort =====");
        u.fill_array(a, 100);
        u.print_array(a, 100);

        println("===== After Sort =====");
        shell_sort.sort(a, 100);
        u.print_array(a, 100);

        return;
    }
}

class Util
{
    Int divide (Int dividend, Int divisor)
    {
        Int quotient;
        Int sum;
        quotient = 0;
        sum = 0;
        while ( sum <= dividend )
        {
            sum = sum + divisor;
            quotient = quotient + 1;
        }

        return (quotient - 1);
    }

    void fill_array(IntArray a, Int n)
    {
        Int i;
        i = 0;
        while ( i < n )
        {
            a.set(i, 3*n - 3*i);
            i = i + 1;
        }
    }

    void print_array(IntArray a, Int n)
    {
        Int i;
        i = 0;
        while ( i < n )
        {
            println(a.get(i));
            i = i + 1;
        }
    }
}

class ShellSort
{
    void sort(IntArray work, Int n)
    {
        Int i;
        Int j;
        Int x;
        Int d;
        Util u;
        u = new Util();
        d = u.divide(n, 2);
        while ( d >= 1 )
        {
            i = d;
            while ( i < n )
            {
                x = work.get(i);
                j = i - d;
                while ( (j >= 0) && (x < work.get(j)) )
                {
                    work.set(j+d, work.get(j));
                    j = j - d;
                }
                work.set(j+d, x);
                i = i + 1;
            }
            d = u.divide(d, 2);
        }
    }
}

class ArrayNode
{
    Int data;
    ArrayNode next;

    Int getData()
    {
        return data;
    }

    void setData(Int data)
    {
        this.data = data;
    }

    ArrayNode getNext()
    {
        return next;
    }

    void setNext(ArrayNode next)
    {
        this.next = next;
    }
}

class IntArray
{
    Int size;
    ArrayNode head;

    void create(Int size)
    {
        Int i;
        ArrayNode prevNode;
        ArrayNode newNode;

        if ( size < 1 )
        {
            println("Size of array is at least 1");
        }
        else
        {
            this.size = size;
            head = new ArrayNode();
            head.setData(0);

            prevNode = head;
            i = 1;
            while ( i < size)
            {
                newNode = new ArrayNode();
                newNode.setData(0);
                prevNode.setNext(newNode);
                prevNode = newNode;
                i = i + 1;
            }
        }
    }

    Int get(Int index)
    {
        Int i;
        ArrayNode node;

        node = head;
        i = 0;
        while ( i < index )
        {
            node = node.getNext();
            i = i + 1;
        }

        return node.getData();
    }

    void set(Int index, Int data)
    {
        Int i;
        ArrayNode node;

        node = head;
        i = 0;
        while ( i < index )
        {
            node = node.getNext();
            i = i + 1;
        }

        node.setData(data);
    }

}


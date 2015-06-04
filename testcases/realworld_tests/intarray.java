/*
   This is a Integer Array implemented by LinkedList
   Its performance is poor, but it enables algorithms based on
   arrays.

   [usage]
   C code:
       int a[100];
       a[5] = 7;
       b = a[5];

   Using this library:
       IntArray a;
       a = new IntArray();
       a.create(100);
       a.set(5, 7);
       b = a.get(5);
*/

class Main
{
    void main ()
    {
        IntArray a;
        a = new IntArray();
        a.create(100);
        a.set(1,3);
        a.set(5,7);
        a.set(11,13);
        a.set(17,19);
        a.set(23,29);
        a.set(31,37);

        println(a.get(0));
        println(a.get(1));
        println(a.get(5));
        println(a.get(11));
        println(a.get(17));
        println(a.get(23));
        println(a.get(31));
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


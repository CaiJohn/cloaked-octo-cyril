//quick sort testcase

class Main
{
    void main ()
    {
        IntArray a;
        Util u;
        QuickSort quick_sort;
        a = new IntArray();
        u = new Util();
        quick_sort = new QuickSort();
        a.create(100);
        println("===== Before Sort =====");
        u.fill_array(a, 100);
        u.print_array(a, 100);

        //should be in ascending order
        println("===== After Sort =====");
        quick_sort.sort(a, 0, 99);
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

class QuickSort
{

    Int partition(IntArray arr, Int left, Int right)
    {
      Int i;
      Int j;
      Int tmp;
      Int pivot;

      i = left;
      j = right;

      while(i<j)
      {
         i = i + 1;
         j = j - 1;
      }

      pivot = arr.get(j);

      //int pivot = arr[(left + right) / 2];
     
      i = left;
      j = right;

      while (i <= j) {
	    while (arr.get(i) < pivot)
            {
		i = i + 1;
	    }

	    while (arr.get(j) > pivot)
            {
	        j = j - 1;
	    }

	    if (i <= j) {
	          tmp = arr.get(i);
	          arr.set(i, arr.get(j));
	          arr.set(j, tmp);
	          i = i + 1;
	          j = j - 1;
	    }
            else
            {
                  i = i;
            }
      }
     
      return i;
    }
 
    void sort(IntArray arr, Int left, Int right) {
      Int index;
      index  = partition(arr, left, right);
      if (left < index - 1)
      {
	    sort(arr, left, index - 1);
      }
      else
      {
        index = index;
      }

      if (index < right)
      {
        sort(arr, index, right);
      }
      else
      {
        index = index;
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

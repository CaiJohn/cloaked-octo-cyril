class Main {
 
    void main() {
        LinkedList list;
        Node node;

        list = new LinkedList();
        
        list.init();

        println("Adding 1 2 3 4 5"); 
        list.add(1);
        list.add(2);
        list.add(3);
        list.add(4);
        list.add(5);

        list.print();

        println("remove index = 2");
        list.remove(2);
        list.print();

        println("Add 10 at the end");
        list.add(10);
        list.print();

        println("Add 8 at index = 0");
        list.add(8,0);
        list.print();

        node = list.get(3);

        println("Node at index 3 = ");
        if(node == NULL)
        {
            println("Node not found");
        }
        else
        {            
            println(node.getData());
        }

        node = list.get(20);

        println("Node at index 20 = ");
        if(node == NULL)
        {
            println("Node not found");
        }
        else
        {
            println(node.getData());
        }

        println("removing everything...");
        while(list.size() > 0)
        {
            list.remove(0);
        }
        list.print();       

        
    }
}
 
class Node {
    Node next;
    Int data;
    
    void init(Int dataValue) {
        next = NULL;
        data = dataValue;
    }

    void init(Int dataValue, Node nextValue) {
        next = nextValue;
        data = dataValue;
    }

    Int getData() {
        return data;
    }

    void setData(Int dataValue) {
        data = dataValue;
    }

    Node getNext() {
        return next;
    }

    void setNext(Node nextValue) {
        next = nextValue;
    }
}
    
class LinkedList {

    Node head;
    Int listCount;
 

    void init() {
        head = new Node();
        head.init(-1);
        listCount = 0;
    }
 
    void add(Int data)
    {
        Node newNode;
        Node curNode;

        newNode = new Node();
        newNode.init(data);

        curNode = head;

        while (curNode.getNext() != NULL) {
            curNode = curNode.getNext();
        }
        
        curNode.setNext(newNode);
        listCount = listCount + 1;
    }
 
    void add(Int data, Int index)
    {
        Node newNode;
        Node curNode;
        Int i;

        newNode = new Node();
        newNode.init(data);

        curNode = head;
        
        i = 0;
        
        while(i < index && curNode.getNext() != NULL)
        {
            curNode = curNode.getNext();
            i = i + 1;
        }

        newNode.setNext(curNode.getNext());

        curNode.setNext(newNode);
        listCount = listCount + 1;
    }
 
    Node get(Int index)
    {
        Node curNode;
        Int i;
        
        if (index < 0)
        {
            return NULL;
        }
        else
        {
            curNode = head.getNext();
        }

        i = 0;
        
        while(i < index){
            if (curNode.getNext() == NULL)
            {
                return NULL;
            }
            else
            {
                i = i;
            }
            
            curNode = curNode.getNext();
            i = i+1;
        }
        
        return curNode;
    }
 
    Bool remove(Int index)
    {
        Node curNode;
        Int i;
    
        if (index < 0 || index >= size())
        {        
            return false;
        }
        else
        {
            i = i;
        }
 
        curNode = head;
        i = 0;
        
        while(i < index)
        {
            if (curNode.getNext() == NULL)
            {
                return false;
            }
            else
            {
                i =  i + 1;
            }
            
            curNode = curNode.getNext();
        }

        curNode.setNext(curNode.getNext().getNext());
        listCount = listCount - 1;
        return true;
    }
 
    Int size()
    {
        return listCount;
    }
 
    void print() 
    {
        Node curNode;
        curNode  = head.getNext();
    
        println("Print Start");

        while (curNode != NULL) {
            println(curNode.getData());
            curNode = curNode.getNext();
        }
        println("Print End");
        return;
    }

}

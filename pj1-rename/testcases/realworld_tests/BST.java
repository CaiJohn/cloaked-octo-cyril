class Main
{
    void main() {
       TreeNode root;
       TreeNode temp;
       BST bst;
       bst = new BST();
       root = NULL;
       root = bst.insert(root,5);
       root = bst.insert(root,-1);
       root = bst.insert(root,3);       
       root = bst.insert(root,-14);
       root = bst.insert(root,8);
       root = bst.insert(root,10);
       root = bst.insert(root,9);
       root = bst.insert(root,6);
       println("= In Order =");
       bst.printInOrder(root);
       println("============");
       root = bst.delete(root,5);
       root = bst.delete(root,-1); 
       println("= In Order =");  
       bst.printInOrder(root);
       println("============");
       temp = bst.findMin(root); 
       println("Min value is");
       println(temp.data);
       temp = bst.findMax(root);
       println("Max value is");
       println(temp.data);
       temp = bst.find(root,8);
       if (temp==NULL) {
          println("Value 8 not found!");
       }
       else {
          println("Value 8 found");
       }
       temp = bst.find(root,2);
       if (temp==NULL) {
          println("Value 2 not found!");
       }  
       else {
          println("Value 2 found");
       }
    }
}

class TreeNode
{
    Int data;
    TreeNode left;
    TreeNode right;
}

class BST 
{
    TreeNode findMin(TreeNode node) {
	if (node==NULL) {
	    return NULL; 
	}
        else {
	    if (node.left!=NULL) {
		return findMin(node.left);
            }
            else {
		return node;
            }
        }
    } 
  
    TreeNode findMax(TreeNode node) {
        if (node==NULL) {
            return NULL;
        } 
        else {
            if (node.right!=NULL) {
                return findMax(node.right);
            }
            else {
                return node;
            }
        }
    }
   
    TreeNode insert(TreeNode node, Int data) {
        TreeNode temp;
        if(node==NULL) {
	    temp = new TreeNode(); 
            temp.data = data;
            temp.left = NULL;
            temp.right = NULL;
            return temp;
        }
        else { data = data; }
        if(data > node.data) {
            node.right = insert(node.right,data);
        } 
        else {
            if(data < node.data) {
	        node.left = insert(node.left,data);    
            }
            else { data = data; } // nothing to do here, cause data already in
        } 
        return node;
    }

    TreeNode delete(TreeNode node, Int data) {
        TreeNode temp;
        if(node==NULL) {
            println("Element not found!");
        }
        else {
          if (data < node.data) {
             node.left = delete(node.left,data); 
          }
          else {
              if (data > node.data) {
                  node.right = delete(node.right,data);
              }
              else { // delete this node and replace with minimum of right subtree
                  if (node.right!=NULL && node.left!=NULL) {
                      temp = findMin(node.right);
                      node.data = temp.data;
                      node.right = delete(node.right,temp.data);
                  }
                  else {
                      temp = node;
                      if(node.left==NULL) {
                          node = node.right;
                      }
                      else {
                          node = node.left;
                      }
                      // free(temp), WARNING: jlite not support free
                  }         
              }
          }
       }
       return node;
    }

    TreeNode find(TreeNode node, Int data) {
        TreeNode temp;
        if(node==NULL) {
            temp = NULL;
        } 
        else {
            if(data > node.data) {
                temp = find(node.right,data);
            }
            else {
                if(data < node.data) {
                    temp = find(node.left,data);
                }
                else { // Element Found!
                    temp = node;
                }
            }
        }
        return temp;
    }
  
    void printInOrder(TreeNode node) {
        if(node==NULL) {
            return;
        } 
        else {  
            printInOrder(node.left); 
            println(node.data);
            printInOrder(node.right); 
        } 
    }
}

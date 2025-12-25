/*

 CLASS:
    Blueprint For Creating Objects
    Reference Semantics
    Used When You Want To Share Data Across Multiple Parts Of Your Code
    Used When A Data Structure Has An Identity That Is Important To Maintain

 STRUCT:
    Value Semantics
    Used When You Want To Pass Data Around Without Sharing It
    Used When A Data Structure Does Not Have An Identity
    Used When You Want To Copy Data Instead Of Referencing It

 TUPLE:
    Group Multiple Values Into A Single Compound Value
    Fixed Size And Type
    Useful For Returning Multiple Values From A Function
    Similar To Structs: Can Be Used To Group Related Data Together Once (Repeatly Used Data Should Be A Struct)
 
 COPY-ON-WRITE:
    Optimization Technique
    Basically Swift Copies The Reference To A Data Structure Instead Until It Is Mutated
    Helps In Improving Performance By Avoiding Unnecessary Copies
 
 - All data structures in Swift are structs.
 - Swift generally has simple data structures built-in, such as arrays, dictionaries, and sets.
*/

// Error Enum
enum _Error:Error {
    case RuntimeError(_ message:String)
}

// TASK: CREATE A STACK
struct Stack<T> {
    private var list: [T] = [];
    var size:Int = 0;
    
    mutating func push(_ ele: T)->Void{
        list.append(ele);
        size+=1;
        return;
    }
    
    mutating func push(_ elements:[T])->Void{
        for ele in elements {
            list.append(ele);
            size+=1;
        }
        return;
    }
    
    mutating func pop()->T{
        let removedEle = list[size-1];
        list.remove(at: size-1)
        return removedEle;
    }
    
    func top()->T{
        return list[size-1];
    }
    
    func isEmpty()->Bool{
        return size==0;
    }
}
var newStack = Stack<Int>();
newStack.push(10);
newStack.push(23);
print("newStack: \(newStack)");
print("newStack.top: \(newStack.top())")
print("newStack.pop: \(newStack.pop())")
print("newStack after pop: \(newStack)")
print("newStack isEmpty \(newStack.isEmpty())")
newStack.push([1,2,3]);
print("newStack after pushing in another list: \(newStack)")
print("\n\n");

// TASK: CREATE A QUEUE
// Principle: First In First Out
struct Queue<T>{
    private var list: [T] = [];
    var size:Int=0;
    
    init(_ list: [T]) {
        self.list = list
        self.size = list.count;
    }
    
    func isEmpty()->Bool{
        return size==0;
    }
    
    mutating func push(_ ele:T)->Void{
        list.append(ele);
        size+=1;
    }
    
    mutating func dequeue() throws -> T {
        if isEmpty(){
            throw _Error.RuntimeError("Queue Is Empty");
        }
        list.reverse();
        let dequeuedEle = list.removeLast();
        size-=1;
        list.reverse();
        return dequeuedEle;
        
    }
    
    func front() throws ->T{
        if isEmpty(){
            throw _Error.RuntimeError("Queue Is Empty");
        }
        return list[0];
    }
    
    func back()throws->T{
        if isEmpty(){
            throw _Error.RuntimeError("Queue Is Empty");
        }
        return list[size-1];
    }
}

do {
    var newQueue = Queue<String>(["Apple", "Oranges"]);
    print("newQueue: \(newQueue)");
    newQueue.push("Bananas");
    try newQueue.dequeue();
    try newQueue.dequeue();
    try newQueue.dequeue();
    print("newQueue after dequeue: \(newQueue)");
    print("newQueue size: \(newQueue.size)")
    try print("newQueue front_element: \(newQueue.front())")
    try print("newQueue back_element: \(newQueue.back())")
} catch let error {
    print(error);
}
print("\n\n");

// TASK: CREATE A SINGLY-LINKED LIST
// Reference Type -> Class
class LLNode <T> {
    var val:T;
    var next: LLNode<T>?;
    
    init(_ val: T, next: LLNode<T>? = nil) {
        self.val = val
        self.next = next ?? nil
    }
}
class LinkedList<T> {
    var head:LLNode<T>;
    var tail:LLNode<T>;
    
    init(_ headVal: T) {
        self.head = LLNode(headVal);
        self.tail = self.head;
    }
    
    func insert(_ val:T)->Void{
        self.tail.next = LLNode(val);
        self.tail = self.tail.next!;
    }
    
    func remove()->LLNode<T>{
        var ptr = self.head;
        while ptr.next != nil && ptr.next!.next != nil {
            ptr = ptr.next!;
        }
        self.tail = ptr;
        let removedNode = self.tail.next!;
        self.tail.next = nil;
        return removedNode;
    }
    
    func size()->Int{
        var tmp = head;
        var count = 0;
        while tmp.next != nil {
            count+=1;
            tmp = tmp.next!;
        }
        count+=1;
        return count;
    }
    
    func log()->Void{
        var tmp = head;
        while tmp.next != nil {
            print(tmp.val, terminator: " ");
            tmp=tmp.next!;
        }
        print(tmp.val);
        return;
    }
}

var ll = LinkedList<Int>(20);
print("LL Head: \(ll.head.val)");
ll.insert(34);
ll.insert(12);
ll.insert(9);
ll.log()
print("LL size: \(ll.size())")
print("Removed Element \(ll.remove().val)");
ll.log()
print("LL Head: \(ll.head.val)");
print("LL size: \(ll.size())")

// TASK: CREATE A DOUBLY-LINKED LIST
// Note: Swift doesn't allow generic equality if they are not equatable
// Remove All Strong References For Swift ARC(Automatic Reference Counting) To Deallocate Memory Of a Variable
class DLLNode<T:Equatable> {
    var val:T;
    var next:DLLNode?=nil;
    var prev:DLLNode?=nil;
    
    init(_ val:T) {
        self.val = val;
    }
    
    func destroy(){
        self.prev = nil;
        self.next = nil;
        return;
    }
}

class DoublyLinkedList<T:Equatable> {
    var head:DLLNode<T>?;
    var tail:DLLNode<T>?;
    
    init(_ val:T){
        print("Initialising a DLL With Node \(val)");
        self.head = DLLNode(val);
        self.tail = self.head!;
    }
    
    func size()->Int{
        var tmp=self.head;
        var count = 0;
        while tmp != nil {
            count+=1;
            tmp = tmp!.next;
        }
        return count;
    }
    
    func insertAtHead(_ val:T){
        print("Inserting \(val) At Head");
        var newNode = DLLNode(val);
        newNode.next = self.head;
        self.head!.prev = newNode;
        self.head = newNode;
    }
    
    func insertAtTail(_ val:T){
        print("Inserting \(val) At Tail");
        var newNode = DLLNode(val);
        newNode.prev = self.tail;
        self.tail!.next = newNode;
        self.tail = newNode;
    }
    
    func removeFromHead(){
        print("Removing From Head");
        if self.head!.next == nil {
            self.head = nil;
            return;
        }
        var nextNode = self.head!.next!;
        nextNode.prev = nil;
        self.head = nextNode;
    }
    
    func removeFromTail(){
        print("Removing From Tail");
        if self.tail!.prev == nil {
            self.tail = nil;
            return;
        }
        var prevNode = self.tail!.prev!;
        prevNode.next = nil;
        self.tail = prevNode;
    }
    
    func insert(val:T, at: Int){
        print("Inserting \(val) At Position \(at)");
        if self.size() < at {
            print("Invalid Position: Out Of Bound");
            return;
        } else if self.size() == at {
            self.insertAtTail(val);
            return;
        } else if at == 0 {
            self.insertAtHead(val);
            return;
        }
        var pos = 0;
        var tmp = self.head;
        while pos < (at-1) {
            tmp=tmp!.next;
            pos+=1;
        }
        var nextToNextNode = tmp!.next;
        
        var newNode = DLLNode(val);
        tmp!.next = newNode;
        newNode.prev = tmp;
        newNode.next = nextToNextNode;
        nextToNextNode!.prev = newNode;
        return;
    }
    
    func remove(at: Int){}
    
    func isEmpty()->Bool{
        return self.size()==0;
    }
    
    func isExists(_ val:T)->Bool{
        var tmp = self.head!;
        while tmp.next != nil {
            if (tmp.val == val) {
                return true;
            }
            tmp = tmp.next!;
        }
        return false;
    }
    
    // Advanced Operations
    func clear(){
        print("Clearing The DLL Completely!")
        var tmp = self.head;
        self.head = nil;
        self.tail = nil;
        while tmp != nil {
            var nextNode = tmp!.next;
            tmp?.destroy();
            tmp = nextNode;
        }
    }
    
    func reverse(){
    }
    
    func removeNodes(withValue:T){
        print("Removing Node With Value \(withValue)")
        var tmp = self.head;
        while tmp != nil {
            if tmp!.val == withValue {
                if tmp === self.head {
                    self.removeFromHead();
                    tmp = self.head;
                    continue;
                } else if tmp === self.tail {
                    self.removeFromTail();
                    tmp = self.tail;
                    continue;
                }
                print("Removing From Middle");
                var prevNode = tmp!.prev;
                var nextNode = tmp!.next;
                prevNode!.next = nextNode;
                nextNode!.prev = prevNode;
            }
            tmp = tmp!.next;
        }
    }
    
    func findFirstPosition(of:T)->Int{
        print("Finding First Position Of \(of):", terminator: " ")
        var tmp = self.head!;
        var pos = 0;
        while tmp.next != nil {
            if tmp.val == of {
                print(pos)
                return pos;
            }
            tmp = tmp.next!;
            pos+=1;
        }
        print("Not Found")
        return -1;
    }
    
    func log(){
        if self.head == nil {
            return print("DLL Is Empty")
        }
        var tmp = self.head;
        print("nil<->", terminator: "");
        while tmp != nil {
            print(tmp!.val, terminator: "<->");
            tmp=tmp!.next;
        }
        print("nil");
        return;
    }
}

print("\n==== DOUBLY LINKED LIST ====")
var dll = DoublyLinkedList(1);
dll.insertAtHead(0);
dll.insertAtTail(2);
dll.insert(val: 3, at: 3)
dll.insert(val: 3, at: 0)
dll.log();
dll.findFirstPosition(of: 3);
dll.findFirstPosition(of: 2);
dll.insert(val: 3, at: 2);
dll.log();
dll.removeNodes(withValue: 3);
dll.log();
dll.findFirstPosition(of: 3);
//dll.reverse();
dll.clear();
dll.log();


// (OPTIONAL) TASK: CREATE A BINARY TREE

// (OPTIONAL) TASK: CREATE A BST

// TASK: CREATE A GRAPH

// TASK: CREATE AN LRU CACHE

// SWIFT-TASK: CREATE AN IMMUTABLE PERSISTANT LIST

// SWIFT-TASK: CREATE A THREAD-SAFE QUEUE


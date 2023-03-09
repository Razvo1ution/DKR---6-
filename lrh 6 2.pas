program SinglyLinkedList;
uses crt;
type
NodePtr = ^Node;
Node = record
data: integer;
next: NodePtr;
end;

var
head: NodePtr;


function newNode(data: integer): NodePtr;
var
temp: NodePtr;
begin
new(temp);
temp^.data := data;
temp^.next := nil;
newNode := temp;
end;

procedure insertAtBeginning(data: integer);
var
temp: NodePtr;
begin
temp := newNode(data);
temp^.next := head;
head := temp;
end;

procedure insertAtEnd(data: integer);
var
temp, current: NodePtr;
begin
temp := newNode(data);
if (head = nil) then
begin
head := temp;
exit;
end;
current := head;
while (current^.next <> nil) do
current := current^.next;
current^.next := temp;
end;

procedure deleteNode(data: integer);
var
temp, prev: NodePtr;
begin
if (head = nil) then exit;
if (head^.data = data) then
begin
temp := head;
head := head^.next;
dispose(temp);
exit;
end;
prev := head;
while (prev^.next <> nil) do
begin
temp := prev^.next;
if (temp^.data = data) then
begin
prev^.next := temp^.next;
dispose(temp);
exit;
end;
prev := prev^.next;
end;
end;

procedure printList;
var
current: NodePtr;
begin
current := head;
while (current <> nil) do
begin
write(current^.data, ' ');
current := current^.next;
end;
writeln;
end;

begin

insertAtBeginning(3);
insertAtBeginning(2);
insertAtBeginning(1);
printList; 


insertAtEnd(4);
insertAtEnd(5);
insertAtEnd(6);
printList; 


deleteNode(3);
printList;
end.
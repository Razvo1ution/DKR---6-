type
NodePtr = ^Node;
Node = record
data: Integer;
next: NodePtr;
end;

var
head: NodePtr;
node1, node2, node3: Node;

begin
//Узлыыыыыыыы
node1.data := 10;
node2.data := 20;
node3.data := 30;

// созд Cвязный список
head := @node1;
node1.next := @node2;
node2.next := @node3;
node3.next := nil;

// исп св список
while head <> nil do
begin
writeln(head^.data);
head := head^.next;
end;
end.
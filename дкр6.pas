uses crt;
type
TNode = record
Data: integer;
Next: integer;
end;

var
List: array[1..100] of TNode;
Head, Tail: integer;

procedure InitList;
begin
Head := 0;
Tail := 0;
end;

function IsEmpty: boolean;
begin
Result := Head = 0;
end;

procedure AddNode(Data: integer);
begin
if Tail = 0 then
begin
Inc(Head);
List[Head].Data := Data;
Tail := Head;
end
else
begin
Inc(Tail);
List[Tail].Data := Data;
List[Tail - 1].Next := Tail;
end;
end;

procedure DeleteNode(Data: integer);
var
Current, Previous: integer;
begin
if IsEmpty then Exit;
Current := Head;
Previous := 0;
while (Current <> 0) and (List[Current].Data <> Data) do
begin
Previous := Current;
Current := List[Current].Next;
end;
if Current <> 0 then
begin
if Current = Head then
Head := List[Head].Next;
if Current = Tail then
Tail := Previous;
List[Previous].Next := List[Current].Next;
end;
end;
begin
  writeln(Head,Tail,List,IsEmpty,Inc);
end.

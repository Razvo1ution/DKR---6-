program Project1;
 
type
  TData = Integer;
  TPElem = ^TElem;
  TElem = record
    Data : TData;
    PNext : TPElem;
  end;
  TDList = record
    Cnt : Integer;
    PFirst, PLast : TPElem;
  end;
procedure Init(var aList : TDList);
begin
  aList.Cnt := 0;
  aList.PFirst := nil;
  aList.PLast := nil;
end;
procedure Add(var aList : TDList; const aData : TData);
var
  PElem : TPElem;
begin
  New(PElem);
  PElem^.Data := aData;
  PElem^.PNext := nil;
  if aList.PFirst = nil then
    aList.PFirst := PElem
  else
    aList.PLast^.PNext := PElem;
  aList.PLast := PElem;
  Inc(aList.Cnt);
end;
procedure Free(var aList : TDList);
var
  PElem, PDel : TPElem;
begin
  PElem := aList.PFirst;
  while PElem <> nil do begin
    PDel := PElem;
    PElem := PElem^.PNext;
    Dispose(PDel);
  end;
  Init(aList);
end;
procedure Print(var aList : TDList);
var
  PElem : TPElem;
  i : Integer;
begin
  PElem := aList.PFirst;
  i := 0;
  while PElem <> nil do begin
    Inc(i);
    if i > 1 then Write(', ');
    Write(PElem^.Data);
    PElem := PElem^.PNext;
  end;
  Writeln;
end;
procedure Reverse(var aList : TDList);
var
  PElem, PNext : TPElem;
begin
  aList.PLast := aList.PFirst;
  PNext := aList.PFirst;
  aList.PFirst := nil;
  while PNext <> nil do begin
    PElem := PNext;
    PNext := PNext^.PNext;
    PElem^.PNext := aList.PFirst;
    aList.PFirst := PElem;
  end;
end;
procedure Del(var aList : TDList; var aPPrev : TPElem);
var
  PDel : TPElem;
begin
  if aList.PFirst = nil then Exit;
 
  if aPPrev = nil then begin
    PDel := aList.PFirst;
    aList.PFirst := PDel^.PNext;
  end else begin
    PDel := aPPrev^.PNext;
    if PDel <> nil then aPPrev^.PNext := PDel^.PNext;
  end;
  if aList.PLast = PDel then aList.PLast := aPPrev;
  if PDel <> nil then begin
    Dispose(PDel);
    Dec(aList.Cnt);
  end;
end;
function DelByVal(var aList : TDList; const aData : TData) : Integer;
var
  PElem, PPrev : TPElem;
  Cnt : Integer;
begin
  Cnt := 0;
  PPrev := nil;
  PElem := aList.PFirst;
  while PElem <> nil do begin
    if PElem^.Data = aData then begin
      PElem := PElem^.PNext;
      Del(aList, PPrev);
      Inc(Cnt);
    end else begin
      PPrev := PElem;
      PElem := PElem^.PNext;
    end;
  end;
  DelByVal := Cnt;
end;
procedure WorkAdd(var aList : TDList);
var
  S : String;
  Data : TData;
  Code : Integer;
begin
  Writeln('Добавление элементов в список.');
  Writeln('Ввод каждого значения завершайте нажатием Enter.');
  Writeln('Чтобы прекратить ввод оставьте пустую строку и нажмите Enter.');
  repeat
    Write('Элемент №', aList.Cnt + 1, ': ');
    Readln(S);
    if S = '' then begin
      Writeln('Отмена.');
      Code := 0;
    end else begin
      Val(S, Data, Code);
      if Code = 0 then begin
        Add(aList, Data);
        Writeln('Элемент добавлен.');
        Code := 1;
      end else
        Writeln('Неверный ввод. Повторите.');
    end;
  until Code = 0;
  Writeln('Ввод элементов списка завершён.');
end;
 
var
  L : TDList;
  Data : TData;
  Cmd, Code, Cnt : Integer;
  S : String;
begin
  Init(L);
  repeat
    Writeln('Выберите действие:');
    Writeln('1: Добавление элементов в список.');
    Writeln('2: Распечатка списка.');
    Writeln('3: Удаление элементов по условию.');
    Writeln('4: Перестройка списка в обратном порядке.');
    Writeln('5: Удаление списка.');
    Writeln('6: Выход.');
    Write('Введите команду: ');
    Readln(Cmd);
    case Cmd of
      1: WorkAdd(L);
      2:
        if L.PFirst = nil then
          Writeln('Спиосок пуст.')
        else begin
          Writeln('Содержимое списка:');
          Print(L);
        end;
      3:
      begin
        Writeln('Элементы с заданным значением будут удалены из списка.');
        Writeln('Чтобы отменить операцию оставьте пустую строку и нажмите Enter.');
        repeat
          Write('Значение: ');
          Readln(S);
          if S = '' then begin
            Writeln('Операция отменена.');
            Code := 0;
          end else begin
            Val(S, Data, Code);
            if Code = 0 then begin
              Cnt := DelByVal(L, Data);
              Writeln('Список обработан. Количество удалённых элементов: ', Cnt);
              Code := 1;
            end else
              Writeln('Неверный ввод. Повторите.');
          end;
        until Code = 0;
      end;
      4:
      begin
        Reverse(L);
        Writeln('Список перестроен в обратном порядке.');
      end;
      5, 6:
      begin
        Free(L);
        Writeln('Список удалён из памяти (очищен).');
      end;
      else
        Writeln('Незарегистрированная команда. Повторите ввод.');
    end;
  until Cmd = 6;
 
  Writeln('Работа программы завершена. Для выхода нажмите Enter.');
  Readln;
end.
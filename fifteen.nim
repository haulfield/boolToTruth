import strutils, macros, math

type
  Polinom =  object
    poli: string
    varNum: int

proc findMax(s: string): int =
  result = 0
  for temp in s:
    if temp in {'0'..'9'}:
      var tempDigit = parseInt($temp)
      if tempDigit > result:
          result = tempDigit

#proc newPolinom(data: string): Polinom =
#  new(result)
 # result.poli = data
  #result.varNum = findMax(data)

proc myPow(a:int, b:int64):Natural=
  result = 1
  for x in 1..b:
    result = result*a

proc pushFirst(s: var string) =
  s.add($s[0])
  s.delete(0,0)
  
template `/\`(a, b: expr): expr =
  a and b

template `\/`(a, b: expr): expr =
  a or b

template `!`(a: expr): expr=
  not a

const p: string = replaceWord(s = r"((1)/\(!x1)\/(x2)/\(x3))", sub = "1", by = "true")
    
macro buildCode(varN: int{lit}): stmt=
  var varNum: int = (varN.intVal).int
  var source: string = "var res = \"\"\n"
  result = newNimNode(nnkStmtList)
  for i in 1..varNum:
    var xString:string = repeat('0', myPow(2, i-1))&repeat('1', myPow(2, i-1))
    source &= "var x"&($i)&"=true\n"
    source &= "var temp"&($i)&"=0\n"
    source &= "var xString"&($i)&":string=\""&xString&"\"\n"
  for ao in 1..myPow(2, varNum):
    for i in 1..varNum:
      source &= "temp"&($i)&"=parseInt($xString"&($i)&"[0])\n"
      source &= "x"&($i)&" = if (temp"&($i)&" == 1):true else:false\n"
      source &= "xString"&($i)&".pushFirst()\n"
    source &= "if(!("&p&")):res = \"no\"\n"
  discard """
  ІТАК ДІМА ВСЬО РАБОТАЄ
  Єслі я правильно понял условіє, і єслі тобі нужно видавать yes 
  коли всі резалти = 0
  i no, єслі хоть один резалт не равєн нулю, то я всьо правильно сдєлав
  64 строка тобі в помощь в розборі мого кода
  """
  result = parseStmt(source)
  echo repr(result)
  
when isMainModule:
  const polin:Polinom = Polinom(poli: p, varNum: findMax(p))
  echo "POLIN: ",polin.varNum
  buildCode(3)
  echo res

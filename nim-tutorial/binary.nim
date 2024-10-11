import std/sequtils
  
type
  Allergen* = enum
    Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats

proc intToBin(i: int): seq[int] =
  var s: seq[int] = @[]
  var n = i
  if i == 0: return @[0]
  else:
    while n > 0:
      s = s & (n mod 2)
      n = n div 2
    s

proc allergies*(score: int): set[Allergen] =
  var result: set[Allergen] = {}
  let pairs = zip(Allergen.items.toSeq(), intToBin(score))
  for t in pairs:
    if t[1] == 1: result.incl(t[0])
  result
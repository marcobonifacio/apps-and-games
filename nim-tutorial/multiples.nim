import std/sets
  
proc multiples(limit:int, base: int): seq[int] =
  var res: seq[int] = @[]
  var counter: int = base
  while counter < limit:
    res.add(counter)
    counter += base
  res
  
proc sum*(limit: int, factors: openArray[int]): int =
  var commons = initHashSet[int]()
  for factor in factors:
    commons = commons + toHashSet(multiples(limit, factor))
  var res = 0
  for element in commons.items:
    res += element
  res

echo sum(1, @[0])
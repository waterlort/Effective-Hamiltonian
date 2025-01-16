BubbleSortWithOddSwaps[L_, list_] := 
 Module[{swapped = True, temp, i, newList = list, s = 1, oddSwaps, 
   isOddSwap},
  p = Length[list];
  While[swapped, swapped = False;
   For[i = 1, i < p, i++, 
    If[newList[[i]] > newList[[i + 1]],(*Perform the swap*)
     isOddSwap = newList[[i]] - newList[[i + 1]];
     temp = newList[[i]];
     newList[[i]] = newList[[i + 1]];
     newList[[i + 1]] = temp;
     swapped = True;
     If[isOddSwap == 1 || isOddSwap == L - 1, s = -s;];]];
   p--;  (*Decrement n since the largest element is now at the \
end*)];
  s(*Return the sign of s (-1 or 1 based on the count of odd swaps)*)
  ]
Geometricfactor[L_, edgeset_, bonds_, defects_] := 
 Module[{subtemp, sum},
  allPermutations = Permutations[edgeset];
  ll = Length[edgeset];
  sum = 0;
  For[i = 1, i <= Length[allPermutations], i++, 
   templist = allPermutations[[i]]; 
   s = BubbleSortWithOddSwaps[L, templist]; q = 1; 
   tempV = ConstantArray[0, L]; subtemp = 1;
   
   For[j = 1, j <= ll - 1, j++,
    tempV[[templist[[j]]]] = Mod[tempV[[templist[[j]]]] + 1, 2]; 
    tempV[[Mod[templist[[j]] + 1, L, 1]]] = 
     Mod[tempV[[Mod[templist[[j]] + 1, L, 1]]] + 1, 2];
    q = Total[tempV];
    For[k = 1, k <= Length[bonds], k++, 
     If[tempV[[bonds[[k]]]] == 1 && 
        tempV[[Mod[bonds[[k]] + 1, L, 1]]] == 1, q -= 2];];
    For[k = 1, k <= Length[defects], k++, q -= tempV[k];];
    
    If[q == 0, Continue[]];
    subtemp = -subtemp/(2 q)];
   sum += subtemp*s;
   ];
  sum
  ]
InteractiveGeometricFactor[] := 
 Module[{L, edgeset, defects, allElements, bonds, 
   result},(*Input the length of the loop L*)
  L = Input[
    "Please enter the length of the loop (a positive integer): "];
  While[! IntegerQ[L] || L <= 0, 
   Print["Error: Please enter a positive integer."];
   L = Input[
     "Please enter the length of the loop (a positive integer): "];];
  (*Input edgeset*)
  edgeset = 
   InputString[
    "Please enter the edges (comma-separated positive integers, range \
1 to " <> ToString[L] <> "): "];
  edgeset = StringSplit[edgeset, ","];
  edgeset = ToExpression[edgeset];
  While[! VectorQ[edgeset, IntegerQ] || ! SubsetQ[Range[L], edgeset], 
   Print["Error: Ensure the edges are integers in the range 1 to " <> 
     ToString[L] <> ", separated by commas."];
   edgeset = 
    InputString[
     "Please enter the edges (comma-separated positive integers, \
range 1 to " <> ToString[L] <> "): "];
   edgeset = StringSplit[edgeset, ","];
   edgeset = ToExpression[edgeset];];
  (*Input defects*)
  defects = 
   InputString[
    "Please enter defects (comma-separated integers, subset of \
edgeset): "];
  defects = StringSplit[defects, ","];
  defects = ToExpression[defects];
  While[! VectorQ[defects, IntegerQ] || ! SubsetQ[edgeset, defects], 
   Print["Error: Ensure defects are a subset of edgeset, separated by \
commas."];
   defects = 
    InputString[
     "Please enter defects (comma-separated integers, subset of \
edgeset): "];
   defects = StringSplit[defects, ","];
   defects = ToExpression[defects];];
  (*Calculate bonds*)allElements = Range[L];
  bonds = Sort[Complement[allElements, edgeset]];
  (*Call Geometricfactor and output the result*)
  result = Geometricfactor[L, edgeset, bonds, defects];
  Print["Result: ", result];]

InteractiveGeometricFactor[]

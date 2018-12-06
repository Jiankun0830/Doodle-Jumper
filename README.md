# Doodle Junmper
The objective was to direct a main character, named "Doodle", who moves continuously to the right. Players can make it jump over the obstacles along the way by doing the math problems. The players need to calulate and compare the sun of two numbers with the given result. 


Arithmetic Logic Unit
======================

Our game make use of the following ALU functions, including three dunctions added by ourselves.

ALUFN  | Operation | Type    | Description
------ | --------- | ------- | ------------------
000000 | ADD       | ARITH   | A + B
000001 | SUB       | ARITH   | A - B
000010 | MUL       | ARITH   | A * B
011000 | AND       | BOOL    | bitwise A and B
011110 | OR        | BOOL    | bitwise A or B
010110 | XOR       | BOOL    | bitwise A xor B
100000 | SHL       | SHIFT   | shift A leftwards by B bits
100001 | SHR       | SHIFT   | shift A rightwards by B bits
110011 | CMPEQ     | CMP     | compare if A == B
110101 | CMPLT     | CMP     | compare if A < B
110111 | CMPLE     | CMP     | compare if A <= B
111011 | CMPNE     | CMP     | compare if A != B
111101 | CMPGE     | CMP     | compare if A >= B
111111 | CMPGT     | CMP     | compare if A > B





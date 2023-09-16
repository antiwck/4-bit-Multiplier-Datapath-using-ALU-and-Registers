# 4-bit-Multiplier-usinng-ALU-and-Registers
# The 4-bit multiplier uses ALU, registers and counter to perform multiplication between two 4-bit unsigned binary numbers.

The program is compiled in Intel Quartus Prime and run under the testbench to perform the functional computation.
The 4-bit multiplier takes two 4-bit number in binary and multiply the two to produce a result that reflects the computation.
The datapath consists of a 4-bit registers, two 4-bit shifter registers, a 1-bit register, a 4-bit adder, a 4-bit AND gate comparator, and a counter.
<br /><br />
Assume: a = First multiplication operand, b = Second multiplication operand, E = Ereg, B = Breg, Ph = Phreg, Pl = Plreg
<br /><br />
The algorithm of the datapath is as below: <br />
E with '0' <br />
B = b <br />
Ph = "0000" <br />
Pl = a <br />
counter = 0 <br />
while (counter < 3) { <br />
(&nbsp) [E, Ph] = Ph + Pl(0)*B <br />
(&nbsp) LSH1(E, Ph, Pl) <br />
(&nbsp) counter = counter + 1 <br />
(&nbsp) } <br />
OUTPUT [Ph, Pl]
<br />
The timing for the dataflow is controlled by a clock signal and the loading of register is dependent on the rising clock edge.

<br />
<p align="center">
  <img src="Sources/Datapath design.png"><br />
  Datapath Design
</p>

<br />
<p align="center">
  <img src="Sources/Output1.png"/><br />
  Result computation 1
</p>
<br />
First computation:<br />
First number  : 1101 (13)<br />
Second number : 1011 (11)<br />
Result        : 10001111 (143)<br />

<br />
<p align="center">
  <img src="Sources/Output2.png"/><br />
  Result computation 2
</p>
<br />
Second computation:<br />
First number  : 1100 (12)<br />
Second number : 1000 (8)<br />
Result        : 01100000 (96)<br />
<br />

<br />
<p align="center">
  <img src="Sources/Output3.png"/><br />
  Result computation 3
</p>
<br />
Third computation:<br />
First number  : 0110 (6)<br />
Second number : 1100 (12)<br />
Result        : 01001000 (72)<br />
<br />

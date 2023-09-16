# 4-bit-Multiplier-usinng-ALU-and-Registers
# The 4-bit multiplier uses ALU, registers and counter to perform multiplication between two 4-bit unsigned binary numbers.

The program is compiled in Intel Quartus Prime and run under the testbench to perform the functional computation.
The 4-bit multiplier takes two 4-bit number in binary and multiply the two to produce a result that reflects the computation.
The datapath consists of two 4-bit registers, one 4-bit multiplier and one 8-bit register.
The 4-bit register stores the value for the two binary numbers and the 8-bit register store the final computed result.
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
  Result computation 1
</p>
<br />
Second computation:<br />
First number  : 1100 (12)<br />
Second number : 1000 (8)<br />
Result        : 01100000 (96)<br />
<br />

<br />
<p align="center">
  <img src="Sources/Output3.pngg"/><br />
  Result computation 1
</p>
<br />
Third computation:<br />
First number  : 0110 (6)<br />
Second number : 1100 (12)<br />
Result        : 01001000 (72)<br />
<br />

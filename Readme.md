# 4-bit Multiplier using Adder and Registers
# The 4-bit multiplier uses adder, registers and counter to perform multiplication between two 4-bit unsigned binary numbers.

The program is compiled in Intel Quartus Prime and run under the testbench to perform the functional computation.
The 4-bit multiplier takes two 4-bit number in binary and multiply the two to produce a result that reflects the computation.
The datapath consists of a 4-bit registers, two 4-bit shifter registers, a 1-bit register, a 4-bit adder, a 4-bit AND gate comparator, and a counter.
<br /><br />
Assume: a = First multiplication operand, b = Second multiplication operand, E = Ereg, B = Breg, Ph = Phreg, Pl = Plreg
<br /><br />
The algorithm of the datapath is as below: <br />
<pre>
E = '0' 
B = b
Ph = "0000"
Pl = a 
counter = 0 
while (counter < 3) {
    [E, Ph] = Ph + Pl(0)*B 
    LSR1(E, Ph, Pl) 
    counter = counter + 1 
    } 
OUTPUT [Ph, Pl]
</pre>
<br />
<p align="center">
  <img src="Sources/Time.png"><br />
  Timing Analysis
</p>
<br />
Figure above shows that the multiplication takes 140ns to complete.<br />
The clock is set at 5ns for low and high giving a total cycle duty of 10ns.<br />
The start signal will be high for 17.5ns and low for 122.5ns to enable the loading of value into the registers and allowing the 4-bit adder to compute with the preloaded zero setting.<br />
The load and shift will follow next where the load will continue to load the adder output into the registers and shift will shift the registers data to the right by one bit.<br />
For each subsequenct computation, there will be a clock edge before load to allow adder to perform the neccesary computation.<br />
The last clock edge will be used to indicate the computation has completed and result will be projected.<br />
<br />
The timing for the dataflow is controlled by a clock signal and the loading of register is dependent on the rising clock edge.
<br />
<br />
<p align="center">
  <img src="Sources/Datapath design.png"><br />
  Datapath Design
</p>

<br />
<p align="center">
  <img src="Sources/Result1.png"/><br />
  Result computation 1
</p>
<br />
First computation:<br />
First number  : 1101 (13)<br />
Second number : 1011 (11)<br />
Result        : 10001111 (143)<br />

<br />
<p align="center">
  <img src="Sources/Result2.png"/><br />
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
  <img src="Sources/Result3.png"/><br />
  Result computation 3
</p>
<br />
Third computation:<br />
First number  : 0110 (6)<br />
Second number : 1100 (12)<br />
Result        : 01001000 (72)<br />
<br />

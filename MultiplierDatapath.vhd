-- 4-bit register
LIBRARY ieee;
USE ieee.std_logic_1164.all; 
ENTITY FourBitRegister IS 
	Port (
		data_in  : in STD_LOGIC_VECTOR(3 downto 0);
		data_out : out STD_LOGIC_VECTOR(3 downto 0);
		clk      : in  std_logic;
		load     : in  std_logic
	); 
END FourBitRegister;

architecture Behavioral of FourBitRegister is

signal reg_data : STD_LOGIC_VECTOR(3 downto 0);

begin
	process(clk)
	begin
		if rising_edge(clk) then
			if load = '1' then
				reg_data	<= data_in;
			end if;
		end if;
    end process;
	 data_out  <= reg_data;
end Behavioral;

------------------------------------------------------------------------------------
-- 4-bit shift register
LIBRARY ieee;
USE ieee.std_logic_1164.all; 

ENTITY FourBitShiftRegister IS 
	Port (
		data_in  	: in  STD_LOGIC_VECTOR(3 downto 0);
		data_out 	: out  STD_LOGIC_VECTOR(3 downto 0);
		clk     	: in  STD_LOGIC;
		load		: in  STD_LOGIC;
		shift 	  	: in  STD_LOGIC;
		shift_in 	: in  STD_LOGIC;
		shift_out	: out STD_LOGIC
	); 
END FourBitShiftRegister;

architecture Behavioral of FourBitShiftRegister is

signal reg_data : STD_LOGIC_VECTOR(3 downto 0);

begin
	process(clk)
	begin
		if rising_edge(clk) then
			if load = '1' then
				reg_data <= data_in;
			elsif shift = '1' then
				reg_data 	<= shift_in & reg_data(3 downto 1);
			end if;
		end if;
	end process;
	data_out <= reg_data;
	shift_out 	<= reg_data(0);
end Behavioral;

------------------------------------------------------------------------------------
-- D flip-flop
library ieee;
use ieee.std_logic_1164.all;
entity OneBitFlipFlop is
    port (
        data_in  : in STD_LOGIC;
        data_out : out STD_LOGIC;
        clk      : in std_logic;
        load     : in std_logic;
		  shift	  : in std_logic
    );
end OneBitFlipFlop;

architecture Behavioral of OneBitFlipFlop is

signal reg_data : std_logic := 'U';

begin
	process(clk)
	begin
		if rising_edge(clk) then
			if load = '1' then
				reg_data	<= data_in;
			elsif shift = '1' then
				data_out <= reg_data;
				reg_data	<= '0';
			end if;
		end if;
		data_out  <= reg_data;		
	end process;
end Behavioral;

------------------------------------------------------------------------------------
-- Full adder
library ieee;
use ieee.std_logic_1164.all;

ENTITY FA IS 
	PORT (        
		a, b, cin : IN std_logic;
		cout, sum   : OUT std_logic
	);
END ENTITY;

ARCHITECTURE Behavioral OF FA IS

SIGNAL tmp : std_logic;

BEGIN
	tmp <= (a XOR b);
	sum <= (tmp XOR cin);
	cout <= ((tmp AND cin) OR (a AND b));
END Behavioral;

------------------------------------------------------------------------------------
-- 4-bit adder
library ieee;
use ieee.std_logic_1164.all;

entity FourBitAdder is
	port (
		operand1  : in  std_logic_vector(3 downto 0);
		operand2  : in  std_logic_vector(3 downto 0);
		sum       : out std_logic_vector(3 downto 0);
		cout      : out std_logic
	);
end FourBitAdder;

architecture Behavioral of FourBitAdder is
	COMPONENT FA IS 
		PORT (        
			a, b, cin : IN std_logic;
			cout, sum   : OUT std_logic
		);
	END COMPONENT;

SIGNAL C0, C1, C2 : std_logic;

begin
    ADDER_0 : FA PORT MAP(
		  a     => operand1(0),
		  b     => operand2(0), 
        cin	  => '0',
		  cout  => C0,
		  sum   => sum(0)
	 );
	 ADDER_1 : FA PORT MAP(
		  a     => operand1(1),
		  b     => operand2(1), 
        cin   => C0,
		  cout  => C1,
		  sum   => sum(1)
	 );
	 ADDER_2 : FA PORT MAP(
		  a     => operand1(2),
		  b     => operand2(2), 
        cin   => C1,
		  cout  => C2,
		  sum   => sum(2)
	 );
	 ADDER_3 : FA PORT MAP(
		  a     => operand1(3),
		  b     => operand2(3), 
        cin   => C2,
		  cout  => cout,
		  sum   => sum(3)
	 );
end Behavioral;

------------------------------------------------------------------------------------
-- 4-bit AND
library ieee;
use ieee.std_logic_1164.all;

entity FourBitAND is
	port (
		operand1  : in  std_logic_vector(3 downto 0);
		operand2  : in  std_logic;
		result	 : out std_logic_vector(3 downto 0)
	);
end FourBitAND;

architecture Behavioral of FourBitAND is

begin
	process(operand2)
	begin
		if operand2 = '1' then
			result <= operand1;
		else
			result <= "0000";
		end if;
	end process;
end Behavioral;

------------------------------------------------------------------------------------
-- Counter
library ieee;
use ieee.std_logic_1164.all;
entity Counter is
	port (
		clk     	: in std_logic;
		done_ctr : out std_logic;
		reset		: in std_logic
	);
end Counter;

architecture Behavioral of Counter is

signal counter_reg : integer := 0;

begin
	process(clk)
	begin
		if falling_edge(clk) then
			counter_reg <= counter_reg + 1;
			if reset = '1' then
				done_ctr <= '0';
				counter_reg <= 0;
			elsif counter_reg = 12 then
				done_ctr <= '1';
			end if;
		end if;
	end process;
end Behavioral;

------------------------------------------------------------------------------------
-- Main datapath
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY MultiplierDatapath IS 
    PORT (
        clk          : IN  STD_LOGIC;
        start        : IN  STD_LOGIC;
		  load			: IN STD_LOGIC;
		  shift			: IN STD_LOGIC;
		  a            : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        b            : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        result       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END MultiplierDatapath;

ARCHITECTURE Behavioral OF MultiplierDatapath IS

	COMPONENT FourBitRegister IS 
		Port (
			data_in  : in STD_LOGIC_VECTOR(3 downto 0);
			data_out : out STD_LOGIC_VECTOR(3 downto 0);
			clk      : in  std_logic;
			load     : in  std_logic
		); 
	END COMPONENT;

	COMPONENT FourBitShiftRegister IS 
		Port (
			data_in  	: in  STD_LOGIC_VECTOR(3 downto 0);
			data_out 	: out  STD_LOGIC_VECTOR(3 downto 0);
			clk     	   : in  STD_LOGIC;
			load		   : in  STD_LOGIC;
			shift 	  	: in  STD_LOGIC;
			shift_in 	: in  STD_LOGIC;
			shift_out	: out STD_LOGIC
		); 
	END COMPONENT;
	
	COMPONENT OneBitFlipFlop is
		port (
			data_in  : in STD_LOGIC;
			data_out : out STD_LOGIC;
			clk      : in std_logic;
			load     : in std_logic;
			shift    : in std_logic
		);
	END COMPONENT;
	
	COMPONENT FourBitAdder is
		port (
			operand1  : in  std_logic_vector(3 downto 0);
			operand2  : in  std_logic_vector(3 downto 0);
			sum       : out std_logic_vector(3 downto 0);
			cout      : out std_logic
		);
	END COMPONENT;
	
	COMPONENT FourBitAND is
	port (
		operand1  : in  std_logic_vector(3 downto 0);
		operand2  : in  std_logic;
		result	 : out std_logic_vector(3 downto 0)
	);
	end COMPONENT;
	
	COMPONENT Counter is
		port (
			clk     	: in std_logic;
			done_ctr : out std_logic;
			reset		: in std_logic
		);
	END COMPONENT;

signal line1, line2, line3, line4, line5, lineTmp, lineTmp2, lineTmp5, lineTmp6, tmp1, tmp3	: std_logic_vector(3 downto 0) := "0000";
signal line6, line7, line8, done, reset, lineTmp3, lineTmp4, tmp2 									: std_logic := '0';
	
BEGIN

	Breg: FourBitRegister PORT MAP (
		data_in  => b,
		data_out => line1,
		clk      => clk,
		load     => load
	);
	
	Phreg: FourBitShiftRegister PORT MAP (
		data_in  	=> lineTmp2,
		data_out 	=> line2,
		clk     	   => clk,
		load		   => load,
		shift 	  	=> shift,
		shift_in 	=> line7,
		shift_out	=> line8
	);
	
	Plreg: FourBitShiftRegister PORT MAP (
		data_in  	=> lineTmp6,
		data_out 	=> line4,
		clk     	   => clk,
		load		   => load,
		shift 	  	=> shift,
		shift_in 	=> line8,
		shift_out	=> lineTmp3
	);
	
	Ereg : OneBitFlipFlop PORT MAP (
		data_in  => lineTmp4,
		data_out => line7,
		clk      => clk,
		load     => load,
		shift   	=> shift
	);	
	
	Adder : FourBitAdder PORT MAP (
		operand1  => lineTmp,
		operand2  => lineTmp5,
		sum       => line3,
		cout      => line6
	);
	
	ANNDres : FourBitAND PORT MAP (
		operand1  => line1,
		operand2  => line4(0),
		result	 => line5
	);
	
	Ctr : Counter PORT MAP (
		clk     	=> clk,
		done_ctr => done,
		reset		=> reset
	);
	
	
	process (clk)
	begin
		if rising_edge(clk) then
			if start = '1' then
				reset <= '0';
				result <= "UUUUUUUU";
			elsif done = '1' then
				reset <= '1';
				result <= line2 & line4; 	
			end if;
		end if;
		if start = '1' then
			lineTmp6 <= a;
			lineTmp 	<= "0000";
		else
			lineTmp <= line2;
			lineTmp6 <= line4;
		end if;
		lineTmp2 <= line3;
		lineTmp4 <= line6;
		lineTmp5 <= line5;
	end process;
	
END Behavioral;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Datapath IS
END Datapath;

ARCHITECTURE Behavioral OF Datapath IS
    SIGNAL clk     : std_logic;
    SIGNAL start   : std_logic;
	 SIGNAL load    : std_logic;
    SIGNAL shift   : std_logic;
    SIGNAL a       : std_logic_vector(3 downto 0);
    SIGNAL b       : std_logic_vector(3 downto 0);
    SIGNAL result  : std_logic_vector(7 downto 0);
	 
	 COMPONENT MultiplierDatapath IS
		 PORT (
			  clk          : IN  STD_LOGIC;
			  start        : IN  STD_LOGIC;
			  load			: IN STD_LOGIC;
			  shift			: IN STD_LOGIC;
			  a            : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
			  b            : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
			  result       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		 );
	END COMPONENT;
		
BEGIN

	UUT: MultiplierDatapath PORT MAP (
		clk 		=> clk,
		start 	=> start,
		load 		=> load,
		shift 	=> shift,
		a 		 	=> a,
		b		 	=> b,
		result 	=> result
	);

	clk_process: process
	begin
		clk <= '0';
		wait for 5 ns;
		clk <= '1';
		wait for 5 ns;
	end process;
	
	input_process: process
	begin
		a <= "1101";
		b <= "1011";
		-- result = 00011010
		wait for 140 ns;
		
		a <= "1100";
		b <= "1000";
		-- result = 01100000
		wait for 140 ns;
		
		a <= "0110";
		b <= "1100";
		-- result = 01001000
		wait for 140 ns;
	end process;


	start_process: process
	begin
		start <= '1';
		wait for 17.5 ns;
		start <= '0';
		wait for 122.5 ns;
	end process;

	load_process: process
	begin
		load <= '1';
		wait for 7.5 ns;
		load <= '0';
		wait for 15 ns;
		load <= '1';
		wait for 7.5 ns;

		load <= '0';
		wait for 22.5 ns;
		load <= '1';
		wait for 7.5 ns;

		load <= '0';
		wait for 22.5 ns;
		load <= '1';
		wait for 7.5 ns;
		
		load <= '0';
		wait for 22.5 ns;
		load <= '1';
		wait for 7.5 ns;

		load <= '0';
		wait for 20 ns;
	end process;

	shift_process: process
	begin
		shift <= '0';
		wait for 32.5 ns;
		shift <= '1';
		wait for 7.5 ns;

		shift <= '0';
		wait for 22.5 ns;
		shift <= '1';
		wait for 7.5 ns;

		shift <= '0';
		wait for 22.5 ns;
		shift <= '1';
		wait for 7.5 ns;
		
		shift <= '0';
		wait for 22.5 ns;
		shift <= '1';
		wait for 7.5 ns;

		shift <= '0';
		wait for 10 ns;
	end process;
	
END Behavioral;


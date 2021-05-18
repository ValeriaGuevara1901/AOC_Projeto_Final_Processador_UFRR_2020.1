LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;  

  ENTITY registrador IS
    PORT (
				clk : IN std_logic;
				E : IN std_logic;
				R : IN std_logic;
				D : IN std_logic_vector (7 DOWNTO 0);
				Q : OUT std_logic_vector (7 DOWNTO 0));
END registrador;

ARCHITECTURE behavior OF registrador IS
BEGIN
    PROCESS (clk, R)
		 BEGIN
			  IF (R='1') THEN
					Q <= (others => '0');
			  ELSIF (clk'event and clk='1') THEN
					IF (E='1') THEN
						Q <= D;
					END IF;
			  END IF;
	 END PROCESS;
END behavior;
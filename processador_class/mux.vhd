LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY muxi IS
    PORT (
				SEL_MUX: IN std_logic;
				I0_MUX : IN std_logic_vector (7 DOWNTO 0);
				I1_MUX : IN std_logic_vector (7 DOWNTO 0);
				SAIDA_MUX : OUT std_logic_vector (7 DOWNTO 0)
			);
END muxi;

ARCHITECTURE behavior OF muxi IS
BEGIN
    WITH SEL_MUX SELECT 
			 SAIDA_MUX <= I0_MUX	WHEN '0',
							  I1_MUX	WHEN OTHERS;
END behavior;
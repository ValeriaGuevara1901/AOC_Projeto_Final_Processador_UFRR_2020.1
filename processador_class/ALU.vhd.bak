LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY ALU IS
    PORT (
				A_ALU : IN std_logic_vector (7 DOWNTO 0);
				B_ALU : IN std_logic_vector (7 DOWNTO 0);
				SEL_ALU : IN std_logic_vector (1 DOWNTO 0);
				SAIDA_ALU : OUT std_logic_vector (7 DOWNTO 0)
			);
END ALU;

ARCHITECTURE behavior OF ALU IS
BEGIN
    SAIDA_ALU <= A_ALU + B_ALU WHEN SEL_ALU = "00" ELSE
					  A_ALU - B_ALU WHEN SEL_ALU = "01" ELSE
					  A_ALU - 1     WHEN SEL_ALU = "10" ELSE
					  A_ALU + 1;
END behavior;
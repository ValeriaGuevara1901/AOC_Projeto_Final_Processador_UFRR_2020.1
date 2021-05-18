LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY triplestado IS
    PORT (
				TE : IN std_logic;
				ENTRADA_TRIPLESTADO : IN std_logic_vector (7 DOWNTO 0);
				SAIDA_TRIPLESTADO  :OUT std_logic_vector (7 DOWNTO 0)
			);
END triplestado;

ARCHITECTURE behavior OF triplestado IS
BEGIN
    WITH TE SELECT 
	 SAIDA_TRIPLESTADO <= ENTRADA_TRIPLESTADO WHEN '0',
								 (OTHERS => 'Z')  WHEN OTHERS;
END behavior;
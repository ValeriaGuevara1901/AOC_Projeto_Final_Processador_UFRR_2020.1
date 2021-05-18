LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY data_fsm IS
    PORT (
				clk: IN std_logic;
				inicio: IN std_logic;
				Entrada1 : IN std_logic_vector (7 DOWNTO 0);
				Entrada2 : IN std_logic_vector (7 DOWNTO 0);
				Saida : OUT std_logic_vector (7 DOWNTO 0)
			);
END data_fsm;

ARCHITECTURE behavior OF data_fsm IS

COMPONENT Datapath
	PORT(
				clk : IN std_logic;
				bandeira_da : OUT std_logic;		
				Entrada_1 : IN std_logic_vector (7 DOWNTO 0);
				Entrada_2 : IN std_logic_vector (7 DOWNTO 0);
				PC_Datapath : IN std_logic_vector (10 DOWNTO 0);
				Saida : OUT std_logic_vector (7 DOWNTO 0)
			);
END COMPONENT;

COMPONENT fsm
	PORT(
				clk: IN std_logic;
				inicio: IN std_logic;
				bandeira : IN std_logic;
				PC_fsm:OUT std_logic_vector (10 DOWNTO 0)
			);
end component;
			
--creando os sinais para conetar
signal bandeira_link: std_logic := '0'; 
signal PC_link: std_logic_vector(10 downto 0 ) := (others => '0');


BEGIN
 
 Inst_Datapath: Datapath PORT MAP (
								
									clk => clk,
									bandeira_da => bandeira_link,
									Entrada_1 => Entrada1 ,
									Entrada_2 => Entrada2,
									PC_Datapath => PC_link,
									Saida => Saida 
 );
 
 
 Inst_fsm: fsm PORT MAP (
								
									clk => clk,
									inicio=> inicio ,
									bandeira => bandeira_link,
									PC_fsm => PC_link
 );
END behavior;
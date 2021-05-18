LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY fsm IS
    PORT (
				clk: IN std_logic;
				inicio, bandeira : IN std_logic;
				PC_fsm:OUT std_logic_vector (10 DOWNTO 0)
			);
END fsm;

ARCHITECTURE behavior OF fsm IS

type estados is (repouso,ler,apagar,somar,subtrair,imprimir);
signal estado_presente, estado_seguinte : estados := repouso;

BEGIN
--registro de estados
     PROCESS (clk)
		 BEGIN
			  IF (clk'event and clk='1') THEN
					estado_presente <= estado_seguinte;
			  END IF;
	 END PROCESS;
	 
	--Logica do estado seguinte 
	PROCESS (estado_presente, inicio, bandeira)
		BEGIN
			CASE (estado_presente) IS
					WHEN repouso =>
						IF inicio ='1' THEN
							estado_seguinte <= ler;
						ELSE
							estado_presente <= repouso;
						END IF;
							
		--Ingresso dos dados nas entradas					
						WHEN ler =>
							estado_seguinte <= apagar;
							
		--As operações 
						WHEN apagar =>
							estado_seguinte <= subtrair;
							
						WHEN somar =>
							estado_seguinte <= subtrair;
							
						WHEN subtrair =>
							IF bandeira ='1' THEN
								estado_seguinte <= somar;
							ELSE  
								estado_presente <= imprimir;
							END IF;

		--Os estados de impressao ou repouso
						WHEN imprimir =>
							estado_seguinte <= repouso;
							
						WHEN OTHERS =>
							estado_seguinte <= repouso;

			END CASE;
		END PROCESS;
		
--logica de saida 
					 WITH estado_presente SELECT 
							   PC_fsm <= "00000000001"	WHEN repouso,
											 "10100000101" WHEN ler,
											 "00000100001"	WHEN apagar,
											 "00001000001"	WHEN somar,
											 "10000010001"	WHEN subtrair,
											 "00000000000"	WHEN imprimir,
											 "00000000001"	WHEN OTHERS;
END behavior;

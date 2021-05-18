LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY Datapath IS
    PORT (
				      clk : IN std_logic;
				bandeira_da : OUT std_logic;		
				Entrada_1 : IN std_logic_vector (7 DOWNTO 0);
				Entrada_2 : IN std_logic_vector (7 DOWNTO 0);
				PC_Datapath : IN std_logic_vector (10 DOWNTO 0);
				Saida : OUT std_logic_vector (7 DOWNTO 0)
			);
END Datapath;

ARCHITECTURE behavior OF Datapath IS
-----------------Component ALU-------------------------------------------------
COMPONENT ALU
	PORT(
				A_ALU : IN std_logic_vector (7 DOWNTO 0);
				B_ALU : IN std_logic_vector (7 DOWNTO 0);
				SEL_ALU : IN std_logic_vector (1 DOWNTO 0);
				SAIDA_ALU : OUT std_logic_vector (7 DOWNTO 0)
			);
END COMPONENT;
-------------------Component muxtiplexador--------------------------------------
COMPONENT muxi
	PORT(
				SEL_MUX: IN std_logic;
				I0_MUX : IN std_logic_vector (7 DOWNTO 0);
				I1_MUX : IN std_logic_vector (7 DOWNTO 0);
				SAIDA_MUX : OUT std_logic_vector (7 DOWNTO 0)
			);
END COMPONENT;
---------------------Component registrador---------------------------------------
COMPONENT registrador
	PORT(
				clk : IN std_logic;
				E : IN std_logic;
				R : IN std_logic;
				D : IN std_logic_vector (7 DOWNTO 0);
				Q : OUT std_logic_vector (7 DOWNTO 0)
			);
END COMPONENT;
----------------------Component triplestado--------------------------------------
COMPONENT triplestado
	PORT(
				TE : IN std_logic;
				ENTRADA_TRIPLESTADO : IN std_logic_vector (7 DOWNTO 0);
				SAIDA_TRIPLESTADO  :OUT std_logic_vector (7 DOWNTO 0)
			);
END COMPONENT;
			
signal DA, DC, QA, QB, QC, sal_mux_2	: std_logic_vector (7 DOWNTO 0) := (OTHERS =>'0');					
------------------------	comeco datatapath-------------------------------------

BEGIN
 
 Inst_ALU: ALU PORT MAP (
									A_ALU	=> sal_mux_2,
									B_ALU => QB,
									SAIDA_ALU => DC,
									SEL_ALU => PC_Datapath (4 DOWNTO 3)
 );
 -------------------alu-----------------------------------------------------------

   Inst_mux_1: muxi PORT MAP (
								
									I0_MUX => DC,
									I1_MUX => Entrada_1,
									SEL_MUX=> PC_Datapath(2),
									SAIDA_MUX => DA
 );
 
  Inst_mux_2: muxi PORT MAP (
								
									I0_MUX => QC,
									I1_MUX => QA,
									SEL_MUX=> PC_Datapath(1),
									SAIDA_MUX => sal_mux_2
 );
------------------------multiplexores------------------------------------------------------

  Inst_registrador_A: registrador PORT MAP (
									clk  => clk,
									D  => DA,
									E  => PC_Datapath(10),
									R  => PC_Datapath(9),
									Q  => QA
 );
 
   Inst_registrador_B: registrador PORT MAP (
									clk  => clk,
									D  => Entrada_2,
									E  => PC_Datapath(8),
									R  => PC_Datapath(7),
									Q  => QB
 );
 
   Inst_registrador_C: registrador PORT MAP (
									clk  => clk ,
									D  => DC,
									E  => PC_Datapath(6),
									R  => PC_Datapath(5),
									Q  => QC
 );
 ----------------------os tres registros---------------------------------------------------
 
    Inst_triplestado: triplestado PORT MAP (
									TE  => PC_Datapath(0),
									ENTRADA_TRIPLESTADO  => QC ,
									SAIDA_TRIPLESTADO   => Saida
 );
 
 ---
 					 WITH QA SELECT 
							   bandeira_da <= '0'	WHEN "00000001",

													'1'	WHEN OTHERS;
 END behavior;
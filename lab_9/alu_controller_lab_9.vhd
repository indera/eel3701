-- lab9: design for ALU controller with IR2:0
-- Student: Andrei Sura
-- TA: Alan Hess
library ieee;
use ieee.std_logic_1164.all;

ENTITY alu_controller_lab_9 IS
port(	reset,clk	:	in std_logic;
		IR			:	in std_logic_vector(2 downto 0);
		PC_INC,PC_LD,IR_LD	:	out std_logic;
		MSA,MSB				: 	out std_logic_vector(1 downto 0);
		MSC					: 	out std_logic_vector(2 downto 0));
END alu_controller_lab_9;

ARCHITECTURE BHV OF alu_controller_lab_9 IS
CONSTANT A:	std_logic_vector(1 downto 0):= "00";
CONSTANT B:	std_logic_vector(1 downto 0):= "01";
CONSTANT C:	std_logic_vector(1 downto 0):= "10";
CONSTANT D:	std_logic_vector(1 downto 0):= "11";

SIGNAL state	:	std_logic_vector(1 downto 0);
BEGIN 
PROCESS(reset,clk)
BEGIN
	IF reset = '0' THEN
		state <= A;
	ELSIF (clk'event and clk = '1') THEN
		CASE state IS
			WHEN A =>
				state <= B;
			WHEN B =>
				IF IR = "001" THEN
					state <= C;
				ELSIF IR = "111" THEN
					state <= D;
				ELSE
					state <= A;
				END IF;
			WHEN C =>
				state <= A;
			WHEN D =>
				state <= A;
			WHEN OTHERS =>
		END CASE;
	END IF;
END PROCESS;

PROCESS (state,IR)
BEGIN
PC_INC <= '0';
PC_LD <= '0';
IR_LD <= '0';
MSC <= "000";
MSB <= "00";
MSA <= "00";

CASE state IS
	WHEN A =>
		IR_LD <= '1';
		MSA <= "10";
		MSB <= "01";
		MSC <= "100";
	WHEN B =>
		IF IR = "000" THEN
			MSA <= "10";
			MSB <= "10";
			MSC <= "100";
			PC_INC <= '1';
		ELSIF IR = "001" THEN
			MSA <= "10";
			MSB <= "01";
			MSC <= "100";
			PC_INC <= '1';
		ELSIF IR = "010" THEN
			MSB <= "01";
			MSC <= "010";
			PC_INC <= '1';
		ELSIF IR = "011" THEN
			MSB <= "01";
			PC_INC <= '1';
		ELSIF IR = "100" THEN
			MSB <= "01";
			MSC <= "001";
			PC_INC <= '1';
		ELSIF IR = "111" THEN
			MSA <= "10";
			MSB <= "01";
			MSC <= "100";
			PC_INC <= '1';
		ELSE
			MSA <= "10";
			MSB <= "01";
			MSC <= "100";
			PC_INC <= '1';
		END IF;
	WHEN C =>
		MSA <= "11";
		MSB <= "01";
		MSC <= "100";
		PC_INC <= '1';
	WHEN D =>
		PC_LD <= '1';
		MSA <= "10";
		MSB <= "01";
		MSC <= "100";
	WHEN OTHERS =>
END CASE;
END PROCESS;
END BHV;

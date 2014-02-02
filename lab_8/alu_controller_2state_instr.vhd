-- lab8: design for ALU controller
-- Student: Andrei Sura
-- TA: Alan Hess

library ieee;
use ieee.std_logic_1164.all;
entity alu_controller_2state_instr is port (
	Q				: in bit;
	IR_1, IR_0		: in bit;
	D				: out bit;
	MSA_1, MSA_0	: out bit;
	MSB_1, MSB_0	: out bit;
	MSC_2, MSC_1, MSC_0: out bit;
	IR_LD			: out bit 
);
end alu_controller_2state_instr;

architecture logic OF alu_controller_2state_instr IS

begin
	D <= (not(Q));
	-- MSA_1 <= ( not(IR_1 and Q));
	MSA_1 <= ( not(IR_1) or not(Q) );
	MSA_0 <= ( not(IR_1) and IR_0 and Q);
	
	MSB_1 <= ( not(IR_1) and not(IR_0) and Q);
	MSB_0 <= (IR_1 or IR_0 or not(Q));

	-- MSC_2 <= ( not(IR_1 and Q));
	MSC_2 <= ( not(IR_1) or not(Q));
	MSC_1 <= '0';
	MSC_0 <= (IR_1 and not(IR_0) and Q);
	
	IR_LD <= ( not(Q));
end logic;

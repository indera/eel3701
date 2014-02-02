-- lab6: design for MUX 4:1
-- Student: Andrei Sura
-- TA: Alan Hess

library ieee;
use ieee.std_logic_1164.all;
entity mux_41_vhdl is port (
	D3, D2, D1, D0	: in bit;
	S1, S0			: in bit;
	Y				: out bit
);
end MUX_41_vhdl;

architecture logic OF mux_41_vhdl IS
-- Y = (D0 * /S1 * /S0) + (D1 * /S1 * S0) + (D2 * S1 * /S0) + (D4 * S1 * S0)
begin
	Y <=   (D0 and (not S1) and (not S0))
		or (D1 and (not S1) and S0)
		or (D2 and  S1      and (not S0))
		or (D3 and  S1      and S0);
end logic;

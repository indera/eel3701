-- Andrei Sura
-- Lab7: Traffic Light Controller Logic
-- Monday: E1-E3
-- TA: Allan Hess

library ieee;
use ieee.std_logic_1164.all;
entity traffic_logic_vhdl is port (
	EV_L, CW_L			: in bit;
	Q2, Q1, Q0			: in bit;
	D2, D1, D0					: out bit;
	LIGHT_G, LIGHT_Y, LIGHT_R 	: out bit
);
end traffic_logic_vhdl;

architecture logic OF traffic_logic_vhdl IS
begin
-- commented due some mistake... 
--D2 <=  ( (not Q2) and Q1 and Q0       )
--	or ( Q2 and (not Q1) and (not Q0) )
--	or ( EV_L and Q2 and (not Q1) and Q0) ;
--D1 <=  ( (not Q2) and (not Q1) and (Q0 or EV_L)			)
--	or ( (not Q2) and Q1 and (not Q0) and (EV_L or CW_L));
--D0 <= ( (not Q2) and (not Q1) and ((not Q0) or EV_L)	)
--	or ( (not Q2) and Q1 and (not Q0) and (EV_L or CW_L))
--	or ( Q2 and (not Q1) and Q0 						);
D2 <=  ( (not Q2) and Q1 and Q0       )
	or ( Q2 and (not Q1) and (not Q0) )
	or ( EV_L and Q2 and (not Q1) and Q0) ;

D1 <=  (EV_L and (not Q2) and (not Q1) and (not Q0) )
	or ( (not EV_L) and (not Q2) and (not Q1) and Q0)
	or ( EV_L and (not Q2) and (not Q1) and Q0)
	or ( (not EV_L) and CW_L and (not Q2) and Q1 and (not Q0))
	or ( EV_L and (not Q2) and Q1 and (not Q0));

D0 <= ( (not EV_L) and 	(not Q2) and (not Q1)  and (not Q0))
	or ( (EV_L) and      (not Q2) and (not Q1) and (not Q0))
	or ( (EV_L) and      (not Q2) and (not Q1) and (Q0))
	or ( (not EV_L) and (CW_L) and (not Q2) and Q1 and (not Q0))
	or (EV_L and 		(not Q2) and Q1  and (not Q0))
	or (Q2 and (not Q1) and (not Q0));
-- Green
LIGHT_G <= (not EV_L) and (not Q2) and ( (not Q1) or (not Q0));
-- Yellow
LIGHT_Y <= (EV_L and Q2 and ( (not Q1) or (not Q2)))
	or ( (not Q2) and Q1 and Q0);
-- Red
LIGHT_R <= Q2 and (not Q1);
end logic;
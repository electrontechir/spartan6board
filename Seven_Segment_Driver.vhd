library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Seven_Segment_Driver is	--Common Anode 7segment
	Generic ( g_Clock_Frequency : integer := 50_000_000 ;
			  g_Digits_Number : integer := 3
		);
	port(
			  i_CLK : in  STD_LOGIC;
           i_Number : in  STD_LOGIC_VECTOR (4 * g_Digits_Number - 1 downto 0);
           o_Display : out  STD_LOGIC_VECTOR (g_Digits_Number - 1 downto 0);
           o_Segment : out  STD_LOGIC_VECTOR (7 downto 0)
			  );
end Seven_Segment_Driver;
architecture Behavioral of Seven_Segment_Driver is
	
	signal digit_number : integer range 0 to 2:=0;
	signal BCD_input1 : STD_LOGIC_VECTOR(3 downto 0);
begin

	o_Display <=  "001" when digit_number = 2 else
					  "010" when digit_number = 1 else
					  "100" when digit_number = 0 else
					  "000";
	WITH BCD_input1 SELECT 
	o_Segment <= "01000000" WHEN "0000" , -- "0"     
					 "01111001" WHEN "0001" , -- "1" 
				  	 "00100100" WHEN "0010" , -- "2" 
					 "00110000" WHEN "0011" , -- "3" 
					 "00011001" WHEN "0100" , -- "4" 
					 "00010010" WHEN "0101" , -- "5" 
					 "00000010" WHEN "0110" , -- "6" 
					 "01111000" WHEN "0111" , -- "7" 
					 "00000000" WHEN "1000" , -- "8"     
					 "00010000" WHEN "1001" , -- "9" 
					 "00001000" WHEN "1010" , -- a
					 "00000011" WHEN "1011" , -- b
					 "01000110" WHEN "1100" , -- C
					 "00100001" WHEN "1101" , -- d
					 "00000110" WHEN "1110" , -- E
					 "00001110" WHEN "1111" , -- F
					 "11111111" WHEN OTHERS;
					 
	BCD_input1 <= i_Number((digit_number + 1) * 4 - 1 downto (digit_number) * 4) ;
	
	PROCESS (i_CLK)
	VARIABLE I :INTEGER :=1;
	BEGIN
		IF RISING_EDGE(i_CLK) THEN
			IF digit_number =3 THEN
			digit_number<=0;
			END IF;
			IF I<1000 THEN
				I:=I+1;
			ELSE
			I:=0;
			digit_number<=digit_number+1;
			END IF;
		END IF;
	END PROCESS;

end Behavioral;
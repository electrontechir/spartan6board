library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ADC is
    Port ( i_CLK : in STD_LOGIC;
	        i_RST : in  STD_LOGIC;
           o_CS : out STD_LOGIC;
			  o_ADC_Data : out  STD_LOGIC_VECTOR (11 downto 0);
			  i_MISO : in  STD_LOGIC;
           o_SCLK : out STD_LOGIC);
end ADC;
 
architecture Behavioral of ADC is

	signal r_SCLK : STD_LOGIC := '1' ;
	signal r_Bit_Counter : integer range 0 to 40 := 0 ;
	signal r_CS : STD_LOGIC := '1' ;
	signal r_Input_Data_Buffer : STD_LOGIC_VECTOR(31 downto 0) ;
	signal r_init_Counter : integer range 0 to 100 := 0 ;
	signal cs_count : integer range 0 to 7 := 0 ;

begin
	
	Process(i_CLK) is
	begin
	
		if falling_edge(i_CLK) then
			if i_RST = '1' then
				r_SCLK <= '1' ;
			else
				if r_CS = '0' then
					r_SCLK <= not r_SCLK ;
				end if ;	
			end if ;	
		end if ;
		
				if rising_edge(i_CLK) then

				if i_RST = '1' then
				r_Bit_Counter <= 0 ;
				r_CS <= '1' ;
			else
					
				if r_CS = '1' then
					if cs_count < 1 then
						cs_count <= cs_count + 1 ;
					else
						r_CS <= '0' ;
						cs_count <= 0 ;
					end if ;
				end if ;

					if r_SCLK = '1' then
						if r_Bit_Counter < 23 then
							r_Bit_Counter <= r_Bit_Counter + 1 ;
						else
							r_Bit_Counter <= 0 ;
							r_CS <= '1' ;
						end if ;
					end if ;
					
		o_ADC_Data <= r_Input_Data_Buffer( 13 downto 2 ) ;
		r_Input_Data_Buffer(18 - r_Bit_Counter) <= i_MISO ;		
					
			end if ;
		end if ;
	end Process ;
	
	o_SCLK <= r_SCLK ;
	o_CS <= r_CS ;
	
end Behavioral;
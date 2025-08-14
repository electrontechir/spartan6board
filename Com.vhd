library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity COM is
    Port ( in_CLK : in  STD_LOGIC;			  
			  -- DACs
			  DAC_1 : out STD_LOGIC_VECTOR (7 downto 0);
			  DAC_2 : out STD_LOGIC_VECTOR (7 downto 0);
			  -- LEDs
			  led_1 : out  STD_LOGIC;
			  led_2 : out  STD_LOGIC;
			  led_3 : out  STD_LOGIC;
			  led_4 : out  STD_LOGIC;
			  -- Switches
			  switch_1 : in  STD_LOGIC;
			  switch_2 : in  STD_LOGIC;
			  switch_3 : in  STD_LOGIC;
			  -- ADC
           CS_ADC1 : out STD_LOGIC;
			  MISO_ADC1 : in  STD_LOGIC;
           CLK_ADC1 : out STD_LOGIC;
           CS_ADC2 : out STD_LOGIC;
			  MISO_ADC2 : in  STD_LOGIC;
           CLK_ADC2 : out STD_LOGIC;
			  -- 7 SEGMENT
			  o_Display : out STD_LOGIC_VECTOR (2 downto 0);
			  o_Segment : out STD_LOGIC_VECTOR (7 downto 0);
			  -- GPIO Right
			  pin118 : inout  STD_LOGIC;
			  pin119 : inout  STD_LOGIC;
			  pin116 : inout  STD_LOGIC;
			  pin117 : inout  STD_LOGIC;
			  pin114 : inout  STD_LOGIC;
			  pin115 : inout  STD_LOGIC;
			  pin111 : inout  STD_LOGIC;
			  pin112 : inout  STD_LOGIC;
			  pin97 : inout  STD_LOGIC;
			  pin98 : inout  STD_LOGIC;
			  pin94 : inout  STD_LOGIC;
			  pin95 : inout  STD_LOGIC;
			  pin92 : inout  STD_LOGIC;
			  pin93 : inout  STD_LOGIC;
			  pin87 : inout  STD_LOGIC;
			  pin88 : inout  STD_LOGIC;
			  pin84 : inout  STD_LOGIC;
			  pin85 : inout  STD_LOGIC;
			  pin82 : inout  STD_LOGIC;
			  pin83 : inout  STD_LOGIC;
			  pin80 : inout  STD_LOGIC;
			  pin81 : inout  STD_LOGIC;
 			  -- GPIO Left
			  pin14 : inout  STD_LOGIC;
			  pin12 : inout  STD_LOGIC;
			  pin16 : inout  STD_LOGIC;
			  pin15 : inout  STD_LOGIC;
			  pin21 : inout  STD_LOGIC;
			  pin17 : inout  STD_LOGIC;
			  pin23 : inout  STD_LOGIC;
			  pin22 : inout  STD_LOGIC;
			  pin26 : inout  STD_LOGIC;
			  pin24 : inout  STD_LOGIC;
			  pin29 : inout  STD_LOGIC;
			  pin27 : inout  STD_LOGIC;
			  pin32 : inout  STD_LOGIC;
			  pin30 : inout  STD_LOGIC;
			  pin34 : inout  STD_LOGIC;
			  pin33 : inout  STD_LOGIC;
			  pin40 : inout  STD_LOGIC;
			  pin35 : inout  STD_LOGIC;
			  pin43 : inout  STD_LOGIC;
			  pin41 : inout  STD_LOGIC;
			  pin45 : inout  STD_LOGIC;
			  pin44 : inout  STD_LOGIC);

end COM;
architecture Behavioral of COM is
	
	-- CLK
	signal s_clk5 : STD_LOGIC ;
	signal s_clk10 : STD_LOGIC ;
	signal s_clk50 : STD_LOGIC ;
	signal s_clk300 : STD_LOGIC ;
	--DAC
	signal sine1 : STD_LOGIC_VECTOR (7 downto 0) ;
	signal sine2 : STD_LOGIC_VECTOR (7 downto 0) ;
	--ADC
	signal ADC_1 : STD_LOGIC_VECTOR (11 downto 0) ;
	signal ADC_2 : STD_LOGIC_VECTOR (11 downto 0) ;

begin

	clk : entity work.clk
	  port map (
		 clk_in1 => in_clk,
		 clk10 => s_clk10,
		 clk5 => s_clk5,
		 clk300 => s_clk300,
		 clk50 => s_clk50);  


	Seven_Segment_Driver: entity work.Seven_Segment_Driver 
			Generic MAP ( 
				g_Clock_Frequency => 50_000_000,
				g_Digits_Number => 3)
			PORT MAP (
				i_CLK => s_clk50,
				i_Number => x"abc",
				o_Display => o_Display,
				o_Segment => o_Segment);

	ADC1: entity work.ADC
		PORT MAP (
			i_CLK => s_clk5,
			i_RST => '0',
			o_SCLK => CLK_ADC1,
			o_CS => CS_ADC1,
			o_ADC_Data => ADC_1 ,
			i_MISO => MISO_ADC1);
		
		DAC_1 <= ADC_1(11 DOWNTO 4);
		DAC_2 <= ADC_1(11 DOWNTO 4);

--	dds1 : entity work.dds1
--	  port map (
--		 clk => s_clk50,
--		 sine => sine1); 
--
--	dds2 : entity work.dds2
--	  port map (
--		 clk => s_clk50,
--		 sine => sine2);
--
--	offset_adder1 : entity work.offset_adder
--	  port map (
--		 A => sine1,
--		 S => DAC_1);
--		 
--	offset_adder2 : entity work.offset_adder
--	  port map (
--		 A => sine2,
--		 S => DAC_2);

end Behavioral;
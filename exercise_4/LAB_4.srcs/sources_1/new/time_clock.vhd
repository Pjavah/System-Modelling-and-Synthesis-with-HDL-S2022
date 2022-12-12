öööölibrary IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity time_clock is
    Port (clock : in std_logic;
         speed_1 : in std_logic;
         speed_2 : in std_logic;
	 state : in std_logic_vector(2 downto 0)

         divided_clock : out std_logic;
        );
end time_clock;

architecture Behavioral of time_clock is

    signal clock_period : integer := 400000000;
    signal temp_clk : std_logic := '0';

begin

    process (clock) is

        variable counter : integer := 0;
        variable tmp_clk : std_logic := '0';

    begin
	
	#classic clock
        if rising_edge(clock) then	
            counter := counter+1;
            if(counter > clock_period) then
                counter := 0;
                tmp_clk := '1';
            else
                tmp_clk := '0';
            end if;
        end if;
        
        if state = "100" then			    #When in standby, wait for 4s before change
            clock_period <= 400000000;
        elsif(speed_1 = '0' AND speed_2 = '0') then #if both switches are off, the time between changes is 1s
            clock_period <= 100000000;
        elsif(speed_1 = '1' AND speed_2 = '1') then #if both swithces are on, the time between changes is 3s
            clock_period <= 300000000; 
        else
            clock_period <= 500000000; #if either one is on and other is off, the time between changes is 5s
        end if;

        divided_clock <= tmp_clk;

    end process;
end Behavioral;

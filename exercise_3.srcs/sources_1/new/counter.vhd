library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use IEEE.numeric_std.all;

entity counter is
    Port (
        -- Inputs
        clk : in std_logic;
        enable : in std_logic;
        reset : in std_logic;
        load : in std_logic;
        down_up : in std_logic;
        data : in std_logic_vector(7 downto 0);

        -- Outputs
        count : out std_logic_vector(7 downto 0);
        -- for debugging, only one 8bit counter is used. 
       -- count2 : out std_logic_vector(3 downto 0);
        over : out std_logic
    );
end counter;

architecture Behavioral of Counter is

begin

    process(enable, reset, down_up, load, clk) is
        -- variable count for counting
        variable count_var : std_logic_vector(7 downto 0) := "00000000";
        -- variable count2 for counting 
       -- variable count2_var : std_logic_vector(3 downto 0) := "0000";
        -- variable over for overflow information
        variable over_var : std_logic := '0';


    begin

        count <= count_var;
        --count2 <= count2_var;
        over <= over_var;

        -- when resetting, both count and over return to zero
        if(reset = '1') then
            count_var := "00000000";
            over_var := '0';

        -- when enabled the counter will work
        elsif enable = '1' and rising_edge(clk) then
            if(down_up = '0') then -- add if 0
                if(count_var = "11111111") then
                    -- if overflowing, reset to 0. Over_var to 1. Add 1 to count2.
--                    if(count2_var = "1111") then
--                        count2_var := "0000";  -- commented out for debugging 
--                        over_var := '1';
--                    else
--                        count2_var := count2_var + 1;
--                    end if;
                    count_var := "00000000";
                else -- if not overflowing continue addition
                    count_var := count_var + 1;
                end if;
            elsif(down_up = '1') then -- substract if 1
                if(count_var = "00000000") then
                    -- if underflowing, reset to 15. Over_var to 1. Subtract from count2.
--                    if(count2_var = "0000") then
--                        count2_var :="1111";  -- commented out for debugging
--                        over_var := '1';
--                    else    
--                        count2_var := count2_var - 1;
--                    end if;
                    count_var := "11111111";
                else -- if not overflowing continue subtracting.
                    count_var := count_var - 1;
                end if;
            end if;

            if(load = '1') then -- loading the data from input
                count_var := data(7 downto 0); --debug
                --count2_var := data(7 downto 4);
            end if;
        end if;
    end process;
end Behavioral;

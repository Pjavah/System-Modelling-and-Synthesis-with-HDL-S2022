library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity pwm is port(
    clk : in std_logic;
    enable : in std_logic;
    width : in std_logic_vector(7 downto 0);
    led : out std_logic 
    );
end pwm;

architecture Behavioral of pwm is

begin

    process(width, clk) is 
        variable count_var : std_logic_vector(7 downto 0) := "00000000";
        variable period : std_logic_vector(7 downto 0) := "11111111";
        
    begin
    
        if rising_edge(clk) then
            if(count_var < width) then
                led <= '1';
            else    
                led <= '0';
            end if;
            if count_var < period then  
                count_var := count_var + 1;
            else count_var := "00000000";
            end if;
        end if;  
    end process;
end Behavioral;

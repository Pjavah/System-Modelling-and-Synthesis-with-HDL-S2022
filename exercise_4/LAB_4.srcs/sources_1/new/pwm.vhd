library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity pwm is Port(

        clock : in std_logic;
        width1 : in  std_logic_vector(7 downto 0);
        width2 : in  std_logic_vector(7 downto 0);
        width3 : in  std_logic_vector(7 downto 0);

        led1 : out std_logic;
        led2 : out std_logic;
        led3 : out std_logic
    );
end pwm;

architecture Behavioral of pwm is

begin

    process(width1, width2, width3, clock) is

        variable count_var : std_logic_vector(7 downto 0) := "00000000";
        variable period : std_logic_vector(7 downto 0) := "11111111";

    begin

        if rising_edge(clock) then
            if(count_var < width1) then
                led1 <= '1';
            else
                led1 <= '0';
            end if;
            if(count_var < width2) then
                led2 <= '1';
            else
                led2 <= '0';
            end if;
            if(count_var < width3) then
                led3 <= '1';
            else
                led3 <= '0';
            end if;
            if count_var < period then
                count_var := count_var + 1;
            else count_var := "00000000";
            end if;
        end if;
    end process;
end Behavioral;
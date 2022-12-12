library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.ALL;


entity counter_test is
    --  Port ( );
end counter_test;

architecture Behavioral of counter_test is

    component controller port(
            clock : in std_logic;
            direction : in std_logic;

            state : out std_logic_vector(2 downto 0);

            LED1 : out std_logic_vector(7 downto 0);
            LED2 : out std_logic_vector(7 downto 0);
            LED3 : out std_logic_vector(7 downto 0)
        );
    end component;

    signal test_clock : std_logic := '0' ;
    signal test_direction : std_logic := '0';

    signal test_state : std_logic_vector(2 downto 0) := "000";

    signal test_led1 : std_logic_vector(7 downto 0) := "00000000";
    signal test_led2 : std_logic_vector(7 downto 0) := "00000000";
    signal test_led3 : std_logic_vector(7 downto 0) := "00000000";

begin

   DUT: controller port map(
        clock => test_clock, 
        direction => test_direction, 
        state => test_state,
        led1 => test_led1,
        led2 => test_led2,
        led3 => test_led3
    );

    process
    begin
        test_clock <= '1';
        wait for 10ns;
        test_clock <= '0';
        wait for 10ns;
    end process;
    
    process
    begin
        test_direction <= '1';
        wait for 500ns;
        test_direction <= '0';
        wait for 500ns;
    end process;

end Behavioral;

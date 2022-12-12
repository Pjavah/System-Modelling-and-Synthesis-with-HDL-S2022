library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity controller is Port (
	# Inputs
        clock : in std_logic;
        direction : in std_logic;
        reset : in std_logic;

	#Outputs
        state : out std_logic_vector(2 downto 0);
        LED1 : out std_logic_vector(7 downto 0);
        LED2 : out std_logic_vector(7 downto 0);
        LED3 : out std_logic_vector(7 downto 0)
    );
end controller;

architecture Behavioral of controller is

    type state_array is array (0 to 1, 0 to 7) of integer;
    type led_array is array (0 to 7, 0 to 2) of integer;
    type led_state is array (0 to 2) of integer;

    signal states : state_array := (
        (0, 6, 3, 7, 1, 4, 2, 1), #if direction 0 use this (logic goes index to value, i.e. ind1 to val6 (1->6), ind2 to val3 (2->3), ind3 to val7 (3->7) etc.) 
        (0, 7, 6, 2, 1, 4, 7, 3)  #if direction 1 use this (logic goes index to value)
    );				  


	#leds on/off/half on in an array of arrays.
    signal leds : led_array := (
        (0, 0, 0),
        (255, 0, 0),
        (0, 255, 0),
        (0, 0, 255),
        (255, 255, 255),
        (0, 0, 0),
        (255, 255, 0),
        (128, 0, 128)
    );

begin

    process(clock, direction)
        variable current_state : integer := 5;
        variable direction_int : integer := 0;
        variable led_var : led_state := (0,0,0);

    begin        
        if rising_edge(clock) then
            if direction = '1' then direction_int := 1;
            else direction_int := 0;
            end if;
            if reset = '1' then
                current_state := 4;
                else
                current_state := states(direction_int, current_state);
            end if;
            LED1 <= std_logic_vector(to_unsigned(leds(current_state, 0), LED1'length));
            LED2 <= std_logic_vector(to_unsigned(leds(current_state, 1), LED2'length));
            LED3 <= std_logic_vector(to_unsigned(leds(current_state, 2), LED3'length));
            state <= std_logic_vector(to_unsigned(current_state, state'length));

        end if;
    end process;

end Behavioral;

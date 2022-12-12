library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

entity top is
    -- opening ports for switches 
    Port (SW0 :in std_logic;
         SW1 :in std_logic;
         SW2 :in std_logic;
         SW3 :in std_logic;
         SW4 :in std_logic;
         SW5 :in std_logic;
         SW6 :in std_logic;
         SW7 :in std_logic;

         -- system clock
         GCLK :in std_logic;

         --leds
         LD0 : out std_logic;
         LD1 : out std_logic;
         LD2 : out std_logic;
         LD3 : out std_logic;
         LD4 : out std_logic;
         LD5 : out std_logic;
         LD7 : out std_logic);

end top;

architecture Behavioral of top is

    -- assigning a virtual clock signal
    signal virtual_clock : std_logic;

    -- making a virtual counter and virtual enable for pwm
    signal virtual_count : std_logic_vector(7 downto 0);
    signal virtual_enable : std_logic;

    --declaring component counter
    component counter is
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
            -- count2 : out std_logic_vector(3 downto 0);
            over : out std_logic
        );
    end component counter;

    -- new component for pwm which has an output for the LED
    component pwm is port (
            clock : in std_logic;
            width : in std_logic_vector(3 downto 0);
            led : out std_logic);

    end component pwm;

begin



    process(GCLK) is
        -- assigning a counter variable to be 0 at first
        variable counter : integer := 0;
    begin
        -- rising counters number by each time system clock hits 1
        if rising_edge (GCLK ) then
            counter := counter + 1;

            -- virtual clock is "1" for x amount of time after which it switches to "0".
            if counter > 15000000 then
                virtual_clock <= '1';
                counter := 0;
            else
                virtual_clock <= '0';
            end if;
        end if;
    end process;


    -- instanciating
    counter_connections:
 Entity work.counter(Behavioral)
        Port map(
            clk => virtual_clock,
            count  =>virtual_count,
            --count2  =>virtual_count(7 downto 4),
            -- data 0-7 are switches 0 to 3 for doubling the input
            data(0) => SW0,
            data(1) => SW1,
            data(2) => SW2,
            data(3) => SW3,
            data(4) => SW0,
            data(5) => SW1,
            data(6) => SW2,
            data(7) => SW3,
            -- enable is switch no4.
            enable => SW4,
            -- down_up switch is the 5th one
            down_up => SW5,
            -- load is assigned to switch 6
            load => SW6,
            -- reset is the 7th switch
            reset => SW7,
            -- overflow is the LED number 4
            over =>LD4
        );

    LD0 <= virtual_count(0);
    LD1 <= virtual_count(1);
    LD2 <= virtual_count(2);

    LD7 <= GCLK;

    pwm_connections:
 Entity work.pwm(Behavioral)
        Port map(
            -- enable is switch no4.
            enable=> SW4,
            clk => GCLK,
            width =>virtual_count,
            -- pwm output led is led number 5
            led => LD5
        );

end Behavioral;

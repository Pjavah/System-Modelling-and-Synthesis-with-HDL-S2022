library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



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
         LD4 : out std_logic);

end top;

architecture Behavioral of top is

    -- assigning a virtual clock signal
    signal virtual_clock : std_logic;
    
    --declaring component counter
    component counter is
        Port (
            -- Inputs
            clk : in std_logic;
            enable : in std_logic;
            reset : in std_logic;
            load : in std_logic;
            down_up : in std_logic;
            data : in std_logic_vector(3 downto 0);

            -- Outputs
            count : out std_logic_vector(3 downto 0);
            over : out std_logic
        );
    end component counter;
begin

   
    process(GCLK) is
        -- assigning a counter variable to be 0 at first
        variable counter : integer := 0;
    begin
        -- rising counters number by each time system clock hits 1
        if rising_edge (GCLK ) then
            counter := +1;
            
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
            -- data is switches 1, 2, 3 and 4
            data(0) => SW0,
            data(1) => SW1,
            data(2) => SW2,
            data(3) => SW3,
            -- enabled is switch 5
            enable => SW4,
            -- down up is switch 6
            down_up => SW5,
            -- load is switch 7
            load => SW6,
            -- reset is switch 8
            reset => SW7,
            -- count values are leds 0 to 4
            count(0) => LD0,
            count(1) => LD1,
            count(2) => LD2,
            count(3) => LD3,
            -- overflow is led 5
            over => LD4
        );

end Behavioral;

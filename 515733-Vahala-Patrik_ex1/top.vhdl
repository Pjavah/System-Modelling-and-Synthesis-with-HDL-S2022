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

        --leds
        LD0 : out std_logic;
        LD1 : out std_logic);
end top;

architecture Behavioral of top is
    --declaring component tally
    component tally is
        Port ( scoresA, scoresB : in std_logic_vector(2 downto 0);
           winner : out std_logic_vector(1 downto 0)
           );
    end component tally;
begin
    -- instanciating the work.tally
    tally_connections:
    Entity work.tally(loopy)
    Port map(
        -- indexes of a correspond to leds 1, 2 and 3
        scoresA(0) => SW0,
        scoresA(1) => SW1,
        scoresA(2) => SW2,
        -- indexes of b correspond to leds 3, 4, 5
        scoresB(0) => SW3,
        scoresB(1) => SW4,
        scoresB(2) => SW5,
        -- winners are leds 0 for b and 1 for a
        winner(0) => LD0,
        winner(1) => LD1
        );
    
end Behavioral;

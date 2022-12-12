library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use IEEE.numeric_std.all;


entity counter_test is
    --  Port ( );
end counter_test;

architecture Behavioral of counter_test is
    component counter
        Port (
            -- Inputs
            clk : in std_logic;
            enable : in std_logic;
            reset : in std_logic;
            load : in std_logic;
            down_up : in std_logic;
            data : in std_logic_vector(3 downto 0);

            -- Outputs
            count : inout std_logic_vector(3 downto 0);
            over : out std_logic
        );
    end component;

    -- declaring the signals and their values
    signal test_clk : std_logic := '0';
    signal test_enable : std_logic := '0';
    signal test_reset : std_logic := '0';
    signal test_load : std_logic := '0';
    signal test_down_up : std_logic := '0';
    signal test_data : std_logic_vector(3 downto 0) := "0000";

    signal test_count : std_logic_vector(3 downto 0) := "0000";
    signal test_over : std_logic := '0';

begin
    DUT: counter port map (clk => test_clk, enable => test_enable, reset => test_reset, load => test_load, down_up => test_down_up, data => test_data, count => test_count, over => test_over);
    process
-- test clock:
--        begin
--            test_clk <=  '0';
--            test_data <= std_logic_vector(unsigned(test_data) + 1);
--            wait for 10ns;
--            test_clk <=  '1';
--            wait for 10ns;
--        end process;
    
--        process
        begin
            test_enable <= '1';
    
            wait for 200ns;
            test_reset <= '0';
            test_enable <= '1';
            test_down_up <= '1';
        
            wait for 200ns;
            test_reset <= '0';
            test_enable <= '0';
            test_down_up <= '0';
        
            wait for 200ns;
            test_reset <= '1';
            test_enable <= '0';

    end process;
end Behavioral;

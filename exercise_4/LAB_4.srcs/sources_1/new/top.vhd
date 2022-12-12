library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port (SW0 :in std_logic;
         SW1 :in std_logic;
         SW2 :in std_logic;
         SW3 :in std_logic;

         GCLK : in std_logic;

         LD0 : out std_logic;
         LD1 : out std_logic;
         LD2 : out std_logic
        );
end top;

architecture Behavioral of top is

    signal virtual_clock : std_logic;
    signal virtual_state : std_logic_vector(2 downto 0);
    signal virtual_led1 : std_logic_vector(7 downto 0);
    signal virtual_led2 : std_logic_vector(7 downto 0);
    signal virtual_led3 : std_logic_vector(7 downto 0);

    component controller is
        Port (
            clock : in std_logic;
            direction : in std_logic;
            reset : in std_logic;

            state : out std_logic_vector(2 downto 0);
            led1 : out std_logic_vector(7 downto 0);
            led2 : out std_logic_vector(7 downto 0);
            led3 : out std_logic_vector(7 downto 0)
        );

    end component controller;

    component time_clock is
        Port (GCLK : in std_logic;
             speed_1 : in std_logic;
             speed_2 : in std_logic;
	     state : in std_logic_vector(2 downto 0)

             divided_clock : out std_logic;
            );

    end component time_clock;

    component pwm is
        Port (
            clock : in std_logic;
            width : in std_logic_vector(3 downto 0);
            led : out std_logic);

    end component pwm;

begin


    controller_connections:
 entity work.controller(Behavioral)
        Port map(
            clock => virtual_clock,
            state => virtual_state,

            reset => SW3,
            direction => SW0,

            led1  => virtual_led1,
            led2  => virtual_led2,
            led3  => virtual_led3
        );

    pwm_connections:
 entity work.pwm(Behavioral)
        Port map(
            clock => GCLK,

            width1 =>virtual_led1,
            width2 =>virtual_led2,
            width3 =>virtual_led3,

            led1 => LD0,
            led2 => LD1,
            led3 => LD2
        );


    time_clock_connections:
 entity work.time_clock(Behavioral)
        Port map(
            clock => GCLK,

            speed_1 =>SW1,
            speed_2 =>SW2,

            divided_clock =>virtual_clock,
            state => virtual_state
        );

end Behavioral;
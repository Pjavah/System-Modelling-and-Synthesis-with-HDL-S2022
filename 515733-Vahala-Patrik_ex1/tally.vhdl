library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tally is
    Port ( scoresA, scoresB : in std_logic_vector(2 downto 0);
           winner : out std_logic_vector(1 downto 0)
           );
end tally;

architecture loopy of tally is
begin
    process(scoresA, scoresB)
        variable vote_a: integer range 0 to 3;
        variable vote_b: integer range 0 to 3;
    begin
    vote_a := 0;
    vote_b := 0;
    
        --looping through positions 0 to 2 in an "array"
        -- array = [0,0,0] position 0, position 1 and position 2
        -- array2 = [0,0,0]
        for i in integer range 0 to 2 loop
            --if i is 1, add a point to a
            if scoresA(i) = '1' then 
                vote_a := vote_a + 1;
            end if;
            --if i is 1, add a point to b
            if scoresB(i)= '1' then 
                vote_b := vote_b + 1;
            end if;
            
        end loop;
            
            
        --if a has more points than b, a wins
        if vote_a > vote_b then
            winner <= "10"; --corresponds to a winning

        --if b has more points than a, b wins
        elsif vote_b > vote_a then
            winner <= "01"; --corresponds to b winning

        --if either is bigger than 0, both have equal points.
        elsif vote_a = vote_b then
            if vote_a = 0 then
                winner <= "00";
            else winner <= "11";
            end if;
        end if;
        
    end process;  
end loopy;


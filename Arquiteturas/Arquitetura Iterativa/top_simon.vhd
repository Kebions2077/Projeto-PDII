
library ieee;
use ieee.std_logic_1164.all;

entity top_simon is
    port (
        clk   : in  std_logic;
        reset : in  std_logic;
        start : in  std_logic;
        plaintext  : in  std_logic_vector(63 downto 0);
        master_key : in  std_logic_vector(127 downto 0);
        ciphertext : out std_logic_vector(63 downto 0);
        busy, done  : out std_logic
    );
end entity top_simon;

architecture rtl of top_simon is

begin

    SIMON_CORE : entity work.simon_iterative
        port map (
            clk        => clk,
            reset      => reset,
            start      => start,
            plaintext  => plaintext,
            master_key => master_key,
            ciphertext => ciphertext,
            busy       => busy,
            done       => done
        );

end architecture rtl;


library ieee;
use ieee.std_logic_1164.all;

entity top_simon_unrolled is
    port (
        clk   : in  std_logic;
        reset : in  std_logic;
        start : in  std_logic;
        busy  : out std_logic;
        done  : out std_logic
    );
end entity top_simon_unrolled;

architecture rtl of top_simon_unrolled is

    constant TEST_KEY : std_logic_vector(127 downto 0) :=
        x"1B1A1918131211100B0A090803020100";

    constant TEST_PLAINTEXT : std_logic_vector(63 downto 0) :=
        x"656B696C20646E75";

    signal resultado : std_logic_vector(63 downto 0);

begin

    CORE : entity work.simon_unrolled(rtl)
        port map (
            clk        => clk,
            reset      => reset,
            start      => start,
            plaintext  => TEST_PLAINTEXT,
            master_key => TEST_KEY,
            ciphertext => resultado,
            busy       => busy,
            done       => done
        );

end architecture rtl;

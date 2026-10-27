
library ieee;
use ieee.std_logic_1164.all;

entity top_simon_pipeline is
    port (
        clk   : in  std_logic;
        reset : in  std_logic;
        start : in  std_logic;
        done  : out std_logic
    );
end entity;

architecture rtl of top_simon_pipeline is

    constant PLAINTEXT_TESTE : std_logic_vector(63 downto 0) :=
        x"656B696C20646E75";

    constant CHAVE_TESTE : std_logic_vector(127 downto 0) :=
        x"1B1A1918131211100B0A090803020100";

    signal ciphertext_interno : std_logic_vector(63 downto 0);

begin

    u_pipeline : entity work.simon_pipeline
        port map (
            clk        => clk,
            reset      => reset,
            start      => start,
            plaintext  => PLAINTEXT_TESTE,
            master_key => CHAVE_TESTE,
            ciphertext => ciphertext_interno,
            done       => done
        );

end architecture;

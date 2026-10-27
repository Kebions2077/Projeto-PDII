
library ieee;
use ieee.std_logic_1164.all;

entity tb_simon_fully_unrolled is
end entity tb_simon_fully_unrolled;

architecture simulacao of tb_simon_fully_unrolled is

    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal start : std_logic := '0';

    signal plaintext : std_logic_vector(63 downto 0) :=
        x"656B696C20646E75";

    signal master_key : std_logic_vector(127 downto 0) :=
        x"1B1A1918131211100B0A090803020100";

    signal ciphertext : std_logic_vector(63 downto 0);
    signal busy : std_logic;
    signal done : std_logic;

    constant EXPECTED : std_logic_vector(63 downto 0) :=
        x"44C8FC20B9DFA07A";

begin

    clk <= not clk after 5 ns;

    DUT : entity work.simon_fully_unrolled(rtl)
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

    process
    begin

        reset <= '1';
        wait for 20 ns;

        wait until falling_edge(clk);
        reset <= '0';

        wait until falling_edge(clk);
        start <= '1';

        wait until falling_edge(clk);
        start <= '0';

        wait until done = '1';
        wait for 1 ns;

        assert ciphertext = EXPECTED
            report "ERRO: ciphertext diferente do esperado!"
            severity failure;

        report "SUCESSO: SIMON-64/128 totalmente desenrolado validado."
            severity note;

        wait;

    end process;

end architecture simulacao;

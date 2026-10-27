
library ieee;
use ieee.std_logic_1164.all;

entity tb_simon_iterative is
end entity tb_simon_iterative;

architecture simulacao of tb_simon_iterative is

    signal clk        : std_logic := '0';
    signal reset      : std_logic := '1';
    signal start      : std_logic := '0';
    signal plaintext  : std_logic_vector(63 downto 0) :=
        x"656B696C20646E75";
    signal master_key : std_logic_vector(127 downto 0) :=
        x"1B1A1918131211100B0A090803020100";
    signal ciphertext : std_logic_vector(63 downto 0);
    signal busy       : std_logic;
    signal done       : std_logic;
    signal finished   : std_logic := '0';

    constant ESPERADO : std_logic_vector(63 downto 0) :=
        x"44C8FC20B9DFA07A";

begin

    DUT : entity work.simon_iterative
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

    CLOCK_PROCESS : process
    begin
        while finished = '0' loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;

    STIMULUS : process
    begin
        wait for 20 ns;
        wait until rising_edge(clk);
        reset <= '0';

        wait until rising_edge(clk);
        start <= '1';

        wait until rising_edge(clk);
        start <= '0';

        wait until done = '1';
        wait for 1 ns;

        if ciphertext = ESPERADO then
            report "SUCESSO: SIMON-64/128 validado."
                severity note;
        else
            report "FALHA: resultado cifrado diferente do esperado."
                severity error;
        end if;

        finished <= '1';
        wait;
    end process;

end architecture simulacao;

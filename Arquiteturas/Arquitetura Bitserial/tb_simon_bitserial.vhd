
library ieee;
use ieee.std_logic_1164.all;

entity tb_simon_bitserial is
end entity;

architecture simulacao of tb_simon_bitserial is
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
begin
    clk <= not clk after 10 ns;

    dut : entity work.simon_bitserial
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
        start <= '0';
        wait for 40 ns;

        wait until falling_edge(clk);
        reset <= '0';

        wait until falling_edge(clk);
        start <= '1';

        wait until falling_edge(clk);
        start <= '0';

        wait until done = '1';
        wait for 1 ns;

        assert ciphertext = x"44C8FC20B9DFA07A"
            report "ERRO: resultado diferente do esperado."
            severity error;

        if ciphertext = x"44C8FC20B9DFA07A" then
            report "SUCESSO: SIMON validado."
                severity note;
        end if;

        wait;
    end process;
end architecture;

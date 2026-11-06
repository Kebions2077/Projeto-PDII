library ieee;
use ieee.std_logic_1164.all;

entity tb_simon_bitserial is
end entity tb_simon_bitserial;

architecture test of tb_simon_bitserial is

    constant CLK_PERIOD : time := 20 ns;

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

    clk <= not clk after CLK_PERIOD / 2;

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

    stimulus : process
    begin

        reset <= '1';
        start <= '0';

        wait for 3 * CLK_PERIOD;
        wait until falling_edge(clk);
        reset <= '0';

        wait until falling_edge(clk);
        start <= '1';

        wait until falling_edge(clk);
        start <= '0';

        wait until done = '1';
        wait for 1 ns;

        assert ciphertext = x"44C8FC20B9DFA07A"
            report "FALHA: ciphertext incorreto."
            severity failure;

        assert busy = '0'
            report "FALHA: busy deveria estar em zero ao terminar."
            severity failure;

        report "APROVADO: SIMON-64/128 bit-serial." severity note;

        wait until rising_edge(clk);
        wait for 1 ns;

        assert done = '0'
            report "FALHA: done deveria durar apenas um ciclo."
            severity failure;

        report "TESTE CONCLUIDO." severity note;
        wait;
    end process;
   
    timeout : process
      begin
      wait until done = '1' for 40000 * CLK_PERIOD;

            assert done = '1'
        report "TIMEOUT: a cifragem nao terminou."
        severity failure;

    wait;
    end process;

end architecture test;


-- =========================================================
-- Projeto: SIMON-64/128 em FPGA
-- Arquivo: tb_simon_round.vhd
--
-- Objetivo:
-- Testar uma rodada do algoritmo SIMON e verificar se as
-- saídas correspondem aos valores calculados previamente.
-- Este arquivo é utilizado apenas para simulacao.
-- =========================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_simon_round is
end tb_simon_round;

architecture Teste of tb_simon_round is

    -- Sinais utilizados para conectar o testbench ao circuito.
    signal x_in  : STD_LOGIC_VECTOR(31 downto 0);
    signal y_in  : STD_LOGIC_VECTOR(31 downto 0);
    signal k_in  : STD_LOGIC_VECTOR(31 downto 0);
    signal x_out : STD_LOGIC_VECTOR(31 downto 0);
    signal y_out : STD_LOGIC_VECTOR(31 downto 0);

begin

    -- Instancia o módulo que será testado.
    DUT: entity work.simon_round
        port map (
            x_in  => x_in,
            y_in  => y_in,
            k_in  => k_in,
            x_out => x_out,
            y_out => y_out
        );

    -- Processo responsável por aplicar os valores de teste.
    estimulos: process
    begin

        -- Aplica o bloco de entrada e a primeira subchave.
        x_in <= x"656B696C";
        y_in <= x"20646E75";
        k_in <= x"03020100";

        -- Aguarda a propagação dos sinais combinacionais.
        wait for 10 ns;

        -- Verifica a nova palavra X.
        assert x_out = x"FC8B8A84"
            report "ERRO: valor de X incorreto!"
            severity error;

        -- Verifica a nova palavra Y.
        assert y_out = x"656B696C"
            report "ERRO: valor de Y incorreto!"
            severity error;

        report "TESTE DA RODADA CONCLUIDO!"
            severity note;

        wait;
    end process;

end Teste;

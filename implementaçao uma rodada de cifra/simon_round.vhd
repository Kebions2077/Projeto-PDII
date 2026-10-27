
-- =========================================================
-- Projeto: SIMON-64/128 em FPGA
-- Arquivo: simon_round.vhd
--
-- Objetivo:
-- Implementar uma rodada do algoritmo de criptografia SIMON.
-- Cada rodada recebe duas palavras de 32 bits (X e Y) e uma
-- subchave de 32 bits, produzindo os novos valores de X e Y.
-- =========================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Define as entradas e saídas do módulo de uma rodada.
entity simon_round is
    Port (
        x_in  : in  STD_LOGIC_VECTOR(31 downto 0); -- Palavra X de entrada
        y_in  : in  STD_LOGIC_VECTOR(31 downto 0); -- Palavra Y de entrada
        k_in  : in  STD_LOGIC_VECTOR(31 downto 0); -- Subchave da rodada
        x_out : out STD_LOGIC_VECTOR(31 downto 0); -- Nova palavra X
        y_out : out STD_LOGIC_VECTOR(31 downto 0)  -- Nova palavra Y
    );
end simon_round;

architecture Behavioral of simon_round is

    -- Realiza a rotação circular à esquerda de uma palavra
    -- de 32 bits pelo número de posições indicado em n.
    function rotl32(
        x : STD_LOGIC_VECTOR(31 downto 0);
        n : natural
    ) return STD_LOGIC_VECTOR is
    begin
        return std_logic_vector(
            rotate_left(unsigned(x), n)
        );
    end function;

    -- Implementa a função F do algoritmo SIMON:
    -- F(X) = (ROTL(X, 1) AND ROTL(X, 8)) XOR ROTL(X, 2).
    -- Essa função combina rotações, AND e XOR para produzir
    -- o valor utilizado no cálculo da nova palavra X.
    function simon_f(
        x : STD_LOGIC_VECTOR(31 downto 0)
    ) return STD_LOGIC_VECTOR is
    begin
        return (rotl32(x, 1) and rotl32(x, 8))
               xor rotl32(x, 2);
    end function;

begin

    -- Calcula a nova palavra X usando a palavra Y anterior,
    -- a função F aplicada ao X anterior e a subchave:
    -- X' = Y XOR F(X) XOR K.
    x_out <= y_in xor simon_f(x_in) xor k_in;

    -- A nova palavra Y recebe o valor anterior de X:
    -- Y' = X.
    y_out <= x_in;

end Behavioral;

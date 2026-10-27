
library ieee;
use ieee.std_logic_1164.all;

entity simon_44rounds is
    port (
        x_in       : in  std_logic_vector(31 downto 0);
        y_in       : in  std_logic_vector(31 downto 0);
        keys_in    : in  std_logic_vector(1407 downto 0);
        x_out      : out std_logic_vector(31 downto 0);
        y_out      : out std_logic_vector(31 downto 0)
    );
end entity simon_44rounds;

architecture structural of simon_44rounds is

    type word_array is array (0 to 44) of
        std_logic_vector(31 downto 0);

    signal x_chain : word_array;
    signal y_chain : word_array;

begin

    x_chain(0) <= x_in;
    y_chain(0) <= y_in;

    GEN_ROUNDS : for i in 0 to 43 generate

        ROUND_I : entity work.simon_round(rtl)
            port map (
                x_in  => x_chain(i),
                y_in  => y_chain(i),
                k_in  => keys_in(i * 32 + 31 downto i * 32),
                x_out => x_chain(i + 1),
                y_out => y_chain(i + 1)
            );

    end generate GEN_ROUNDS;

    x_out <= x_chain(44);
    y_out <= y_chain(44);

end architecture structural;

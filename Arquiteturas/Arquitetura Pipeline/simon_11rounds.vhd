
library ieee;
use ieee.std_logic_1164.all;

entity simon_11rounds is
    port (
        x_in  : in  std_logic_vector(31 downto 0);
        y_in  : in  std_logic_vector(31 downto 0);
        keys  : in  std_logic_vector(351 downto 0);
        x_out : out std_logic_vector(31 downto 0);
        y_out : out std_logic_vector(31 downto 0)
    );
end entity;

architecture rtl of simon_11rounds is
    type word_array is array (0 to 11) of
        std_logic_vector(31 downto 0);

    signal xs : word_array;
    signal ys : word_array;
begin
    xs(0) <= x_in;
    ys(0) <= y_in;

    gen_rounds : for i in 0 to 10 generate
        round_i : entity work.simon_round
            port map (
                x_in  => xs(i),
                y_in  => ys(i),
                k     => keys(i*32+31 downto i*32),
                x_out => xs(i+1),
                y_out => ys(i+1)
            );
    end generate;

    x_out <= xs(11);
    y_out <= ys(11);
end architecture;

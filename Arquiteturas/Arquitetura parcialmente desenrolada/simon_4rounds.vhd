
library ieee;
use ieee.std_logic_1164.all;

entity simon_4rounds is
    port (
        x_in       : in  std_logic_vector(31 downto 0);
        y_in       : in  std_logic_vector(31 downto 0);
        keys_in    : in  std_logic_vector(127 downto 0);
        x_out      : out std_logic_vector(31 downto 0);
        y_out      : out std_logic_vector(31 downto 0)
    );
end entity simon_4rounds;

architecture structural of simon_4rounds is

    signal x1, x2, x3, x4 : std_logic_vector(31 downto 0);
    signal y1, y2, y3, y4 : std_logic_vector(31 downto 0);

begin

    R0 : entity work.simon_round(rtl)
        port map (
            x_in  => x_in,
            y_in  => y_in,
            k_in  => keys_in(31 downto 0),
            x_out => x1,
            y_out => y1
        );

    R1 : entity work.simon_round(rtl)
        port map (
            x_in  => x1,
            y_in  => y1,
            k_in  => keys_in(63 downto 32),
            x_out => x2,
            y_out => y2
        );

    R2 : entity work.simon_round(rtl)
        port map (
            x_in  => x2,
            y_in  => y2,
            k_in  => keys_in(95 downto 64),
            x_out => x3,
            y_out => y3
        );

    R3 : entity work.simon_round(rtl)
        port map (
            x_in  => x3,
            y_in  => y3,
            k_in  => keys_in(127 downto 96),
            x_out => x4,
            y_out => y4
        );

    x_out <= x4;
    y_out <= y4;

end architecture structural;

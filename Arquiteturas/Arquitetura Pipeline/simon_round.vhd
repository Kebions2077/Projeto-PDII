
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity simon_round is
    port (
        x_in  : in  std_logic_vector(31 downto 0);
        y_in  : in  std_logic_vector(31 downto 0);
        k      : in  std_logic_vector(31 downto 0);
        x_out : out std_logic_vector(31 downto 0);
        y_out : out std_logic_vector(31 downto 0)
    );
end entity;

architecture rtl of simon_round is
    signal rot1 : std_logic_vector(31 downto 0);
    signal rot8 : std_logic_vector(31 downto 0);
    signal rot2 : std_logic_vector(31 downto 0);
    signal f    : std_logic_vector(31 downto 0);
begin
    rot1 <= x_in(30 downto 0) & x_in(31);
    rot8 <= x_in(23 downto 0) & x_in(31 downto 24);
    rot2 <= x_in(29 downto 0) & x_in(31 downto 30);

    f <= (rot1 and rot8) xor rot2;

    x_out <= y_in xor f xor k;
    y_out <= x_in;
end architecture;

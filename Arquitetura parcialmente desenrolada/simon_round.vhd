
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity simon_round is
    port (
        x_in  : in  std_logic_vector(31 downto 0);
        y_in  : in  std_logic_vector(31 downto 0);
        k_in  : in  std_logic_vector(31 downto 0);
        x_out : out std_logic_vector(31 downto 0);
        y_out : out std_logic_vector(31 downto 0)
    );
end entity simon_round;

architecture rtl of simon_round is

    function rotl32(
        x : std_logic_vector(31 downto 0);
        n : natural
    ) return std_logic_vector is
        variable u : unsigned(31 downto 0);
    begin
        u := unsigned(x);
        return std_logic_vector(
            shift_left(u, n) or shift_right(u, 32 - n)
        );
    end function;

    signal f_x : std_logic_vector(31 downto 0);

begin

    f_x <= (rotl32(x_in, 1) and rotl32(x_in, 8))
           xor rotl32(x_in, 2);

    x_out <= y_in xor f_x xor k_in;
    y_out <= x_in;

end architecture rtl;

library ieee;
use ieee.std_logic_1164.all;

entity simon_11rounds is
    generic (
        Z_BASE : natural := 0   
    );
    port (
        x_in    : in  std_logic_vector(31 downto 0);
        y_in    : in  std_logic_vector(31 downto 0);
        key_in  : in  std_logic_vector(127 downto 0);  
        x_out   : out std_logic_vector(31 downto 0);
        y_out   : out std_logic_vector(31 downto 0);
        key_out : out std_logic_vector(127 downto 0)   
    );
end entity;

architecture rtl of simon_11rounds is
    type word_array is array (natural range <>) of
        std_logic_vector(31 downto 0);

    signal xs, ys : word_array(0 to 11);
    signal ks     : word_array(0 to 14);

    constant SIMON_C : std_logic_vector(31 downto 0) := x"FFFFFFFC";

    constant Z3 : std_logic_vector(61 downto 0) :=
        "11011011101011000110010111100000010010001010011100110100001111";

    function zbit(idx : natural) return std_logic is
    begin
        return Z3(61 - (idx mod 62));
    end function;

    function key_next(
        ka : std_logic_vector(31 downto 0);
        kb : std_logic_vector(31 downto 0);
        kc : std_logic_vector(31 downto 0);
        z  : std_logic
    ) return std_logic_vector is
        variable u : std_logic_vector(31 downto 0);
        variable v : std_logic_vector(31 downto 0);
    begin
        u := (kc(2 downto 0) & kc(31 downto 3)) xor kb;   -- ROR3(kc) xor kb
        v := u(0) & u(31 downto 1);                        -- ROR1(u)
        u := ka xor u xor v xor SIMON_C;
        u(0) := u(0) xor z;
        return u;
    end function;
begin
    ks(0) <= key_in(31 downto 0);
    ks(1) <= key_in(63 downto 32);
    ks(2) <= key_in(95 downto 64);
    ks(3) <= key_in(127 downto 96);

    gen_keys : for j in 4 to 14 generate
        ks(j) <= key_next(ks(j - 4), ks(j - 3), ks(j - 1), zbit(Z_BASE + j - 4));
    end generate;

    xs(0) <= x_in;
    ys(0) <= y_in;

    gen_rounds : for i in 0 to 10 generate
        round_i : entity work.simon_round
            port map (
                x_in  => xs(i),
                y_in  => ys(i),
                k     => ks(i),
                x_out => xs(i + 1),
                y_out => ys(i + 1)
            );
    end generate;

    x_out   <= xs(11);
    y_out   <= ys(11);
    key_out <= ks(14) & ks(13) & ks(12) & ks(11);
end architecture;

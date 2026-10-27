
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity simon_key_schedule is
    port (
        clk         : in  std_logic;
        reset       : in  std_logic;
        start       : in  std_logic;
        master_key  : in  std_logic_vector(127 downto 0);
        round_key   : out std_logic_vector(31 downto 0);
        round_index : out unsigned(5 downto 0);
        round_valid : out std_logic;
        busy        : out std_logic;
        done        : out std_logic
    );
end entity simon_key_schedule;

architecture rtl of simon_key_schedule is

    constant C : std_logic_vector(31 downto 0) := x"FFFFFFFC";

    constant Z3 : std_logic_vector(61 downto 0) :=
        "11011011101011000110010111100000010010001010011100110100001111";

    type key_array is array (0 to 43) of
        std_logic_vector(31 downto 0);

    signal keys : key_array := (others => (others => '0'));
    signal contador : integer range 0 to 43 := 0;
    signal ativo : std_logic := '0';

    function ror32(
        x : std_logic_vector(31 downto 0);
        n : natural
    ) return std_logic_vector is
    begin
        return std_logic_vector(rotate_right(unsigned(x), n));
    end function;

    function expand_key(
        master : std_logic_vector(127 downto 0)
    ) return key_array is
        variable k    : key_array;
        variable temp : std_logic_vector(31 downto 0);
        variable zbit : std_logic_vector(31 downto 0);
    begin
        -- K0 e a palavra menos significativa.
        k(0) := master(31 downto 0);
        k(1) := master(63 downto 32);
        k(2) := master(95 downto 64);
        k(3) := master(127 downto 96);

        for i in 4 to 43 loop
            temp := ror32(k(i - 1), 3) xor k(i - 3);
            temp := temp xor ror32(temp, 1);

            zbit := (others => '0');
            zbit(0) := Z3(61 - ((i - 4) mod 62));

            k(i) := k(i - 4) xor temp xor C xor zbit;
        end loop;

        return k;
    end function;

begin

    busy <= ativo;
    round_index <= to_unsigned(contador, 6);

    process(clk, reset)
    begin
        if reset = '1' then
            keys <= (others => (others => '0'));
            contador <= 0;
            ativo <= '0';
            round_key <= (others => '0');
            round_valid <= '0';
            done <= '0';

        elsif rising_edge(clk) then
            round_valid <= '0';
            done <= '0';

            if start = '1' and ativo = '0' then
                keys <= expand_key(master_key);
                contador <= 0;
                ativo <= '1';

            elsif ativo = '1' then
                round_key <= keys(contador);
                round_valid <= '1';

                if contador = 43 then
                    ativo <= '0';
                    done <= '1';
                else
                    contador <= contador + 1;
                end if;
            end if;
        end if;
    end process;

end architecture rtl;

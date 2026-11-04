

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
    constant C  : std_logic_vector(31 downto 0) := x"FFFFFFFC";
    constant Z3 : std_logic_vector(61 downto 0) :=
        "11011011101011000110010111100000010010001010011100110100001111";
 
    signal k0, k1, k2, k3 : std_logic_vector(31 downto 0) := (others => '0');
    signal contador : integer range 0 to 43 := 0;
    signal ativo    : std_logic := '0';
 
    function ror32(x : std_logic_vector(31 downto 0); n : natural)
        return std_logic_vector is
    begin
        return std_logic_vector(rotate_right(unsigned(x), n));
    end function;
 
    -- ka = k[0], kb = k[1], kc = k[3] (como no golden model)
    function key_next(ka, kb, kc : std_logic_vector(31 downto 0); z : std_logic)
        return std_logic_vector is
        variable temp : std_logic_vector(31 downto 0);
        variable zbit : std_logic_vector(31 downto 0);
    begin
        temp := ror32(kc, 3) xor kb;
        temp := temp xor ror32(temp, 1);
        zbit := (others => '0');
        zbit(0) := z;
        return ka xor temp xor C xor zbit;
    end function;
begin
    round_key   <= k0;
    round_index <= to_unsigned(contador, 6);
    round_valid <= ativo;
    busy        <= ativo;
 
    process(clk, reset)
    begin
        if reset = '1' then
            k0 <= (others => '0'); k1 <= (others => '0');
            k2 <= (others => '0'); k3 <= (others => '0');
            contador <= 0; ativo <= '0'; done <= '0';
        elsif rising_edge(clk) then
            done <= '0';
            if start = '1' and ativo = '0' then
                k0 <= master_key(31 downto 0);
                k1 <= master_key(63 downto 32);
                k2 <= master_key(95 downto 64);
                k3 <= master_key(127 downto 96);
                contador <= 0;
                ativo <= '1';
            elsif ativo = '1' then
                k0 <= k1;
                k1 <= k2;
                k2 <= k3;
                k3 <= key_next(k0, k1, k3, Z3(61 - (contador mod 62)));
                if contador = 43 then
                    ativo <= '0';
                    done <= '1';
                    contador <= 0;
                else
                    contador <= contador + 1;
                end if;
            end if;
        end if;
    end process;
end architecture;

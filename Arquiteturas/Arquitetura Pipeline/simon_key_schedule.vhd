
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity simon_key_schedule is
    port (
        master_key : in  std_logic_vector(127 downto 0);
        round_keys : out std_logic_vector(1407 downto 0)
    );
end entity;

architecture rtl of simon_key_schedule is
    type key_array is array (0 to 43) of
        std_logic_vector(31 downto 0);

    constant Z3 : std_logic_vector(63 downto 0) :=
        x"FC2CE51207A635DB";

    signal keys : key_array;
begin
    process(master_key)
        variable ktmp : key_array;
        variable temp : std_logic_vector(31 downto 0);
        variable novo : std_logic_vector(31 downto 0);
        variable zbit : std_logic;
        variable t    : std_logic_vector(31 downto 0);
    begin
        ktmp(0) := master_key(31 downto 0);
        ktmp(1) := master_key(63 downto 32);
        ktmp(2) := master_key(95 downto 64);
        ktmp(3) := master_key(127 downto 96);

        for i in 0 to 39 loop
            temp := ktmp(i+3);
            temp := temp(2 downto 0) & temp(31 downto 3);

            novo := ktmp(i) xor temp xor ktmp(i+1);

            t := temp xor ktmp(i+1);
            t := t(0) & t(31 downto 1);

            novo := novo xor t xor x"FFFFFFFC";

            zbit := Z3(i mod 62);
            novo(0) := novo(0) xor zbit;

            ktmp(i+4) := novo;
        end loop;

        for i in 0 to 43 loop
            keys(i) <= ktmp(i);
        end loop;
    end process;

    gen_keys : for i in 0 to 43 generate
        round_keys(i*32+31 downto i*32) <= keys(i);
    end generate;
end architecture;

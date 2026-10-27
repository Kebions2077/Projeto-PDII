
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity simon_key_schedule is
    port (
        master_key : in  std_logic_vector(127 downto 0);
        round_keys : out std_logic_vector(1407 downto 0)
    );
end entity simon_key_schedule;

architecture rtl of simon_key_schedule is

    constant SIMON_C : unsigned(31 downto 0) :=
        x"FFFFFFFC";

    constant SIMON_Z3 : std_logic_vector(63 downto 0) :=
        x"FC2CE51207A635DB";

    function rotr32(
        x : unsigned(31 downto 0);
        n : natural
    ) return unsigned is
    begin
        return shift_right(x, n) or shift_left(x, 32 - n);
    end function;

begin

    process(master_key)
        variable k0, k1, k2, k3 : unsigned(31 downto 0);
        variable temp            : unsigned(31 downto 0);
        variable new_key         : unsigned(31 downto 0);
        variable rk              : std_logic_vector(1407 downto 0);
    begin

        k0 := unsigned(master_key(31 downto 0));
        k1 := unsigned(master_key(63 downto 32));
        k2 := unsigned(master_key(95 downto 64));
        k3 := unsigned(master_key(127 downto 96));

        for i in 0 to 43 loop

            rk(i * 32 + 31 downto i * 32) :=
                std_logic_vector(k0);

            temp := rotr32(k3, 3);

            new_key := k0 xor temp xor k1
                       xor rotr32(temp xor k1, 1);

            new_key := new_key xor SIMON_C;

            if SIMON_Z3(i) = '1' then
                new_key := new_key xor
                           to_unsigned(1, 32);
            end if;

            k0 := k1;
            k1 := k2;
            k2 := k3;
            k3 := new_key;

        end loop;

        round_keys <= rk;

    end process;

end architecture rtl;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity simon_bitserial is
    port (
        clk        : in  std_logic;
        reset      : in  std_logic;
        start      : in  std_logic;
        plaintext  : in  std_logic_vector(63 downto 0);
        master_key : in  std_logic_vector(127 downto 0);
        ciphertext : out std_logic_vector(63 downto 0);
        busy       : out std_logic;
        done       : out std_logic
    );
end entity simon_bitserial;

architecture rtl of simon_bitserial is

    type state_type is (IDLE, PROCESS_BIT);

    constant Z3 : std_logic_vector(63 downto 0) :=
        x"FC2CE51207A635DB";

    signal state       : state_type := IDLE;

    signal x_reg       : std_logic_vector(31 downto 0) := (others => '0');
    signal y_reg       : std_logic_vector(31 downto 0) := (others => '0');
    signal x_work      : std_logic_vector(31 downto 0) := (others => '0');

    signal k0_reg      : std_logic_vector(31 downto 0) := (others => '0');
    signal k1_reg      : std_logic_vector(31 downto 0) := (others => '0');
    signal k2_reg      : std_logic_vector(31 downto 0) := (others => '0');
    signal k3_reg      : std_logic_vector(31 downto 0) := (others => '0');

    signal bit_count   : integer range 0 to 31 := 0;
    signal round_count : integer range 0 to 43 := 0;

    signal done_reg    : std_logic := '0';

    function rotr32(
        value : std_logic_vector(31 downto 0);
        amount : integer
    ) return std_logic_vector is
    begin
        return value(amount - 1 downto 0) &
               value(31 downto amount);
    end function;

begin

    process(clk)
        variable bit_result : std_logic;
        variable x_complete : std_logic_vector(31 downto 0);
        variable temp       : std_logic_vector(31 downto 0);
        variable new_key    : std_logic_vector(31 downto 0);
    begin
        if rising_edge(clk) then

            if reset = '1' then
                state       <= IDLE;
                x_reg       <= (others => '0');
                y_reg       <= (others => '0');
                x_work      <= (others => '0');

                k0_reg      <= (others => '0');
                k1_reg      <= (others => '0');
                k2_reg      <= (others => '0');
                k3_reg      <= (others => '0');

                bit_count   <= 0;
                round_count <= 0;
                done_reg    <= '0';

            else
                done_reg <= '0';

                case state is

                    when IDLE =>
                        if start = '1' then
                            x_reg <= plaintext(63 downto 32);
                            y_reg <= plaintext(31 downto 0);
                            x_work <= (others => '0');

                            k0_reg <= master_key(31 downto 0);
                            k1_reg <= master_key(63 downto 32);
                            k2_reg <= master_key(95 downto 64);
                            k3_reg <= master_key(127 downto 96);

                            bit_count   <= 0;
                            round_count <= 0;
                            state       <= PROCESS_BIT;
                        end if;

                    when PROCESS_BIT =>

                        bit_result :=
                            y_reg(bit_count) xor
                            (x_reg((bit_count + 31) mod 32) and
                             x_reg((bit_count + 24) mod 32)) xor
                            x_reg((bit_count + 30) mod 32) xor
                            k0_reg(bit_count);

                        x_work(bit_count) <= bit_result;

                        if bit_count = 31 then

                            x_complete := x_work;
                            x_complete(31) := bit_result;

                            x_reg <= x_complete;
                            y_reg <= x_reg;

                            if round_count = 43 then
                                state    <= IDLE;
                                done_reg <= '1';
                            else

                                temp := rotr32(k3_reg, 3);

                                new_key :=
                                    k0_reg xor
                                    temp xor
                                    k1_reg xor
                                    rotr32(temp xor k1_reg, 1) xor
                                    x"FFFFFFFC";

                                new_key(0) :=
                                    new_key(0) xor Z3(round_count);

                                k0_reg <= k1_reg;
                                k1_reg <= k2_reg;
                                k2_reg <= k3_reg;
                                k3_reg <= new_key;

                                round_count <= round_count + 1;
                                bit_count   <= 0;
                            end if;

                        else
                            bit_count <= bit_count + 1;
                        end if;

                end case;
            end if;
        end if;
    end process;

    ciphertext <= x_reg & y_reg;
    busy       <= '1' when state = PROCESS_BIT else '0';
    done       <= done_reg;

end architecture rtl;


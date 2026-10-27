
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity simon_iterative is
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
end entity simon_iterative;

architecture rtl of simon_iterative is

    type state_type is (IDLE, WAIT_KEY, RUN);
    signal state : state_type := IDLE;

    signal x_reg, y_reg : std_logic_vector(31 downto 0) :=
        (others => '0');

    signal x_next, y_next : std_logic_vector(31 downto 0);

    signal key_start : std_logic := '0';
    signal round_key : std_logic_vector(31 downto 0);
    signal round_index : unsigned(5 downto 0);
    signal round_valid, key_busy, key_done : std_logic;

    signal contador : integer range 0 to 43 := 0;
    signal ocupado, terminou : std_logic := '0';

begin

    busy <= ocupado;
    done <= terminou;

    KEY_SCHEDULE : entity work.simon_key_schedule
        port map (
            clk         => clk,
            reset       => reset,
            start       => key_start,
            master_key  => master_key,
            round_key   => round_key,
            round_index => round_index,
            round_valid => round_valid,
            busy        => key_busy,
            done        => key_done
        );

    ROUND_UNIT : entity work.simon_round
        port map (
            x_in  => x_reg,
            y_in  => y_reg,
            k_in  => round_key,
            x_out => x_next,
            y_out => y_next
        );

    process(clk, reset)
    begin
        if reset = '1' then
            state <= IDLE;
            x_reg <= (others => '0');
            y_reg <= (others => '0');
            key_start <= '0';
            contador <= 0;
            ocupado <= '0';
            terminou <= '0';
            ciphertext <= (others => '0');

        elsif rising_edge(clk) then
            key_start <= '0';
            terminou <= '0';

            case state is

                when IDLE =>
                    ocupado <= '0';

                    if start = '1' then
                        x_reg <= plaintext(63 downto 32);
                        y_reg <= plaintext(31 downto 0);

                        key_start <= '1';
                        contador <= 0;
                        ocupado <= '1';
                        state <= WAIT_KEY;
                    end if;

                when WAIT_KEY =>
                    ocupado <= '1';

                    if round_valid = '1' then
                        x_reg <= x_next;
                        y_reg <= y_next;
                        contador <= 1;
                        state <= RUN;
                    end if;

                when RUN =>
                    ocupado <= '1';

                    if round_valid = '1' then
                        x_reg <= x_next;
                        y_reg <= y_next;

                        if contador = 43 then
                            ciphertext <= x_next & y_next;
                            terminou <= '1';
                            ocupado <= '0';
                            state <= IDLE;
                        else
                            contador <= contador + 1;
                        end if;
                    end if;

            end case;
        end if;
    end process;

end architecture rtl;


library ieee;
use ieee.std_logic_1164.all;

entity simon_fully_unrolled is
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
end entity simon_fully_unrolled;

architecture rtl of simon_fully_unrolled is

    type state_type is (IDLE, RUN);
    signal state : state_type := IDLE;

    signal key_reg : std_logic_vector(127 downto 0) :=
        (others => '0');

    signal plain_reg : std_logic_vector(63 downto 0) :=
        (others => '0');

    signal all_keys : std_logic_vector(1407 downto 0);

    signal x_result : std_logic_vector(31 downto 0);
    signal y_result : std_logic_vector(31 downto 0);

begin

    KEYGEN : entity work.simon_key_schedule(rtl)
        port map (
            master_key => key_reg,
            round_keys => all_keys
        );

    ROUNDS : entity work.simon_44rounds(structural)
        port map (
            x_in    => plain_reg(63 downto 32),
            y_in    => plain_reg(31 downto 0),
            keys_in => all_keys,
            x_out   => x_result,
            y_out   => y_result
        );

    busy <= '1' when state = RUN else '0';

    process(clk, reset)
    begin
        if reset = '1' then

            state      <= IDLE;
            key_reg    <= (others => '0');
            plain_reg  <= (others => '0');
            ciphertext <= (others => '0');
            done       <= '0';

        elsif rising_edge(clk) then

            done <= '0';

            case state is

                when IDLE =>
                    if start = '1' then

                        key_reg   <= master_key;
                        plain_reg <= plaintext;

                        state <= RUN;

                    end if;

                when RUN =>

                    ciphertext <= x_result & y_result;
                    done <= '1';

                    state <= IDLE;

            end case;

        end if;
    end process;

end architecture rtl;

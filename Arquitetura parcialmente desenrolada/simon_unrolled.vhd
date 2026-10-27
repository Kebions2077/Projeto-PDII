
library ieee;
use ieee.std_logic_1164.all;

entity simon_unrolled is
    port (
        clk         : in  std_logic;
        reset       : in  std_logic;
        start       : in  std_logic;
        plaintext   : in  std_logic_vector(63 downto 0);
        master_key  : in  std_logic_vector(127 downto 0);
        ciphertext  : out std_logic_vector(63 downto 0);
        busy        : out std_logic;
        done        : out std_logic
    );
end entity simon_unrolled;

architecture rtl of simon_unrolled is

    type state_type is (IDLE, RUN);
    signal state : state_type := IDLE;

    signal key_reg : std_logic_vector(127 downto 0) :=
        (others => '0');

    signal all_keys : std_logic_vector(1407 downto 0);

    signal group_keys : std_logic_vector(127 downto 0);
    signal group_index : integer range 0 to 10 := 0;

    signal x_reg, y_reg : std_logic_vector(31 downto 0);
    signal x_next, y_next : std_logic_vector(31 downto 0);

begin

    KEYGEN : entity work.simon_key_schedule(rtl)
        port map (
            master_key => key_reg,
            round_keys => all_keys
        );

    -- Seleciona quatro subchaves do grupo atual.
    process(all_keys, group_index)
        variable base : integer;
    begin
        base := group_index * 128;
        group_keys <= all_keys(base + 127 downto base);
    end process;

    ROUND_GROUP : entity work.simon_4rounds(structural)
        port map (
            x_in    => x_reg,
            y_in    => y_reg,
            keys_in => group_keys,
            x_out   => x_next,
            y_out   => y_next
        );

    busy <= '1' when state = RUN else '0';

    process(clk, reset)
    begin
        if reset = '1' then
            state      <= IDLE;
            group_index <= 0;
            key_reg    <= (others => '0');
            x_reg      <= (others => '0');
            y_reg      <= (others => '0');
            ciphertext <= (others => '0');
            done       <= '0';

        elsif rising_edge(clk) then

            -- done dura um ciclo de clock.
            done <= '0';

            case state is

                when IDLE =>
                    if start = '1' then

                        key_reg <= master_key;

                        x_reg <= plaintext(63 downto 32);
                        y_reg <= plaintext(31 downto 0);

                        group_index <= 0;
                        state <= RUN;

                    end if;

                when RUN =>

                    -- Armazena o resultado das quatro rodadas.
                    x_reg <= x_next;
                    y_reg <= y_next;

                    if group_index = 10 then

                        -- Resultado do ultimo grupo.
                        ciphertext <= x_next & y_next;

                        done <= '1';
                        state <= IDLE;

                    else
                        group_index <= group_index + 1;
                    end if;

            end case;

        end if;
    end process;

end architecture rtl;

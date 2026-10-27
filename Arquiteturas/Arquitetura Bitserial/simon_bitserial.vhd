
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
end entity;

architecture rtl of simon_bitserial is
    signal round_keys : std_logic_vector(1407 downto 0);

    signal x_reg : std_logic_vector(31 downto 0);
    signal y_reg : std_logic_vector(31 downto 0);

    signal x_next : std_logic_vector(31 downto 0);
    signal y_next : std_logic_vector(31 downto 0);

    signal round_key : std_logic_vector(31 downto 0);
    signal round_count : integer range 0 to 43 := 0;

    signal active : std_logic := '0';
    signal done_reg : std_logic := '0';

begin
    key_schedule_inst : entity work.simon_key_schedule
        port map (
            master_key => master_key,
            round_keys => round_keys
        );

    round_key <= round_keys(
        round_count * 32 + 31 downto round_count * 32
    );

    round_inst : entity work.simon_round
        port map (
            x_in  => x_reg,
            y_in  => y_reg,
            k     => round_key,
            x_out => x_next,
            y_out => y_next
        );

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                x_reg <= (others => '0');
                y_reg <= (others => '0');
                round_count <= 0;
                active <= '0';
                done_reg <= '0';
            else
                done_reg <= '0';

                if active = '0' then
                    if start = '1' then
                        x_reg <= plaintext(63 downto 32);
                        y_reg <= plaintext(31 downto 0);
                        round_count <= 0;
                        active <= '1';
                    end if;
                else
                    x_reg <= x_next;
                    y_reg <= y_next;

                    if round_count = 43 then
                        active <= '0';
                        done_reg <= '1';
                    else
                        round_count <= round_count + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    ciphertext <= x_reg & y_reg;
    busy <= active;
    done <= done_reg;

end architecture;

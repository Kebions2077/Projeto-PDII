
library ieee;
use ieee.std_logic_1164.all;

entity simon_pipeline is
    port (
        clk         : in  std_logic;
        reset       : in  std_logic;
        start       : in  std_logic;
        plaintext   : in  std_logic_vector(63 downto 0);
        master_key  : in  std_logic_vector(127 downto 0);
        ciphertext  : out std_logic_vector(63 downto 0);
        done        : out std_logic
    );
end entity;

architecture rtl of simon_pipeline is
    signal rk0, rk1, rk2, rk3 :
        std_logic_vector(1407 downto 0);

    signal x1, y1, x2, y2, x3, y3, x4, y4 :
        std_logic_vector(31 downto 0);

    signal key1, key2, key3 :
        std_logic_vector(127 downto 0);

    signal valid1, valid2, valid3, valid4 : std_logic;

    signal p1x, p1y, p2x, p2y, p3x, p3y :
        std_logic_vector(31 downto 0);

    signal ciph_reg : std_logic_vector(63 downto 0);
begin
    schedule0 : entity work.simon_key_schedule
        port map (
            master_key => master_key,
            round_keys => rk0
        );

    schedule1 : entity work.simon_key_schedule
        port map (
            master_key => key1,
            round_keys => rk1
        );

    schedule2 : entity work.simon_key_schedule
        port map (
            master_key => key2,
            round_keys => rk2
        );

    schedule3 : entity work.simon_key_schedule
        port map (
            master_key => key3,
            round_keys => rk3
        );

    stage1 : entity work.simon_11rounds
        port map (
            x_in  => plaintext(63 downto 32),
            y_in  => plaintext(31 downto 0),
            keys  => rk0(351 downto 0),
            x_out => x1,
            y_out => y1
        );

    stage2 : entity work.simon_11rounds
        port map (
            x_in  => p1x,
            y_in  => p1y,
            keys  => rk1(703 downto 352),
            x_out => x2,
            y_out => y2
        );

    stage3 : entity work.simon_11rounds
        port map (
            x_in  => p2x,
            y_in  => p2y,
            keys  => rk2(1055 downto 704),
            x_out => x3,
            y_out => y3
        );

    stage4 : entity work.simon_11rounds
        port map (
            x_in  => p3x,
            y_in  => p3y,
            keys  => rk3(1407 downto 1056),
            x_out => x4,
            y_out => y4
        );

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                p1x <= (others => '0');
                p1y <= (others => '0');
                p2x <= (others => '0');
                p2y <= (others => '0');
                p3x <= (others => '0');
                p3y <= (others => '0');

                key1 <= (others => '0');
                key2 <= (others => '0');
                key3 <= (others => '0');

                valid1 <= '0';
                valid2 <= '0';
                valid3 <= '0';
                valid4 <= '0';
                ciph_reg <= (others => '0');
            else
                valid1 <= start;
                valid2 <= valid1;
                valid3 <= valid2;
                valid4 <= valid3;

                p1x <= x1;
                p1y <= y1;
                key1 <= master_key;

                p2x <= x2;
                p2y <= y2;
                key2 <= key1;

                p3x <= x3;
                p3y <= y3;
                key3 <= key2;

                if valid3 = '1' then
                    ciph_reg <= x4 & y4;
                end if;
            end if;
        end if;
    end process;

    ciphertext <= ciph_reg;
    done <= valid4;
end architecture;

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
 
    signal k0, k1, k2, k3     : std_logic_vector(31 downto 0) := (others => '0');
    signal nk4, nk5, nk6, nk7 : std_logic_vector(31 downto 0);
 
    constant SIMON_C : std_logic_vector(31 downto 0) := x"FFFFFFFC";
 
    constant Z3 : std_logic_vector(61 downto 0) :=
        "11011011101011000110010111100000010010001010011100110100001111";
 
    function zbit(idx : natural) return std_logic is
    begin
        return Z3(61 - (idx mod 62));
    end function;
 
    function key_next(
        ka : std_logic_vector(31 downto 0);
        kb : std_logic_vector(31 downto 0);
        kc : std_logic_vector(31 downto 0);
        z  : std_logic
    ) return std_logic_vector is
        variable u : std_logic_vector(31 downto 0);
        variable v : std_logic_vector(31 downto 0);
    begin
        u := (kc(2 downto 0) & kc(31 downto 3)) xor kb;   -- ROR3(kc) xor kb
        v := u(0) & u(31 downto 1);                        -- ROR1(u)
        u := ka xor u xor v xor SIMON_C;
        u(0) := u(0) xor z;
        return u;
    end function;
 
    signal group_keys : std_logic_vector(127 downto 0);
    signal group_index : integer range 0 to 10 := 0;
 
    signal x_reg, y_reg : std_logic_vector(31 downto 0);
    signal x_next, y_next : std_logic_vector(31 downto 0);
 
begin
 
    group_keys <= k3 & k2 & k1 & k0;
 
    nk4 <= key_next(k0, k1, k3,  zbit(4 * group_index));
    nk5 <= key_next(k1, k2, nk4, zbit(4 * group_index + 1));
    nk6 <= key_next(k2, k3, nk5, zbit(4 * group_index + 2));
    nk7 <= key_next(k3, nk4, nk6, zbit(4 * group_index + 3));
 
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
            k0         <= (others => '0');
            k1         <= (others => '0');
            k2         <= (others => '0');
            k3         <= (others => '0');
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
 
                        k0 <= master_key(31 downto 0);
                        k1 <= master_key(63 downto 32);
                        k2 <= master_key(95 downto 64);
                        k3 <= master_key(127 downto 96);
 
                        x_reg <= plaintext(63 downto 32);
                        y_reg <= plaintext(31 downto 0);
 
                        group_index <= 0;
                        state <= RUN;
 
                    end if;
 
                when RUN =>
 
                    -- Armazena o resultado das quatro rodadas.
                    x_reg <= x_next;
                    y_reg <= y_next;
                    k0    <= nk4;
                    k1    <= nk5;
                    k2    <= nk6;
                    k3    <= nk7;
 
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

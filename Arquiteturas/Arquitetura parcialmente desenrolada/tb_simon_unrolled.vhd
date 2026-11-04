library ieee;
use ieee.std_logic_1164.all;

entity tb_simon_unrolled is
end entity tb_simon_unrolled;

architecture simulacao of tb_simon_unrolled is

    type vetor_t is record
        key : std_logic_vector(127 downto 0);
        pt  : std_logic_vector(63 downto 0);
        ct  : std_logic_vector(63 downto 0);
    end record;

    type vetores_t is array (natural range <>) of vetor_t;

    constant VETORES : vetores_t := (
        (key => x"1B1A1918131211100B0A090803020100", pt => x"656B696C20646E75", ct => x"44C8FC20B9DFA07A"),
        (key => x"00000000000000000000000000000000", pt => x"0000000000000000", ct => x"EDF1BE0A54D9BF51"),
        (key => x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF", pt => x"FFFFFFFFFFFFFFFF", ct => x"DB15E84A8DAFF32A"),
        (key => x"55555555AAAAAAAA55555555AAAAAAAA", pt => x"AAAAAAAA55555555", ct => x"53E8B277F12B8B24"),
        (key => x"1B1A1918131211100B0A090803020100", pt => x"0000000000000000", ct => x"97EEB55290AABC32"),
        (key => x"00000000000000000000000000000000", pt => x"FFFFFFFFFFFFFFFF", ct => x"CCC468FD2553CACB"),
        (key => x"ACE435DB18AAA8D0B97ADDB52666E5D4", pt => x"4439A299298E1340", ct => x"1FCBA6B6D7EBE64C"),
        (key => x"4FC018412872C876A80E83EEBAFB7E35", pt => x"E227927CF8C92EF4", ct => x"DFE7869A4FC17B78"),
        (key => x"C778E287E46B45FA2E5B0BC63B47C2D9", pt => x"00956F75E5BD9F80", ct => x"FE9160C1B083B984"),
        (key => x"6E9F0CEB2CD12C1AE4B741432C9CBA3D", pt => x"EBD92739A29CD113", ct => x"DAF7B87261884CC9"),
        (key => x"D43BE2F1A761D848B75F99B8D0A604F8", pt => x"973CD66CC7313414", ct => x"0DF6B50F42136063"),
        (key => x"D29CF9D2E6ABD6D863DA48366F3D7217", pt => x"863CBD1166B7EDEC", ct => x"A90642DD778A06CE"),
        (key => x"4E99A682FA478BB2F8FD937BF11F8F99", pt => x"B23B4DE352EE281F", ct => x"C23AAB81F0460D30"),
        (key => x"E458FBBBB0B2F9C779E8C14D5A4B08E8", pt => x"61C00BFD42074D6A", ct => x"D7973E7A8414ADAA"),
        (key => x"5E4FD1E4F68082520A7B73EBC3EA2BA7", pt => x"53435CAF7568C8BE", ct => x"3B28E19B499CD367"),
        (key => x"CA483DFD55A0AF7C759B790C9E4BC9ED", pt => x"E57FAC3BB81797B8", ct => x"1396AC6C246787F3"),
        (key => x"4974E37F5FBED765A33011E0DCD8F4AC", pt => x"6A56A6876FD6EBC5", ct => x"3098491D19DD4792"),
        (key => x"63D6FE532FE5230883A83AC426A9B942", pt => x"E47E72C43FA404C7", ct => x"A1F448F2079BC340"),
        (key => x"20A26AC7D67F420E4B16DAA40AA0188A", pt => x"1F7205D06E293765", ct => x"7CA7225421FE1669"),
        (key => x"EA64AB518E2B724F13D5E043E84ADBF1", pt => x"11D589B28DCB4182", ct => x"5C351EACECB3E264"),
        (key => x"985E7E9D1B3EB7341B4299B09E1CE999", pt => x"EE4EE13B2F7E9483", ct => x"C8A238511569F077"),
        (key => x"82B9AEA49DEE7BF1BD0A5A054266CB9D", pt => x"2A78AC4EAE32DA5B", ct => x"BD22234CC9303A3A"),
        (key => x"8620915CCF116BC3A11E4A2E40695AEF", pt => x"099FCB86328AB1B9", ct => x"36F2046C35CE20E7"),
        (key => x"90AACE0985138997243D52799D00C984", pt => x"06DCE64733C126A2", ct => x"2CCEA1B9C292B377"),
        (key => x"80868464296F642DF720BA1C6F5FB978", pt => x"B5621A248A46A3BE", ct => x"BD508E2403B148C2"),
        (key => x"C7DCA885215A6027219CDB43CFD25A44", pt => x"6416BD529F07D46A", ct => x"743276A15208FBF0")
    );

    signal clk        : std_logic := '0';
    signal reset      : std_logic := '1';
    signal start      : std_logic := '0';
    signal plaintext  : std_logic_vector(63 downto 0) := (others => '0');
    signal master_key : std_logic_vector(127 downto 0) := (others => '0');
    signal ciphertext : std_logic_vector(63 downto 0);
    signal busy       : std_logic;
    signal done       : std_logic;
    signal finished   : boolean := false;

begin

    clk <= not clk after 5 ns when not finished else '0';

    DUT : entity work.simon_unrolled(rtl)
        port map (
            clk        => clk,
            reset      => reset,
            start      => start,
            plaintext  => plaintext,
            master_key => master_key,
            ciphertext => ciphertext,
            busy       => busy,
            done       => done
        );

    process
        variable aprovados  : integer := 0;
        variable reprovados : integer := 0;
    begin

        reset <= '1';
        wait for 20 ns;
        wait until falling_edge(clk);
        reset <= '0';
        wait until falling_edge(clk);

        for i in VETORES'range loop

            plaintext  <= VETORES(i).pt;
            master_key <= VETORES(i).key;
            start      <= '1';
            wait until falling_edge(clk);
            start      <= '0';

            wait until done = '1' for 2 us;
            wait for 1 ns;

            if done = '1' and ciphertext = VETORES(i).ct then
                aprovados := aprovados + 1;
                report "vetor " & integer'image(i) & ": APROVADO"
                    severity note;
            else
                reprovados := reprovados + 1;
                report "vetor " & integer'image(i) & ": REPROVADO"
                    severity error;
            end if;

            wait until falling_edge(clk);

        end loop;

        report "RESUMO: " & integer'image(aprovados) & " aprovados, " &
               integer'image(reprovados) & " reprovados."
            severity note;

        finished <= true;
        wait;

    end process;

end architecture simulacao;

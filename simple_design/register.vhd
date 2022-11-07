library ieee;
use ieee.std_logic_1164.all;
use work.types.all;

entity reg is
port ( 
    din : in  signed(sample_bits-1 downto 0);
    enable : in std_logic;
    n_rst: in std_logic;
    clk: in std_logic;
    dout: out signed(sample_bits-1 downto 0)
 );
end entity;

architecture register_arch of register is 

begin
    process(clk, n_rst) begin
        if (n_rst = '0') then
            dout<=(others=>'0');
        elsif rising_edge(clk) then
            if(enable = '1') then   
                dout <= din;
            end if;
        end if;
    end process;
end architecture;
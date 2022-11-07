library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;


entity filter_block is
port ( 
    reg_in : in  signed(sample_bits-1 downto 0);
    coeff : in signed(coeff_bits-1 downto 0);
    add_in : in signed(sample_bits-1 downto 0);
    enable : in std_logic;
    n_rst: in std_logic;
    clk: in std_logic;
    reg_out: out signed(sample_bits-1 downto 0);
    add_out: out signed(sample_bits-1 downto 0)
 );
end entity;

architecture arch of filter_block is 
component reg is 
	port(
		din : in  signed(sample_bits-1 downto 0);
    	enable : in std_logic;
   		n_rst: in std_logic;
    	clk: in std_logic;
    	dout: out signed(sample_bits-1 downto 0)
	);
end component;
    
    signal register_output : signed(sample_bits-1 downto 0);
    signal mult_out: signed(sample_bits-1 downto 0);
    
begin

reg_0: reg port map(din=>reg_in,enable=>enable,n_rst=>n_rst,clk=>clk, dout=>register_output);
reg_out <= register_output;
mult_out <= resize(register_output * coeff, mult_out'length);
add_out <= resize(mult_out + add_in, add_out'length);

end architecture;
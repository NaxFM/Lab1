library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;

entity filter is
	port(
    	din : in  signed(sample_bits-1 downto 0);
      b : in coeff_array;
      vin : in std_logic;
      rst_n : in std_logic;
      clk : in std_logic;
      dout : out signed(sample_bits-1 downto 0);
      vout : out std_logic
    );
    
end entity;

architecture arch of filter is
component reg is 
	port(
      din : in  signed(sample_bits-1 downto 0);
      enable : in std_logic;
      n_rst: in std_logic;
      clk: in std_logic;
      dout: out signed(sample_bits-1 downto 0)
    );
end component;

component filter_block is 
	port(
    	reg_in : in  signed(sample_bits-1 downto 0);
   		coeff : in signed(coeff_bits-1 downto 0);
    	add_in : in signed(sample_bits-1 downto 0);
    	enable : in std_logic;
    	n_rst: in std_logic;
    	clk: in std_logic;
    	reg_out: out signed(sample_bits-1 downto 0);
    	add_out: out signed(sample_bits-1 downto 0)
    );
end component;

type sample_bits_array is array(order downto 0) of signed (sample_bits -1 downto 0); 
signal reg_out: sample_bits_array;
signal add_out: sample_bits_array;
signal zero_signed : signed(sample_bits-1 downto 0);

signal buffer_register_out : signed(sample_bits-1 downto 0);
signal mult_out: signed(sample_bits-1 downto 0);


begin

	  zero_signed <= (others=>'0');
    vout <= vin;
	
    filter_block_0 : filter_block port map (
      reg_in => din, 
      coeff => b(0), 
      add_in => zero_signed,
      enable => vin,
      n_rst => rst_n,
      clk => clk,
      reg_out => reg_out(0),
      add_out => add_out(0)
    );

    filter_block_1 : filter_block port map (
      reg_in => reg_out(0), 
      coeff => b(1), 
      add_in => add_out(0),
      enable => vin,
      n_rst => rst_n,
      clk => clk,
      reg_out => reg_out(1),
      add_out => add_out(1)
    );

    filter_block_2 : filter_block port map (
      reg_in => reg_out(1), 
      coeff => b(2), 
      add_in => add_out(1),
      enable => vin,
      n_rst => rst_n,
      clk => clk,
      reg_out => reg_out(2),
      add_out => add_out(2)
    );

    filter_block_3 : filter_block port map (
      reg_in => reg_out(2), 
      coeff => b(3), 
      add_in => add_out(2),
      enable => vin,
      n_rst => rst_n,
      clk => clk,
      reg_out => reg_out(3),
      add_out => add_out(3)
    );

    filter_block_4 : filter_block port map (
      reg_in => reg_out(3), 
      coeff => b(4), 
      add_in => add_out(3),
      enable => vin,
      n_rst => rst_n,
      clk => clk,
      reg_out => reg_out(4),
      add_out => add_out(4)
    );

    filter_block_5 : filter_block port map (
      reg_in => reg_out(4), 
      coeff => b(5), 
      add_in => add_out(4),
      enable => vin,
      n_rst => rst_n,
      clk => clk,
      reg_out => reg_out(5),
      add_out => add_out(5)
    );

    filter_block_6 : filter_block port map (
      reg_in => reg_out(5), 
      coeff => b(6), 
      add_in => add_out(5),
      enable => vin,
      n_rst => rst_n,
      clk => clk,
      reg_out => reg_out(6),
      add_out => add_out(6)
    );

    filter_block_7 : filter_block port map (
      reg_in => reg_out(6), 
      coeff => b(7), 
      add_in => add_out(6),
      enable => vin,
      n_rst => rst_n,
      clk => clk,
      reg_out => reg_out(7),
      add_out => add_out(7)
    );

    filter_block_8 : filter_block port map (
      reg_in => reg_out(7), 
      coeff => b(8), 
      add_in => add_out(7),
      enable => vin,
      n_rst => rst_n,
      clk => clk,
      reg_out => reg_out(8),
      add_out => add_out(8)
    );

    filter_block_9 : filter_block port map (
      reg_in => reg_out(8), 
      coeff => b(9), 
      add_in => add_out(8),
      enable => vin,
      n_rst => rst_n,
      clk => clk,
      reg_out => reg_out(9),
      add_out => add_out(9)
    );

    filter_block_10 : filter_block port map (
      reg_in => reg_out(9), 
      coeff => b(10), 
      add_in => add_out(9),
      enable => vin,
      n_rst => rst_n,
      clk => clk,
      --reg_out => reg_out(10),
      add_out => add_out(10)
    );

    out_reg : reg port map(
      din => add_out(10),
      enable => vin,
      n_rst => rst_n,
      clk => clk,
      dout => dout
    );
	
end architecture;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;

entity filter_block is
    
    port(
        reg_in : in signed(sample_bits-1 downto 0);
        B : in signed(coeff_bits-1 downto 0);
        clk : in std_logic;
        rst_n : in std_logic;
        enable : in std_logic;
        reg_out : out signed (sample_bits-1 downto 0);
    );
end entity;

architecture filter of filter_block is 
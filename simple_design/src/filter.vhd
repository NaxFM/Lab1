library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;

entity filter is
    
    port(
        DIN : in signed(sample_bits-1 downto 0);
        B : in coeff_array;
        clk : in std_logic;
        rst_n : in std_logic;
        vin : in std_logic;
        DOUT : out signed(sample_bits-1 downto 0);
        VOUT : out std_logic
    );
end entity
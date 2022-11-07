library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package types is
    constant sample_bits : integer := 7;
    constant coeff_bits : integer := 8;
    constant order : integer := 10;

    type coeff_array is array(order downto 0) of signed (coeff_bits -1 downto 0); 
    
end types;
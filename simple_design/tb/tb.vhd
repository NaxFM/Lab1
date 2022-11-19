library IEEE;
library std;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types.all;
use std.textio.all;


entity tb is 
end entity;

architecture testbench of tb is 

    component filter is
        port(
            din : in  signed(sample_bits-1 downto 0);
            b : in coeff_array;
            vin : in std_logic;
            rst_n : in std_logic;
            clk : in std_logic;
            dout : out signed(sample_bits-1 downto 0);
            vout : out std_logic
        );
    end component;

    file f_sample_in : text;
    file f_sample_out : text;

    signal tb_din : signed(sample_bits-1 downto 0);
    signal tb_b : coeff_array;
    signal tb_vin : std_logic := '1';
    signal tb_rst_n : std_logic := '1';
    signal tb_clk : std_logic := '1';
    signal tb_dout : signed(sample_bits-1 downto 0);
    signal tb_vout : std_logic;

    type sample_list is array (201-1 downto 0) of signed (sample_bits-1 downto 0);
    signal samples : sample_list ;

    begin
        Filter_inst : filter
            port map(
                din => tb_din,
                b => tb_b,
                vin => tb_vin,
                rst_n => tb_rst_n,
                clk => tb_clk,
                dout => tb_dout,
                vout => tb_vout
            );

        
        tb_clk <= not tb_clk after 20 ns;
        tb_rst_n<='1', '0' after 2 ns, '1' after 3 ns;

        tb_b(0)<=to_signed(0,tb_b(0)'length);
        tb_b(1)<=to_signed(1,tb_b(1)'length);
        tb_b(2)<=to_signed(6,tb_b(2)'length);
        tb_b(3)<=to_signed(15,tb_b(3)'length);
        tb_b(4)<=to_signed(25,tb_b(4)'length);
        tb_b(5)<=to_signed(30,tb_b(5)'length);
        tb_b(6)<=to_signed(25,tb_b(6)'length);
        tb_b(7)<=to_signed(15,tb_b(7)'length);
        tb_b(8)<=to_signed(6,tb_b(8)'length);
        tb_b(9)<=to_signed(1,tb_b(9)'length);
        tb_b(10)<=to_signed(0,tb_b(10)'length);


        

        --put all input samples in a list
        process(tb_rst_n)
            variable in_line : line;
            variable sample_in : integer;
            variable i : integer := 0;
        begin
            if(falling_edge(tb_rst_n)) then
                file_open(f_sample_in, "../matlab/samples.txt", read_mode);
                while not endfile(f_sample_in) and i < 201 loop
                    readline(f_sample_in, in_line);
                    read(in_line, sample_in);
                    samples(i) <= to_signed(sample_in, sample_bits);
                    i := i + 1;
                end loop;
            file_close(f_sample_in);
            end if;
        end process;
        --------------

        file_open(f_sample_out, "./sample_out.txt", write_mode);
        process(tb_clk)
            variable list_index : integer := 0;
            variable out_line : line;

        begin

            if(falling_edge(tb_clk) and tb_rst_n = '1' and tb_vin = '1') then
                
                tb_din <= samples(list_index);
                list_index := list_index + 1;
                write(out_line, to_integer(tb_dout));
                writeline(f_sample_out, out_line);  
                --file_close(f_sample_out);
            end if;
            
        end process;

    end testbench;
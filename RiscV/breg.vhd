library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

library work;

entity mem_reg is
  port (
    clock : in std_logic;
    we : in std_logic;
    address1x : in std_logic_vector(4 downto 0);
    address2x : in std_logic_vector(4 downto 0);
    write_address : in std_logic_vector(4 downto 0);
    data_in : in std_logic_vector(31 downto 0);
    data1_out : OUT std_logic_vector(31 downto 0);
    data2_out : OUT std_logic_vector(31 downto 0));
end mem_reg;

architecture arch_breg of mem_reg is

constant mem_depth : natural := 32;
constant mem_width : natural := 32;
type mem_type is array (0 to mem_depth - 1)
    of std_logic_vector(mem_width - 1 downto 0);

signal address1_signal : integer := 0;
signal address2_signal : integer := 0;
signal write_address_signal : integer := 0;

signal breg : mem_type := (x"00000000",
                           others => (others => '0'));

begin

  address1_signal <= to_integer(UNSIGNED(address1x));
  address2_signal <= to_integer(UNSIGNED(address2x));
  write_address_signal <= to_integer(UNSIGNED(write_address));
  data1_out <= breg(address1_signal);
  data2_out <= breg(address2_signal);

  process (clock, we, write_address_signal)
  begin
    if RISING_EDGE(clock) and (we = '1') and (write_address_signal /= 0) then
      breg(write_address_signal) <= data_in;
    end if;
  end process;

end arch_breg;
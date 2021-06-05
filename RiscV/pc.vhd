library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;

entity pc is
  port (
    addr_in : in std_logic_vector(31 downto 0);
    rst : in STD_LOGIC;
    clk : in STD_LOGIC;
    addr_out : OUT std_logic_vector(31 downto 0) := x"00000000");
end entity pc;

architecture arch_pc of pc is

begin

  process (clk) begin
    if rising_edge(clk) then
      if rst = '1' then
        addr_out <= x"00000000";
      else
        addr_out <= addr_in;
          end if;
       end if;
    end process;
  end arch_pc;
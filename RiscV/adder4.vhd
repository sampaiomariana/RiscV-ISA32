library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;

entity adder4 is
  port (
    A : in std_logic_vector(31 downto 0);
    Z : out std_logic_vector(31 downto 0));
end entity adder4;

architecture arch_adder4 of adder4 is

signal A_signal : INTEGER;

begin

  A_signal <= TO_INTEGER(UNSIGNED(A)) + 4;
  Z <= std_logic_vector(TO_UNSIGNED(A_signal, Z'length));

end arch_adder4;
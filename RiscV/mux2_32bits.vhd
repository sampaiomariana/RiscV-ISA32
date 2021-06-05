library ieee;
use ieee.std_logic_1164.all;

library work;

entity mux2_32bits is
  port (
    Sel : in std_logic;
    A : in std_logic_vector(31 DOWNTO 0);
    B : in std_logic_vector(31 DOWNTO 0);
    Result : out std_logic_vector(31 DOWNTO 0));
end mux2_32bits;

architecture arch_mux of mux2_32bits is

begin

  process (Sel, A, B)
  begin
    if Sel = '0' then
      Result <= A;
    else
      Result <= B;
    end if;
  end process;

end arch_mux;
library ieee;
use ieee.std_logic_1164.all;

library work;

entity control_alu is
  generic (data_width : natural := 32);
  port (
    ulaOp : in std_logic_vector(1 downto 0);
    funct7 : in std_logic;
    auipcIn : in std_logic;
    funct3 : in std_logic_vector(2 downto 0);
    opOut : out std_logic_vector(3 downto 0));
end entity control_alu;

architecture arch_control_ula OF control_alu is

begin

  process (funct7, funct3, ulaOp, auipcIn)
  begin

    case ulaOp is

      when "00" =>
        case funct3 is
          when "000" =>
            if funct7 = '0' then
              opOut <= "0000";  -- ADD
            else
              opOut <= "0001";  -- SUB
            end if;
          when "001" => opOut <= "0101";  -- SLL
          when "010" => opOut <= "1000";  -- SLT
          when "011" => opOut <= "1001";  -- SLTU
          when "100" => opOut <= "0100";  -- XOR
          when "101" =>
            if funct7 = '0' then
              opOut <= "0110";  -- SRL
            else
              opOut <= "0111";  -- SRA
            end if;
          when "110" => opOut <= "0011";  -- OR
          when "111" => opOut <= "0010";  -- AND
          when others => opOut <= "0000";
        end case;
      when "01" =>
        case funct3 is
          when "000" => opOut <= "0000";  -- ADDi
          when "001" => opOut <= "0101";  -- SLLi
          when "010" => opOut <= "1000";  -- SLTi
          when "011" => opOut <= "1001";  -- SLTUi
          when "100" => opOut <= "0100";  -- XORi
          when "101" =>
            if funct7 = '0' then
              opOut <= "0110";  -- SRLi
            else
              opOut <= "0111";  -- SRAi
            end if;
          when "110" => opOut <= "0011";  -- ORi
          when "111" => opOut <= "0010";  -- ANDi
          when others => opOut <= "0000";
        end case;
      when "10" =>
        case funct3 is
          when "000" => opOut <= "1100";  -- BEQ
          when "001" => opOut <= "1101";  -- BNE
          when "100" => opOut <= "1000";  -- BLT
          when "101" => opOut <= "1010";  -- BGE
          when others => opOut <= "0000";
        end case;
      when "11" =>
        if auipcIn = '0' then
          opOut <= "1110";  -- LUi
        else
          opOut <= "1111";  -- AUiPC
        end if;
      when others => opOut <= "0000";

    end case;

  end process;

end arch_control_ula;
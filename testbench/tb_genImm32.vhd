library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Para teste 

entity testbench is 
end entity testbench;

architecture arch_genImm32_teste of testbench is
component genImm32
	port (
		instr : in std_logic_vector(31 downto 0);
		imm32: out signed(31 downto 0));
end component;

signal entrada: std_logic_vector (31 downto 0);
signal saida: signed(31 downto 0);

begin
	teste: genImm32 port map (entrada,saida);
process begin 

	entrada <= x"000002b3"; wait for 5 ns;
	if (saida = 0) then report "Tipo R- executado com sucesso" severity note;
	else report "Tipo R- executado com erro" severity error;
	end if;

	
	entrada <= x"01002283"; wait for 5 ns;
	if (saida = 16) then report "Tipo I- executado com sucesso" severity note;
	else report "Tipo I- executado com erro" severity error;
	end if;

	entrada <= x"f9c00313"; wait for 5 ns;
	if (saida = -100) then report "Tipo I- executado com sucesso" severity note;
	else report "Tipo I- executado com erro" severity error;
	end if;
	
	
	entrada <= x"fff2c293"; wait for 5 ns;
	if (saida = -1) then report "Tipo I- executado com sucesso" severity note;
	else report "Tipo I- executado com erro" severity error;
	end if;

	
	entrada <= x"16200313"; wait for 5 ns;
	if (saida = 354) then report "Tipo I- executado com sucesso" severity note;
	else report "Tipo I- executado com erro" severity error;
	end if;
	
	
	entrada <= x"01800067"; wait for 5 ns;
	if (saida = 24) then report "Tipo I- executado com sucesso" severity note;
	else report "Tipo I- executado com erro" severity error;
	end if;


	entrada <= x"00002437"; wait for 5 ns;
	if (saida = 2000) then report "Tipo U- executado com sucesso" severity note;
	else report "Tipo U- executado com erro" severity error;
	end if;

	
	entrada <= x"02542e23"; wait for 5 ns;
	if (saida = 60) then report "Tipo S- executado com sucesso" severity note;
	else report "Tipo S- executado com erro" severity error;
	end if;

	
	entrada <= x"fe5290e3"; wait for 5 ns;
	if (saida = -32) then report "Tipo SB- executado com sucesso" severity note;
	else report "Tipo SB- executado com erro" severity error;
	end if;
	

	entrada <= x"00c000ef"; wait for 5 ns;
	if (saida = 12) then report "Tipo UJ- executado com sucesso" severity note;
	else report "Tipo UJ- executado com erro" severity error;
	end if;	
wait;
end process;

end arch_genImm32_teste;

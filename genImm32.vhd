library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity genImm32 is 
	port(
		instr : in std_logic_vector(31 downto 0); -- 32
		result_imm: out std_logic_vector(31 downto 0));
end genImm32;
	   
architecture arch_genImm32 of genImm32 is
-- Para receber os sinais
	-- Vector recebe 20 bits no type UJ e U
	signal vector : std_logic_vector(19 downto 0); -- 20 bits
	-- Todos os sinais tem que retornar 32 bits
	signal Result : std_logic_vector(31 downto 0); -- 32

-- Iniciando a arquitetura 
begin
	-- vector tera o bit mais significativo
	vector <= (others => instr(31));
	-- Tipos de imediatos 
	-- Tipo R recebe 0 de [31:12] [11:7] => rd e [6:0] x = opcode 0x33
	-- Result eh convertido em um sinal do tipo unsigned
		Result <= (31 downto 0 => '0') when unsigned (instr( 6 downto 0)) = x"33" else -- Tipo R
		vector & instr(31 downto 20) when unsigned(instr(6 downto 0))=x"03" or unsigned(instr(6 downto 0))=x"13" or unsigned (instr(6 downto 0))=x"67" else -- Tipo I
		vector & instr(31 downto 25) & instr(11 downto 7) when unsigned (instr(6 downto 0))=x"23" else -- Tipo S
	 	vector & instr(7) & instr(30 downto 25) & instr(11 downto 8) & '0'  when unsigned(instr(6 downto 0))=x"63" else -- Tipo SB
		vector(11 downto 0) & instr(19 downto 12) & instr(20) & instr(30 downto 21) & '0' when unsigned(instr(6 downto 0))=x"37" else -- Tipo U
		instr (31 downto 12) &  "000000000000" when unsigned (instr(6 downto 0))=x"6F" else -- Tipo UJ
		instr;

-- O imediato recebe o sinal que eh obtido de n

Result <= result_imm;


-- Finaliza a arquitetura	
end arch_genImm32;

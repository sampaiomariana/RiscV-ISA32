library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- Memória RAM 
-- Memória de dados
entity mem_rv is
	generic (n: integer := 8 ; size: natural := 32);
	port (
		clock: in std_logic;
		we: in std_logic; -- (sinal de habilitação de escrita wren write-enable)
		address: in std_logic_vector(n-1 downto 0);
		datain : in std_logic_vector(size - 1 downto 0);
		dataout: out std_logic_vector(size - 1 downto 0)
	);
end entity mem_rv;

architecture arch_memram of mem_rv is

type mem_type is array (0 to (2**address' length)-1) of std_logic_vector (datain' range);
signal mem: mem_type;
signal read_address: std_logic_vector(address'range);
--  memória inicializando em x"00000000"
signal mem_ram: mem_type := (
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",-- mem 10
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",-- mem 20
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",
	x"00000000",-- mem 30
	x"00000000" );
begin 
write : process (clock) begin
	if we = '1' then
		mem(to_integer(unsigned(address))) <= datain;
	end if;
	read_address <= address;
	end process;
dataout <= mem(to_integer(unsigned(read_address)));

end arch_memram;
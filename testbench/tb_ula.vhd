library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
	generic (WSIZE : natural := 32);
end ula_tb;

architecture tb_arch of ula_tb is
component ula is 
	port (
		opcode: in std_logic_vector(3 downto 0);
		A,B: in std_logic_vector(WSIZE-1 downto 0);
		Z: out std_logic_vector(WSIZE-1 downto 0);
		zero: out std_logic
		);
end component;
--Separando os sinais de acordo com as suas saídas da porta
-- signal 
signal A,B,Z : std_logic_vector(WSIZE-1 downto 0);
signal opcode: std_logic_vector(3 downto 0);
signal zero: std_logic;
	
begin 

DUT: ula port map (A,B,Z,opcode,zero);

process
	begin
	--soma 
	A <= X"00000005";
	B <= X"00000005";
	opcode <= "0000";
	wait for 1 ns;

	--subtração 
	A <= X"00000005";
	B <= X"00000005";
	opcode <= "0001";
	wait for 1 ns;

	--AND
	A <= X"000000F0";
	B <= X"0000000F";
	opcode <= "0010";
	wait for 1 ns;
	
	--OR 
	A <= X"000000F0";
	B <= X"0000000F";
	opcode <= "0011";
	wait for 1 ns;

	--xor 
	A <= X"000000F0";
	B <= X"000000FF";
	opcode <= "0100";
	wait for 1 ns;

	--sll
	A <= X"00000005";
	B <= X"00000001";
	opcode <= "0101";
	wait for 1 ns;

	--srl
	A <= X"00000005";
	B <= X"00000001";
	opcode <= "0110";
	wait for 1 ns;

	--sra
	A <= X"FFFF0000";
	B <= X"0000FFFF";
	opcode <= "0111";
	wait for 1 ns;

	--slt 
	A <= X"00000000";
	B <= X"0000FFFF";
	opcode <= "1000";
	wait for 1 ns;
	
	--sltu 
	A <= X"00000000";
	B <= X"0000FFFF";
	opcode <= "1001";
	wait for 1 ns;
	
	--sge
	A <= X"0000000a";
	B <= X"00000005";
	opcode <= "1010";
	wait for 1 ns;

	--sgeu
	A <= X"00000005";
	B <= X"0000000a";
	opcode <= "1011";
	wait for 1 ns;

	--seq
	A <= X"0000000a";
	B <= X"0000000a";
	opcode <= "1100";
	wait for 1 ns;

	--sne
	A <= X"0000000a";
	B <= X"00000005";
	opcode <= "1101";
	wait for 1 ns;
	
	assert false report "Test done." severity note;
	wait;
end process;
end tb_arch;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ulaRV is	
	generic (WSIZE : natural := 32);
	port (
		opcode: in std_logic_vector (3 downto 0);
		A,B: in std_logic_vector(WSIZE-1 downto 0);
		Z: out std_logic_vector(WSIZE-1 downto 0);
		zero: out std_logic
		);
	
end entity ulaRV;

architecture ula of ulaRV is
--sinal interno
signal aux: std_logic_vector(WSIZE-1 downto 0);
constant zero_k: std_logic_vector := X"0000";

begin
	Z <= aux;
	

aux <=  std_logic_vector(signed(A) + signed(B)) when opcode = "0000" else -- ADD
	std_logic_vector(signed(A) - signed(B)) when opcode = "0001" else -- SUB
	(A and B) when opcode = "0010" else -- AND
	(A or B) when opcode = "0011" else -- OR
	(A xor B) when opcode = "0100" else -- XOR
	std_logic_vector(unsigned(A) sll to_integer(unsigned(B))) when opcode = "0101" else -- SLL
	std_logic_vector(unsigned(A) srl to_integer(unsigned(B))) when opcode = "0110" else -- SRL	
	std_logic_vector(SHIFT_RIGHT(signed(A), to_integer(unsigned(B)))) when opcode = "0111" else -- SRA
	aux & '1' when opcode = "1000" and (signed(A) < signed(B)) else -- SLT
	aux & '1' when opcode = "1001" and (unsigned(A) < unsigned(B)) else -- SLTU
	aux & '1' when opcode = "1010" and (signed(A) >= signed(B)) else -- SGE
	aux & '1' when opcode = "1011" and (unsigned(A) <= unsigned(B)) else -- SGEU
	aux & '1' when opcode = "1100" and (unsigned(A) = unsigned(B)) else -- SEQ
	aux & '1' when opcode = "1101" and (unsigned(A) /= unsigned(B)) else -- SNE

	zero_k & '0';
	zero <= '1' when signed(aux)= 0 else '0';

end ula;
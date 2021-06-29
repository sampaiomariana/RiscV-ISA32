library ieee;
library std;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;

entity testbench_RiscV_processor is
end;

architecture testbench_RiscV_processor_arch of  testbench_RiscV_Processor  is

  signal clock : std_logic;
  signal instruction : std_logic_vector(31 downto 0);
  signal rs1 : std_logic_vector(31 downto 0);
  signal rs2 : std_logic_vector(31 downto 0);
  signal rd : std_logic_vector(31 downto 0);
  signal immediate : std_logic_vector(31 downto 0);

  component RiscV_processor
    port (
      clock : in std_logic;
      instruction :out std_logic_vector(31 downto 0);
      rs1 :out std_logic_vector(31 downto 0);
      rs2 :out std_logic_vector(31 downto 0);
      rd :out std_logic_vector(31 downto 0);
      immediate :out std_logic_vector(31 downto 0));
  end component ;

begin

  DUT : RiscV_processor
    port MAP (
      clock => clock,
      instruction => instruction,
      rs1 => rs1,
      rs2 => rs2,
      rd => rd,
      immediate => immediate);

  process
  begin

    
    clock <= '0';
    WAIT FOR 1 ns;
    clock <= '1';
    WAIT FOR 1 ns;

    
    
    clock <= '0';
    WAIT FOR 1 ns;
    clock <= '1';
    WAIT FOR 1 ns;



    
    clock <= '0';
    WAIT FOR 1 us;
    clock <= '1';
    WAIT FOR 1 us;

    
    clock <= '0';
    WAIT FOR 1 ns;
    clock <= '1';
    WAIT FOR 1 ns;

    
    
    clock <= '0';
    WAIT FOR 1 ns;
    clock <= '1';
    WAIT FOR 1 ns;



    
    clock <= '0';
    WAIT FOR 1 us;
    clock <= '1';
    WAIT FOR 1 us;

    
    
    clock <= '0';
    WAIT FOR 1 ns;
    clock <= '1';
    WAIT FOR 1 ns;

    
    
    clock <= '0';
    WAIT FOR 1 ns;
    clock <= '1';
    WAIT FOR 1 ns;



    
    clock <= '0';
    WAIT FOR 1 us;
    clock <= '1';
    WAIT FOR 1 us;

    
    
    clock <= '0';
    WAIT FOR 1 ns;
    clock <= '1';
    WAIT FOR 1 ns;

    
    
    clock <= '0';
    WAIT FOR 1 ns;
    clock <= '1';
    WAIT FOR 1 ns;



    
    clock <= '0';
    WAIT FOR 1 us;
    clock <= '1';
    WAIT FOR 1 us;

    
    
    clock <= '0';
    WAIT FOR 1 ns;
    clock <= '1';
    WAIT FOR 1 ns;

    
    
    clock <= '0';
    WAIT FOR 1 ns;
    clock <= '1';
    WAIT FOR 1 ns;



    
    clock <= '0';
    WAIT FOR 1 us;
    clock <= '1';
    WAIT FOR 1 us;

    
    
    clock <= '0';
    WAIT FOR 1 ns;
    clock <= '1';
    WAIT FOR 1 ns;

    
    
    clock <= '0';
    WAIT FOR 1 ns;
    clock <= '1';
    WAIT FOR 1 ns;



    
    clock <= '0';
    WAIT FOR 1 us;
    clock <= '1';
    WAIT FOR 1 us;

    
    
    clock <= '0';
    WAIT FOR 1 ns;
    clock <= '1';
    WAIT FOR 1 ns;

    
    
    clock <= '0';
    WAIT FOR 1 ns;
    clock <= '1';
    WAIT FOR 1 ns;



    
    clock <= '0';
    WAIT FOR 1 us;
    clock <= '1';
    WAIT FOR 1 us;

    
    
  




    report "RiscV_processor done" SEVERITY NOTE;
    WAIT;
  end process;
end;
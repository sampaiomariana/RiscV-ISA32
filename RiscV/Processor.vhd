library ieee;
use ieee.std_logic_1164.all;

library work;

entity RiscV_Processor is
  port (
    clock : in std_logic;
    instruction : out std_logic_vector(31 downto 0);
    rs1 : out std_logic_vector(31 downto 0);
    rs2 : out std_logic_vector(31 downto 0);
    rd : out std_logic_vector(31 downto 0);
    immediate : out std_logic_vector(31 downto 0));
end RiscV_Processor;

architecture arch_processor of RiscV_Processor is




-- mem
signal instruction_signal : std_logic_vector(31 downto 0);
-- immgen
signal immout_signal : std_logic_vector(31 downto 0);
-- alu
signal Ain_signal : std_logic_vector(31 downto 0);
signal Bin_signal : std_logic_vector(31 downto 0);
signal Zout_signal : std_logic_vector(31 downto 0);
signal zeroout_signal : std_logic;
signal aluOP_signal : std_logic_vector(1 downto 0);
signal aluOPout_signal : std_logic_vector(3 downto 0);
-- control
signal branch_signal : std_logic;
signal memToReg_signal : std_logic;
signal memRead_signal : std_logic;
signal memWrite_signal : std_logic;
signal auipc_signal : std_logic;
signal aluSrc_signal : std_logic;
signal jal_signal : std_logic;
signal regWrite_signal : std_logic;
-- pc
signal addr_in_signal : std_logic_vector(31 downto 0);
signal rst_signal : std_logic := '0';
signal addr_out_signal : std_logic_vector(31 downto 0);
-- adders
signal adderout_signal : std_logic_vector(31 downto 0);
signal adder4out_signal : std_logic_vector(31 downto 0);

signal write_data_signal : std_logic_vector(31 downto 0);
signal rs1_signal : std_logic_vector(31 downto 0);
signal rs2_signal : std_logic_vector(31 downto 0);

signal data_out_signal : std_logic_vector(31 downto 0);

signal adder_in1_signal : std_logic_vector(31 downto 0);

signal write_or_jal_signal : std_logic_vector(31 downto 0);







component genImm32
  port (
    instr : in std_logic_vector(31 downto 0); 
    result_imm : out std_logic_vector(31 downto 0));
end component;

component control_alu
  port (
    ulaOp : in std_logic_vector(1 downto 0);
    funct7 : in std_logic;
    auipcin : in std_logic;
    funct3 : in std_logic_vector(2 downto 0);
    opout : out std_logic_vector(3 downto 0));
end component;

component control
  port (
    op : in std_logic_vector(6 downto 0);
    branch : out std_logic;
    memRead : out std_logic;
    memToReg : out std_logic;
    auipc : out std_logic;
    jal : out std_logic;
    aluOp : out std_logic_vector (1 downto 0);
    memWrite : out std_logic;
    aluSrc : out std_logic;
    regWrite : out std_logic);
end component;

component mux2_32bits
  port (
    Sel : in std_logic;
    A : in std_logic_vector(31 downto 0);
    B : in std_logic_vector(31 downto 0);
    Result : out std_logic_vector(31 downto 0));
end component;

component mux2_5bits
  port (
    Sel : in std_logic;
    A : in std_logic_vector(4 downto 0);
    B : in std_logic_vector(4 downto 0);
    Result : out std_logic_vector(4 downto 0));
end component;

component adder
  port (
    A : in std_logic_vector(31 downto 0);
    B : in std_logic_vector(31 downto 0);
    Z : out std_logic_vector(31 downto 0));
end component;

component adder4
  port (
    A : in std_logic_vector(31 downto 0);
    Z : out std_logic_vector(31 downto 0));
end component;

component pc
  port (
    addr_in : in std_logic_vector(31 downto 0);
    rst : in std_logic;
    clk : in std_logic;
    addr_out : out std_logic_vector(31 downto 0));
end component;

component ula
  port (
    opcode : in std_logic_vector(3 downto 0);
    A: in std_logic_vector(31 downto 0);
    B : in std_logic_vector(31 downto 0);
    Z : out std_logic_vector(31 downto 0);
    zero : out std_logic);
end component;

component mem_reg
  port (
    clock : in std_logic;
    we : in std_logic;
    address1x : in std_logic_vector(4 downto 0);
    address2x : in std_logic_vector(4 downto 0);
    write_address : in std_logic_vector(4 downto 0);
    data_in : in std_logic_vector(31 downto 0);
    data1_out : out std_logic_vector(31 downto 0);
    data2_out : out std_logic_vector(31 downto 0));
end component;

component mem_data
  port (
    clock : in std_logic;
    we : in std_logic;
    re : in std_logic;
    address : in std_logic_vector(11 downto 0);
    data_in : in std_logic_vector(31 downto 0);
    data_out : out std_logic_vector(31 downto 0));
end component;

component mem_rom
  port (
    address: in std_logic_vector(11 downto 0);
  	data_out: out std_logic_vector(31 downto 0));
end component;







begin
  rst_signal <= '0';

  control_inst01 : control
  port map (
    op => instruction_signal(6 downto 0),
    aluOp => aluOp_signal,
    branch => branch_signal,
    memToReg => memToReg_signal,
    memWrite => memWrite_signal,
    auipc => auipc_signal,
    jal => jal_signal,
    memRead => memRead_signal,
    aluSrc => aluSrc_signal,
    regWrite => regWrite_signal);

  genImm_inst02 : genImm32
  port map (
    instr => instruction_signal,
    result_imm => immout_signal);

  alu_inst03 : ula
  port map (
    opcode => aluOPout_signal,
    A => Ain_signal,
    B => Bin_signal,
    Z => Zout_signal,
    zero => zeroout_signal);

  control_alu_inst04 : control_alu
  port map (
    ulaOp => aluOp_signal,
    funct7 => instruction_signal(30),
    auipcIn => auipc_signal,
    funct3 => instruction_signal(14 downto 12),
    opout => aluOPout_signal);

  pc_inst05 : pc
  port map (
    addr_in => addr_in_signal,
    rst => rst_signal,
    clk => clock,
    addr_out => addr_out_signal);

  adder_inst06 : adder
  port map (
    A => adder_in1_signal,
    B => immout_signal,
    Z => adderout_signal);

  adder4_inst07 : adder4
  port map (
    A => addr_out_signal,
    Z => adder4out_signal);

  -- mux A
  -- muxA_inst08 : mux2_32bits
  -- port map (
  -- Sel => branch_signal AND (jal_signal OR zeroout_signal),
  -- A => adder4out_signal,
  -- B => adderout_signal,
  -- Result => addr_in_signal);

  -- mux B
  muxB_inst09 : mux2_32bits
  port map (
    Sel => aluSrc_signal,
    A => rs2_signal,
    B => immout_signal,
    Result => Bin_signal);

  -- mux C
  muxC_inst10 : mux2_32bits
  port map (
    Sel => memToReg_signal,
    A => Zout_signal,
    B => data_out_signal,
    Result => write_data_signal);

  -- mux D
  muxD_inst11 : mux2_32bits
  port map (
    Sel => auipc_signal,
    A => rs1_signal,
    B => addr_out_signal,
    Result => Ain_signal);

  -- mux G
  -- muxG_inst14 : mux2_32bits
  -- port map (
  --   Sel => jal_signal AND NOT(instruction_signal(3)),
  --   A => addr_out_signal,
  --   B => rs1_signal,
  --   Result => adder_in1_signal);

  -- mux H
  -- muxH_inst15 : mux2_32bits
  -- port map (
  --   Sel => jal_signal AND instruction_signal(3),
   --  A => write_data_signal,
   --  B => adder4out_signal,
   --  Result => write_or_jal_signal);

  mem_reg_inst16 : mem_reg
  port map (
    clock => clock,
    we => regWrite_signal,
    address1x => instruction_signal(19 downto 15),
    address2x => instruction_signal(24 downto 20),
    write_address => instruction_signal(11 downto 7),
    data_in => write_or_jal_signal,
    data1_out => rs1_signal,
    data2_out => rs2_signal);

  mem_data_inst17 : mem_data
  port map (
    clock => clock,
    we => memWrite_signal,
    re => memRead_signal,
    address => Zout_signal(11 downto 0),
    data_in => rs2_signal,
    data_out => data_out_signal);

  mem_instr_inst18 : mem_rom
  port map (
    address => addr_out_signal(11 downto 0),
    data_out => instruction_signal);

  instruction <= instruction_signal;
  rs1 <= rs1_signal;
  rs2 <= rs2_signal;
  rd <= write_data_signal;
  immediate <= immout_signal;

end arch_processor;
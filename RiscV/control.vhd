library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;

entity control is
  port (
    op : in std_logic_vector(6 downto 0);
    branch : out std_logic;  -- Ligado caso haja uma instrucao de branch
    memRead : out std_logic;  -- Permite a escrita na memoria
    memToReg : out std_logic;  -- O valor que vem da memoria de dados para se escrita no registrador
    auipc : out std_logic;
    jal : out std_logic;
    aluOp : out std_logic_vector (1 downto 0);  -- 2 bits da aluOp
    memWrite : out std_logic;  -- Permite a escrita na memoria
    aluSrc : out std_logic;  -- Se a segunda entrada na ula vira do imediato ou nao
    regWrite : out std_logic);  -- Permite escrever na memoria de registradores
end control;

architecture arch_control of control is

signal op_signal : std_logic_vector (6 downto 0);
signal branch_signal : std_logic;
signal memRead_signal : std_logic;
signal memToReg_signal : std_logic;
signal aluOp_signal : std_logic_vector(1 downto 0);
signal memWrite_signal : std_logic;
signal aluSrc_signal : std_logic;
signal auipc_signal : std_logic;
signal jal_signal : std_logic;
signal regWrite_signal : std_logic;

begin

  op_signal <= op;
  branch <= branch_signal;
  memRead <= memRead_signal;
  memToReg <= memToReg_signal;
  aluOp <= aluOp_signal;
  auipc <= auipc_signal;
  jal <= jal_signal;
  memWrite <= memWrite_signal;
  aluSrc <= aluSrc_signal;
  regWrite <= regWrite_signal;

process (op_signal)
  begin

    case op_signal is

      -- tipo R
      when "0110011" =>
        branch_signal <= '0';
        memRead_signal <= '0';
        memToReg_signal <= '0';
        memWrite_signal <= '0';
        auipc_signal <= '0';
        jal_signal <= '0';
        regWrite_signal <= '1';
        aluSrc_signal <= '0';
        aluOp_signal <= "00";

      -- tipo I
      when "0010011" =>
        branch_signal <= '0';
        memRead_signal <= '0';
        memToReg_signal <= '0';
        memWrite_signal <= '0';
        auipc_signal <= '0';
        jal_signal <= '0';
        regWrite_signal <= '1';
        aluSrc_signal <= '1';
        aluOp_signal <= "01";

      -- Branches
      when "1100011" =>
        branch_signal <= '1';
        memRead_signal <= '0';
        memToReg_signal <= '0';
        memWrite_signal <= '0';
        auipc_signal <= '0';
        jal_signal <= '0';
        regWrite_signal <= '0';
        aluSrc_signal <= '0';
        aluOp_signal <= "10";

      -- LW
      when "0000011" =>
        branch_signal <= '0';
        memRead_signal <= '1';
        memToReg_signal <= '1';
        memWrite_signal <= '0';
        auipc_signal <= '0';
        jal_signal <= '0';
        regWrite_signal <= '1';
        aluSrc_signal <= '1';
        aluOp_signal <= "11";

      -- SW
      when "0100011" =>
        branch_signal <= '0';
        memRead_signal <= '0';
        memToReg_signal <= '0';
        memWrite_signal <= '1';
        auipc_signal <= '0';
        jal_signal <= '0';
        regWrite_signal <= '0';
        aluSrc_signal <= '1';
        aluOp_signal <= "11";

      -- LUi
      when "0110111" =>
        branch_signal <= '0';
        memRead_signal <= '0';
        memToReg_signal <= '0';
        memWrite_signal <= '0';
        auipc_signal <= '0';
        jal_signal <= '0';
        regWrite_signal <= '1';
        aluSrc_signal <= '1';
        aluOp_signal <= "11";

      -- AUiPC
      when "0010111" =>
        branch_signal <= '0';
        memRead_signal <= '0';
        memToReg_signal <= '0';
        memWrite_signal <= '0';
        auipc_signal <= '1';
        jal_signal <= '0';
        regWrite_signal <= '1';
        aluSrc_signal <= '1';
        aluOp_signal <= "11";

      -- JAL
      when "1101111" =>
        branch_signal <= '1';
        memRead_signal <= '0';
        memToReg_signal <= '0';
        memWrite_signal <= '0';
        auipc_signal <= '0';
        jal_signal <= '1';
        regWrite_signal <= '1';
        aluSrc_signal <= '1';
        aluOp_signal <= "11";

      -- JALR
      when "1100111" =>
        branch_signal <= '1';
        memRead_signal <= '0';
        memToReg_signal <= '0';
        memWrite_signal <= '0';
        auipc_signal <= '0';
        jal_signal <= '1';
        regWrite_signal <= '0';
        aluSrc_signal <= '1';
        aluOp_signal <= "11";

      when others =>
        branch_signal <= '0';
        memRead_signal <= '0';
        memToReg_signal <= '0';
        jal_signal <= '0';
        aluOp_signal <= "00";
        memWrite_signal <= '0';
        auipc_signal <= '0';
        aluSrc_signal <= '0';
        regWrite_signal <= '0';

    end case;
  end process;

end arch_control;
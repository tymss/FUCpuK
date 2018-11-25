----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:40:02 11/23/2018 
-- Design Name: 
-- Module Name:    CPU - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.DEFINES.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU is
	Port ( 
	clk : in STD_LOGIC;
	rst : in STD_LOGIC;
	struct_ins_stall : in STD_LOGIC;   --取指令阶段结构冲突暂停流水
	ins_in : in STD_LOGIC_VECTOR (15 downto 0);	--取到的指令
	ram_data_in : in STD_LOGIC_VECTOR (15 downto 0);  --访存得到的数据
	ins_addr : out STD_LOGIC_VECTOR (15 downto 0);	--指令地址
	ram_addr_out : out STD_LOGIC_VECTOR (15 downto 0);  --访存地址
	ram_memR : out STD_LOGIC;
	ram_memW : out STD_LOGIC;
	ram_data_out : out STD_LOGIC_VECTOR (15 downto 0)  --需要写入内存的数据
	);
end CPU;

architecture Behavioral of CPU is

	component PCReg
		Port ( 
		PCin : in  STD_LOGIC_VECTOR (15 downto 0);
		clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		stall_hazard : in  STD_LOGIC;
		stall_structure : in  STD_LOGIC;
		PCout : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;

	component Adder
		Port (
		rst : in STD_LOGIC;
	   oper_1 : in  STD_LOGIC_VECTOR (15 downto 0);
		oper_2 : in  STD_LOGIC_VECTOR (15 downto 0);
		output : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component IF_ID
		Port (
		clk : in  STD_LOGIC;
      rst : in  STD_LOGIC;
      if_pc : in  STD_LOGIC_VECTOR (15 downto 0);
		if_ins : in  STD_LOGIC_VECTOR (15 downto 0); 
		stall_structure : in  STD_LOGIC;
		stall_hazard : in  STD_LOGIC;
		b_flush : in  STD_LOGIC;
		id_pc : out  STD_LOGIC_VECTOR (15 downto 0);
		id_ins : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;

	component Decoder
		Port (
		rst : in  STD_LOGIC;
		ins : in  STD_LOGIC_VECTOR (15 downto 0);
		reg1 : out  STD_LOGIC_VECTOR (3 downto 0);
		reg2 : out  STD_LOGIC_VECTOR (3 downto 0);
		aluOp : out  STD_LOGIC_VECTOR (2 downto 0);
		imm : out  STD_LOGIC_VECTOR (15 downto 0);
		regDst : out  STD_LOGIC_VECTOR (3 downto 0);
		aluSel : out  STD_LOGIC;
		memR : out  STD_LOGIC;
		memW : out  STD_LOGIC;
		regW : out  STD_LOGIC;
		TW : out STD_LOGIC;
		b_cont : out  STD_LOGIC_VECTOR (2 downto 0));
	end component;
	
	component RegFile
		Port ( 
		clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		Reg1Addr : in  STD_LOGIC_VECTOR (3 downto 0);
		Reg2Addr : in  STD_LOGIC_VECTOR (3 downto 0);
		RegWrite : in  STD_LOGIC;
		WriteAddr : in  STD_LOGIC_VECTOR (3 downto 0);
		WriteData : in  STD_LOGIC_VECTOR (15 downto 0);
		PCin : in  STD_LOGIC_VECTOR (15 downto 0);
		Reg1Data : out  STD_LOGIC_VECTOR (15 downto 0);
		Reg2Data : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component ID_EXE
		Port (
		clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		flush_structure : in  STD_LOGIC;
		flush_hazard : in  STD_LOGIC;
		id_reg1 : in  STD_LOGIC_VECTOR (15 downto 0);
		id_reg2 : in  STD_LOGIC_VECTOR (15 downto 0);
		id_reg1addr : in  STD_LOGIC_VECTOR (3 downto 0);
		id_reg2addr : in  STD_LOGIC_VECTOR (3 downto 0);
		id_imm : in  STD_LOGIC_VECTOR (15 downto 0);
		id_regDst : in  STD_LOGIC_VECTOR (3 downto 0);
		id_aluSel : in  STD_LOGIC;
		id_memR : in  STD_LOGIC;
		id_memW : in  STD_LOGIC;
		id_regW : in  STD_LOGIC;
		id_TW : in STD_LOGIC; 
		id_aluOp : in  STD_LOGIC_VECTOR (2 downto 0);
		exe_reg1 : out  STD_LOGIC_VECTOR (15 downto 0);
		exe_reg2 : out  STD_LOGIC_VECTOR (15 downto 0);
		exe_reg1addr : out  STD_LOGIC_VECTOR (3 downto 0);
		exe_reg2addr : out  STD_LOGIC_VECTOR (3 downto 0);
		exe_regDst : out  STD_LOGIC_VECTOR (3 downto 0);
		exe_imm : out  STD_LOGIC_VECTOR (15 downto 0);
		exe_aluSel : out  STD_LOGIC;
		exe_aluOp : out  STD_LOGIC_VECTOR (2 downto 0);
		exe_memR : out  STD_LOGIC;
		exe_memW : out  STD_LOGIC;
		exe_regW : out  STD_LOGIC;
		exe_TW : out STD_LOGIC);
	end component;
	
	component ALU
		Port ( 
		ALUop : in  STD_LOGIC_VECTOR (2 downto 0);
		rst : in  STD_LOGIC;
		oper_1 : in  STD_LOGIC_VECTOR (15 downto 0);
		oper_2 : in  STD_LOGIC_VECTOR (15 downto 0);
		ALUflag : out  STD_LOGIC;
		ALUout : out STD_LOGIC_VECTOR (15 downto 0));
	end component;

	component TReg
		Port ( 
		Twrite : in  STD_LOGIC;
		clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		Tin : in  STD_LOGIC;
		Tout : out  STD_LOGIC);
	end component;
	
	component EXE_MEM
		Port ( 
		rst : in  STD_LOGIC;
      clk : in  STD_LOGIC;
		exe_aluResult : in  STD_LOGIC_VECTOR (15 downto 0);
		exe_reg2 : in  STD_LOGIC_VECTOR (15 downto 0);
		exe_regDst : in  STD_LOGIC_VECTOR (3 downto 0);
		exe_memW : in  STD_LOGIC;
		exe_memR : in  STD_LOGIC;
		exe_regW : in  STD_LOGIC;
		mem_aluResult : out  STD_LOGIC_VECTOR (15 downto 0);
		mem_reg2 : out  STD_LOGIC_VECTOR (15 downto 0);
		mem_regDst : out  STD_LOGIC_VECTOR (3 downto 0);
		mem_memW : out  STD_LOGIC;
		mem_memR : out  STD_LOGIC;
		mem_regW : out  STD_LOGIC);     
	end component;

	component MEM
		Port ( 
		rst : in  STD_LOGIC;
		memR_in : in STD_LOGIC;
		memW_in : in STD_LOGIC;
		mem_addr_in : in STD_LOGIC_VECTOR (15 downto 0);
		mem_data_in : in STD_LOGIC_VECTOR (15 downto 0);
		memR_out : out STD_LOGIC;
		memW_out : out STD_LOGIC;
		mem_addr_out : out STD_LOGIC_VECTOR (15 downto 0);
		mem_data_out : out STD_LOGIC_VECTOR (15 downto 0));
	end component;

	component MEM_WB
		Port ( 
		clk : in  STD_LOGIC;
		rst : in  STD_LOGIC;
		mem_regW : in 	STD_LOGIC;
		mem_memR : in 	STD_LOGIC; 
		mem_aluResult : in  STD_LOGIC_VECTOR (15 downto 0);
		mem_regDst : in  STD_LOGIC_VECTOR (3 downto 0);
		mem_readData : in  STD_LOGIC_VECTOR (15 downto 0);
		wb_regW : out  STD_LOGIC;
		wb_memR : out 	STD_LOGIC;
		wb_aluResult : out  STD_LOGIC_VECTOR (15 downto 0);
		wb_regDst : out  STD_LOGIC_VECTOR (3 downto 0);
		wb_readData : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;
	
	component Mux2
		Port ( 
		sel : in  STD_LOGIC;
		input0 : in  STD_LOGIC_VECTOR (15 downto 0);
		input1 : in  STD_LOGIC_VECTOR (15 downto 0);
		output : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;

	component Mux3
		Port (
		sel : in  STD_LOGIC_VECTOR (1 downto 0);
		input0 : in  STD_LOGIC_VECTOR (15 downto 0);
		input1 : in  STD_LOGIC_VECTOR (15 downto 0);
		input2 : in  STD_LOGIC_VECTOR (15 downto 0);
		output : out  STD_LOGIC_VECTOR (15 downto 0));
	end component;

	component BranchControl
		Port ( 
		rst : in  STD_LOGIC;
		b_op : in  STD_LOGIC_VECTOR (2 downto 0);
		Tdata : in  STD_LOGIC;
		RegData : in  STD_LOGIC_VECTOR (15 downto 0);
		sel : out  STD_LOGIC_VECTOR (1 downto 0);
		jump : out STD_LOGIC);
	end component;

	component Forward
		Port ( 
		rst : in  STD_LOGIC;
		src_addr : in  STD_LOGIC_VECTOR (3 downto 0);
		regW1 : in  STD_LOGIC;
		regW2 : in  STD_LOGIC;
		reg_dst1 : in  STD_LOGIC_VECTOR (3 downto 0);
		reg_dst2 : in  STD_LOGIC_VECTOR (3 downto 0);
		sel : out  STD_LOGIC_VECTOR (1 downto 0));
	end component;

	component Hazard
		Port ( 
		rst : in  STD_LOGIC;
		reg1addr : in  STD_LOGIC_VECTOR (3 downto 0);
		reg2addr : in  STD_LOGIC_VECTOR (3 downto 0);
		exe_memR : in  STD_LOGIC;
		regDst : in  STD_LOGIC_VECTOR (3 downto 0);
		flush : out  STD_LOGIC;
		stall_pc : out  STD_LOGIC;
		stall_if_id : out  STD_LOGIC);
	end component;
	
	signal ifid_h_stall : std_logic;  --hazard信号
	signal pc_h_stall : std_logic;
	signal idexe_h_flush : std_logic;

   signal pc_in : std_logic_vector (15 downto 0);	
	signal pc_out : std_logic_vector (15 downto 0);	
	signal if_pc : std_logic_vector (15 downto 0);
	
	signal b_jump : std_logic;
	signal b_cont : std_logic_vector (2 downto 0);
	signal b_f_sel : std_logic_vector (1 downto 0);
	signal b_f_out : std_logic_vector (15 downto 0);
	signal b_rx : std_logic_vector (15 downto 0);
	signal b_last_lw : std_logic;
	signal b_target_sel : std_logic_vector (1 downto 0);
	
	signal id_pc : std_logic_vector (15 downto 0);
	signal id_ins : std_logic_vector (15 downto 0);
	signal id_reg1addr : std_logic_vector (3 downto 0);
	signal id_reg2addr : std_logic_vector (3 downto 0);
	signal id_regDst : std_logic_vector (3 downto 0);
	signal id_aluop : std_logic_vector (2 downto 0);
	signal id_imm : std_logic_vector (15 downto 0);
	signal id_alusel : std_logic;
	signal id_memR : std_logic;
	signal id_memW : std_logic;
	signal id_regW : std_logic;
	signal id_TW : std_logic;
	
	signal pc_imm : std_logic_vector (15 downto 0);
	signal id_reg1 : std_logic_vector (15 downto 0);
	signal id_reg2 : std_logic_vector (15 downto 0);
	
	signal exe_reg1 : std_logic_vector (15 downto 0);
	signal exe_reg2 : std_logic_vector (15 downto 0);
	signal exe_reg1addr : std_logic_vector (3 downto 0);
	signal exe_reg2addr : std_logic_vector (3 downto 0);
	signal exe_regdst : std_logic_vector (3 downto 0);
	signal exe_imm : std_logic_vector (15 downto 0);
	signal exe_alusel : std_logic;
	signal exe_aluop : std_logic_vector (2 downto 0);
	signal exe_memR : std_logic;
	signal exe_memW : std_logic;
	signal exe_regW : std_logic;
	signal exe_TW : std_logic;
	signal alusel_out : std_logic_vector (15 downto 0);
	
	signal alu_sel1 : std_logic_vector (1 downto 0);
	signal alu_sel2 : std_logic_vector (1 downto 0);
	signal aluoper1 : std_logic_vector (15 downto 0);
	signal aluoper2 : std_logic_vector (15 downto 0);
	signal aluflag : std_logic;
	signal exe_aluout : std_logic_vector (15 downto 0);
	signal exe_Tout : std_logic;
	
	signal mem_aluout : std_logic_vector (15 downto 0);
	signal mem_regW : std_logic;
	signal mem_regdst : std_logic_vector (3 downto 0);
	signal mem_reg2 : std_logic_vector (15 downto 0);
	signal mem_memW : std_logic;
	signal mem_memR : std_logic;
	
	signal wb_regW : std_logic;
	signal wb_memR : std_logic;
	signal wb_addr : std_logic_vector (3 downto 0);
	signal wb_aluout : std_logic_vector (15 downto 0);
	signal wb_readdata : std_logic_vector (15 downto 0);
	signal wb_data : std_logic_vector (15 downto 0);
	
begin
		
	ins_addr <= pc_out;	
	
	pc_reg : PCReg	port map(PCin=>pc_in, clk=>clk, rst=>rst, stall_hazard=>pc_h_stall, 
									stall_structure=>struct_ins_stall, PCout=>pc_out);
	
	pc_adder : Adder port map(rst=>rst, oper_1=>pc_out, oper_2=>OneData, output=>if_pc);
	
	if_id_reg : IF_ID port map(clk=>clk, rst=>rst, if_pc=>if_pc, if_ins=>ins_in, 
										stall_structure=>struct_ins_stall, stall_hazard=>ifid_h_stall,
										b_flush=>b_jump, id_pc=>id_pc, id_ins=>id_ins);
	
	id_decoder : Decoder port map(rst=>rst, ins=>id_ins, reg1=>id_reg1addr, reg2=>id_reg2addr,
											aluOp=>id_aluop, imm=>id_imm, regDst=>id_regDst, aluSel=>id_alusel,
											memR=>id_memR, memW=>id_memW, regW=>id_regW, TW=>id_TW, b_cont=>b_cont);
	
	pc_imm_adder : Adder port map(rst=>rst, oper_1=>id_pc, oper_2=>id_imm, output=>pc_imm);
	
	id_regfile : RegFile port map(clk=>clk, rst=>rst, Reg1Addr=>id_reg1addr, Reg2Addr=>id_reg2addr,
											RegWrite=>wb_regW, WriteAddr=>wb_addr, WriteData=>wb_data, PCin=>id_pc,
											Reg1Data=>id_reg1, Reg2Data=>id_reg2);
											
	id_exe_reg : ID_EXE port map(clk=>clk, rst=>rst, flush_structure=>struct_ins_stall, flush_hazard=>idexe_h_flush,
										  id_reg1=>id_reg1, id_reg2=>id_reg2, id_reg1addr=>id_reg1addr, id_reg2addr=>id_reg2addr,
										  id_imm=>id_imm, id_regDst=>id_regDst, id_aluSel=>id_alusel, id_memR=>id_memR, 
										  id_memW=>id_memW, id_regW=>id_regW, id_TW=>id_TW, id_aluOp=>id_aluop, exe_reg1=>exe_reg1,
										  exe_reg2=>exe_reg2, exe_reg1addr=>exe_reg1addr, exe_reg2addr=>exe_reg2addr, exe_regDst=>exe_regdst,
										  exe_imm=>exe_imm, exe_aluSel=>exe_alusel, exe_aluOp=>exe_aluop, exe_memR=>exe_memR, exe_memW=>exe_memW,
										  exe_regW=>exe_regW, exe_TW=>exe_TW);
	
	aluselector : Mux2 port map(sel=>exe_alusel, input0=>exe_reg2, input1=>exe_imm, output=>alusel_out);
	
	forward1 : Forward port map(rst=>rst, src_addr=>exe_reg1addr, regW1=>mem_regW, regW2=>wb_regW, reg_dst1=>mem_regdst,
										 reg_dst2=>wb_addr, sel=>alu_sel1);
	
	forward2 : Forward port map(rst=>rst, src_addr=>exe_reg2addr, regW1=>mem_regW, regW2=>wb_regW, reg_dst1=>mem_regdst,
										 reg_dst2=>wb_addr, sel=>alu_sel2);
	
	aluoper1_sel : Mux3 port map(sel=>alu_sel1, input0=>exe_reg1, input1=>mem_aluout, input2=>wb_data, output=>aluoper1);
	
	aluoper2_sel : Mux3 port map(sel=>alu_sel2, input0=>alusel_out, input1=>mem_aluout, input2=>wb_data, output=>aluoper2);
	
	exe_alu : ALU port map(ALUop=>exe_aluop, rst=>rst, oper_1=>aluoper1, oper_2=>aluoper2, ALUflag=>aluflag, ALUout=>exe_aluout);

	t_reg : TReg port map(Twrite=>exe_TW, clk=>clk, rst=>rst, Tin=>aluflag, Tout=>exe_Tout);
	
	exe_mem_reg : EXE_MEM port map(rst=>rst, clk=>clk, exe_aluResult=>exe_aluout, exe_reg2=>exe_reg2, exe_regDst=>exe_regdst,
											 exe_memW=>exe_memW, exe_memR=>exe_memR, exe_regW=>exe_regW, mem_aluResult=>mem_aluout,
											 mem_reg2=>mem_reg2, mem_regDst=>mem_regdst, mem_memW=>mem_memW, mem_memR=>mem_memR, mem_regW=>mem_regW);
											 
	mem_delay : MEM port map(rst=>rst, memR_in=>mem_memR, memW_in=>mem_memW, mem_addr_in=>mem_aluout, mem_data_in=>mem_reg2,
									 memR_out=>ram_memR, memW_out=>ram_memW, mem_addr_out=>ram_addr_out, mem_data_out=>ram_data_out);

	mem_wb_reg : MEM_WB port map(clk=>clk, rst=>rst, mem_regW=>mem_regW, mem_memR=>mem_memR, mem_aluResult=>mem_aluout, mem_regDst=>mem_regdst,
										  mem_readData=>ram_data_in, wb_regW=>wb_regW, wb_memR=>wb_memR, wb_aluResult=>wb_aluout, wb_regDst=>wb_addr, 
										  wb_readData=>wb_readdata);

   wb_selector : Mux2 port map(sel=>wb_memR, input0=>wb_aluout, input1=>wb_readdata, output=>wb_data);

	hazard_controller : Hazard port map(rst=>rst, reg1addr=>id_reg1addr, reg2addr=>id_reg2addr, exe_memR=>exe_memR, 
													regDst=>exe_regdst, flush=>idexe_h_flush, stall_pc=>pc_h_stall, stall_if_id=>ifid_h_stall);
	
	branch_forward : Forward port map(rst=>rst, src_addr=>id_reg1addr, regW1=>exe_regW, regW2=>mem_regW, reg_dst1=>exe_regdst,
	                                  reg_dst2=>mem_regdst, sel=>b_f_sel);
	
	b_rx_mux3 : Mux3 port map(sel=>b_f_sel, input0=>id_reg1, input1=>exe_aluout, input2=>mem_aluout, output=>b_f_out);
	
	b_rx_mux2 : Mux2 port map(sel=>b_last_lw, input0=>b_f_out, input1=>ram_data_in, output=>b_rx);
	
	branch_controller : BranchControl port map(rst=>rst, b_op=>b_cont, Tdata=>exe_Tout, RegData=>b_rx, sel=>b_target_sel,
															 jump=>b_jump);
															 
	b_target_mux3 : Mux3 port map(sel=>b_target_sel, input0=>id_pc, input1=>pc_imm, input2=>b_rx, output=>pc_in);
	
	process(mem_memR, mem_regdst, id_reg1addr)
	begin
		if ((mem_memR = '1') and (mem_regdst = id_reg1addr) and (id_reg1addr /= ZeroAddr)) then
			b_last_lw <= '1';
		else
			b_last_lw <= '0';
		end if;
	end process;
		
end Behavioral;


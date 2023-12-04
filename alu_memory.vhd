LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_textio.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;
USE std.textio.ALL;
ENTITY alu_memory IS
    PORT (
        clk : IN STD_LOGIC;
        src1_data : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        io_read : IN STD_LOGIC;
        io_write : IN STD_LOGIC;
        push : IN STD_LOGIC;
        pop : IN STD_LOGIC;
        RTI : IN STD_LOGIC;
        RET : IN STD_LOGIC;
        call : IN STD_LOGIC;
        memory_read : IN STD_LOGIC;
        memory_write : IN STD_LOGIC;
        write_back : IN STD_LOGIC;
        reg_dest : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        result_alu : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
        flags_alu : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        EA : IN STD_LOGIC_VECTOR (19 DOWNTO 0);

        out_write_back : OUT STD_LOGIC;
        out_reg_dest : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        out_result_alu : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        out_flags_alu : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        out_io_read : OUT STD_LOGIC;
        out_io_write : OUT STD_LOGIC;
        out_push : OUT STD_LOGIC;
        out_pop : OUT STD_LOGIC;
        out_RTI : OUT STD_LOGIC;
        out_RET : OUT STD_LOGIC;
        out_call : OUT STD_LOGIC;
        out_memory_read : OUT STD_LOGIC;
        out_memory_write : OUT STD_LOGIC;
        out_EA : OUT STD_LOGIC_VECTOR (19 DOWNTO 0);
        out_src1_data : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE arch_alu_memory OF alu_memory IS
BEGIN
    decode_alu_p : PROCESS (clk)
    BEGIN
        IF clk'event AND clk = '1'THEN
            out_write_back <= write_back;
            out_reg_dest <= reg_dest;
            out_result_alu <= result_alu;
            out_io_read <= io_read;
            out_io_write <= io_write;
            out_push <= push;
            out_pop <= pop;
            out_RTI <= RTI;
            out_RET <= RET;
            out_call <= call;
            out_memory_read <= memory_read;
            out_memory_write <= memory_write;
            out_EA <= EA;
            out_src1_data <= src1_data;
            out_flags_alu <= flags_alu;
            END IF;
        END PROCESS;

    END ARCHITECTURE;
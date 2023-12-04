USE work.reg.ALL;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY write_back IS
    PORT (
        clk : IN STD_LOGIC;
        memory_read : IN STD_LOGIC;
        write_back : IN STD_LOGIC;
        -- registers : INOUT registers_block(0 TO 7)(31 DOWNTO 0);
        dest_address : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        data_alu : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        data_memory : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        dataout : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
     
        -- out_registers : OUT registers_block(0 TO 7)(31 DOWNTO 0)
    );
END ENTITY;
ARCHITECTURE arch_write_back OF write_back IS
BEGIN
    -- write_back_unit : PROCESS (clk)

    -- BEGIN

    -- out_registers <= registers;
    -- IF  clk = '1' THEN

    --     IF (write_back = '1') THEN
    --         IF (memory_read = '1') THEN
    --             dataout <= data_memory;
    --         ELSE
    --             dataout <= data_alu;
    --         END IF;

    --     END IF;
    -- END IF;
    dataout <= data_memory WHEN memory_read = '1'
        ELSE
        data_alu;
    -- END PROCESS;
END ARCHITECTURE;
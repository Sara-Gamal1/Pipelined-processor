USE work.my_pkg.ALL;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_textio.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.numeric_std.ALL;
USE std.textio.ALL;

ENTITY data_memory IS
    PORT (
        clk : IN STD_LOGIC;
        we1 : IN STD_LOGIC;
        we2 : IN STD_LOGIC;
        re1 : IN STD_LOGIC;
        re2 : IN STD_LOGIC;
        address : IN STD_LOGIC_VECTOR(11 DOWNTO 0);
        datain1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        stack_memory : IN STD_LOGIC;
        datain2 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        dataout1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
        dataout2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0')
    );
END ENTITY;

ARCHITECTURE arch_data_memory OF data_memory IS
    SIGNAL one : STD_LOGIC_VECTOR(31 DOWNTO 0) := (0 => '1', OTHERS => '0');
    SIGNAL two : STD_LOGIC_VECTOR(31 DOWNTO 0) := (1 => '1', OTHERS => '0');
    SIGNAL three : STD_LOGIC_VECTOR(31 DOWNTO 0) := (0 => '1', 1 => '1', OTHERS => '0');
    SIGNAL ram : memory_array(0 TO 3)(15 DOWNTO 0);
    SIGNAL initial_flag : STD_LOGIC := '1';
BEGIN

    data_memory : PROCESS (clk) IS
        FILE memory_file : text OPEN read_mode IS "data.txt";
        VARIABLE file_line : line;
        VARIABLE temp_data : STD_LOGIC_VECTOR(15 DOWNTO 0);
    BEGIN
        IF (initial_flag = '1') THEN
            FOR i IN ram'RANGE LOOP
                IF NOT endfile(memory_file) THEN
                    readline(memory_file, file_line);
                    read(file_line, temp_data);
                    ram(i) <= temp_data;
                ELSE
                    file_close(memory_file);

                END IF;
            END LOOP;
            initial_flag <= '0';

        ELSIF clk'event AND clk = '0' THEN
            --stack 
            IF stack_memory = '1' THEN
                IF we2 = '1' THEN
                    ram(to_integer(unsigned(address - one))) <= datain2(31 DOWNTO 16);
                    ram(to_integer(unsigned(address))) <= datain2(15 DOWNTO 0);
                    ram(to_integer(unsigned(address - three))) <= datain1(31 DOWNTO 16);
                    ram(to_integer(unsigned(address - two))) <= datain1(15 DOWNTO 0);

                ELSIF we1 = '1' THEN
                    ram(to_integer(unsigned(address - one))) <= datain1(31 DOWNTO 16);
                    ram(to_integer(unsigned(address))) <= datain1(15 DOWNTO 0);

                ELSIF re2 = '1' THEN
                    dataout1 <= ram(to_integer(unsigned(address - one))) & ram(to_integer(unsigned(address - two)));
                    dataout2 <= ram(to_integer(unsigned(address - two - one))) & ram(to_integer(unsigned(address - two - two)));
                ELSIF re1 = '1' THEN
                    dataout1 <= ram(to_integer(unsigned(address - one))) & ram(to_integer(unsigned(address - two)));
                END IF;
                --memory
            ELSE
                IF we1 = '1' THEN
                    ram(to_integer(unsigned(address))) <= datain1(31 DOWNTO 16);
                    ram(to_integer(unsigned(address + one))) <= datain1(15 DOWNTO 0);

                ELSIF re1 = '1' THEN
                    dataout1 <= ram(to_integer(unsigned(address))) & ram(to_integer(unsigned(address + one)));
                END IF;
            END IF;
        END IF;

    END PROCESS data_memory;
END ARCHITECTURE;
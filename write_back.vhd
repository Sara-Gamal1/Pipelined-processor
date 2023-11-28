USE work.my_pkg1.ALL;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY write_back IS
    PORT (
        registers : INOUT register_array(0 TO 7)(31 DOWNTO 0);
        dest_address : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        data: IN STD_LOGIC_VECTOR(31 DOWNTO 0)
      
    );
END ENTITY;
ARCHITECTURE arch_write_back OF write_back IS

BEGIN
    registers(to_integer(unsigned(dest_address))) <= data;

END ARCHITECTURE;
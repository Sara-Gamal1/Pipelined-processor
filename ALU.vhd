Library ieee;
Use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use std.STANDARD.NATURAL;
use ieee.numeric_std.all;
--Entity B
entity alu IS
port (
src1,src2:IN std_logic_vector(31 downto 0);
ALU_signal:IN std_logic_vector (3 downto 0);
result: out std_logic_vector (31 downto 0);
flags:out std_logic_vector (3 downto 0)
);
end entity;

Architecture arch_alu of alu IS
signal one:std_logic_vector(31 downto 0);
signal zero:std_logic_vector(31 downto 0);
signal temp:std_logic_vector(31 downto 0);
begin 
zero<=(Others => '0');
one<=(0=>'1', Others => '0');
temp<=(to_integer(unsigned(src2))=>'1',Others=>'0');

result <= not src2 WHEN ALU_signal="0001" ELSE
    zero-src2 WHEN ALU_signal="0010" ELSE
    src2+one WHEN ALU_signal="0011" ELSE
    src2-one WHEN ALU_signal="0100" ELSE
    src1+src2 when ALU_signal="0110" ELSE
    src1-src2 when ALU_signal="0111" ELSE
    src1 and src2 when ALU_signal="1000" ELSE
    src1 OR src2 when ALU_signal="1001" ELSE
    src1 XOR src2 when ALU_signal="1010" ELSE
    src1 or temp  when  ALU_signal="1011" ELSE
    src2(0)&src2(31 downto 1)  when  ALU_signal="1101" ELSE
    src2(30 downto 0)&src2(31)  when  ALU_signal="1100";

end Architecture;







// Simple init
arch n64.cpu
endian msb
output "test.N64", create

fill $0010'1000 // Set ROM Size in hex

// 4096 B reserved for header (config etc)
// 1,048,576‬ B copied to ram on boot
// ‬leaving 1,052,672‬ B for me
// 1052672‬ Bytes = $00101000‬ in hex

origin $00000000
base $80000000
//useful for patcher

include "../LIB/N64.INC"
include "../LIB/N64_GFX.INC"
include "N64_Header.asm"
insert "../LIB/N64_BOOTCODE.BIN"

Start:	                 // NOTE: base $80001000
	lui t0, PIF_BASE     // t0 = $BFC0 << 16	
	addi t1, zero, 8	         // t1 = 0 + 8
	sw t1, PIF_CTRL(t0)  // 0xBFC007FC = 8	

Loop:  // while(true);
	j Loop
	nop
	
	

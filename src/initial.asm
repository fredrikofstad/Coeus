// Simple init
arch n64.cpu
endian msb
output "test.N64", create

fill $0010'1000 // Set ROM Size in hex

// 4096 B reserved for header (config etc)
// 1,048,576‬B copied to ram on boot
// leaving 1,052,672‬B for me
// 1052672‬bytes = $00101000‬ in hex

origin $00000000
base $80000000
//useful for patcher

//everything in asm is written to rom, inc is written as needed
include "../library/N64.INC"
include "../library/N64_GFX.INC"
include "N64_Header.asm"
insert "../library/N64_BOOTCODE.BIN"

//starts at $80001000
Start:	                 
	lui t0, PIF_BASE     
	// t0 = $BFC0 << 16	
	addi t1, zero, 8	         
	// t1 = 0 + 8
	sw t1, PIF_CTRL(t0)  
	// 0xBFC007FC = 8	

Loop:  // while(true) infinite
	j Loop
	nop
	
	

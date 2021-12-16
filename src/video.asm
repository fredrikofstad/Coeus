// Simple init
arch n64.cpu
endian msb
output "video.N64", create

fill $0010'1000 // Set ROM Size in hex

// 4096 B reserved for header (config etc)
// 1,048,576b copied to ram on boot
// leaving 1,052,672b for me
// 1052672 bytes = $0010 1000 in hex

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
	//needed to initialize
	lui t0, PIF_BASE     // t0 = $BFC0 << 16	
	addi t1, zero, 8	 // t1 = 0 + 8
	sw t1, PIF_CTRL(t0)  // 0xBFC007FC = 8	
	
	//video register init
	lui t0, VI_BASE
	
	li t1, BPP16
	sw t1, VI_STATUS(t0)
	
	li t1, $A000'0000
	sw t1, VI_ORIGIN(t0)
	
	li t1, $A000'0000
	sw t1, VI_ORIGIN(t0)
	
	li t1, $A000'0000
	sw t1, VI_ORIGIN(t0)
	
	li t1, $A000'0000
	sw t1, VI_ORIGIN(t0)
	
	

Loop:
	j Loop
	nop
	
	

.extern Pico
.extern PicoCramHigh
.extern HighCol
.extern cram_high
.extern PicoCpu
.extern PicoPad

.global TileNorm @ *pd (r0), addr (r1), *pal (r2)

TileNorm:
		stmfd   sp!, {r4, lr}			@backup of some registers
		ldr     r3, =(Pico+0x10000)
		lsl     r1, r1, #1
		add		r3, r3, r1
		ldr     r1, [r3]					@r1 now has pack
        cmp     r1, #0
        beq     .endifpackblank
@ifpack
		mov 	r4, r1
		and     r4, r4, #61440			@ AND 0x0000f000
		cmp     r4, #0
        beq     .endifbit5
@ifbit5
		lsr     r4, r4, #12				@shift left 12 bits
		lsl		r4, r4, #1
		add		r4, r4, r2
		ldrh    r4, [r4]				@r4 now has pal[x]
		strh    r4, [r0, #0]			@store with array index
.endifbit5:
		mov 	r4, r1
		and     r4, r4, #3840			@ AND 0x00000f00
		cmp     r4, #0
        beq     .endifbit6
@ifbit6
		lsr     r4, r4, #8				@shift left 8 bits
		lsl		r4, r4, #1
		add		r4, r4, r2
		ldrh    r4, [r4]				@r4 now has pal[x]
		strh    r4, [r0, #2]			@store with array index
.endifbit6:
		mov 	r4, r1
		and     r4, r4, #240			@ AND 0x000000f0
		cmp     r4, #0
        beq     .endifbit7
@ifbit7
		lsr     r4, r4, #4				@shift left 4 bits
		lsl		r4, r4, #1
		add		r4, r4, r2
		ldrh    r4, [r4]				@r4 now has pal[x]
		strh    r4, [r0, #4]			@store with array index
.endifbit7:
		mov 	r4, r1
		and     r4, r4, #15				@ AND 0x0000000f
		cmp     r4, #0
        beq     .endifbit8
@ifbit8
										@shift left 0 bits
		lsl		r4, r4, #1
		add		r4, r4, r2
		ldrh    r4, [r4]				@r4 now has pal[x]
		strh    r4, [r0, #6]			@store with array index
.endifbit8:
		mov 	r4, r1
		and     r4, r4, #-268435456		@ AND 0xf0000000
		cmp     r4, #0
        beq     .endifbit1
@ifbit1
		lsr     r4, r4, #28				@shift left 28 bits
		lsl		r4, r4, #1
		add		r4, r4, r2
		ldrh    r4, [r4]				@r4 now has pal[x]
		strh    r4, [r0, #8]			@store with array index
.endifbit1:
		mov 	r4, r1
		and     r4, r4, #251658240		@ AND 0x0f000000
		cmp     r4, #0
        beq     .endifbit2
@ifbit2
		lsr     r4, r4, #24				@shift left 24 bits
		lsl		r4, r4, #1
		add		r4, r4, r2
		ldrh    r4, [r4]				@r4 now has pal[x]
		strh    r4, [r0, #10]			@store with array index
.endifbit2:
		mov 	r4, r1
		and     r4, r4, #15728640		@ AND 0x00f00000
		cmp     r4, #0
        beq     .endifbit3
@ifbit3
		lsr     r4, r4, #20				@shift left 20 bits
		lsl		r4, r4, #1
		add		r4, r4, r2
		ldrh    r4, [r4]				@r4 now has pal[x]
		strh    r4, [r0, #12]			@store with array index
.endifbit3:
		mov 	r4, r1
		and     r4, r4, #983040			@ AND 0x000f0000
		cmp     r4, #0
        beq     .endifbit4
@ifbit4
		lsr     r4, r4, #16				@shift left 16 bits
		lsl		r4, r4, #1
		add		r4, r4, r2
		ldrh    r4, [r4]				@r4 now has pal[x]
		strh    r4, [r0, #14]			@store with array index
.endifbit4:		
		mov     r0, #0					@r0 contains OK return value
		ldmfd   sp!, {r4, r12}		@recovery of some registers
        bx      r12
.endifpackblank:
		mov     r0, #1					@r0 contains BLANK return value
		ldmfd   sp!, {r4, r12}		@recovery of some registers
        bx      r12


@-----------------------------------------------------------------------------------------------------
.global TileFlip @ *pd (r0), addr (r1), *pal (r2)

TileFlip:
		stmfd   sp!, {r4, lr}			@backup of some registers
		ldr     r3, =(Pico+0x10000)
		lsl     r1, r1, #1
		add		r3, r3, r1
		ldr     r1, [r3]					@r1 now has pack
        cmp     r1, #0
        beq     .endifpackblankf
@ifpackf
		mov 	r4, r1
		and     r4, r4, #61440			@ AND 0x0000f000
		cmp     r4, #0
        beq     .endifbit5f
@ifbit5f
		lsr     r4, r4, #12				@shift left 12 bits
		lsl		r4, r4, #1
		add		r4, r4, r2
		ldrh    r4, [r4]				@r4 now has pal[x]
		strh    r4, [r0, #14]			@store with array index
.endifbit5f:
		mov 	r4, r1
		and     r4, r4, #3840			@ AND 0x00000f00
		cmp     r4, #0
        beq     .endifbit6f
@ifbit6f
		lsr     r4, r4, #8				@shift left 8 bits
		lsl		r4, r4, #1
		add		r4, r4, r2
		ldrh    r4, [r4]				@r4 now has pal[x]
		strh    r4, [r0, #12]			@store with array index
.endifbit6f:
		mov 	r4, r1
		and     r4, r4, #240			@ AND 0x000000f0
		cmp     r4, #0
        beq     .endifbit7f
@ifbit7f
		lsr     r4, r4, #4				@shift left 4 bits
		lsl		r4, r4, #1
		add		r4, r4, r2
		ldrh    r4, [r4]				@r4 now has pal[x]
		strh    r4, [r0, #10]			@store with array index
.endifbit7f:
		mov 	r4, r1
		and     r4, r4, #15				@ AND 0x0000000f
		cmp     r4, #0
        beq     .endifbit8f
@ifbit8f
										@shift left 0 bits
		lsl		r4, r4, #1
		add		r4, r4, r2
		ldrh    r4, [r4]				@r4 now has pal[x]
		strh    r4, [r0, #8]			@store with array index
.endifbit8f:
		mov 	r4, r1
		and     r4, r4, #-268435456		@ AND 0xf0000000
		cmp     r4, #0
        beq     .endifbit1f
@ifbit1f
		lsr     r4, r4, #28				@shift left 28 bits
		lsl		r4, r4, #1
		add		r4, r4, r2
		ldrh    r4, [r4]				@r4 now has pal[x]
		strh    r4, [r0, #6]			@store with array index
.endifbit1f:
		mov 	r4, r1
		and     r4, r4, #251658240		@ AND 0x0f000000
		cmp     r4, #0
        beq     .endifbit2f
@ifbit2f
		lsr     r4, r4, #24				@shift left 24 bits
		lsl		r4, r4, #1
		add		r4, r4, r2
		ldrh    r4, [r4]				@r4 now has pal[x]
		strh    r4, [r0, #4]			@store with array index
.endifbit2f:
		mov 	r4, r1
		and     r4, r4, #15728640		@ AND 0x00f00000
		cmp     r4, #0
        beq     .endifbit3f
@ifbit3f
		lsr     r4, r4, #20				@shift left 20 bits
		lsl		r4, r4, #1
		add		r4, r4, r2
		ldrh    r4, [r4]				@r4 now has pal[x]
		strh    r4, [r0, #2]			@store with array index
.endifbit3f:
		mov 	r4, r1
		and     r4, r4, #983040			@ AND 0x000f0000
		cmp     r4, #0
        beq     .endifbit4f
@ifbit4f
		lsr     r4, r4, #16				@shift left 16 bits
		lsl		r4, r4, #1
		add		r4, r4, r2
		ldrh    r4, [r4]				@r4 now has pal[x]
		strh    r4, [r0, #0]			@store with array index
.endifbit4f:		
		mov     r0, #0					@r0 contains OK return value
		ldmfd   sp!, {r4, r12}		@recovery of some registers
        bx      r12
.endifpackblankf:
		mov     r0, #1					@r0 contains BLANK return value
		ldmfd   sp!, {r4, r12}		@recovery of some registers
        bx      r12
		
@-----------------------------------------------------------------------------------------------------
.global BackFill @ reg7 (r0)
BackFill:
    mov     r0, r0, lsl #26
    ldr     r1, =PicoCramHigh   @ r1=PicoCramHigh
    ldr     r1, [r1]
    add     r0, r1, r0, lsr #25 @ halfwords
    ldrh    r0, [r0]            @ back=PicoCramHigh[reg7&0x3f];
    orr     r0, r0, r0, lsl #16
	ldr		r1, =HighCol
	add		r2, r1, #64				@r2 now has pd (HighCol+32)
	add		r3, r1, #704			@r3 now has end (HighCol+32+320)
.do:
	str		r0, [r2]
	str		r0, [r2, #4]
	str		r0, [r2, #8]
	str		r0, [r2, #12]
	add		r2, #16
	cmp		r2, r3
	bne		.do

    bx      lr

@-----------------------------------------------------------------------------------------------------
.global UpdatePalette
UpdatePalette:
    stmfd   sp!, {r4-r5,lr}
	mov		r1, #0				@r1 = while condition
	b 		.checkwhile
.iniwhile:
	ldr     r2, =(Pico+0x22100)	@r2 = &Pico.cram
	mov		r3, r1, lsl #1
	add		r2, r2, r3			@r2 = &Pico.cram[i]
	ldrh    r2, [r2]			@r2 = Pico.cram[i] (value)
	lsl     r3, r2, #3
    and     r3, r3, #30720		@r3 = (r2 & 3840)<<3
	lsl     r4, r2, #2
    and     r4, r4, #960		@r4 = (r2 & 240)<<2
	lsl     r5, r2, #1
    and     r5, r5, #30			@r5 = (r2 & 15)<<1
	orr     r3, r3, #32768
	orr     r3, r3, r4
	orr     r3, r3, r5			@r3 = final value of cram
	ldr		r4, =(cram_high)	@r4 = &cram_high
	mov		r5, r1, lsl #1
	add		r4, r4, r5			@r4 = &cram_high[i]
	strh    r3, [r4]			@Saved final value of cram into &cram_high[i]
	add		r1, #1
.checkwhile:
	cmp		r1, #64
	bne 	.iniwhile
	ldmfd   sp!, {r4-r5,r12}
    bx      r12

@-----------------------------------------------------------------------------------------------------
.global PicoCheckPc				@ pc (r0)
PicoCheckPc:
	ldr		r3, =(PicoCpu+0x60)	@r3 = &PicoCpu.membase
	ldr		r1, [r3]			@r1 = PicoCpu.membase (value)
	sub		r0, r0, r1
	ldr		r1, =16777215
	and     r0, r0, r1
	ldr		r2, =(Pico+0x22200)	@pico.rom
	ldr		r2, [r2]
	and     r1, r0, #14680064
    cmp     r1, #14680064
	bne		.endif1pcp
	and		r1, r0, #16711680
	ldr		r2, =(Pico)			@pico.ram
	sub		r2, r2, r1	
.endif1pcp:
	str		r2, [r3]			@stored PicoCpu.membase
	add		r0, r0, r2			@return value = PicoCpu.membase + pc
    bx      lr

@-----------------------------------------------------------------------------------------------------
.global OtherRead16b				@ a (r0) [INCOMPLETE FUNCTION]
OtherRead16b:
	stmfd   sp!, {r4-r7,lr}
	ldr		r6, =16769024
	and		r1, r6, r0
	ldr		r6, =10485760
	cmp     r1, r6				@if ((a&0xffe000)==0xa00000)
	bne		.else1or16
	ldr		r6, =8191
	and		r1, r0, r6
	ldr		r2, =(Pico+0x20000) @Pico.zram
	add		r1, r1, r2
	ldr		r1, [r1]			@r1 = pico.zram+(a&0x1fff)
	ldr		r5, =(Pico+0x22208)	@r5 = &pico.m.rotate
	ldrb	r4, [r5]			@r4 = pico.m.rotate
	and		r2, r4, #2
	cmp		r2, #0x0
	beq		.endifA
	lsr     r2, r4, #2
	and		r2, r2, #255		@r2 = (pico.m.rotate>>2)&0xff; 
	lsl     r3, r2, #8
	orr		r2, r2, r3			@r2 = r2 | r2<<8;
.endifA:
	add		r2, r4, #1
	strb	r2, [r5]			@pico.m.rotate updated!
	b		.endif1or16
.else1or16:
	ldr		r6, =10502144
	cmp		r0, r6				@if (a==0xa04000)
	bne		.else2or16
	and		r2, r4, #3
	add		r6, r4, #1
	strb	r6, [r5]			@pico.m.rotate updated!
	b		.endif1or16
.else2or16:
	ldr		r6, =10551296
	cmp		r0, r6				@if (a==0xa10000)
	bne		.else3or16
	ldr		r2, =(Pico+0x2220F)	
	ldrb	r2, [r2]			@r2=pico.m.hardware
	b		.endif1or16	
.else3or16:
	ldr		r6, =10551298
	cmp		r0, r6				@if (a==0xa10002)
	bne		.else4or16
	ldr		r3, =(PicoPad)
	ldr		r3, [r3]
	mvn		r3, r3				@r3 = ~PicoPad[0]
	ldr		r6, =(Pico+0x2220A)
	ldrb	r6, [r6]			@r6 = pico.m.padTHPhase[0]
	cmp		r6, #0
	beq		.elseifB
	and		r2, r3, #63
	orr		r2, r2, #64			@r2 = 0x40|(pad&0x3f)
	b		.endif1or16
.elseifB:
	and		r2, r3, #3
	and		r3, r3, #192
	lsr		r3, r3, #2
	orr		r2, r2, r3			@r2=((pad&0xc0)>>2)|(pad&3);
	b		.endif1or16
.else4or16:
	ldr		r7, =10551300
	cmp		r0, r7				@if (a==0xa10004)
	bne		.else5or16
	ldr		r3, =(PicoPad+0x4)	
	ldr		r3, [r3]
	mvn		r3, r3				@r3 = ~PicoPad[1]
	ldr		r6, =(Pico+0x2220B)
	ldrb	r6, [r6]			@r6 = pico.m.padTHPhase[1]
	cmp		r6, #0
	beq		.elseifB2
	and		r2, r3, #63
	orr		r2, r2, #64			@r2 = 0x40|(pad&0x3f)
	b		.endif1or16
.elseifB2:
	and		r2, r3, #3
	and		r3, r3, #192
	lsr		r3, r3, #2
	orr		r2, r2, r3			@r2=((pad&0xc0)>>2)|(pad&3);
	b		.endif1or16
.else5or16:
	ldr		r6, =10555648
	cmp		r0, r6				@if (a==0xa11100)
	bne		.else6or16
	and		r2, r4, #4
	lsl		r2, r2, #6			@r2=((pico.m.rotate)&4)<<6;
	add		r3, r4, #1
	strb	r3, [r5]			@pico.m.rotate updated!
	b		.endif1or16
.else6or16:
	ldr		r6, =16777184
	and		r3, r0, r6	
	ldr		r6, =12582912
	cmp     r3, r6				@if ((a&0xffffe0)==0xc00000)
	bne		.endif1or16
	and		r3, r0, #28
	cmp		r3, #0
	bne		.elseifC1
	
	b		.endif1or16
.elseifC1:
	cmp		r3, #4
	bne		.elseifC2
	ldr		r2, =(Pico+0x22250)
	ldr		r2, [r2]			@r2 = pico.video.status
	ldr		r6, =13344
	orr     r2, r2, r6
	orr		r2, r2, #32
	ldrb	r6, [r5]
	and		r1, r6, #4
	cmp		r1, #0
	beq		.elserotate
	orr		r2, r2, #256
	b		.endifrotate
.elserotate:
	orr		r2, r2, #512
.endifrotate:
	and		r1, r6, #2
	cmp		r1, #0
	beq		.endifrotate2
	orr		r2, r2, #4
.endifrotate2:
	add		r6, r6, #1
	strb	r6, [r5]				@pico.m.rotate updated!
.elseifC2:
	and		r0, r0, #28
	cmp		r0, #8
	bne		.endif1or16
	ldr		r0, =(Pico+0x2220C)
	ldrh	r2, [r0]			@r2 = pico.m.scanline
	cmn		r2, #99
	blt		.elsescanline
	b		.endifscanline
.elsescanline:
	ldrb	r2, [r5]
	add		r2, r2, #1
	strb	r2, [r5]
	sub		r2, #1
.endifscanline:
	and     r2, r2, #255
	lsl     r2, r2, #8
	ldr		r3, =(PicoCpu+0x5C)
	ldr		r3, [r3]
	mov		r6, #500
	sub		r4, r6, r3
	lsr		r4, #1
	and		r4, #255
	orr		r2, r2, r4
.endif1or16:
	mov 	r0, r2				@r0 = return value
	ldmfd   sp!, {r4-r7,r12}
    bx      r12

@---------------------------------------------------------------------------
.global VideoRead
VideoRead:
	stmfd   sp!, {r2-r3,r6-r7,lr}
	ldr		r0, =(Pico+0x2224E)
	ldrh	r6, [r0]			@pico.video.addr;
	lsr		r0, r6, #1
	ldr		r3, =(Pico+0x2224D)
	ldrb	r3, [r3]			@pico.video.type
	cmp     r3, #0
	beq     .case1vr
	cmp     r3, #4
	beq     .case2vr
	cmp     r3, #8
	bne     .endcasevr
	and		r0, r0, #63
	lsl		r0, #1
	ldr		r2, =(Pico+0x22100)
	add		r2, r2, r0
	ldrh	r2, [r2]			@r2=pico.cram[a&0x003f]
	b		.endcasevr
.case1vr:
	ldr		r7, =32767
	and		r0, r0, r7
	lsl		r0, #1
	ldr		r2, =(Pico+0x10000)
	add		r2, r2, r0
	ldrh	r2, [r2]			@r2=pico.vram[a&0x7fff]
	b		.endcasevr
.case2vr:
	and		r0, r0, #63
	lsl		r0, #1
	ldr		r2, =(Pico+0x22180)
	add		r2, r2, r0
	ldrh	r2, [r2]			@r2=pico.vsram[a&0x003f]
.endcasevr:
	ldr		r3, =(Pico+0x22228)
	add		r3, r3, #15
	ldrb	r3, [r3]			@r3=pico.video.reg[0xF]
	add		r6, r6, r3
	ldr		r0, =(Pico+0x2224E)
	strh	r6, [r0]
	mov 	r0, r2
	ldmfd   sp!, {r2-r3,r6-r7,lr}
    bx      r12

@---------------------------------------------------------------------------
.global PicoVideoRead	@ unsigned int a (r0)
PicoVideoRead:
	stmfd   sp!, {r1-r5,lr}
	and		r1, r0, #0x1C		@r1 = a&0x1c
	cmp		r1, #0			
	bne		.else1pvr
	bl      VideoRead
	b		.endpvr
.else1pvr:
	cmp		r1, #0x04
	bne		.else2pvr
	ldr		r0, =(Pico+0x22250)	@pico.video.status
	ldr		r0, [r0]
	orr		r0, r0, #0x3400
	orr		r0, r0, #0x0020
	ldr		r4, =(Pico+0x22208)	@pico.m.rotate
	ldrb	r1, [r4]
	and		r2, r1, #4
	cmp		r2, #0
	beq		.elserotate4pvr
	orr		r0, r0, #0x0100
	b		.endrotate4pvr
.elserotate4pvr:
	orr		r0, r0, #0x0200
.endrotate4pvr:
	and 	r2, r1, #2
	beq		.endrotate2pvr
	orr		r0, r0, #0x0004
.endrotate2pvr:
	add		r1, r1, #1
	strb	r1, [r4]			@updated pico.m.rotate
	b		.endpvr
.else2pvr:
	and		r0, r0, #0x1C
	cmp		r0, #0x08
	bne		.endpvr
	ldr		r0, =(Pico+0x2220C)
	ldrh	r2, [r0]			@r2 = pico.m.scanline
	cmn		r2, #99
	blt		.elsescanlinepvr
	b		.endifscanlinepvr
.elsescanlinepvr:
	add		r2, r2, #1
	strb	r2, [r5]
	sub		r2, #1
	mov		r0, r2
.endifscanlinepvr:
	and		r0, r0, #0xFF
	lsl		r0, #8
	ldr		r3, =(PicoCpu+0x5C)	@picocpu.SelCycles
	ldr		r3, [r3]
	mov		r2, #500
	sub		r4, r2, r3
	lsr		r4, #1
	and		r4, #0xFF
	orr		r0, r0, r4
.endpvr:
	ldmfd   sp!, {r1-r5,r12}
    bx      r12

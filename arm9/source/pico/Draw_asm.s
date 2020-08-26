.extern Pico
.extern PicoCramHigh
.extern HighCol
.extern cram_high

.global TileNorm @ *pd (r0), addr (r1), *pal (r2)

TileNorm:
		stmfd   sp!, {r4-r9, lr}			@backup of some registers
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
		ldmfd   sp!, {r4-r9, r12}		@recovery of some registers
        bx      r12
.endifpackblank:
		mov     r0, #1					@r0 contains BLANK return value
		ldmfd   sp!, {r4-r9, r12}		@recovery of some registers
        bx      r12


@-----------------------------------------------------------------------------------------------------
.global TileFlip @ *pd (r0), addr (r1), *pal (r2)

TileFlip:
		stmfd   sp!, {r4-r9, lr}			@backup of some registers
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
		ldmfd   sp!, {r4-r9, r12}		@recovery of some registers
        bx      r12
.endifpackblankf:
		mov     r0, #1					@r0 contains BLANK return value
		ldmfd   sp!, {r4-r9, r12}		@recovery of some registers
        bx      r12
		
@-----------------------------------------------------------------------------------------------------
.global BackFill @ reg7 (r0)
BackFill:
    stmfd   sp!, {r4-r9,lr}
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

    ldmfd   sp!, {r4-r9,r12}
    bx      r12

@-----------------------------------------------------------------------------------------------------
.global UpdatePalette
UpdatePalette:
    stmfd   sp!, {r4-r9,lr}
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
	ldmfd   sp!, {r4-r9,r12}
    bx      r12

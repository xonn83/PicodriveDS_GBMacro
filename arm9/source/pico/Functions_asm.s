.extern Pico
.extern PicoCramHigh
.extern HighCol
.extern cram_high
.extern PicoCpu
.extern PicoPad
.extern Scanline
.extern rendstatus
.extern PicoOpt

@---------------------------------------------------------------------------------------------------
@old: TileNorm (r1=pdest, r2=pixels8, r3=pal) r0,r4: scratch
.global TileNorm		@ unsigned short pd (r0), int addr (r1), unsigned short pal (r2)

TileNorm:
	stmfd   sp!, {r1-r4, lr}			
	ldr     r3, =(Pico+0x10000)		@Pico.vram
	lsl     r1, r1, #1
	add		r3, r3, r1
	ldr     r4, [r3]				@r4 now has pack
	mov		r3, #0x1E				@in binary: 00011110
	cmp     r4, #0
	beq     .endifblank
    ands    r1, r3, r4, lsr #11 @ #0x0000f000
    ldrneh  r1, [r2, r1]
    strneh  r1, [r0]
    ands    r1, r3, r4, lsr #7  @ #0x00000f00
    ldrneh  r1, [r2, r1]
    strneh  r1, [r0,#2]
    ands    r1, r3, r4, lsr #3  @ #0x000000f0
    ldrneh  r1, [r2, r1]
    strneh  r1, [r0,#4]
    ands    r1, r3, r4, lsl #1  @ #0x0000000f
    ldrneh  r1, [r2, r1]
    strneh  r1, [r0,#6]
    ands    r1, r3, r4, lsr #27 @ #0xf0000000
    ldrneh  r1, [r2, r1]
    strneh  r1, [r0,#8]
    ands    r1, r3, r4, lsr #23 @ #0x0f000000
    ldrneh  r1, [r2, r1]
    strneh  r1, [r0,#10]
    ands    r1, r3, r4, lsr #19 @ #0x00f00000
    ldrneh  r1, [r2, r1]
    strneh  r1, [r0,#12]
    ands    r1, r3, r4, lsr #15 @ #0x000f0000
    ldrneh  r1, [r2, r1]
    strneh  r1, [r0,#14]
	mov     r0, #0				@r0 contains OK return value
	ldmfd   sp!, {r1-r4, r12}		
    bx      r12
.endifblank:
	mov     r0, #1				@r0 contains BLANK return value
	ldmfd   sp!, {r1-r4, r12}		
    bx      r12
	
@------------------------------------------------------------------------
.global TileFlip		@ unsigned short pd (r0), int addr (r1), unsigned short pal (r2)

TileFlip:
	stmfd   sp!, {r1-r4, lr}			
	ldr     r3, =(Pico+0x10000)		@Pico.vram
	lsl     r1, r1, #1
	add		r3, r3, r1
	ldr     r4, [r3]				@r4 now has pack
	mov		r3, #0x1E				@in binary: 00011110
	cmp     r4, #0
	beq     .endifblank2
    ands    r1, r3, r4, lsr #15 @ #0x000f0000
    ldrneh  r1, [r2, r1]
    strneh  r1, [r0]
	ands    r1, r3, r4, lsr #19 @ #0x00f00000
    ldrneh  r1, [r2, r1]
    strneh  r1, [r0,#2]
	ands    r1, r3, r4, lsr #23 @ #0x0f000000
    ldrneh  r1, [r2, r1]
    strneh  r1, [r0,#4]
	ands    r1, r3, r4, lsr #27 @ #0xf0000000
    ldrneh  r1, [r2, r1]
    strneh  r1, [r0,#6]
	ands    r1, r3, r4, lsl #1  @ #0x0000000f
    ldrneh  r1, [r2, r1]
    strneh  r1, [r0,#8]
	ands    r1, r3, r4, lsr #3  @ #0x000000f0
    ldrneh  r1, [r2, r1]
    strneh  r1, [r0,#10]
	ands    r1, r3, r4, lsr #7  @ #0x00000f00
    ldrneh  r1, [r2, r1]
    strneh  r1, [r0,#12]
	ands    r1, r3, r4, lsr #11 @ #0x0000f000
    ldrneh  r1, [r2, r1]
    strneh  r1, [r0, #14]
	mov     r0, #0				@r0 contains OK return value
	ldmfd   sp!, {r1-r4, r12}		
    bx      r12
.endifblank2:
	mov     r0, #1				@r0 contains BLANK return value
	ldmfd   sp!, {r1-r4, r12}		
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
	add		lr, r1, #64				@lr now has (HighCol[32])
	add		r12, r1, #704			@r12 now has (HighCol[32+320])
	mov     r1, r0
    mov     r2, r0
    mov     r3, r0
    mov     r4, r0
    mov     r5, r0
    mov     r6, r0
    mov     r7, r0
    mov     r8, r0
    mov     r9, r0
    stmia   lr!, {r0-r9}
    stmia   lr!, {r0-r9}
    stmia   lr!, {r0-r9}
    stmia   lr!, {r0-r9}
    stmia   lr!, {r0-r9}
    stmia   lr!, {r0-r9}
    stmia   lr!, {r0-r9}
    stmia   lr!, {r0-r9}
    stmia   lr!, {r0-r9}
    stmia   lr!, {r0-r9}
    stmia   lr!, {r0-r9}
    stmia   lr!, {r0-r9}
    stmia   lr!, {r0-r9}
    stmia   lr!, {r0-r9}
    stmia   lr!, {r0-r9}
    stmia   lr!, {r0-r9}
    ldmfd   sp!, {r4-r9,r12}
    bx      r12	
	
@-----------------------------------------------------------------------------------------------------
.global UpdatePalette
UpdatePalette:
	mov		r1, #0				@r1 = while condition
	push	{r4}
	ldr     r4, =(Pico+0x22100)	@r4 = &Pico.cram
.iniwhile:
	cmp		r1, #128
	beq 	.endwhile
	ldrh    r0, [r4, r1]		@r0 = Pico.cram[i] (value)
	lsl     r3, r0, #3
    and     r3, r3, #30720		@r3 = (r0 & 3840)<<3	
	orr     r3, r3, #32768	
	lsl     r2, r0, #2
    and     r2, r2, #960		@r2 = (r0 & 240)<<2	
	orr     r3, r3, r2	
	lsl     r2, r0, #1
    and     r2, r2, #30			@r2 = (r0 & 15)<<1	
	orr     r3, r3, r2			@r3 = final value of cram
	ldr		r2, =(cram_high)	@r2 = &cram_high
	add		r2, r2, r1			@r2 = &cram_high[i]
	strh    r3, [r2] 			@Saved final value of cram into &cram_high[i]
	add		r1, #2
	b		.iniwhile
.endwhile:
	pop		{r4}
    bx      lr

@-----------------------------------------------------------------------------------------------------
.global DrawSprite				@unsigned int *sprite (r0), int **hc (r1)
DrawSprite:
	stmfd   sp!, {r1-r9,lr}
	ldr		r2, [r0]			@sy = sprite[0] (r2)
	lsr		r3, r2, #24			@height = sy>>24 (r3)
	ldr		r9, =0x1FF
	and		r2, r2, r9
	sub		r2, r2, #0x80
	lsr		r4, r3, #2
	and		r4, r4, #3			@width = (height>>2)&3 (r4)
	and		r3, r3, #3
	add		r4, r4, #1
	add		r3, r3, #1
	ldr		r5, =(Scanline)
	ldr		r5, [r5]
	sub		r5, r5, r2			@row = Scanline - sy (r5) [r2 free]
	ldr		r6, [r0, #4]		@code = sprite[1] (r6)
	lsr		r7, r6, #16
	ldr		r9, =0x1FF
	and		r7, r7, r9
	ldr		r9, =0x78
	sub		r7, r7, r9			@sx = ((code>>16)&0x1ff)-0x78 (r7)
	ldr		r9, =0x7FF
	and		r8, r6, r9			@tile = code&0x7ff (r8)
	mov		r9, r3				@delta = height (r9)
	ands	r2, r6, #0x1000
	beq		.endif1ds
	lsl		r2, r3, #3			@ [r3 free]
	sub		r2, r2, #1
	sub		r5, r2, r5
.endif1ds:
	lsr		r2, r5, #3
	add		r8, r8, r2
	ands	r2, r6, #0x0800
	beq		.endif2ds
	sub		r2, r4, #1
	mul		r2, r9, r2
	add		r8, r8, r2
	rsb     r9, r9, #0			@invert value
.endif2ds:
	lsl		r8, r8, #4
	and		r2, r5, #7			@ [r5 free]
	lsl		r2, r2, #1
	add		r8, r8, r2
	ands	r2, r6, #0x8000
	beq		.elseif3ds
	lsl		r2, r8, #16
	and		r3, r6, #0x0800
	lsl		r3, r3, #5
	orr		r2, r2, r3
	lsl		r3, r7, #6
	ldr		r5, =0x0000ffc0
	and		r3, r3, r5
	orr		r2, r2, r3
	lsr		r3, r6, #9
	and		r3, r3, #0x30
	orr		r2, r2, r3
	ldr		r3, [r0]
	lsr		r3, r3, #24 
	and		r3, r3, #0xF
	orr		r2, r2, r3
	ldr		r5, [r1]			@r5 now has *hc
	str		r2, [r5]			@**hc updated
	add		r5, r5, #4
	str		r5, [r1]			@ [r5 is free]
	b 		.endif3ds
.elseif3ds:
	lsl		r9, r9, #4
	ldr 	r2, =PicoCramHigh
	ldr		r2, [r2]
	lsr		r3, r6, #9
	and		r3, r3, #0x30
	lsl		r3, r3, #1
	add		r2, r2, r3			@pal = PicoCramHigh+((code>>9)&0x30) (r2)
.iniwhileds:
	cmp		r4, #0
	beq		.endif3ds			@go to end
	cmp		r7, #0
	bgt		.endif4ds
	b		.endwhileds
.endif4ds:
	cmp		r7, #328
	blt		.endif5ds
	b		.endif3ds			@go to end if greater or equal
.endif5ds:
	ldr		r3, =0x7FFF
	and		r8, r8, r3
	ldr		r5, =HighCol
	mov		r0, r7
	add		r0, r0, #24
 	lsl		r0, r0, #1
	add		r0, r0, r5
	mov		r1, r8
	ands 	r3, r6, #0x0800 
	beq		.normds
	bl      TileFlip
	b		.endwhileds
.normds:
	bl      TileNorm
.endwhileds:					@update vars
	sub		r4, r4, #1
	add		r7, r7, #8
	add		r8, r8, r9
	b		.iniwhileds
.endif3ds:
	ldmfd   sp!, {r1-r9,r12}
    bx      r12

@-----------------------------------------------------------------------------------------------------
.global DrawAllSprites		@ int *hcache (r0), int maxwidth (r1)
DrawAllSprites:
	stmfd   sp!, {r1-r10,lr}
	str     fp, [sp, #-4]!
    mov     fp, sp
    sub     sp, sp, #88
	str		r0, [fp, #-4]		@we save *hcache on stack, offset -4 [r0 is free]
	str		r1, [fp, #-8]		@we save maxwitdth on stack offset -8 [r1 is free]
	mov		r2, #0				@link = 0 (r2)
	ldr		r3, =(Pico+0x22249)	@pico.video.reg[5]
	ldrb	r3, [r3]
	and		r3, r3, #0x7F		@table=Pico.video.reg[5]&0x7f (r3)
	ldr		r4, =(Pico+0x22256)	@pico.video.reg[12]
	ldrb	r4, [r4]
	ands	r4, r4, #1
	beq		.endif1das
	and		r3, r3, #0x7E
.endif1das:
	lsl		r3, r3, #8
	mov		r4, #0				@i = 0 (r4)
	mov		r5, #0 				@u = 0 (r5)
.iniwhile1das:
	cmp		r5, #80				@condition1 (u < 80)
	beq		.endwhile1das
	cmp		r4, #21				@condition2	(i < 21)
	beq		.endwhile1das
	lsl		r6, r2, #2 			@ r6 = link << 2
	add		r6, r6, r3			@ r6 = table + (link<<2)
	ldr		r0, =0x7FFC
	and		r6, r6, r0			@ r6 = (table + (link<<2)) & 0x7FFC
	lsl		r6, r6, #1			@ r6 = 0x(r6)0
	ldr		r7, =(Pico+0x10000)	@ r7 = Pico.vram
	add		r6, r6, r7			@ sprite=Pico.vram + offset[((table+(link<<2))&0x7ffc)] (r6)
	ldr		r7, [r6]			@ code=sprite[0] (r7)
	ldr		r0, =0x1FF
	and		r8, r7, r0
	sub		r8, r8, #0x80		@sy = (code&0x1ff)-0x80 (r8)
	lsr		r9, r7, #24
	and		r9, r9, #3
	add		r9, r9, #1
	lsl		r9, r9, #3			@height = (((code>>24)&3)+1)<<3 (r9)
	ldr		r10, =(Scanline)
	ldr		r10, [r10]
	cmp		r10, r8
	blt		.nextspritedas
	sub		r10, r10, r9		@ [r9 is free]
	cmp		r10, r8
	bge		.nextspritedas
	ldr		r9, [r6, #4]
	lsr		r9, r9, #16 
	ldr		r0, =0x1FF
	ands	r9, r9, r0			@sx = (sprite[1]>>16)&0x1ff (r9)
	bne		.else2das
	ldr		r0, =(rendstatus)
	ldr		r0, [r0]
	cmp		r0, #0
	bne		.endif3das
	sub		r4, r4, #1
	b		.endwhile1das
.else2das:
	cmp		r9, #1
	bne		.endif3das
	mov		r1, #1
	ldr		r0, =(rendstatus)
	ldr		r1, [r0]
.endif3das:
	sub		r9, r9,  #0x78
	cmn		r9, #23
	blt		.nextspritedas
	ldr		r1, [fp, #-8]		@load maxwidth from stack
	cmp		r9, r1
	bge		.nextspritedas	
	add		r0, sp, r4			@r0 = spin[i]
	strb	r2, [r0]
	add		r4, r4, #1
.nextspritedas:
	lsr		r2, r7, #16
	and		r2, r2, #0x7F
	cmp		r2, #0
	beq		.endwhile1das
	add		r5, r5, #1
	b		.iniwhile1das
.endwhile1das:
	sub		r4, r4, #1 
.iniwhile2das:
	cmp		r4, #0
	blt		.endwhile2das
	add		r0, sp, r4			@ r0 = &spin[i]
	ldrb	r0, [r0]			@ r0 = spin[i]
	lsl		r0, r0, #2 			@ r0 = spin[i] << 2
	add		r0, r0, r3 			@ r0 = table + (spin[i]<<2)
	ldr		r1, =0x7FFC
	and		r0, r0, r1			@ r0 = (table + (spin[i]<<2)) & 0x7ffc
	lsl		r0, r0, #1			@ 0x(r0)0
	ldr		r1, =(Pico+0x10000)	@ r1 = Pico.vram
	add		r0, r1, r0			@ r0 = Pico.vram + offset[((table+(spin[i]<<2))&0x7ffc)];
	sub		r1, fp, #4			@ r1 = **hcache
	bl		DrawSprite
	sub		r4, r4, #1 
	b 		.iniwhile2das
.endwhile2das:
	ldr		r1, [fp, #-4]		@r1 = *hcache
	mov		r0, #0
	str		r0, [r1]
	mov     sp, fp
    ldr     fp, [sp], #4
	ldmfd   sp!, {r1-r10,r12}
    bx      r12

@-----------------------------------------------------------------------------------------------------
.global DrawSpritesFromCache				@ int *hc (r0)
DrawSpritesFromCache:
		stmfd	sp!, {r4-r10,lr}
        mov 	r9, r0					@r9 = *hc
        b       .L2dsfc
.L10dsfc:
        ldr     r2, =PicoCramHigh
        ldr     r2, [r2]
        and     r3, r8, #48
        lsl     r3, r3, #1
        add     r2, r2, r3				@r2 = pal = PicoCramHigh + offset(code&0x30)
        and     r3, r8, #15				@r3 = delta
        asr     r4, r3, #2				@r4 = width
        and     r3, r3, #3
        add     r4, r4, #1
        add     r3, r3, #1
        and     r5, r8, #65536
        cmp     r5, #0
        beq     .L3dsfc
        rsb     r3, r3, #0
.L3dsfc:
        lsl     r3, r3, #4
        lsr     r1, r8, #17
        lsl     r1, r1, #1				@r1 = tile
        lsl     r6, r8, #16
        asr     r6, r6, #22				@r6 = sx
        b       .L4dsfc
.L9dsfc:
        cmp     r6, #0
        ble     .L6dsfc
        cmp     r6, #328
		bge		.L2dsfc
        lsl     r1, r1, #17
        lsr     r1, r1, #17
        and     r7, r8, #65536
        cmp     r7, #0
        beq     .L8dsfc
        add     r0, r6, #24
        lsl     r0, r0, #1
        ldr     r5, =HighCol
        add     r0, r0, r5
        bl      TileFlip
        b       .L6dsfc
.L8dsfc:
        add     r0, r6, #24
        lsl     r0, r0, #1
        ldr     r5, =HighCol
        add     r0, r0, r5
        bl      TileNorm
.L6dsfc:
        sub     r4, r4, #1
        add     r6, r6, #8
        add     r1, r1, r3
.L4dsfc:
        cmp     r4, #0
        bne     .L9dsfc
.L2dsfc:
        ldr		r8, [r9]			@r8 = code
		add     r9, r9, #4
        cmp     r8, #0
        bne     .L10dsfc
        ldmfd   sp!, {r4-r10,lr}
		bx      lr 

@-----------------------------------------------------------------------------------------------------
.global DrawStrip				@ TileStrip *ts (r0)
DrawStrip:
	stmfd   sp!, {r1-r10,lr}
	mov 	r4, r0				@r4 = ts	[r0 is free]
	mvn		r10, #0				@r10 = oldcode
	ldr		r8, [r4, #8]		@ts->hscroll
	rsb		r8, r8, #0
	asr		r8, r8, #3			@r8 = tilex
	ldr		r7, [r4, #4]		@ts->line
	and		r7, r7, #7
	lsl		r7, r7, #1			@r7 = ty
	ldr 	r6, [r4, #8]
	sub 	r6, r6, #1 
	and		r6, r6, #7 
	add 	r6, r6, #1 			@r6 = dx
	ldr		r5, [r4, #20]		@r5 = cells
	cmp		r6, #8
	beq		.iniwhile1strip
	add		r5, r5, #1
.iniwhile1strip:
	cmp		r5, #0
	beq		.endwhile1strip
	ldr		r3, [r4, #12]		@ts->xmask
	and		r3, r3, r8 
	ldr		r9, [r4]			@ts->nametab
	add		r3, r3, r9
	lsl		r3, r3, #1
	ldr		r9, =(Pico+0x10000)
	add		r3, r3, r9
	ldrh	r3, [r3]			@r3 = code
	cmp		r3, #0
	beq		.nextwhile1strip
	asr		r9, r3, #15
	cmp		r9, #0
	beq		.endif1strip
	lsl		r9, r6, #16
	orr		r9, r3, r9
	lsl		r1, r7, #25 
	orr		r9, r9, r1			@code | (dx<<16) | (ty<<25)
	ldr		r1, [r4, #16]
	str		r9, [r1]			@ts->hc = code | (dx<<16) | (ty<<25)
	add		r1, r1, #4
	str 	r1, [r4, #16]		@ts->hc++
	b 		.nextwhile1strip
.endif1strip:
	cmp		r3, r10
	beq		.endif2strip
	mov		r10, r3
	ldr		r9, =0x7FF
	and		r1, r3, r9
	lsl		r1, r1, #4 			@r1 = addr
	ands	r9, r3, #0x1000
	beq		.else3strip
	add		r1, r1, #14
	sub		r1, r1, r7
	b		.endif3strip
.else3strip:
	add		r1, r1, r7
.endif3strip:
	ldr     r2, =PicoCramHigh
	ldr     r2, [r2]
	asr     r9, r3, #9
	and     r9, r9, #0x30
	lsl     r9, r9, #1
	add     r2, r2, r9			@r2 = pal = PicoCramHigh + ((code>>9)&0x30);
.endif2strip:
	ldr		r9, =HighCol
	add		r0, r6, #24
	lsl		r0, r0, #1
	add		r0, r9, r0
	ands	r9, r3, #0x0800
	beq		.else4strip
	bl		TileFlip
	b 		.nextwhile1strip
.else4strip:
	bl		TileNorm
.nextwhile1strip:
	add		r6, r6, #8
	add		r8, r8, #1 
	sub		r5, r5, #1
	b		.iniwhile1strip
.endwhile1strip:
	mov		r1, #0
	ldr		r0, [r4, #16]
	str		r1, [r0]			@*ts->hc = 0
	ldmfd   sp!, {r1-r10,lr}
	bx      lr 
		
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
.global VideoRead
VideoRead:
	stmfd   sp!, {r2-r3,r6-r7,lr}
	ldr		r0, =(Pico+0x2226A)
	ldrh	r6, [r0]			@pico.video.addr;
	lsr		r0, r6, #1
	ldr		r3, =(Pico+0x22269)
	ldrb	r3, [r3]			@pico.video.type
	cmp     r3, #0
	beq     .case1vr
	cmp     r3, #4
	beq     .case2vr
	cmp     r3, #8
	bne     .defaultcasevr
	and		r0, r0, #63
	lsl		r0, r0, #1
	ldr		r2, =(Pico+0x22100)
	add		r2, r2, r0
	ldrh	r0, [r2]			@r0=pico.cram[a&0x003f]
	b		.endcasevr
.case1vr:
	ldr		r7, =32767
	and		r0, r0, r7
	lsl		r0, r0, #1
	ldr		r2, =(Pico+0x10000)
	add		r2, r2, r0
	ldrh	r0, [r2]			@r0=pico.vram[a&0x7fff]
	b		.endcasevr
.case2vr:
	and		r0, r0, #63
	lsl		r0, r0, #1
	ldr		r2, =(Pico+0x22180)
	add		r2, r2, r0
	ldrh	r0, [r2]			@r0=pico.vsram[a&0x003f]
.defaultcasevr:
	mov		r0, #0				@r0=0 (default case)
.endcasevr:
	ldr		r3, =(Pico+0x22253)	@r3=pico.video.reg[0xF]
	ldrb	r3, [r3]			
	add		r6, r6, r3
	ldr		r2, =(Pico+0x2226A)
	strh	r6, [r2]
	ldmfd   sp!, {r2-r3,r6-r7,lr}
    bx      lr

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
	ldr		r0, =(Pico+0x2226C)	@pico.video.status
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
	and		r1, r1, #0x1C
	cmp		r1, #0x08
	bne		.else3pvr
	ldr		r0, =(Pico+0x2220C)
	ldrh	r2, [r0]			@r2 = pico.m.scanline
	cmn		r2, #99
	bge		.endifscanlinepvr
.elsescanlinepvr:
	add		r2, r2, #1
	strb	r2, [r5]
	sub		r2, #1
	mov		r0, r2
.endifscanlinepvr:
	and		r0, r0, #0xFF
	lsl		r0, r0, #8
	ldr		r3, =(PicoCpu+0x5C)	@picocpu.SelCycles
	ldr		r3, [r3]
	rsb		r4, r3, #500
	lsr		r4, #1
	and		r4, #0xFF
	orr		r0, r0, r4
	b		.endpvr
.else3pvr:
	mov		r0, #0
.endpvr:
	ldmfd   sp!, {r1-r5,r12}
    bx      r12

@---------------------------------------------------------------------------
.global VideoWrite		@ unsigned int d (r0)
VideoWrite:
	stmfd   sp!, {r1-r4,r6,lr}
	ldr		r1, =(Pico+0x2226A)	@r1 = &pico.video.addr
	ldrh	r6, [r1]			@r6 = pico.video.addr
	ands 	r2, r6, #1
	beq		.endifvw
	lsl		r2, r0, #8
	and		r2, r2, #0xFF00
	lsr		r0, r0, #8
	orr		r0, r2, r0			@bytes swapped
.endifvw:
	lsr		r4, r6, #1
	ldr		r2, =(Pico+0x22269)
	ldrb	r2, [r2]			@pico.video.type
	cmp		r2, #5
	beq		.case5vw
	cmp		r2, #3
	beq		.case3vw
	cmp		r2, #1
	bne		.endcasevw
	ldr		r2, =0x7FFF
	and		r2, r4, r2
	lsl		r2, r2, #1
	ldr		r3, =(Pico+0x10000)
	add		r3, r3, r2
	strh	r0, [r3]			@pico.vram[a&0x7fff]=r0
	b		.endcasevw
.case3vw:
	and		r2, r4, #0x003F
	lsl		r2, r2, #1
	ldr		r3, =(Pico+0x22100)
	add		r3, r3, r2
	strh	r0, [r3]			@pico.cram[a&0x003f]=r0
	b		.endcasevw
.case5vw:
	and		r2, r4, #0x003F
	lsl		r2, r2, #1
	ldr		r3, =(Pico+0x22180)
	add		r3, r3, r2
	strh	r0, [r3]			@pico.vsram[a&0x003f]=r0
.endcasevw:
	ldr		r3, =(Pico+0x22253)	@r3=pico.video.reg[0xF]
	ldrb	r3, [r3]			
	add		r6, r6, r3
	strh	r6, [r1]
	ldmfd   sp!, {r1-r4,r6,lr}
    bx      lr

@---------------------------------------------------------------------------
.global GetDmaSource
GetDmaSource:
	stmfd   sp!, {r1-r2,lr}
	ldr		r1, =(Pico+0x22244)		
	ldrb	r0, [r1, #0x15]			@pico.video.reg[0x15]
	lsl		r0, r0, #1
	ldrb	r2, [r1, #0x16]			@pico.video.reg[0x16]
	lsl		r2, r2, #9
	orr		r0, r0, r2
	ldrb	r2, [r1, #0x17]			@pico.video.reg[0x17]
	lsl		r2, r2, #17
	orr		r0, r0, r2
	ldmfd   sp!, {r1-r2,lr}
    bx      lr

@---------------------------------------------------------------------------
.global GetDmaLength
GetDmaLength:
	stmfd   sp!, {r1,lr}
	ldr		r1, =(Pico+0x22244)		
	ldrb	r0, [r1, #0x13]			@pico.video.reg[0x13]
	ldrb	r1, [r1, #0x14]			@pico.video.reg[0x14]
	lsl		r1, r1, #8
	orr		r0, r0, r1
	ldmfd   sp!, {r1,lr}
    bx      lr

@---------------------------------------------------------------------------
.global DmaFill			@int data (r0)
DmaFill:
        stmfd   sp!, {r1-r10,lr}
        mov		r5, r0
        ldr     r8, =(Pico+0x2226A)		@r8 = &pico.video.addr
		ldr     r7, =(Pico+0x10000)		@r7 = &pico.vram
		ldr		r6, =0xFFFF				@r6 = useful constant
        asr     r4, r5, #8				@r4 = high
        and    	r5, r5, #0xFF			@r5 = low
        ldr		r1, =(Pico+0x22244)		@-----------------------INI getDmaLength
		ldrb	r0, [r1, #0x13]			@pico.video.reg[0x13]
		ldrb	r1, [r1, #0x14]			@pico.video.reg[0x14]
		lsl		r1, r1, #8
		orr		r9, r0, r1				@-----------------------END getDmaLength  r9 = len
		ldrh	r1, [r8]				@r1 = pico.video.addr
        eor     r3, r1, #1
        and		r3, r3, r6
        mov     r2, r3
        add     r3, r7, r2
        strb    r5, [r3]
        b       .L2
.L3:
		add     r3, r7, r1
        strb    r4, [r3]
        ldr     r3, =(Pico+0x22253)		@r3=pico.video.reg[0xF]
        ldrb    r3, [r3]
        and		r3, r3, r6
		add     r3, r1, r3
		and		r1, r3, r6
        sub     r9, r9, #1
.L2:
        cmp     r9, #1
        bge     .L3
		strh    r1, [r8]				@save pico.video.addr into memory
		ldmfd   sp!, {r1-r10,pc}

@---------------------------------------------------------------------------
.global PadRead			@int i (r0)
PadRead:
	stmfd   sp!, {r4,lr}
	mov		r4, r0						@backup of r0
	ldr		r1, =PicoPad
	ldr     r1, [r1, r0, lsl #2]
    mvn     r1, r1						@r1 = pad
	ldr		r2, =(Pico+0x22000)			@pico.ioports
	add		r3, r0, #1 
	ldrb	r2, [r2, r3]
	and		r2, r2, #0x40				@r2 = TH
	ldr		r3, =PicoOpt
	ldr		r3, [r3]
	ands	r3, r3, #0x20
	beq		.endif1pr
	ldr		r3, =(Pico+0x2220A)			@pico.m.padTHPhase
	ldr		r3, [r3, r0]				@r3 = phase    [r0 is free]
	cmp		r3, #2 
	bne		.else1pr
	cmp		r2, #0 
	bne		.else1pr
	and		r0, r1, #0xC0 				@ [r3 is free]
	asr		r0, r0, #2 
	b		.endpr
.else1pr:
	cmp		r3, #3 
	bne		.endif1pr
	cmp		r2, #0 
	beq		.else2pr
	and		r0, r1, #0x30 				@ [r3 is free]
	asr		r3, r1, #8 
	and		r3, r3, #0xF 
	orr		r0, r0, r3
	b		.endpr
.else2pr:
	and		r0, r1, #0xC0 
	asr		r0, r0, #2 
	orr		r0, r0, #0x0F
	b 		.endpr
.endif1pr:
	cmp		r2, #0
	beq  	.else3pr
	and		r0, r1, #0x3F
	b		.endpr
.else3pr:
	and		r0, r1, #0xC0 
	asr		r0, r0, #2
	and		r3, r1, #3
	orr		r0, r0, r3
.endpr:									@ [r2 is free]
	ldr		r3, =(Pico+0x22000)			@pico.ioports
	add		r2, r3, r4
	add		r3, r3, r4
	ldrb 	r3, [r3, #1]				@pico.ioports[i+1]
	ldrb	r2, [r2, #4] 				@pico.ioports[i+4]
	and		r2, r3, r2 
	orr		r0, r0, r2
	ldmfd   sp!, {r4,pc}
mario_exgfx:
	lda !gfx_bypass_flag		;check if you there is another gfx due to be loaded
	beq .no_bypass_everything
	rep #$20
	lda !gfx_bypass_num		;load mario's gfx
	bra .bypass_everything
.no_bypass_everything
if !SA1 == 1
	stz $2250
	lda !player_num
	sta $2251
	stz $2252
	lda.b #!max_powerup+$01
	stz $2253
	stz $2254
	lda #$00
	xba
	lda $19
	clc
	adc $2306	
else	
	lda !player_num
	sta $4202
	lda.b #!max_powerup+1
	sta $4203
	lda #$00
	xba
	nop
	nop
	lda $19
	clc
	adc $4216
endif
	;$0DB3|!base2		;check if player = luigi

	tax
	lda.l GFXData,x			;get the correct powerup data
.bypass_everything
	rep #$30
	sta $02
	and #$007F
	sta $00
	asl
	clc
	adc $00
	tax				;multiply data*3
	lda.l PowerupGFX,x
	sta !gfx_pointer
	sep #$20
	lda.l PowerupGFX+2,x
	sta !gfx_pointer+2		;store info in pointers
	sep #$10
	
	ldx #$00			;check if using a 32*32 player

	rep #$20
	lda $09
	clc
	adc !gfx_pointer
	and #$0300
	sec
	ror
	pha

	lda $09
	clc
	adc !gfx_pointer
	and #$3C00
	asl
	ora $01,s
	sta $0D85|!base2
	lda !gfx_pointer+2
	and #$00FF
	tay
	bit $09
	bvc +
	iny
+	
	sty $0D87|!base2
	tya
	pla

	lda $0B
	and #$FF00
	lsr #3
	adc !gfx_pointer
	sta $0D89|!base2
	clc
	adc #$0200
	sta $0D93|!base2

	lda $0C
	and #$FF00
	lsr #3
	adc #$2000
	sta $0D99|!base2
	sep #$20
	lda #$0A
	sta $0D84|!base2
	jml $00F69E|!base3
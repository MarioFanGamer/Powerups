;;;;;;;;;;;;;;
;; Fire flower
;;;;;;;;;;;;;;

	LDA $73
	ORA $74
	ORA $187A|!base2
	ORA $1470|!base2
	BNE .Return

	BIT $16
	BVS .ShootFireball
	LDA $140D|!base2
	BEQ .Return
	INC $13E2|!base2
	LDA $13E2|!base2
	AND #$0F
	BNE .Return
	TAY
	LDA $13E2|!base2
	AND #$10
	BEQ +
	INY
+
	STY $76
.ShootFireball
	PHB
	LDA #$00
	PHA
	PLB
	PHK
	PEA.w ..return-1
	PEA $84CE
	JML $00FEA8|!base3
..return
if !fireball_shoot_up == 1
	lda $15
	and #$08
	beq +
	lda !ext_sprite_y_speed,x
	eor #$FF
	inc 
	sta !ext_sprite_y_speed,x
+	
endif
	PLB
	
.Return
	RTS
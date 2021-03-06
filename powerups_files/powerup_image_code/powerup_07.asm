;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tanooki Suit (Super Mario Bros. 3)
;; 
;; Gives Mario a full tanooki suit
;; You can fly for a short period of time.
;; You can also convert yourself in a statue.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	ldx $13F3|!base2
	bne .tail
	lda !timer
	sec
	sbc #$04
	beq .no_spin
	bmi .no_spin
	lsr #2
	and #$03
	sta $00
	lda !power_ram
	asl #2
	and #$04
	clc
	adc $00
	tax
	lda.w .pose,x
	sta $13E0|!base2
	lda .turn,x
	sta $76
	bra .tail
.no_spin
	cmp #$FD
	bne .tail
	lda !power_ram
	sta $76
.tail	
	lda $78
	and #$10
	beq +
	jmp .no_tail
+	
	ldx $13E0|!base2
	lda $76
	clc
	ror #3
	ora .settings,x
	sta !extra_tile_flag
	lda .tile,x
	sta !extra_tile_frame

	lda !timer
	beq .no_spin_tail
	lsr #2
	and #$01
	beq +
	lda #$02
	sta !extra_tile_frame
	bra .no_anim
+	
	lda #$04
	sta !extra_tile_frame
	bra .no_anim
.no_spin_tail
	lda $77
	and #$04
	bne .no_anim
	lda $7D
	bmi .no_floor
	lda $74
	ora $13E3|!base2
	ora $13F3|!base2
	bne .no_floor
	lda $14
	lsr #3
	and #$01
	beq +
	lda #$0C
	sta !extra_tile_frame
	bra .no_floor
+	
	lda #$02
	sta !extra_tile_frame
.no_floor
	lda !power_ram+1
	beq .no_anim
	dec
	sta !power_ram+1
	lsr #2
	and #$03
	tax
	lda .hover_anim,x
	sta !extra_tile_frame
.no_anim	
	txa
	asl
	tax
	rep #$30
	lda .offset_y,x
	sta !extra_tile_offset_y
	lda $76
	and #$00FF
	bne +
	txa
	clc
	adc.w #(.offset_x_end-.offset_x)
	tax
+	
	lda .offset_x,x
	sta !extra_tile_offset_x
	sep #$30
	bra .no_hide
.no_tail
	lda #$0E
	sta !extra_tile_frame
	lda #$F0
	tsb $78
.no_hide
	lda !power_ram+2
	cmp #$01
	bne .no_statue
	lda #$F0
	tsb $78
	lda #$0E
	sta !extra_tile_frame
	lda #$46
	sta $13E0|!base2
	stz $76
.no_statue
	rts

.offset_x
	dw $FFF8,$FFF8,$FFF8,$FFF8,$FFF8,$FFF8,$FFF8,$FFF8
	dw $FFF8,$FFF8,$FFF8,$FFF8,$FFF8,$FFF8,$FFF8,$0000
	dw $FFF2,$FFF2,$FFF2,$FFF2,$FFF8,$0000,$FFF8,$FFF8
	dw $FFF8,$FFF8,$FFF8,$FFF8,$FFF8,$FFF8,$0000,$0000
	dw $FFF6,$FFF8,$0000,$0000,$FFF8,$0000,$0000,$FFF6
	dw $FFF6,$FFF6,$0000,$0000,$0000,$0000,$0000,$0000
	dw $FFF8,$FFF8,$FFF8,$FFF8,$FFF8,$FFF8,$FFF8,$FFF8
	dw $0000,$0000,$FFF8,$FFF8,$FFF8,$FFF8,$0000,$FFF8
	dw $FFF8,$FFF8,$0000,$0000,$0000,$0000,$FFF8
	dw $0000
..end
	dw $0008,$0008,$0008,$0008,$0008,$0008,$0008,$0008
	dw $0008,$0008,$0008,$0008,$0008,$0008,$0008,$0000
	dw $000E,$000E,$000E,$000E,$0008,$0000,$0008,$0008
	dw $0008,$0008,$0008,$0008,$0008,$0008,$0000,$0000
	dw $000A,$0008,$0000,$0000,$0008,$0000,$0000,$000A
	dw $000A,$000A,$0000,$0000,$0000,$0000,$0000,$0000
	dw $0008,$0008,$0008,$0008,$0008,$0008,$0008,$0008
	dw $0000,$0000,$0008,$0008,$0008,$0008,$0000,$0008
	dw $0008,$0008,$0000,$0000,$0000,$0000,$0008
	dw $0000
.offset_y
	dw $0012,$0012,$0012,$0012,$0012,$0012,$0012,$0012
	dw $0012,$0012,$0012,$0012,$0012,$0012,$0012,$0012
	dw $0018,$0024,$0024,$0024,$0012,$0012,$0012,$0012
	dw $0012,$0012,$0012,$0012,$0012,$0012,$0012,$0012
	dw $0012,$0012,$0012,$0012,$0012,$0012,$0012,$0012
	dw $0012,$0012,$0012,$0012,$0012,$0012,$0012,$0012
	dw $0012,$0012,$0012,$0012,$0012,$0012,$0012,$0012
	dw $0012,$0012,$0012,$0012,$0012,$0012,$0012,$0012
	dw $0012,$0012,$0012,$0016,$0012,$0012,$0012
	dw $8000
.tile	
	db $00,$02,$00,$00,$00,$02,$00,$00
	db $02,$00,$00,$00,$02,$04,$00,$0A
	db $04,$08,$08,$08,$00,$0A,$00,$00
	db $02,$02,$00,$00,$0C,$00,$0A,$04
	db $00,$04,$0A,$0A,$00,$0A,$0A,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $0C,$0C,$00,$00,$00,$00,$00,$00
	db $0A,$0A,$00,$00,$00,$00,$00,$00
	db $00,$00,$0A,$0A,$0A,$0A,$00
	db $00
..end
.settings
	db $01,$01,$01,$01,$01,$01,$01,$01
	db $01,$01,$01,$01,$01,$01,$01,$01
	db $01,$01,$01,$01,$01,$11,$01,$01
	db $01,$01,$01,$01,$01,$01,$11,$11
	db $01,$01,$11,$11,$01,$11,$01,$01
	db $01,$01,$00,$00,$00,$00,$00,$00
	db $01,$01,$01,$01,$01,$01,$01,$01
	db $11,$11,$01,$01,$01,$00,$00,$01
	db $01,$01,$01,$01,$11,$01,$01
	db $00

.hover_anim
	db $02,$04,$02,$06
.pose
	db $00,$25,$00,$0F
	db $00,$0F,$00,$25
.turn	
	db $00,$00,$01,$01
	db $01,$01,$00,$00


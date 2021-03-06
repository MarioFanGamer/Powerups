give_penguin_suit:
	lda $86
	sta !slippery_flag_backup
	lda #$00
	sta !clipping_flag
	sta !collision_flag
	ldy $0DB3|!base2
	lda #!penguin_suit_powerup_num
	sta $19
	sta $0DB8|!base2,y
if !DEBUG
	lda $0F
	bmi +
endif
	lda #$0A
	sta $1DF9|!base2
	ldy !1534,x
	bne +
	lda #$04
	jsl $02ACE5|!base3
+	
	jsl $01C5AE|!base3
	inc $9D

	ldy #$1C
	lda !extra_tile_flag
	bit #$10
	beq .normal_priority
	ldy #$0C
.normal_priority
	lda #$F0
	sta $0301|!base2,y

	stz $1407|!base2
	lda $13ED|!base2
	and #$7F
	sta $13ED|!base2
	
	lda #$00
	sta !disable_spin_jump
	sta !mask_15
	sta !mask_17
	sta !flags
	sta !timer
	sta !misc
	sta !misc+1
	sta !shell_immunity
	sta !cape_settings
	sta !extra_tile_flag
	sta !extra_tile_offset_x
	sta !extra_tile_offset_x+1
	sta !extra_tile_offset_y
	sta !extra_tile_offset_y+1
	sta !extra_tile_frame
	sta !ride_yoshi_flag
	sta !insta_kill_flag
	sta !power_ram+0
	sta !power_ram+1
	sta !power_ram+2
	sta !power_ram+3
	sta !power_ram+4
	sta !power_ram+5
	sta !power_ram+6
	sta !power_ram+7
	sta !power_ram+8
	sta !power_ram+9
	sta !power_ram+$A
	sta !power_ram+$B
	sta !power_ram+$C
	sta !power_ram+$D
	sta !power_ram+$E
	sta !power_ram+$F
if !gfx_compression == 1
	jsr request_gfx
endif
	jml $01C560|!base3
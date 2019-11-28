_TEXT	SEGMENT WORD PUBLIC 'CODE'
	ASSUME	cs:_TEXT, ds:_TEXT
	ORG	100h

first:
	jmp	start			; Jump over data

Banner1	BYTE	"IdentAT PC/AT Identifier v0.0.1", 13, 10, "$"
Banner2 BYTE	"  Copyright (C) 2019 John P. Willis", 13, 10, 13, 10, "$"
VerStrt BYTE	"Verifying machine ID marker byte...  $"
VerGood BYTE	"[AT]",13,10,"$"
VerBad	BYTE	"[NOT AT]",13,10,"$"
Type1	BYTE	"   This is a PC/AT Type 1.",13,10,"$"
Type2	BYTE	"   This is a PC/AT Type 2.",13,10,"$"
Type3	BYTE	"   This is a PC/AT Type 3.",13,10,"$"

start:
	mov	ah, 9h
	mov	dx, OFFSET Banner1
	int	21h
	mov	dx, OFFSET Banner2
	int	21h
	mov	dx, OFFSET VerStrt
	int	21h

	mov	ax, 0F000h		; point ES to BIOS data area
	mov	es, ax

	mov	ah, es:0FFFEh
	cmp	ah, 0FCh
	je	isAT

notAT:
	mov	ah, 9h
	mov	dx, OFFSET VerBad
	int	21h

	mov	ax, 4C01h
	int	21h

isAT:
	mov	ah, 9h
	mov	dx, OFFSET VerGood
	int	21h

	mov	ah, es:0FFF5h
	cmp	ah, 31h
	jne	notType3

isType3:
	mov	ah, 9h
	mov	dx, OFFSET Type3
	int	21h
	jmp	success

notType3:
	mov	ah, es:0FFF6h
	cmp	ah, 31h
	jne	isType2

isType1:
	mov	ah, 9h
	mov	dx, OFFSET Type1
	int	21h
	jmp	success

isType2:
	mov	ah, 9h
	mov	dx, OFFSET Type2
	int	21h

success:
	mov	ax, 4C00h		; Exit functions with 0 in AL
	int	21h			; Exit Program with Return Code

_TEXT	ENDS

	END	first

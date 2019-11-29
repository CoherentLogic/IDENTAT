;;
;; IDENTAT.ASM
;;  IdentAT PC/AT Identifier
;;
;; Author:  John P. Willis <jpw@coherent-logic.com>
;;  Copyright (C) 2019 Coherent Logic Development
;;
;;
;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.
;;
;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU General Public License for more details.
;;
;;  You should have received a copy of the GNU General Public License
;;  along with this program.  If not, see <https://www.gnu.org/licenses/>
;;

_TEXT   SEGMENT WORD PUBLIC 'CODE'
    ASSUME  cs:_TEXT, ds:_TEXT
    ORG 100h

first:
    jmp start           ; Jump over data

Banner1 BYTE    "IdentAT PC/AT Identifier v0.0.1", 13, 10, "$"
Banner2 BYTE    "  Copyright (C) 2019 John P. Willis", 13, 10, 13, 10, "$"
VerStrt BYTE    "Verifying machine ID marker byte...  $"
VerGood BYTE    "[AT]",13,10,"$"
VerBad  BYTE    "[NOT AT]",13,10,"$"
Type1   BYTE    "   This is a PC/AT Type 1.",13,10,"$"
Type2   BYTE    "   This is a PC/AT Type 2.",13,10,"$"
Type3   BYTE    "   This is a PC/AT Type 3.",13,10,"$"

start:
    mov ah, 9h
    mov dx, OFFSET Banner1
    int 21h
    mov dx, OFFSET Banner2
    int 21h
    mov dx, OFFSET VerStrt
    int 21h

    mov ax, 0F000h      ; point ES to BIOS data area
    mov es, ax

    mov ah, es:0FFFEh   ; machine ID byte is at ES:0FFFEh
    cmp ah, 0FCh        ; machine ID byte of 0FCh is IBM PC/AT
    je  isAT

notAT:
    mov ah, 9h          ; not an IBM PC/AT at all
    mov dx, OFFSET VerBad
    int 21h

    mov ax, 4C01h       ; quit with return code 01h
    int 21h

isAT:
    mov ah, 9h
    mov dx, OFFSET VerGood
    int 21h

    mov ah, es:0FFF5h   ; check BIOS date string to determine type
    cmp ah, 31h         ; first byte of BIOS date string will only be 31h on a type 3
    jne notType3        ; if first byte of date string is not 31h, we know
                        ; this is not a type 3, so jump appropriately

isType3:
    mov ah, 9h          ; print Type 3 message
    mov dx, OFFSET Type3
    int 21h
    jmp success         ; jump to cleanup

notType3:
    mov ah, es:0FFF6h   ; get second byte of BIOS date string
    cmp ah, 31h         ; if second byte is 31h, this is type 1
    jne isType2         ; if not, no other options but type 2

isType1:
    mov ah, 9h          ; print type 1 message
    mov dx, OFFSET Type1
    int 21h
    jmp success         ; jump to cleanup

isType2:
    mov ah, 9h          ; no other options left, this is a type 2
    mov dx, OFFSET Type2
    int 21h

success:
    mov ax, 4C00h       ; exit with return code 00h
    int 21h         

_TEXT   ENDS

    END first

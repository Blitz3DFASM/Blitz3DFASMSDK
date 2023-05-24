;******************************************************
;*                  Blitz3D on FASM                   *
;******************************************************

format PE GUI 4.0
entry start

include 'win32ax.inc'
include 'blitz3dsdk.inc'

; ------------ variables and arrays ----------------
section '.data' data readable writeable

camera BBCamera 0
light BBLight 0
cone BBModel 0
font BBFont 0

r dd 0
g dd 0
b dd 0

font_name db 'System',0
text db "Simple Text! Ïðîñòîé òåêñò",0
title db 'Blitz3D 2D Graphics Exmple on FASM', 0
exit db 'Do you really want to exit?', 0
empty_str db 0

; --------------------- Code -----------------------
section '.code' code readable executable

start:
      cinvoke bbBeginBlitz3D
      cinvoke bbSetBlitz3DTitle, title, exit
      cinvoke bbGraphics, 640, 480, 32, 3

      cinvoke bbLoadFont, font_name, 32, BBTRUE, BBFALSE, BBTRUE
      mov [font],eax
      cinvoke bbSetFont, [font]

main_2dloop:
      cinvoke bbKeyHit, KEY_ESCAPE
      or eax, eax
      jnz exit_from_main_loop           ; If Esc pressed then exit from app

      cinvoke bbClsColor, [r], [g], [b]  ; Set color and clear screen
      cinvoke bbCls
      inc [r]
      add [g],7
      add [b],3

      cinvoke bbLine, 20, 20, 20, 460
      cinvoke bbColor, 0, 128, 255
      cinvoke bbRect, 40, 40, 50, 50, BBTRUE
      cinvoke bbColor, 255, 255, 255
      cinvoke bbText, 320, 220, text, BBTRUE, BBFALSE

      cinvoke bbFlip                     ; Show buffer

      jmp main_2dloop;

exit_from_main_loop:
      cinvoke bbEndBlitz3D
      invoke ExitProcess,0

section '.idata' import data readable writeable

library kernel32,'KERNEL32.DLL',\
       user32,'USER32.DLL',\
       b3d,'B3D.DLL'

       include 'api\kernel32.inc'
       include 'api\user32.inc'
       include 'b3d.inc'

section '.rsrc' resource data readable
       ICON equ '3D.ico'
       include 'res.inc'

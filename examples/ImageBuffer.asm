;******************************************************
;*                  Blitz3D on FASM                   *
;******************************************************

format PE GUI 4.0
entry start

include 'win32ax.inc'
include 'blitz3dsdk.inc'

; ------------ êîíñòàíòû è ïåðåìåííûå -----------------
section '.data' data readable writeable

buffer BBCanvas 0
image BBCanvas 0

; ------------------------- êîä ------------------------
section '.code' code readable executable

start:
      cinvoke bbBeginBlitz3D
      cinvoke bbGraphics, 640, 480, 32, 3

      cinvoke bbCreateImage, 7, 9, 1 ; 7x9 pixels frame = 1
      mov [image], eax

      cinvoke bbImageBuffer, [image], 0 ; get buffer of image frame=0
      cinvoke bbSetBuffer, eax

      cinvoke bbOval, 0, 0, 5, 5, 1

      cinvoke bbBackBuffer
      mov [buffer],eax
      cinvoke bbSetBuffer, [buffer]

main_loop:
      cinvoke bbKeyHit, KEY_ESCAPE ; Wait Esc
      or eax, eax
      jnz exit_from_main_loop

      cinvoke bbTileImage, [image], 0, 0, 0

      cinvoke bbFlip, BBTRUE       ; Flip buffers
      jmp main_loop;
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

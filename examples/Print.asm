;******************************************************
;*                  Blitz3D on FASM                   *
;*                                                    *
;*     Example of using b3dmacro.inc InText macro     *
;******************************************************

format PE GUI 4.0
entry start

include 'win32ax.inc'
include 'blitz3dsdk.inc'

; ------------ variables and arrays ----------------
section '.data' data readable writeable

include 'b3dmacro.inc'

buffer BBCanvas 0
camera BBCamera 0
light BBLight 0

cone BBModel 0
cube BBModel 0
sphere BBModel 0

title db 'Blitz3D 3D Graphics Exmple on FASM', 0
text db 'Class of cube is: ', 0
exit db 'Do you really want to exit?', 0
empty_str db 0
class_name dd 0      ; Pointer to string

string db 'This is string',0

strFormat db 'EBP pointer is: %d ESP pointer is: %d',0
strBuffer rb 256
val dd 0

; --------------------- Code -----------------------
section '.code' code readable executable

start:
      cinvoke bbBeginBlitz3D
      cinvoke bbSetBlitz3DTitle, title, empty_str
      cinvoke bbGraphics3D, 640, 480, 32, 3

      cinvoke bbBackBuffer
      mov [buffer],eax
      cinvoke bbSetBuffer, [buffer]

      cinvoke bbCreateCamera, 0            ; paerent 0
      mov [camera], eax
      cinvoke bbCreateLight, 1, 0          ; 1 - direct light, parent null
      mov [light], eax

      cinvoke bbCreateCube, 0              ; parent null
      mov [cube], eax
      cinvoke bbPositionEntity, [cube], 0f, 0f, 4f
      cinvoke bbEntityColor, [cube], 150f, 5f, 150f

      cinvoke bbEntityClass, [cube]
      mov [class_name], eax    ; Save pointer to string

main_loop:
      cinvoke bbKeyHit, KEY_ESCAPE ; Wait Esc
      or eax, eax
      jnz exit_from_main_loop

      cinvoke bbTurnEntity, [cube], 0.5f, 2f, 1f

      cinvoke bbRenderWorld, 1      ; Render world to buffer


      InText 1, 1, 'Class of cube is: %s', [class_name]

      cinvoke bbText,   1, 20, strBuffer, BBFALSE, BBFALSE


      cinvoke bbEntityYaw, [cube]
      fistp [val]  ; float to integer
      InText 0, 40, 'Cube Yaw:   %i', [val]
      cinvoke bbEntityPitch, [cube]
      fistp [val]  ; float to integer
      InText 0, 50, 'Cube Pitch: %i', [val]
      cinvoke bbEntityRoll, [cube]
      fistp [val]  ; float to integer
      InText 0, 60, 'Cube Roll:  %i', [val]

      InText 0, 100, 'Example of printg values from macro: %d %X %x %s', -24, 0xC0DE0ACE, 0x0DECADE, string

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

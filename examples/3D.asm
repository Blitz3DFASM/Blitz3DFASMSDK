;******************************************************
;*                  Blitz3D on FASM                   *
;******************************************************

format PE GUI 4.0
entry start

include 'win32ax.inc'
include 'blitz3dsdk.inc'

; ------------ variables and arrays -----------------
section '.data' data readable writeable

buffer BBCanvas 0
camera BBCamera 0
light BBLight 0

cone BBModel 0
cube BBModel 0
sphere BBModel 0

title db 'Blitz3D 3D Graphics Exmple on FASM', 0
text db 'Class of cube is: ', 0
empty_str db 0
class_name dd 0      ; Pointer to string

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

      cinvoke bbCreateCone, 32, BBTRUE, 0  ; 32 segments, solid, parent null
      mov [cone], eax
      cinvoke bbPositionEntity, [cone], -3f, 0f, 5f
      cinvoke bbEntityColor, [cone], 255f, 32f, 32f

      cinvoke bbCreateCube, 0              ; parent null
      mov [cube], eax
      cinvoke bbPositionEntity, [cube], 0f, 0f, 6.5f
      cinvoke bbEntityColor, [cube], 70f, 155f, 30f

      cinvoke bbCreateSphere, 7, 0         ; detail level - 7, parent null
      mov [sphere], eax
      cinvoke bbPositionEntity, [sphere], 3f, 0f, 5f
      cinvoke bbEntityColor, [sphere], 0f, 128f, 255f

      cinvoke bbEntityClass, [cube]
      mov [class_name], eax    ; Save pointer to string

main_loop:
      cinvoke bbKeyHit, KEY_ESCAPE ; Wait Esc
      or eax, eax
      jnz exit_from_main_loop

      cinvoke bbTurnEntity, [cube], 0.5f, 2f, 1f
      cinvoke bbTurnEntity, [cone], 0f, 1f, 0.5f
      cinvoke bbTurnEntity, [sphere], 2f, 1f, 0.5f

      cinvoke bbRenderWorld, 1     ; Render world to buffer

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

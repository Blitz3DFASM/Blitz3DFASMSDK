; bbLCreateLight Example
include "blitz3d.inc"

sphere dd 0
light dd 0
x dd 0
y dd 0
z dd 0

start:
     ; Set The Graphic Mode
     cinvoke bbGraphics3D, 640, 480, 0, 0

     cinvoke bbBackBuffer
     cinvoke bbSetBuffer, eax

     ; Create camera (parent none)
     cinvoke bbCreateCamera, 0

     ; Create Spot Light (parent none)
     cinvoke bbCreateLight, 3, 0
     mov [light], eax

     cinvoke bbLightRange, [light], 25f

     ; Create sphere 50 times (sphere mesh detail level=7, parent none)
     mov ecx, 50
next_sphere:
     push ecx
     cinvoke bbCreateSphere, 7, 0
     mov [sphere], eax
     rand [x],-15,15
     fild [x]              ; convert integer to float
     fstp [x]
     rand [y],-15,15
     fild [y]              ; convert integer to float
     fstp [y]
     rand [z],5,15
     fild [z]              ; convert integer to float
     fstp [z]
     cinvoke bbPositionEntity, [sphere], [x], [y], [z]
     pop ecx
     dec ecx
     jnz next_sphere

     ; Wait for ESC to hit
main_loop:
     cinvoke bbKeyHit, KEY_ESCAPE ; Wait Esc
     or eax, eax
     jnz exit_from_main_loop

     ; Render world
     cinvoke bbRenderWorld, 1

     ; Invoke Flip inside loop every frame
     cinvoke bbFlip

     jmp main_loop;
exit_from_main_loop:
; bbMouseX bbMouseY Example
include "blitz3d.inc"

start:
     cinvoke bbBeginBlitz3D
     cinvoke bbGraphics, 640, 480, 0, 3

main_loop:
     cinvoke bbKeyHit, KEY_ESCAPE ; Wait Esc
     or eax, eax
     jnz exit

     cinvoke bbMouseX
     mov esi, eax
     cinvoke bbMouseY
     mov edi, eax

     cinvoke bbOval, esi, edi, 7, 7, 0

     cinvoke bbFlip, BBTRUE       ; Flip buffers
     jmp main_loop;
exit:

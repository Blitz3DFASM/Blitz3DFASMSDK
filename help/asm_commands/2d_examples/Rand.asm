; Rand example

; include blitz3D lib
include "blitz3d.inc"

     ; Set The Graphic Mode
     cinvoke bbGraphics, 800, 600, 16, 0

; Generate 20 random numbers between 1 and 100
     mov ecx, 20
next_value:
     push ecx
     rand 1, 100
     InPrint "Random value: %d", eax
     pop ecx
     dec ecx
     jnz next_value   ; use jns for 20..0 cycles, and jnz for 20..1 cycles

     cinvoke bbFlip
     cinvoke bbWaitKey


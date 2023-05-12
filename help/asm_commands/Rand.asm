; Rand example
include "blitz3d.inc"

start:
     ; Set The Graphic Mode
     cinvoke bbGraphics, 800, 600, 0, 0

     ; Generate 20 random numbers between 1 and 100
     mov ecx, 20
next_value:
     push ecx
     rand eax, 1, 100
     InPrint "Random value: %d", eax
     pop ecx
     dec ecx
     jnz next_value   ; Use jns for 20..0 cycles, or jnz for 20..1 cycles

     cinvoke bbFlip   ; Show screen buffer
     cinvoke bbWaitKey


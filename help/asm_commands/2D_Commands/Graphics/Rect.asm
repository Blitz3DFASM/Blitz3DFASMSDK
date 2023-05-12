; bbRect example
include "blitz3d.inc"

r dd 0
g dd 0
b dd 0
x dd 0
y dd 0
width dd 0
height dd 0
solid dd 0

start:
     ; Set The Graphic Mode
     cinvoke bbGraphics, 800, 600, 0, 0

     ; Set backbuffer
     cinvoke bbBackBuffer
     cinvoke bbSetBuffer, eax

     ; Wait for ESC to hit
main_loop:
     cinvoke bbKeyHit, KEY_ESCAPE ; Wait Esc
     or eax, eax
     jnz exit_from_main_loop

     ; Set a random color
     rand [r],255
     rand [g],255
     rand [b],255
     cinvoke bbColor, [r], [g], [b]

     ; Draw a random rect
     rand [x],-100,800
     rand [y],-100,600
     rand [width],100
     rand [height],100
     rand [solid],1
     cinvoke bbRect, [x],[y],[width],[height],[solid]

     cinvoke bbFlip, 0

     jmp main_loop;
exit_from_main_loop:

; Line example
include "blitz3d.inc"

r dd 0
g dd 0
b dd 0
x1 dd 0
y1 dd 0
x2 dd 0
y2 dd 0

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

     ; Draw a random line
     rand [x1],800
     rand [y1],600
     rand [x2],800
     rand [y2],600
     cinvoke bbLine, [x1],[y1],[x2],[y2]

     cinvoke bbFlip, 0

     jmp main_loop;
exit_from_main_loop:

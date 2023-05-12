;GRAPHICS Example
include "blitz3d.inc"

start:
     ; Set The Graphic Mode
     cinvoke bbGraphics, 800, 600, 16, 0

     ; Now print something on the graphic screen
     InText 0, 0, "This is some text printed on the graphic screen (and a white box)!  Press ESC ..."

     ; Now for a box
     cinvoke bbRect, 100, 100, 200, 200, 1

     ; Wait for ESC to hit
main_loop:
     cinvoke bbKeyHit, KEY_ESCAPE ; Wait Esc
     or eax, eax
     jnz exit_from_main_loop

     ; Invoke Flip inside loop every frame
     cinvoke bbFlip

     jmp main_loop;
exit_from_main_loop:
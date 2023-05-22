; Switch Case Example
include "blitz3d.inc"

start:
     cinvoke bbBeginBlitz3D
     cinvoke bbGraphics, 640, 480, 0, 3

main_loop:

     InPrint "Press any key for get random mission info"
     InPrint ""

     cinvoke bbWaitKey
     cmp eax, 27      ; 27 - Esc ASCII code
     je exit

     rand [mission], 0, 7   ; random mission number
     InPrint "Mission %d:", [mission]
     mov eax,[mission]

     cmp eax,(case_table_end-case_table)/4 ; 5
     jae default
     jmp dword [case_table+eax*4]

mission dd 0

case_table:
     dd case_0
     dd case_1
     dd case_2
     dd case_3
     dd case_4
case_table_end:

case_1:
     InPrint "Your mission is to get the plutonium and get out alive!"
     jmp end_select
case_2:
     InPrint "Your mission is to destroy all enemies!"
     jmp end_select
case_3:
     InPrint "Your mission is to steal the enemy building plans!"
     jmp end_select
case_4:
     InPrint "This is final mission!"
     jmp end_select
case_0:
default:
     InPrint "Information about mission %d is not found!", eax
end_select:

     cinvoke bbFlip, BBTRUE       ; Flip buffers
     jmp main_loop
exit:

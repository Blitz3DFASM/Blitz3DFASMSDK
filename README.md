# Blitz3D FASM SDK

Blitz3D SDK for Flat Assembler x86

# How to use

* Download Blitz3D SDK V1.05 and get B3D.dll from it and place it in folder with *.inc files from this SDK.
* Download FASM for windows, extract it to specify folder.
* Run FASMW IDE from FASM archive 
* Open one of the *.asm files from this SDK examples folder
* Select Run->Run for create execute and run example

# SDK Description:

SDK contains files:

* b3d.inc - headers of b3d.dll
* blitz3dsdk.inc - contains Blitz3D constants like key codes, data types and other constants 
* b3dmacro.inc - contains assember macroses for SDK for easy text output, random generator and other
* blitz3d.inc - special header, it simplifies the code structure to a minimum, which makes programming easier for novice users. (used throughout the examples).
* res.inc - contain resources description
* \examples - contain app examples
* \help - contain few examples from help

# Typical Blitz3D Assembler x86 appliction source code

Typical FASM application code for Windows consists of:  
* header *format PE GUI 4.0*
* pointer to the beginning of the code *entry start*  

And several sections:
* *.data* - Contains variables, arrays are marked as writable and readable, but not executable.
* *.code* - Contains code, can also contain data but is read-only, marked as readable and executable code, but not writable (modifications).
* *.idata* - Contains information about exported functions of third-party libraries. As a rule, this is a user32, kernel32 and of course b3d "headers".
* *.rsrc* - Contains application resources: icons, application version information, can also contain images, dialogs, menus.

The approach of dividing the code into sections allows you to make the application more secure, for example, you cannot save the code into a variable and execute it. This is protection against code injections.

A typical Blitz3D SDK application has the following structure:
* Before start working with SDK, need to invoke bbBeginBlitz3D at first
* Next, if you use graphics, you need to create a window by bbGraphics3D, 640, 480, 32, 3 Then some custom code follows.
* At the end, when exiting the application, need to call bbEndBlitz3D and invoke ExitProcess

While we are not considering the Blitz3D code and functions itself, this is only a description of the assembler code structure of typical Windows application.

    ;******************************************************
    ;*                  Blitz3D on FASM                   *
    ;******************************************************

    format PE GUI 4.0
    entry start

    include 'win32a.inc'
    include 'blitz3dsdk.inc'

    ; ------------ data section -----------------
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

    ; ------------ code section ------------------
    section '.code' code readable executable

    start:
          cinvoke bbBeginBlitz3D
          cinvoke bbGraphics3D, 640, 480, 32, 3
          cinvoke bbSetBlitz3DTitle, title, empty_str
          
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
          
# Using simplified code with blitz3d.inc

Using blitz3d.inc allows to greatly simplify the code.

However, with this approach, both the data and the executable code are in the same *.code* section, which is not very good.

On the positive side:
1. code sections are hidden from the main code, which reduces its size.
3. don't need to call bbBeginBlitz3D at the beginning of the code, this is done automatically.
3. No need to add: bbEndBlitz3D and ExitProcess at the end. A special macro adds this code to the end of the application automatically.

Among the shortcomings, it can also be noted that if you want to connect any other library or change resources, then it will be difficult for you to do this. In a simple way, no way.

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
        
 

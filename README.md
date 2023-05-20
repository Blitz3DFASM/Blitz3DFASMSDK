# Blitz3D FASM SDK

[Blitz3D SDK](https://blitzresearch.itch.io/blitz3d) for [Flat Assembler x86](https://flatassembler.net/). This SDK can make learning Assembly X86 language more fun.

Simple Online Help is placed [here](https://blitz3dfasm.github.io/FASM_B3D_SDK_HELP/help/asm_commands/index.htm)

Blitz3D SDK (B3D.dll) disadvantages [here](https://blitz3dfasm.github.io/FASM_B3D_SDK_HELP/help/asm_commands/main.htm). Read before use this SDK.

# How to use

![B3DFASMSDK](https://github.com/Blitz3DFASM/Blitz3DFASMSDK/assets/133161792/3ee654fe-ede5-41b8-82ec-f4844ac47074)

* Download [this Blits3D FASM SDK](https://github.com/Blitz3DFASM/Blitz3DFASMSDK/archive/refs/heads/main.zip), and extract it to any folder folder.
* Download [Blitz3D SDK V1.05](http://www.google.com/search?q=Blitz3D+SDK+v1.05), and extract it to any folder folder.
* Download [FASM for windows](http://flatassembler.net/download.php), and extract it to any folder folder.
* Copy all files from SDK\INCLUDE folder to FASM\INCLUDE folder.
* Copy **B3D.dll** from *Blitz3D_SDK_V1.05\redist* folder and copy it **to folder with \*.asm files** (The compiled exe file will not run without B3D.dll library in exe file folder).
* Run FASMW.EXE IDE from FASM archive and open one of the *.asm files from this SDK and select Run->Run from main menu for create execute and run example.

**Note:** Also, you can set FASMW.EXE as default application for *.asm files in youre opeartin system. Then, when opening an *.asm file, it will immediately open it in the FASMW IDE, which greatly simplifies work.

# SDK Description:

SDK contains files:
* \INCLUDE - contains files that need to be moved to the FASM\INCLUDE folder.
    * 3D.ico - default icon (It is spelled out in the res.inc file)   
    * b3d.inc - headers of b3d.dll
    * blitz3dsdk.inc - contains Blitz3D constants like key codes, data types and other constants 
    * b3dmacro.inc - contains assember macroses for SDK for easy text output, random generator and other
    * blitz3d.inc - special header, it simplifies the code structure to a minimum, which makes programming easier for novice users. (used throughout the examples).
    * res.inc - contain resources description
* \examples - contain a few examples
* \help\asm_commands - contain few examples from help that match the commands in the [Documentation repository](https://blitz3dfasm.github.io/Blitz3DFASMSDK_HELP/help/asm_commands/index.htm).
* \media - contains media files like: sounds, images, models, textures, which are used in the examples located in the help\ folder

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
* Next, if you use graphics, you need to create a window by bbGraphics3D invoke, then some custom code follows.
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
        
 # A simple Blitz3D Base functions replacement on Assembly x86 language:
 
For Sin, Cos Tan functions is need's to create coefficinet varible (in the data section or in the non-executable fragment of the code section). Varible must be contain pi/180 value:

      pi_div_180   dd	0.0174533f	; float pi/180 = 0.0174533f or 3C8EFA35h in hex

This value is needed to calculate trigonometric functions in degrees.

## Sin(degrees_value)

      fld	dword [pi_div_180]
      fmul	dword [degrees_value]
      fsin
      fstp  dword [result] 
   
## Cos(degrees_value)

      fld	dword [pi_div_180]
      fmul	dword [degrees_value]
      fcos
      fstp  dword [result] 

## Tan(degrees_value)

The *fptan* instruction pushes two values on the top of the stack: sine (sin(x)) and cosine (cos(x)). The cosine (cos(x)) is not used in this code and is simply removed from the stack with "fstp st(0)".

      fld	dword ptr [pi_div_180]
      fmul	dword ptr [degrees_value]
      fptan
      fstp	ST0               ; remove cos(x)
      fstp  dword [result]    ; save sin(x)

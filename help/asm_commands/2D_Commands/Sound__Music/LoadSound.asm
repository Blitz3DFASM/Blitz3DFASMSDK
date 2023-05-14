; bbLoadSound Example
include "blitz3d.inc"

blaster BBSound 0
rel_path db "../../../../media/"
sound_file db "blaster.wav",0

start:

     ; Try to load sound from app run path
     cinvoke bbLoadSound, sound_file
     cmp eax,0
     jne sound_loaded
     ; If sound not loaded try to load it from media folder of SDK
     cinvoke bbLoadSound, rel_path
sound_loaded:
     mov [blaster],eax

     cinvoke bbPlaySound, [blaster]

     ; Wait about a second before exit, for the sound to be played.
     cinvoke bbDelay, 1000
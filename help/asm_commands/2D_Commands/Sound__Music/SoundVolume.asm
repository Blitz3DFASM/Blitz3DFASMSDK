; bbSoundVolume Example
include "blitz3d.inc"

sound BBSound 0
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
     mov [sound],eax

     ; Set Volume of sound to 10% level
     cinvoke bbSoundVolume, [sound], 0.1f

     ; Play a sound and wait a second to it play completed
     cinvoke bbPlaySound, [sound]
     cinvoke bbDelay, 1000
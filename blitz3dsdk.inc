;***********************************************
;*       Blitz3D SDK V1.05 FASM constants      *
;***********************************************

; Boolean values

BBFALSE = 0
BBTRUE = 1

; Graphics window mode

GFX_DEFAULT = 0
GFX_FULLSCREEN = 1
GFX_WINDOWED = 2
GFX_WINDOWEDSCALED = 3

PROJ_NONE = 0
PROJ_PERSPECTIVE = 1
PROJ_ORTHO = 2

; Light type

LIGHT_DIRECTIONAL = 1
LIGHT_POINT = 2
LIGHT_SPOT = 3

TX_COLOR = 1
TX_ALPHA = 2
TX_MASKED = 4
TX_MIP = 8
TX_CLAMPU = 16
TX_CLAMPV = 32
TX_SPHERE = 64
TX_CUBIC = 128
TX_VRAM = 256
TX_HIGHCOLOR = 512

TX_BLEND_NONE = 0
TX_BLEND_ALPHA = 1
TX_BLEND_MULT = 2
TX_BLEND_ADD = 3
TX_BLEND_DOT3 = 4
TX_BLEND_MULT2 = 5

CUBEFACE_LEFT = 0
CUBEFACE_FRONT = 1
CUBEFACE_RIGHT = 2
CUBEFACE_BACK = 3
CUBEFACE_TOP = 4
CUBEFACE_BOTTOM = 5

CUBEMODE_SPECULAR = 1
CUBEMODE_DIFFUSE = 2
CUBEMODE_REFRACTION = 3

BRUSHBLEND_NONE = 0
BRUSHBLEND_ALPHA = 1
BRUSHBLEND_MULTIPLY = 2
BRUSHBLEND_ADD = 3

BRUSHFX_NONE = 0
BRUSHFX_FULLBRIGHT = 1
BRUSHFX_VERTEXCOLOR = 2
BRUSHFX_FLAT = 4
BRUSHFX_NOFOG = 8
BRUSHFX_DOUBLESIDED = 16
BRUSHFX_VERTEXALPHA = 32

COLLIDE_SPHERESPHERE = 1
COLLIDE_SPHEREPOLY = 2
COLLIDE_SPHEREBOX = 3

COLLIDE_STOP = 1
COLLIDE_SLIDE1 = 2
COLLIDE_SLIDE2 = 3

PICK_NONE = 0
PICK_SPHERE = 1
PICK_POLY = 2
PICK_BOX = 3

ANIM_STOP = 0
ANIM_LOOP = 1
ANIM_PINGPONG = 2
ANIM_ONCE = 3

SPRITE_TURNXY = 1
SPRITE_STILL = 2
SPRITE_ALIGNZ = 3
SPRITE_TURNY = 4

PLAYCD_SINGLE = 1
PLAYCD_LOOP = 2
PLAYCD_ALL = 3

MOUSE_BUTTON = 1
MOUSE_RIGHTBUTTON = 2
MOUSE_MIDDLEBUTTON = 3

JOYTYPE_NONE = 0
JOYTYPE_DIGITAL = 1
JOYTYPE_ANALOG = 2

; Key codes

KEY_ESCAPE = 1
KEY_TAB = 15
KEY_SPACE = 57
KEY_RETURN = 28
KEY_LEFTSHIFT = 42
KEY_LEFTCONTROL = 29
KEY_LEFTALT = 56
KEY_RIGHTSHIFT = 54
KEY_RIGHTCONTROL = 157
KEY_RIGHTALT = 184

KEY_UP = 200
KEY_LEFT = 203
KEY_RIGHT = 205
KEY_DOWN = 208

KEY_F1 = 59
KEY_F2 = 60
KEY_F3 = 61
KEY_F4 = 62
KEY_F5 = 63
KEY_F6 = 64
KEY_F7 = 65
KEY_F8 = 66
KEY_F9 = 67
KEY_F10 = 68

KEY_Q = 16
KEY_W = 17
KEY_E = 18
KEY_R = 19
KEY_T = 20
KEY_Y = 21
KEY_U = 22
KEY_I = 23
KEY_O = 24
KEY_P = 25

KEY_A = 30
KEY_S = 31
KEY_D = 32
KEY_F = 33
KEY_G = 34
KEY_H = 35
KEY_J = 36
KEY_K = 37
KEY_L = 38

KEY_Z = 44
KEY_X = 45
KEY_C = 46
KEY_V = 47
KEY_B = 48
KEY_N = 49
KEY_M = 50

KEY_1 = 2
KEY_2 = 3
KEY_3 = 4
KEY_4 = 5
KEY_5 = 6
KEY_6 = 7
KEY_7 = 8
KEY_8 = 9
KEY_9 = 10
KEY_0 = 11

KEY_MINUS = 12
KEY_EQUALS = 13
KEY_BACKSPACE = 14
KEY_LEFTBRACKET = 26
KEY_RIGHTBRACKET = 27
KEY_SEMICOLON = 39
KEY_APOSTROPHE = 40
KEY_GRAVE = 41
KEY_BACKSLASH = 43
KEY_COMMA = 51
KEY_PERIOD = 52
KEY_SLASH = 53
KEY_CAPSLOCK = 58

KEY_PRINT = 183
KEY_SCROLLLOCK = 70
KEY_PAUSEBREAK = 197
KEY_INSERT = 210
KEY_DELETE = 211
KEY_HOME = 199
KEY_END = 207
KEY_PAGEUP = 201
KEY_PAGEDOWN = 209

KEY_NUMLOCK = 69
KEY_NUMPADDIVIDE = 181
KEY_NUMPADMULT = 55
KEY_NUMPADMINUS = 74
KEY_NUMPADPLUS = 78
KEY_NUMPADENTER = 156
KEY_NUMPADDOT = 83
KEY_NUMPAD0 = 82
KEY_NUMPAD1 = 79
KEY_NUMPAD2 = 80
KEY_NUMPAD3 = 81
KEY_NUMPAD4 = 75
KEY_NUMPAD5 = 76
KEY_NUMPAD6 = 77
KEY_NUMPAD7 = 71
KEY_NUMPAD8 = 72
KEY_NUMPAD9 = 73

KEY_F11 = 87
KEY_F12 = 88
KEY_LEFTWINDOWS = 219
KEY_RIGHTWINDOWS = 220
KEY_NUMPADEQUALS = 141
KEY_NUMPADCOMMA = 179
KEY_OEM_102 = 86
KEY_AT = 145
KEY_COLON = 146
KEY_UNDERLINE = 147
KEY_BREAK = 149

KEY_PREVIOUSTRACK = 144
KEY_NEXTTRACK = 153
KEY_MUTE = 160
KEY_PLAYPAUSE = 162
KEY_STOP = 164
KEY_VOLUMELESS = 174
KEY_VOLUMEMORE = 176

KEY_APPS = 221
KEY_POWER = 222
KEY_SLEEP = 223
KEY_WAKE = 227

KEY_WEBHOME = 178
KEY_WEBSEARCH = 229
KEY_WEBFAVORITES = 230
KEY_WEBREFRESH = 231
KEY_WEBSTOP = 232
KEY_WEBFORWARD = 233
KEY_WEBBACK = 234

KEY_MYCOMPUTER = 235
KEY_CALCULATOR = 161
KEY_MAIL = 236
KEY_MEDIASELECT = 237

; Object types (C int = assembler dd)

BBTimer fix dd
BBSound  fix dd
BBChannel fix dd 

BBGraphics fix dd 
BBImage fix dd
BBMovie fix dd
BBFont fix dd
BBCanvas fix dd
BBScene fix dd

BBLight fix dd
BBCamera fix dd
BBModel fix dd
BBEntity fix dd
BBSurface fix dd
BBTexture fix dd
BBBrush fix dd
BBPivot fix dd
BBSprite fix dd
BBPlaneModel fix dd
BBMeshModel fix dd
BBQ3BSPModel fix dd
BBMD2Model fix dd
BBMirror fix dd
BBTerrain fix dd

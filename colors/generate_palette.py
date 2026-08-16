# Generator script based on: https://gist.github.com/jake-stewart/0a8ea46159a7da2c808e5be2177e1783
# Interpolation logic copied from: https://gist.github.com/jake-stewart/1533b798cffcc08508803bdba8b9e878
import math
import json

def rgb_to_xyz(r, g, b):
    # sRGB to XYZ conversion
    def linearize(c):
        c = c / 255.0
        if c > 0.04045:
            return math.pow((c + 0.055) / 1.055, 2.4)
        else:
            return c / 12.92
    
    r = linearize(r)
    g = linearize(g)
    b = linearize(b)
    
    x = (r * 0.4124 + g * 0.3576 + b * 0.1805)
    y = (r * 0.2126 + g * 0.7152 + b * 0.0722)
    z = (r * 0.0193 + g * 0.1192 + b * 0.9505)
    
    return x, y, z

def xyz_to_lab(x, y, z):
    # Reference white (D65)
    ref_x, ref_y, ref_z = 0.95047, 1.00000, 1.08883
    
    def f(t):
        if t > 0.008856:
            return math.pow(t, 1/3)
        else:
            return (7.787 * t) + (16 / 116)
    
    x = x / ref_x
    y = y / ref_y
    z = z / ref_z
    
    l = (116 * f(y)) - 16
    a = 500 * (f(x) - f(y))
    b = 200 * (f(y) - f(z))
    
    return l, a, b

def lab_to_xyz(l, a, b):
    # Reference white (D65)
    ref_x, ref_y, ref_z = 0.95047, 1.00000, 1.08883
    
    y = (l + 16) / 116
    x = a / 500 + y
    z = y - b / 200
    
    def f_inv(t):
        if math.pow(t, 3) > 0.008856:
            return math.pow(t, 3)
        else:
            return (t - 16 / 116) / 7.787
            
    x = ref_x * f_inv(x)
    y = ref_y * f_inv(y)
    z = ref_z * f_inv(z)
    
    return x, y, z

def xyz_to_rgb(x, y, z):
    r = x *  3.2406 + y * -1.5372 + z * -0.4986
    g = x * -0.9689 + y *  1.8758 + z *  0.0415
    b = x *  0.0557 + y * -0.2040 + z *  1.0570
    
    def delinearize(c):
        if c > 0.0031308:
            return 1.055 * math.pow(c, 1/2.4) - 0.055
        else:
            return 12.92 * c
            
    r = int(max(0, min(255, round(delinearize(r) * 255))))
    g = int(max(0, min(255, round(delinearize(g) * 255))))
    b = int(max(0, min(255, round(delinearize(b) * 255))))
    
    return r, g, b

def hex_to_rgb(hx):
    hx = hx.lstrip('#')
    return tuple(int(hx[i:i+2], 16) for i in (0, 2, 4))

def rgb_to_hex(r, g, b):
    return '#{:02x}{:02x}{:02x}'.format(r, g, b)

def rgb_to_lab(r, g, b):
    x, y, z = rgb_to_xyz(r, g, b)
    return xyz_to_lab(x, y, z)

def lab_to_rgb2(l, a, b):
    x, y, z = lab_to_xyz(l, a, b)
    return xyz_to_rgb(x, y, z)

def lerp_lab(t, lab1, lab2):
    return (
        lab1[0] + t * (lab2[0] - lab1[0]),
        lab1[1] + t * (lab2[1] - lab1[1]),
        lab1[2] + t * (lab2[2] - lab1[2]),
    )

def generate_256_palette(base16, bg, fg, harmonious=True):
    # Convert inputs to RGB then LAB
    bg_rgb = hex_to_rgb(bg)
    fg_rgb = hex_to_rgb(fg)
    base16_rgb = [hex_to_rgb(c) for c in base16]
    
    base8_lab = [
        rgb_to_lab(*bg_rgb),
        rgb_to_lab(*base16_rgb[1]),
        rgb_to_lab(*base16_rgb[2]),
        rgb_to_lab(*base16_rgb[3]),
        rgb_to_lab(*base16_rgb[4]),
        rgb_to_lab(*base16_rgb[5]),
        rgb_to_lab(*base16_rgb[6]),
        rgb_to_lab(*fg_rgb),
    ]

    is_light_theme = base8_lab[7][0] < base8_lab[0][0]
    if is_light_theme and not harmonious:
        base8_lab[0], base8_lab[7] = base8_lab[7], base8_lab[0]

    palette = [*base16]
    
    for r in range(6):
        c0 = lerp_lab(r / 5, base8_lab[0], base8_lab[1])
        c1 = lerp_lab(r / 5, base8_lab[2], base8_lab[3])
        c2 = lerp_lab(r / 5, base8_lab[4], base8_lab[5])
        c3 = lerp_lab(r / 5, base8_lab[6], base8_lab[7])
        
        for g in range(6):
            c4 = lerp_lab(g / 5, c0, c1)
            c5 = lerp_lab(g / 5, c2, c3)
            
            for b in range(6):
                c6 = lerp_lab(b / 5, c4, c5)
                rgb_val = lab_to_rgb2(*c6)
                palette.append(rgb_to_hex(*rgb_val))
                
    for i in range(24):
        t = (24 - i) / 25
        lab = lerp_lab(t, base8_lab[0], base8_lab[7])
        rgb_val = lab_to_rgb2(*lab)
        palette.append(rgb_to_hex(*rgb_val))
        
    return palette

# Define our base 16 colors
bg = "#ffffff"
fg = "#000000"

# Based on implementation plan
base16 = [
    "#000000", # 0: Normal Black
    "#c82829", # 1: Normal Red
    "#718c00", # 2: Normal Green
    "#f5871f", # 3: Normal Yellow
    "#4271ae", # 4: Normal Blue
    "#8959a8", # 5: Normal Magenta
    "#3e999f", # 6: Normal Cyan
    "#efefef", # 7: Normal White (selection)
    "#8e908c", # 8: Bright Black
    "#ffc1bf", # 9: Bright Red
    "#aaf2bb", # 10: Bright Green
    "#fee2ae", # 11: Bright Yellow
    "#a9ddff", # 12: Bright Blue
    "#d7005f", # 13: Bright Magenta
    "#27bbbb", # 14: Bright Cyan
    "#ffffff", # 15: Bright White
]

res = generate_256_palette(base16, bg, fg, harmonious=True)
print(json.dumps(res, indent=2))

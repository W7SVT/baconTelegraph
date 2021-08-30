print("Keyboard Running")

import board
from kmk.keys import KC
from kmk.kmk_keyboard import KMKKeyboard
from kmk.matrix import DiodeOrientation
from kmk.hid import HIDModes
from kmk.modules.modtap import ModTap
from kmk.modules.layers import Layers

## Tired of typing KMKKeyboard
keyboard = KMKKeyboard()

# Set tap time
keyboard.tap_time = 725

# Config GPIO
keyboard.col_pins = (board.GP2, board.GP3, board.GP4, board.GP5, board.GP6, board.GP7)
keyboard.row_pins = (board.GP8, board.GP9, board.GP10, board.GP11, board.GP12)

# Could not figure a way to get the USB on top so right side it is
keyboard.col_pins = tuple(reversed(keyboard.col_pins))
keyboard.row_pins = tuple(reversed(keyboard.row_pins))

keyboard.diode_orientation = DiodeOrientation.COLUMNS

#To make this work at all we need long press and layers, like parfeit
keyboard.modules.append(ModTap())
keyboard.modules.append(Layers())

# this is much easier to type over and over
XXXXX = KC.TRNS

keyboard.keymap = [
    # SHORT PRESS
    # [---------------------------------------------------------------------]
    # |   Q  |   W  |   E  |   R  |   T  |   Y  |   U  |   I  |   O  |   P  |
    # |------+------+------+------+------+------+------+------+------+------|
    # |   A  |   S  |   D  |   F  |   G  |   H  |   J  |   K  |   L  |  ESC |
    # |------+------+------+------+------+-------------+------+------+------|
    # |   Z  |   X  |   C  |   V  |   B  |   N  |   M  | BSPC |  SPC |  ENT |
    # [---------------------------------------------------------------------]
    # LONG PRESS
    # [---------------------------------------------------------------------]
    # |   Q  |   W  |   E  |   R  |   T  |   Y  |   U  |   I  |   O  |   P  |
    # |------+------+------+------+------+------+------+------+------+------|
    # |   A  |   S  |   D  |   F  |   G  |   H  |   J  |   K  |   L  | SHFT |
    # |------+------+------+------+------+-------------+------+------+------|
    # | CTRL | ALT  | Ly1  | Ly2  | Ly3  | Ly4  | Ly5  |  ALT | CTRL | SHFT |
    # [---------------------------------------------------------------------]
    [
        KC.Q,    KC.W,    KC.E,    KC.R,    KC.T,    KC.Y,    KC.U,    KC.I,    KC.O,    KC.P,
        KC.A,    KC.S,    KC.D,    KC.F,    KC.G,    KC.H,    KC.J,    KC.K,    KC.L,    KC.MT(KC.ESC, KC.RSFT),
        KC.MT(KC.Z, KC.LCTRL), KC.MT(KC.X, KC.LALT), KC.LT(1, KC.C), KC.LT(2, KC.V), KC.LT(3, KC.B),
        KC.LT(4, KC.N, ), KC.LT(5, KC.M, ), KC.MT(KC.BSPC, KC.RALT), KC.MT(KC.SPC, KC.RCTRL), KC.MT(KC.ENT, KC.RSFT),

    ],
    # Layout 2
    # [---------------------------------------------------------------------]
    # |   1  |   2  |   3  |   4  |   5  |   6  |   7  |   8  |   9  |   0  |
    # |------+------+------+------+------+------+------+------+------+------|
    # |   !  |   @  |   #  |   $  |   %  |   ^  |   &  |   *  |   (  |   )  |
    # |------+------+------+------+------+-------------+------+------+------|
    # |      |      |      |      |      |      |      |      |  DEL |      |
    # [---------------------------------------------------------------------]
    [
        KC.N1,   KC.N2,   KC.N3,   KC.N4,   KC.N5,   KC.N6,   KC.N7,   KC.N8,   KC.N9,   KC.N0,
        KC.EXLM, KC.AT,   KC.HASH, KC.DLR,  KC.PERC, KC.CIRC, KC.AMPR, KC.ASTR, KC.LPRN, KC.RPRN,
        XXXXX,   XXXXX,   XXXXX,   XXXXX,   XXXXX,   XXXXX,   XXXXX,   XXXXX,   KC.DEL,  XXXXX,
    ],
    # Layout 3
    # [---------------------------------------------------------------------]
    # |  TAB |      |      |      |      |   -  |   =  |   [  |   ]  |   \  |
    # |------+------+------+------+------+------+------+------+------+------|
    # |      |      |      |      |      |      |      |   /  |   ;   | '  |
    # |------+------+------+------+------+-------------+------+------+------|
    # |      |      |      |      |      |  ,   |  .   |  <   |  >   |  ?   |
    # [---------------------------------------------------------------------]
    [
        KC.TAB,  XXXXX, XXXXX, XXXXX, XXXXX, KC.MINS, KC.EQL,  KC.LBRC, KC.RBRC, KC.BSLS,
        XXXXX,   XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,    XXXXX,  KC.SLSH, KC.SCLN, KC.QUOT,
        XXXXX,   XXXXX, XXXXX, XXXXX, XXXXX, KC.COMM, KC.DOT,  KC.DOWN,   KC.UP, KC.RGHT,
    ],
    # Layout 3
    # [---------------------------------------------------------------------]
    # |      |      |      |      |      |  _   |  +   |   {  |   }  |  |   |
    # |------+------+------+------+------+------+------+------+------+------|
    # |      |      |      |      |      |      |  <   |   >  |   :  |  "   |
    # |------+------+------+------+------+-------------+------+------+------|
    # |      |      |      |      |      |      | HOME | PGDN | PGUP | END  |
    # [---------------------------------------------------------------------]
    [
        XXXXX,  XXXXX, XXXXX, XXXXX, XXXXX, KC.UNDS, KC.PLUS, KC.LCBR, KC.RCBR, KC.PIPE,
        XXXXX,  XXXXX, XXXXX, XXXXX, XXXXX, KC.LABK, KC.RABK, KC.QUES, KC.COLN, KC.DQUO,
        XXXXX,  XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,   KC.HOME, KC.PGDN, KC.PGUP, KC.END,
    ],
    # Layout 4 unused for the now
    # [---------------------------------------------------------------------]
    # |      |      |      |      |      |      |      |      |      |      |
    # |------+------+------+------+------+------+------+------+------+------|
    # |      |      |      |      |      |      |      |      |      |      |
    # |------+------+------+------+------+-------------+------+------+------|
    # |      |      |      |      |      |      |      |      |      |      |
    # [---------------------------------------------------------------------]
    [
        XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,
        XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,
        XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,
    ],
    # Layout 5 unused for the now
    # [---------------------------------------------------------------------]
    # |      |      |      |      |      |      |      |      |      |      |
    # |------+------+------+------+------+------+------+------+------+------|
    # |      |      |      |      |      |      |      |      |      |      |
    # |------+------+------+------+------+-------------+------+------+------|
    # |      |      |      |      |      |      |      |      |      |      |
    # [---------------------------------------------------------------------]
    [
        XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,
        XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,
        XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX, XXXXX,
    ],

]

if __name__ == '__main__':
    keyboard.go()
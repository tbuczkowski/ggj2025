import time
from machine import Pin
import select
import sys

onboardLED = Pin(25, Pin.OUT)
top1 = Pin(2, Pin.IN, Pin.PULL_DOWN)
bottom2 = Pin(3, Pin.IN, Pin.PULL_DOWN)
top2 = Pin(4, Pin.IN, Pin.PULL_DOWN)
bottom1 = Pin(5, Pin.IN, Pin.PULL_DOWN)

cartridgeId = 0b000

button1 = Pin(26, Pin.IN, Pin.PULL_UP)
button2 = Pin(27, Pin.IN, Pin.PULL_UP)

b1on = False
b2on = False

def toggleOnboardLED():
    onboardLED.toggle()

toggleOnboardLED()

while True:
    #if top1.value() == 1:
    #    cartridgeId = cartridgeId | 0b0001
    #if top2.value() == 1:
    #    cartridgeId = cartridgeId | 0b0010
    #if bottom2.value() == 1:
    #    cartridgeId = cartridgeId | 0b0100
    #if bottom1.value() == 1:
    #    cartridgeId = cartridgeId | 0b1000
    #print(bin(cartridgeId))
    if button1.value() == 0 and b1on == False:
        print('redOn')
        b1on = True
        toggleOnboardLED()
    elif button1.value() == 1 and b1on == True:
        print('redOff')
        b1on = False
        toggleOnboardLED()
    if button2.value() == 0 and b2on == False:
        print('greenOn')
        b2on = True
        toggleOnboardLED()
    elif button2.value() == 1 and b2on == True:
        print('greenOff')
        b2on = False
        toggleOnboardLED()
    time.sleep(0.001)
    #cartridgeId = 0b000
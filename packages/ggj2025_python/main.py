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

def toggleOnboardLED():
    onboardLED.toggle()

toggleOnboardLED()

while True:
    if top1.value() == 1:
        cartridgeId = cartridgeId | 0b0001
    if top2.value() == 1:
        cartridgeId = cartridgeId | 0b0010
    if bottom2.value() == 1:
        cartridgeId = cartridgeId | 0b0100
    if bottom1.value() == 1:
        cartridgeId = cartridgeId | 0b1000
    print(bin(cartridgeId))
    if button1.value() == 0:
        print('button1')
    if button2.value() == 0:
        print('button2')
    time.sleep(0.05)
    cartridgeId = 0b000
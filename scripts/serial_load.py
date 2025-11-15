#!/usr/bin/python3

import serial

SERIAL_PORT = "/dev/ttyUSB1"
BAUDRATE = 115200
FIRMWARE = "build/opensbi.bin"

print(f"Opening {SERIAL_PORT}...")
ser = serial.Serial(SERIAL_PORT, BAUDRATE, timeout=1)

print(f"Loading '{FIRMWARE}'...")
with open(FIRMWARE, "rb") as f:
    data = f.read()

print(f"Sending {len(data)} bytes...")
ser.write(data)
ser.flush()

print("Done!")
while True:
    line = ser.readline()
    if line:
        print(line.decode(errors="ignore"), end="")

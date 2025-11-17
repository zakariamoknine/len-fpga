#!/usr/bin/env python3

import serial
import struct
import time
import sys

SERIAL_PORT = "/dev/ttyUSB1"
BAUDRATE = 115200
PAYLOAD_FILE = "build/opensbi-1.7/platform/generic/firmware/fw_payload.bin"

SERIAL_MAGIC = 0x0dca18fb
LOAD_ADDR = 0x80000000
ENTRY_ADDR = 0x80000000

def main():
    with open(PAYLOAD_FILE, "rb") as f:
        payload = f.read()

    payload_size = len(payload)
    print(f"Payload size: {payload_size} bytes")

    #
    # firmware/serial.h:
    #
    # struct serial_header {
    #     uint32_t magic;
    #     uint32_t size;
    #     uint32_t load_addr;
    #     uint32_t entry_addr;
    # }
    #
    header = struct.pack("<IIII", SERIAL_MAGIC, payload_size, LOAD_ADDR, ENTRY_ADDR)

    with serial.Serial(SERIAL_PORT, BAUDRATE, timeout=1) as ser:
        print(f"Sending header...")
        ser.write(header)
        ser.flush()

        time.sleep(1);

        print("Sending payload...")
        chunk_size = 1024
        total_sent = 0

        for i in range(0, payload_size, chunk_size):
            chunk = payload[i:i+chunk_size]
            ser.write(chunk)
            ser.flush()
            total_sent += len(chunk)

            percent = (total_sent * 100) // payload_size
            print(f"\rProgress: {percent}%", end="", flush=True)

            time.sleep(0.001)

        print("\nDone sending payload!")

        while True:
            data = ser.read(256)
            if data:
                sys.stdout.write(data.decode("latin1", errors="replace"))
                sys.stdout.flush()

if __name__ == "__main__":
    main()

#!/usr/bin/env python3

import serial
import struct
import time
import sys
import argparse

SERIAL_MAGIC = 0x0dca18fb
LOAD_ADDR = 0x80000000
ENTRY_ADDR = 0x80000000

def main():
    parser = argparse.ArgumentParser(description="Send a payload over serial boot.")
    parser.add_argument(
            "payload_file",
            help="Path to the fw_payload.bin file"
            )
    parser.add_argument(
            "-p", "--port",
            default="/dev/ttyUSB1",
            help="Serial port to use (default: /dev/ttyUSB1)"
            )
    parser.add_argument(
            "-b", "--baudrate",
            type=int,
            default=115200,
            help="Baudrate to use (default: 115200)"
            )

    args = parser.parse_args()

    payload_file = args.payload_file
    serial_port = args.port
    baudrate = args.baudrate

    print("================ SERIAL BOOT ================")
    print(f"Using serial port: {serial_port}")
    print(f"Baudrate: {baudrate}")
    print(f"Payload file: {payload_file}")

    with open(payload_file, "rb") as f:
        payload = f.read()

    payload_size = len(payload)
    print(f"Payload size: {payload_size} bytes")

    header = struct.pack("<IIII", SERIAL_MAGIC, payload_size, LOAD_ADDR, ENTRY_ADDR)

    with serial.Serial(serial_port, baudrate, timeout=1) as ser:
        print("Sending header...")
        ser.write(header)
        ser.flush()

        time.sleep(0.5)

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

            time.sleep(0.0001)

        print("\n==================== DONE ===================\n\n")

        while True:
            data = ser.read(1)
            if data:
                sys.stdout.write(data.decode("latin1", errors="replace"))
                sys.stdout.flush()

if __name__ == "__main__":
    main()

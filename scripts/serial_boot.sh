#!/bin/bash

magic=0xACF3FA19
dev="/dev/ttyUSB1"
baudrate="460800"

usage() {
    echo "Usage: $0 [-p port] [-b baudrate] <kernel> <ramfs>"
    echo "  -p  Serial port (default: $dev)"
    echo "  -b  Baudrate    (default: $baudrate)"
    exit 1
}

while getopts ":p:b:h" opt; do
    case ${opt} in
        p) dev="$OPTARG" ;;
        b) baudrate="$OPTARG" ;;
        *) usage ;;
    esac
done
shift $((OPTIND - 1))

kernel="$1"
ramfs="$2"

[ -z "$kernel" ] || [ -z "$ramfs" ] && { echo "E: kernel and ramfs required."; usage; }
[ -f "$kernel" ] || { echo "E: '$kernel' not found.";  exit 1; }
[ -f "$ramfs"  ] || { echo "E: '$ramfs'  not found.";  exit 1; }
[ -e "$dev"    ] || { echo "E: '$dev'    not found.";  exit 1; }

send_crc() {
    local file="$1"
    python3 - "$file" >&3 <<'EOF'
import sys, zlib
with open(sys.argv[1], 'rb') as f:
    crc = zlib.crc32(f.read()) & 0xFFFFFFFF
sys.stdout.buffer.write(crc.to_bytes(4, 'little'))
EOF
}

send_image() {
    local name="$1"
    local file="$2"
    local size
    size=$(stat -c%s "$file")

    echo "--- $name: $size bytes ---"

    perl -e "print pack('VV', $magic, $size)" >&3

    sleep 0.2

    pv -N "$name" -s "$size" "$file" >&3

    send_crc "$file"

    sleep 0.2
}

echo "========= SERIAL BOOT ========="
echo "Port:     $dev"
echo "Baudrate: $baudrate"
echo "Kernel:   $kernel  ($(stat -c%s "$kernel") bytes)"
echo "Ramfs:    $ramfs   ($(stat -c%s "$ramfs") bytes)"
echo "==============================="

exec 3<> "$dev"
stty -F "$dev" "$baudrate" cs8 -cstopb -parenb raw -echo || {
    echo "E: failed to configure $dev"
    exec 3>&-
    exit 1
}

sleep 2

send_image "kernel" "$kernel"
send_image "ramfs"  "$ramfs"

exec 3>&-
echo "============ DONE ============="

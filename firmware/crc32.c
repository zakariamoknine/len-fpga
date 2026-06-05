#include "crc32.h"

static const uint32_t tab[16] = {
    0x00000000, 0x1DB71064, 0x3B6E20C8, 0x26D930AC,
    0x76DC4190, 0x6B6B51F4, 0x4DB26158, 0x5005713C,
    0xEDB88320, 0xF00F9344, 0xD6D6A3E8, 0xCB61B38C,
    0x9B64C2B0, 0x86D3D2D4, 0xA00AE278, 0xBDBDF21C,
};

uint32_t crc32_init(void)
{
    return 0xFFFFFFFF;
}

uint32_t crc32_update(uint32_t crc, uint8_t byte)
{
    crc = (crc >> 4) ^ tab[(crc ^ (uint32_t)byte) & 0x0F];
    crc = (crc >> 4) ^ tab[(crc ^ (uint32_t)(byte >> 4)) & 0x0F];
    return crc;
}

uint32_t crc32_final(uint32_t crc)
{
    return crc ^ 0xFFFFFFFF;
}

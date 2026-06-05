#include "panic.h"

void panic(const char *str)
{
	print("====[PANIC]====\n");
	print("%s", str);
	print("Rebooting...\n\n");

	// Wait one second then reboot the box
	udelay(1000000);
	reboot();

	__builtin_unreachable();
}

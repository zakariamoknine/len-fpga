#include "string.h"

int strcmp(const char* str1, const char* str2)
{
	while (*str1 && (*str1 == *str2)) {
		str1++;
		str2++;
	}
	return (unsigned char)(*str1) - (unsigned char)(*str2);
}

int strncmp(const char* str1, const char* str2, size_t n)
{
	for (size_t i = 0; i < n; i++) {
		if (str1[i] != str2[i] || str1[i] == '\0')
			return (unsigned char)str1[i] -
			       (unsigned char)str2[i];
	}
	return 0;
}

size_t strlen(const char* str)
{
	const char* p = str;
	while (*p) {
		p++;
	}
	return (size_t)(p - str);
}

size_t strnlen(const char* str, size_t maxlen)
{
	size_t i = 0;
	while (i < maxlen && str[i] != '\0') {
		i++;
	}
	return i;
}

char* strrchr(const char* str, int c)
{
	const char* last = 0;
	uint8_t ch = (uint8_t)c;

	while (*str) {
		if ((uint8_t)*str == ch) {
			last = str;
		}
		str++;
	}
	if (ch == '\0') {
		return (char*)str;
	}
	return (char*)last;
}

void* memset(void* ptr, int val, size_t n)
{
	uint8_t* p = (uint8_t*)ptr;
	for (size_t i = 0; i < n; i++) {
		p[i] = (uint8_t)val;
	}
	return ptr;
}

void* memcpy(void* dest, const void* src, size_t n)
{
	uint8_t* d = (uint8_t*)dest;
	const uint8_t* s = (const uint8_t*)src;
	for (size_t i = 0; i < n; i++) {
		d[i] = s[i]; 
	}
	return dest;     
}

int memcmp(const void* a, const void* b, size_t n)
{
	const uint8_t* pa = (const uint8_t*)a;
	const uint8_t* pb = (const uint8_t*)b;
	for (size_t i = 0; i < n; i++) {
		if (pa[i] != pb[i]) {
			return (int)pa[i] - (int)pb[i];
		}
	}
	return 0;
}

void* memchr(const void* ptr, int val, size_t n)
{
	const uint8_t* p = (const uint8_t*)ptr;
	uint8_t c = (uint8_t)val;
	for (size_t i = 0; i < n; i++) {
		if (p[i] == c) {
			return (void*)(p + i);
		}
	}
	return 0;
}

void* memmove(void* dest, const void* src, size_t n)
{
	uint8_t* d = (uint8_t*)dest;
	const uint8_t* s = (const uint8_t*)src;
	if (d < s) {
		for (size_t i = 0; i < n; i++) {
			d[i] = s[i];
		}
	} else if (d > s) {
		for (size_t i = n; i > 0; i--) {
			d[i - 1] = s[i - 1];
		}
	}
	return dest;
}

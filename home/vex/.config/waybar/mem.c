#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
    FILE *f = fopen("/proc/meminfo", "r");
    if (!f) return 1;

    long mem_total = 0, mem_free = 0, buffers = 0, cached = 0;
    char key[64];
    long value;
    char unit[16];

    while (fscanf(f, "%63s %ld %15s\n", key, &value, unit) == 3) {
        if (strcmp(key, "MemTotal:") == 0) mem_total = value;
        else if (strcmp(key, "MemFree:") == 0) mem_free = value;
        else if (strcmp(key, "Buffers:") == 0) buffers = value;
        else if (strcmp(key, "Cached:") == 0) cached = value;
    }
    fclose(f);

    long used_kb = mem_total - mem_free - buffers - cached;
    long used_mb = used_kb / 1024;

    printf(" %ldM ", used_mb);
    return 0;
}

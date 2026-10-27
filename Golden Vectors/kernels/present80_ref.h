#ifndef PRESENT80_REF_H
#define PRESENT80_REF_H

#include <stdint.h>

typedef struct {
    uint16_t high;
    uint64_t low;
} present80_key_t;

uint64_t present80_next_round_key(present80_key_t *key, int round);

uint64_t present_encrypt(uint64_t state, present80_key_t key);

#endif
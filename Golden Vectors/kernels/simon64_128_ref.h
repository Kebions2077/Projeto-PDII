#ifndef SIMON64_128_REF_H
#define SIMON64_128_REF_H

#include <stdint.h>

typedef struct {
    uint32_t k[4];
} simon64_128_key_t;

uint32_t simon64_128_next_round_key(
    simon64_128_key_t *key,
    int round);

uint32_t simon64_128_f(uint32_t x);

void simon64_128_encrypt(
    uint32_t *x,
    uint32_t *y,
    simon64_128_key_t key);

#endif
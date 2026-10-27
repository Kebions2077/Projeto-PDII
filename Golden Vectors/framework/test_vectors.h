#ifndef TEST_VECTORS_H
#define TEST_VECTORS_H

#include <stdint.h>

typedef struct {
    const char *name;
    uint16_t key_high;
    uint64_t key_low;
    uint64_t plaintext;
    uint64_t ciphertext;
} present_test_vector_t;

typedef struct {
    const char *name;
    uint32_t key_k3;
    uint32_t key_k2;
    uint32_t key_k1;
    uint32_t key_k0;
    uint32_t plaintext_x;
    uint32_t plaintext_y;
    uint32_t ciphertext_x;
    uint32_t ciphertext_y;
} simon_test_vector_t;

static const present_test_vector_t PRESENT_VECTORS[] = {
    {
        "PRESENT_ZERO",
        0x0000,
        0x0000000000000000ULL,
        0x0000000000000000ULL,
        0x5579C1387B228445ULL
    },
    {
        "PRESENT_ALL_ONES",
        0xFFFF,
        0xFFFFFFFFFFFFFFFFULL,
        0xFFFFFFFFFFFFFFFFULL,
        0x3333DCD3213210D2ULL
    },
    {
        "PRESENT_ZERO_KEY_ONE_PLAIN",
        0x0000,
        0x0000000000000000ULL,
        0xFFFFFFFFFFFFFFFFULL,
        0xA112FFC72F68417BULL
    },
    {
        "PRESENT_ONE_KEY_ZERO_PLAIN",
        0xFFFF,
        0xFFFFFFFFFFFFFFFFULL,
        0x0000000000000000ULL,
        0xE72C46C0F5945049ULL
    }
};

#define PRESENT_VECTOR_COUNT \
    (sizeof(PRESENT_VECTORS) / sizeof(PRESENT_VECTORS[0]))

static const simon_test_vector_t SIMON_VECTORS[] = {
    {
        "SIMON64_128_OFFICIAL",
        0x1B1A1918,
        0x13121110,
        0x0B0A0908,
        0x03020100,
        0x656B696C,
        0x20646E75,
        0x44C8FC20,
        0xB9DFA07A
    }
};

#define SIMON_VECTOR_COUNT \
    (sizeof(SIMON_VECTORS) / sizeof(SIMON_VECTORS[0]))

#endif
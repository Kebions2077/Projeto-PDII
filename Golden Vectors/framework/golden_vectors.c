#include <stdio.h>
#include <stdint.h>

#include "test_vectors.h"


typedef struct {
    uint16_t high;
    uint64_t low;
} present80_key_t;

uint64_t present_encrypt(
    uint64_t state,
    present80_key_t key);


typedef struct {
    uint32_t k[4];
} simon64_128_key_t;

void simon64_128_encrypt(
    uint32_t *x,
    uint32_t *y,
    simon64_128_key_t key);


static void generate_present_vectors(FILE *file)
{
    fprintf(file, "# PRESENT-80 GOLDEN VECTORS\n");
    fprintf(file, "# name,key,plaintext,ciphertext\n");

    for (size_t i = 0; i < PRESENT_VECTOR_COUNT; i++) {

        present80_key_t key;

        key.high = PRESENT_VECTORS[i].key_high;
        key.low = PRESENT_VECTORS[i].key_low;

        uint64_t ciphertext = present_encrypt(
            PRESENT_VECTORS[i].plaintext,
            key);

        fprintf(
            file,
            "%s,%04X%016llX,%016llX,%016llX\n",
            PRESENT_VECTORS[i].name,
            key.high,
            (unsigned long long)key.low,
            (unsigned long long)PRESENT_VECTORS[i].plaintext,
            (unsigned long long)ciphertext);
    }

    fprintf(file, "\n");
}


static void generate_simon_vectors(FILE *file)
{
    fprintf(file, "# SIMON-64/128 GOLDEN VECTORS\n");
    fprintf(file, "# name,key,plaintext,ciphertext\n");

    for (size_t i = 0; i < SIMON_VECTOR_COUNT; i++) {

        simon64_128_key_t key;

        key.k[0] = SIMON_VECTORS[i].key_k0;
        key.k[1] = SIMON_VECTORS[i].key_k1;
        key.k[2] = SIMON_VECTORS[i].key_k2;
        key.k[3] = SIMON_VECTORS[i].key_k3;

        uint32_t x = SIMON_VECTORS[i].plaintext_x;
        uint32_t y = SIMON_VECTORS[i].plaintext_y;

        simon64_128_encrypt(
            &x,
            &y,
            key);

        fprintf(
            file,
            "%s,%08lX%08lX%08lX%08lX,%08lX%08lX,%08lX%08lX\n",
            SIMON_VECTORS[i].name,
            (unsigned long)key.k[3],
            (unsigned long)key.k[2],
            (unsigned long)key.k[1],
            (unsigned long)key.k[0],
            (unsigned long)SIMON_VECTORS[i].plaintext_x,
            (unsigned long)SIMON_VECTORS[i].plaintext_y,
            (unsigned long)x,
            (unsigned long)y);
    }

    fprintf(file, "\n");
}


int main(void)
{
    FILE *file = fopen(
        "golden_vectors.txt",
        "w");

    if (file == NULL) {
        perror("golden_vectors.txt");
        return 1;
    }

    fprintf(file, "# CRYPTOGRAPHIC GOLDEN VECTORS\n");
    fprintf(file, "# Generated directly from reference kernels\n\n");

    generate_present_vectors(file);
    generate_simon_vectors(file);

    fclose(file);

    printf("Golden vectors generated in golden_vectors.txt\n");

    return 0;
}
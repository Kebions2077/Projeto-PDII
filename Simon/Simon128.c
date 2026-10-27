
#include <stdio.h>
#include <stdint.h>

// Constantes do SIMON-64/128
#define SIMON_C  0xFFFFFFFCu
#define SIMON_Z3 0xFC2CE51207A635DBULL
#define RODADAS 44

// Chave de 128 bits, dividida em quatro palavras de 32 bits
typedef struct {
    uint32_t k[4];
} simon64_128_key_t;

// Rotação à direita
static uint32_t rotr32(uint32_t x, unsigned int n) {
    return (x >> n) | (x << (32 - n));
}

// Rotação à esquerda
static uint32_t rotl32(uint32_t x, unsigned int n) {
    return (x << n) | (x >> (32 - n));
}

// Gera a subchave da rodada atual
uint32_t simon64_128_next_round_key(
    simon64_128_key_t *key, int round) {

    uint32_t round_key = key->k[0];
    uint32_t temp = rotr32(key->k[3], 3);

    uint32_t new_key = key->k[0] ^ temp ^ key->k[1]
        ^ rotr32(temp ^ key->k[1], 1);

    new_key ^= SIMON_C;
    new_key ^= (uint32_t)((SIMON_Z3 >> round) & 1ULL);

    key->k[0] = key->k[1];
    key->k[1] = key->k[2];
    key->k[2] = key->k[3];
    key->k[3] = new_key;

    return round_key;
}

// Função F do SIMON
uint32_t simon64_128_f(uint32_t x) {
    return (rotl32(x, 1) & rotl32(x, 8))
           ^ rotl32(x, 2);
}

// Criptografa um bloco de 64 bits
void simon64_128_encrypt(
    uint32_t *x, uint32_t *y,
    simon64_128_key_t key) {

    for (int round = 0; round < RODADAS; round++) {
        uint32_t round_key =
            simon64_128_next_round_key(&key, round);

        uint32_t new_x =
            *y ^ simon64_128_f(*x) ^ round_key;

        uint32_t new_y = *x;

        *x = new_x;
        *y = new_y;
    }
}

int main(void) {
    // Chave de teste de 128 bits
    simon64_128_key_t key = {{
        0x03020100u,
        0x0b0a0908u,
        0x13121110u,
        0x1b1a1918u
    }};

    // Bloco de entrada de 64 bits
    uint32_t x = 0x656b696cu;
    uint32_t y = 0x20646e75u;

    // Resultado esperado do vetor de referência
    const uint32_t esperado_x = 0x44c8fc20u;
    const uint32_t esperado_y = 0xb9dfa07au;

    printf("=== SIMON-64/128 ===\n\n");

    printf("Bloco de entrada: %08x%08x\n", x, y);

    printf("Chave: ");
    printf("%08x%08x%08x%08x\n",
           key.k[3], key.k[2], key.k[1], key.k[0]);

    simon64_128_encrypt(&x, &y, key);

    printf("\nBloco criptografado: %08x%08x\n", x, y);

    printf("Resultado esperado:  %08x%08x\n",
           esperado_x, esperado_y);

    if (x == esperado_x && y == esperado_y) {
        printf("\nTESTE APROVADO!\n");
        printf("O resultado corresponde ao vetor esperado.\n");
    } else {
        printf("\nTESTE REPROVADO!\n");
        printf("Verifique a implementacao do algoritmo.\n");
        return 1;
    }

    return 0;
}

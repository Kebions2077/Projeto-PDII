#include <stdint.h>

// Constante do key schedule do SIMON-64/128
#define SIMON_C 0xFFFFFFFCu

// Sequência z3 do SIMON-64/128.
// O bit menos significativo é utilizado primeiro.
#define SIMON_Z3 0xFC2CE51207A635DBULL


/*
 * Chave de 128 bits:
 *
 *     master_key[127:96] -> k[3]
 *     master_key[95:64]  -> k[2]
 *     master_key[63:32]  -> k[1]
 *     master_key[31:0]   -> k[0]
 *
 * k[0] é a primeira round key utilizada
 * pelo algoritmo.
 */
typedef struct {
    uint32_t k[4];
} simon64_128_key_t;


/*
 * Rotação à direita de uma palavra de 32 bits.
 */
static uint32_t rotr32(uint32_t x, unsigned int n)
{
    return (x >> n) | (x << (32 - n));
}


/*
 * Gera a round key atual e atualiza a chave para a
 * próxima rodada.
 *
 * A janela corrente é:
 *
 *     k[0] = round key atual
 *     k[1]
 *     k[2]
 *     k[3]
 *
 * Após a atualização:
 *
 *     k[0] <- k[1]
 *     k[1] <- k[2]
 *     k[2] <- k[3]
 *     k[3] <- nova palavra
 */
uint32_t simon64_128_next_round_key(simon64_128_key_t *key, int round)
{
    uint32_t round_key = key->k[0];

    uint32_t temp = rotr32(key->k[3], 3);

    uint32_t new_key = key->k[0] ^ temp ^ key->k[1] ^ rotr32(temp ^ key->k[1], 1);

    new_key ^= SIMON_C;
    new_key ^= (uint32_t)((SIMON_Z3 >> round) & 0x1ULL);

    key->k[0] = key->k[1];
    key->k[1] = key->k[2];
    key->k[2] = key->k[3];
    key->k[3] = new_key;

    return round_key;
}


/*
 * Rotação à esquerda de uma palavra de 32 bits.
 */
static uint32_t rotl32(uint32_t x, unsigned int n)
{
    return (x << n) | (x >> (32 - n));
}


/*
 * Função F do SIMON-64/128.
 */
uint32_t simon64_128_f(uint32_t x)
{
    return (rotl32(x, 1) & rotl32(x, 8)) ^ rotl32(x, 2);
}


/*
 * Criptografa um bloco de 64 bits usando SIMON-64/128.
 *
 * x e y representam as duas palavras de 32 bits
 * do bloco de entrada.
 */
void simon64_128_encrypt(
    uint32_t *x,
    uint32_t *y,
    simon64_128_key_t key)
{
    for (int round = 0; round < 44; round++) {

        uint32_t round_key = simon64_128_next_round_key(&key, round);

        uint32_t new_x = *y ^ simon64_128_f(*x) ^ round_key;
        uint32_t new_y = *x;

        *x = new_x;
        *y = new_y;
    }
}
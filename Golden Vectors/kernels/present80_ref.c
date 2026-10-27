#include <stdint.h>

// S-Box do PRESENT
extern const uint8_t SBOX[16];


/*
 * Chave de 80 bits:
 *
 *     high = bits 79..64
 *     low  = bits 63..0
 */
typedef struct {
    uint16_t high;
    uint64_t low;
} present80_key_t;


/*
 * Gera a round key da rodada atual e atualiza
 * a chave de 80 bits para a próxima rodada.
 *
 * round_key = 64 bits superiores da chave atual.
 *
 * Depois:
 *   1. Rotação de 61 bits para a esquerda;
 *   2. S-Box nos 4 bits mais significativos;
 *   3. XOR do contador da rodada nos bits 19..15.
 */
uint64_t present80_next_round_key(present80_key_t *key, int round)
{
    uint64_t round_key = ((uint64_t)key->high << 48) | (key->low >> 16);

    uint16_t old_high = key->high;
    uint64_t old_low = key->low;

    key->high = (uint16_t)(old_low >> 3);
    key->low = (old_low << 61) | ((uint64_t)old_high << 45) | (old_low >> 19);

    key->high = (uint16_t)((key->high & 0x0FFF) | ((uint16_t)SBOX[key->high >> 12] << 12));

    key->low ^= ((uint64_t)(round & 0x1F) << 15);

    return round_key;
}


/*
 * Criptografa um bloco de 64 bits usando PRESENT-80.
 */
uint64_t present_encrypt(uint64_t state, present80_key_t key)
{
    for (int round = 1; round <= 31; round++) {

        uint64_t round_key = present80_next_round_key(&key, round);

        state ^= round_key;

        uint64_t temp_state = 0;

        for (int i = 0; i < 16; i++) {
            uint8_t nibble = (state >> (i * 4)) & 0xF;
            temp_state |= ((uint64_t)SBOX[nibble]) << (i * 4);
        }

        state = temp_state;

        temp_state = 0;

        for (int i = 0; i < 63; i++) {
            int target_pos = (16 * i) % 63;
            temp_state |= ((state >> i) & 0x1ULL) << target_pos;
        }

        temp_state |= (state & (1ULL << 63));

        state = temp_state;
    }

    // A chave já foi atualizada após a rodada 31.
    uint64_t final_key = ((uint64_t)key.high << 48) | (key.low >> 16);

    return state ^ final_key;
}
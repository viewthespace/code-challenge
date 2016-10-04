#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Entry kahn_hash_entry;
typedef struct Hash kahn_hash;

struct Entry {
    char *key;
    int value;
    kahn_hash_entry *next;
};

struct Hash {
    int size;
    kahn_hash_entry **entries;
};

int kahn_hash_crc(int size, char *key);
kahn_hash* kahn_hash_init(int size);
void kahn_hash_put(kahn_hash *hash, char *key, int value);

kahn_hash* kahn_hash_init(int size) {
    kahn_hash *hash = malloc(sizeof(kahn_hash));
    hash->size = size;
    hash->entries = malloc(sizeof(kahn_hash_entry) * hash->size);
    return hash;
}

void kahn_hash_put(kahn_hash *hash, char *key, int value){
    int hash_key = kahn_hash_crc(hash->size, key);
    kahn_hash_entry *entry = hash->entries[hash_key];
    while(entry) {
        if(!strcmp(key, entry->key)){
            entry->value = value;
            break;
        }
        entry = entry->next;
    }
    if(!entry){
        hash->entries[hash_key] = malloc(sizeof(kahn_hash_entry));
        hash->entries[hash_key]->key = key;
        hash->entries[hash_key]->value = value;
    }
}

int kahn_hash_get(kahn_hash *hash, char *key){
    int hash_key = kahn_hash_crc(hash->size, key);
    kahn_hash_entry *entry = hash->entries[hash_key];
    while(entry->key) {
        if(!strcmp(key, entry->key)){
            return entry->value;
        }
        entry = entry->next;
    }
    return NULL;
}

int kahn_hash_crc(int size, char *key){
    int hash = 0;
    for (int i = 0 ; key[i] != '\0' ; i++)
    {
        hash = 31*hash + key[i];
    }
    return hash % (size * size);
}

int kahn(int *matrix, int n) {
    int max = 1;
    kahn_hash *counter = kahn_hash_init(n * n);
    for(int i = 0; i < n; i++){
        char *key = "";
        char *keyI = "";
        for(int j = 0; j < n; j++){
            char *val = ':';
            char *valI = ':';
            char str_val[16];
            char str_valI[16];
            printf("%d\n", matrix[i * j + j]);
            snprintf(str_val, sizeof(str_val), "%d", matrix[i * j + j]);
            strcat(key, snprintf(str_val, sizeof(str_valI), "%d", matrix[i * j + j]));
        }
        kahn_hash_put(counter, key, (kahn_hash_get(counter, key) || 0) + 1 );
        kahn_hash_put(counter, key, (kahn_hash_get(counter, keyI) || 0) + 1 );
        if (kahn_hash_get(counter, key) > max) max = kahn_hash_get(counter, key);
        if (kahn_hash_get(counter, keyI) > max) max = kahn_hash_get(counter, key);
    }
    return max;
}

int main(int argc, char **argv) {
    kahn_hash *hash = kahn_hash_init(3 * 3);
    int matrix[] = (int []) {1,1,1,1,1,1,1,0,1};
    printf("%d", kahn(matrix, 3));
    return 0;
}

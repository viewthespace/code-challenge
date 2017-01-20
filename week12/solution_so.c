#include <stdlib.h>
#include <stdio.h>
#include <memory.h>

#define NULL -1

typedef struct Bucket {
  int min;
  int max;
} Bucket;

/*
 * max_gap
 * Time: O(n)
 * Memory: O(n)
 */
int max_gap(int *nums, int n) {
  int min = NULL;
  int max = NULL;

  for(int i = 0; i < n; i++) {
    int num = nums[i];
    if(min == NULL) {
      min = max = num;
    } else if (num < min) {
      min = num;
    } else if (num > max) {
      max = num;
    }
  }
  Bucket *buckets = malloc(sizeof(Bucket) * (n + 1));
  memset(buckets, NULL, sizeof(Bucket) * (n + 1));
  const int BUCKET_SIZE = ((max - min) / n);

  for(int i = 0; i < n; i++) {
    int num = nums[i];
    int b = (num - min) / BUCKET_SIZE;
    Bucket *bucket = &(buckets[b]);
    if(bucket->min == NULL) {
      bucket->min = num;
      bucket->max = num;
    } else if(num < bucket->min) {
      bucket->min = num;
    } else if(num > bucket->max) {
      bucket->max = num;
    }
  }

  int gap = 0;
  int last_max = buckets[0].min;

  for(int i = 0; i <= n; i++) {
    Bucket bucket = buckets[i];
    if(bucket.min == NULL) {
      continue;
    }
    if(bucket.min - last_max > gap) {
      gap = bucket.min - last_max;
    } else if(bucket.max - bucket.min > gap) {
      gap = bucket.max - bucket.min;
    }
    last_max = bucket.max;
  }
  return gap;
}

int main(int argc, char** argv) {
  int nums[11] = { 2, 5, 22, 53, 52, 3, 6, 20, 70, 74, 2 };
  printf("%i", max_gap(nums, 11));
  return 0;
}
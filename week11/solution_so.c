#include "secret_data_structure_so.h"

static int data[18] = { 2,9,10, 3,7,15, 5,12,12, 15,20,10, 19,24,8, INT32_MAX, INT32_MAX, INT32_MAX };
static int DATA_SIZE = 18;

/*
 *  Runtime:  Worst: O(N LOG N),  Average: O(N)
 *  Memory:  Worst: O(N),        Average: O(1)
 */
int main(int argc, char **argv) {
  int skyline[DATA_SIZE * 2];
  int cnt = 0;
  Heap *expire_heap = heap_init(20, 0);
  Heap *height_heap = heap_init(20, 1);
  for(int i = 0; i < 18; i+=3) {
    int start = data[i];
    int end = data[i + 1];
    int height = data[i + 2];
    while(expire_heap->size && (start > heap_peak(expire_heap)) ) {
      HeapNode *expire_heap_node = heap_pop(expire_heap);
      int expiring_height = expire_heap_node->heap_node_ref->val;
      if(expiring_height == heap_peak(height_heap)) {
        heap_pop(height_heap);
        skyline[cnt++] = expire_heap_node->val;
        if(height_heap->size) {
          skyline[cnt++] = heap_peak(height_heap);
        } else {
          skyline[cnt++] = 0;
        }
      } else {
        heap_remove(height_heap, expire_heap_node->heap_node_ref);
      }
    }
    if( (i != 15) && (!height_heap->size || height > heap_peak(height_heap))) {
      skyline[cnt++] = start;
      skyline[cnt++] = height;
    }
    heap_associate_nodes(heap_insert(expire_heap, end), heap_insert(height_heap, height));
  }
}
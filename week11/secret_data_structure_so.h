#include <stdlib.h>
#include <stdio.h>
#include <memory.h>

typedef struct Heap Heap;
typedef struct HeapNode HeapNode;

struct Heap {
  HeapNode *entries;
  int capacity;
  int size;
  int is_max_heap;
};

struct HeapNode{
  int val;
  HeapNode *heap_node_ref;
};

Heap *heap_init(int capacity, int is_max_heap) {
  Heap *heap =  malloc(sizeof(Heap));
  heap->entries = malloc(sizeof(HeapNode) * capacity);
  heap->capacity = capacity;
  heap->size = 0;
  heap->is_max_heap = is_max_heap;
  return heap;
}

HeapNode* heap_insert(Heap *heap, int val) {
  if(heap->size >= heap->capacity) {
    int size = sizeof(HeapNode) * heap->capacity;
    heap->capacity *= 2;
    HeapNode *new_entries = malloc(sizeof(HeapNode) * heap->capacity);
    heap->entries = memcpy(new_entries, heap->entries, size);
  }
  HeapNode *node = heap->entries + heap->size;
  node->val = val;
  node->heap_node_ref = 0;
  heap->size++;
  int pos = heap->size - 1;
  HeapNode *child = heap->entries + pos;
  HeapNode *parent = 0;
  while(pos > 0) {
    child = heap->entries + pos;
    parent = heap->entries + (pos = pos >> 1);
    if(heap_gt(heap, child->val, parent->val)) {
      heap_node_swap(child, parent);
    } else {
      break;
    }
  }
  if(parent && parent->val == val) {
    return parent;
  } else {
    return child;
  }
}

HeapNode* heap_remove(Heap *heap, HeapNode *node) {
  heap_node_swap(node, heap->entries + heap->size - 1);
  heap->size--;
  unsigned long pos = node - heap->entries ;
  while(pos < heap->size) {
    HeapNode *parent = heap->entries + pos;
    if((pos * 2) + 2 < heap->size) {
      HeapNode *child_one = heap->entries + ((pos * 2) + 1);
      HeapNode *child_two = heap->entries + ((pos * 2) + 2);
      if(heap_gt(heap, child_one->val, parent->val) && heap_gt(heap, child_one->val, child_two->val)) {
        heap_node_swap(child_one, parent);
        pos = (pos * 2) + 1;
      } else if(heap_gt(heap, child_two->val, parent->val) && heap_gt(heap, child_two->val, child_one->val)) {
        heap_node_swap(child_two, parent);
        pos = (pos * 2) + 2;
      }
      else {
        break;
      }
    } else if((pos * 2) + 1 < heap->size) {
      HeapNode *child = heap->entries + (pos = (pos * 2) + 1);
      if(heap_gt(heap, child->val, parent->val)) {
        heap_node_swap(child, parent);
      }
    } else {
      break;
    }
  }
  return heap->entries + heap->size;
}

void heap_associate_nodes (HeapNode *node_one, HeapNode *node_two) {
  node_one->heap_node_ref = node_two;
  node_two->heap_node_ref = node_one;
}

HeapNode* heap_pop (Heap *heap) {
  return heap_remove(heap, heap->entries);
}

int heap_gt(Heap *heap, int val_one, int val_two) {
  if (heap->is_max_heap) {
    return val_one > val_two;
  } else {
    return val_one < val_two;
  }
}

int heap_peak (Heap *heap) {
  return heap->entries->val;
}

int heap_node_swap (HeapNode *node_one, HeapNode *node_two) {
  int temp_val = node_one->val;
  HeapNode *temp_heap_node_ref = node_one->heap_node_ref;
  node_one->val = node_two->val;
  node_two->val = temp_val;
  node_one->heap_node_ref = node_two->heap_node_ref;
  node_two->heap_node_ref = temp_heap_node_ref;

  if(node_one->heap_node_ref) {
    node_one->heap_node_ref->heap_node_ref = node_one;
  }
  if(node_two->heap_node_ref) {
    node_two->heap_node_ref->heap_node_ref = node_two;
  }

}
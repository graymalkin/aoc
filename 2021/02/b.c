#include <stdio.h>
#include <string.h>

int main(void) {
  int hori = 0, vert = 0, aim = 0;
  char inst[8];
  int dist = 0;
  while (scanf("%7s %d\n", inst, &dist) != EOF) {
    if (strcmp("forward", (const char*)inst) == 0) {
      hori += dist;
      vert += aim * dist;
    }
    if (strcmp("up", (const char*)inst) == 0)
      aim -= dist;
    if (strcmp("down", (const char*)inst) == 0)
      aim += dist;
  }
  printf("%d\n", hori * vert);
  return 0;
}
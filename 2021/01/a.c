#include <limits.h>
#include <stdio.h>
#include <stdlib.h>

int main(void) {
  int prev = INT_MAX;
  int curr;
  int count = 0;
  do {
    if (curr > prev)
      count++;
    prev = curr;
  } while (scanf("%d\n", &curr) != EOF);
  printf("%d\n", count);
  return EXIT_SUCCESS;
}

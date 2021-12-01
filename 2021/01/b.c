#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define WINDOW_LENGTH   (3)

int sum(int * p, int n) {
  int total = 0;
  for(int i = 0; i < n; i++) {
    total += p[i];
  }
  return total;
}

int main(void) {
  int count = 0;
  int pos = 2;
  int prev_sum = INT_MAX;
  int curr_sum;
  int window[WINDOW_LENGTH] = {0};
  scanf("%d\n", &window[0]);
  scanf("%d\n", &window[1]);
  while (scanf("%d\n", &window[pos]) != EOF) {
    pos = (pos + 1) % WINDOW_LENGTH;
    curr_sum = sum(window, WINDOW_LENGTH);
    if (curr_sum > prev_sum)
      count++;
    prev_sum = curr_sum;
  }
  printf("%d\n", count);
}

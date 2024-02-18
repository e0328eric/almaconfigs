#include <errno.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define DEFAULT_BRIGHTNESS 35000
#define BACKLIGHT_RECODER "/tmp/current_backlight.💡"

int main(int argc, char **argv) {
  if (argc < 2) {
    fprintf(stderr, "too little arguments\n");
    return 1;
  }

  FILE *current_backlight_file = fopen(BACKLIGHT_RECODER, "r+");
  if (!current_backlight_file) {
    switch (errno) {
    case ENOENT:
      current_backlight_file = fopen(BACKLIGHT_RECODER, "w+");
      if (current_backlight_file)
        break;
    default:
      fprintf(stderr, "cannot open " BACKLIGHT_RECODER "\n");
      fprintf(stderr, "detail: %s\n", strerror(errno));
      return 1;
    }
  }
  char file_buf[10] = {0};
  fread(file_buf, 1, 6, current_backlight_file);

  if (file_buf[0] == '\0') {
    sprintf(file_buf, "%d", DEFAULT_BRIGHTNESS);
  }

  uint16_t brightness = atoi(file_buf);
  int adjustment = atoi(argv[1]);

  if (strcmp(argv[1], "status") == 0) {
    double percent = (float)brightness / (float)UINT16_MAX * 100.0;
    printf("%.2f", percent);
    goto CLOSE_FILE;
  }

  if (adjustment + brightness >= UINT16_MAX) {
    brightness = UINT16_MAX;
  } else if ((int)brightness + adjustment < 0) {
    brightness = 0;
  } else {
    brightness += adjustment;
  }

  char buf[100];
  sprintf(buf, "gmux_backlight %d", brightness);
  system(buf);

  sprintf(file_buf, "%d", brightness);
  rewind(current_backlight_file);
  fwrite(file_buf, 1, 6, current_backlight_file);

CLOSE_FILE:
  fclose(current_backlight_file);

  return 0;
}

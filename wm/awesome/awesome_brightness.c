#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define DEFAULT_BRIGHTNESS 0.85
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
    sprintf(file_buf, "%.5f", DEFAULT_BRIGHTNESS);
  }

  double brightness = atof(file_buf);
  double adjustment = atof(argv[1]);

  if (strcmp(argv[1], "status") == 0) {
    printf("%.3f", brightness * 100.0);
    goto CLOSE_FILE;
  }

  if (adjustment + brightness >= 1.0) {
    brightness = 1.0;
  } else if (brightness + adjustment < 0) {
    brightness = 0;
  } else {
    brightness += adjustment;
  }

  char buf[100];
  sprintf(buf, "xrandr --output eDP-1 --brightness %.5f", brightness);
  system(buf);

  sprintf(file_buf, "%.5f", brightness);
  rewind(current_backlight_file);
  fwrite(file_buf, 1, 6, current_backlight_file);

CLOSE_FILE:
  fclose(current_backlight_file);

  return 0;
}

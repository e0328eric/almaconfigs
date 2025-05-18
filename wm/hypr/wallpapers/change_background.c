#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char** argv) {
    if (argc != 2) {
        fprintf(stderr, "ERROR: not enough arguments\n");
        fprintf(stderr, "USAGE: change_background <IMG_NAME>\n");
        return 1;
    }

    FILE* input_img = fopen(argv[1], "r");
    FILE* old_output_img = fopen(".wallpaper_old", "w+");
    FILE* output_img = fopen(".wallpaper_modified", "w+");

    fseek(input_img, 0, SEEK_END); fseek(output_img, 0, SEEK_END);
    size_t input_len = ftell(input_img);
    size_t output_len = ftell(output_img);
    rewind(input_img); rewind(output_img);

    char* data = malloc(input_len + output_len);

    fread(data, 1, output_len, output_img);
    fwrite(data, 1, output_len, old_output_img);
    fread(data, 1, input_len, input_img);
    fwrite(data, 1, input_len, output_img);

    free(data);
    fclose(input_img);
    fclose(old_output_img);
    fclose(output_img);

    return 0;
}

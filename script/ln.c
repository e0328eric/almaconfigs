#include <stdio.h>
#include <string.h>

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <winbase.h>

int symlinkDir(const char* source, const char* target);
int symlinkFile(const char* source, const char* target);

int main(int argc, char **argv) {
    if (argc < 3) {
        fprintf(stderr, "ERROR: invalid argument\n");
        fprintf(stderr, "USAGE: ln [-d] <source> <target>\n");
        return 1;
    }

    if (strcmp(argv[1], "-d") == 0) return symlinkDir(argv[2], argv[3]);
    else return symlinkFile(argv[1], argv[2]);
}

int symlinkFile(const char* source, const char* target) {
    return !CreateSymbolicLinkA(source, target, 0);
}

int symlinkDir(const char* source, const char* target) {
    return !CreateSymbolicLinkA(source, target, SYMBOLIC_LINK_FLAG_DIRECTORY);
}

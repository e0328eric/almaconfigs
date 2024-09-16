#include <stdio.h>
#include <string.h>

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <winbase.h>

int symlinkDir(const char* source, const char* target);
int symlinkFile(const char* source, const char* target);
const char* winerrAsString(DWORD errcode);

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
    if (!CreateSymbolicLinkA(target, source, 0)) {
        LPCSTR err_msg = winerrAsString(GetLastError());
        fprintf(stderr, "ERROR: cannot make a symlink\nREASON: %s\n", err_msg);
        LocalFree((void*)err_msg);
        return 1;
    }

    return 0;
}

int symlinkDir(const char* source, const char* target) {
    if (!CreateSymbolicLinkA(target, source, SYMBOLIC_LINK_FLAG_DIRECTORY)) {
        LPCSTR err_msg = winerrAsString(GetLastError());
        fprintf(stderr, "ERROR: cannot make a symlink\nREASON: %s\n", err_msg);
        LocalFree((void*)err_msg);
        return 1;
    }

    return 0;
}

LPCSTR winerrAsString(DWORD errcode) {
    LPSTR message = NULL;
    
    size_t size = FormatMessageA(
        FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
        NULL, errcode, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), 
        (LPSTR)&message, 0, NULL
    );

    return message;
}

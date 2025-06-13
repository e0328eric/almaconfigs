#include <filesystem>
#include <iostream>

namespace fs = std::filesystem;

int main(int argc, char** argv) {
    if (argc != 3) {
        std::cerr << "ERROR: wrong argument\n";
        std::cerr << "USAGE: ln <SOURCE> <TARGET>\n";
        return 1;
    }

    std::error_code ec;

    const char* source = argv[1];
    const char* target = argv[2];
    bool is_dir = fs::is_directory(source, ec);

    if (ec) {
        std::cerr << "ERROR: " << ec.message() << '\n';
        return 1;
    }

    if (is_dir) {
        fs::create_directory_symlink(source, target, ec);
    } else {
        fs::create_symlink(source, target, ec);
    }

    if (ec) {
        std::cerr << "ERROR: " << ec.message() << '\n';
        return 1;
    }

    return 0;
}

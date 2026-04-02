/*
 * almaarch_setup.c
 * AlmaArch Configuration for CauchyOS
 * C rewrite of the original bash setup script.
 *
 * Compile:  gcc -std=c11 -Wall -Wextra -o almaarch_setup almaarch_setup.c
 * Run:      ./almaarch_setup   (from inside ~/.almaconf/<subdir>/)
 */

#define _POSIX_C_SOURCE 200809L

#include <errno.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define CAUCHYOS
#include "config.h"

#define ARR_LEN(_arr) (sizeof(_arr) / sizeof(_arr[0]))

/* ── helpers ──────────────────────────────────────────────────────────────── */

/* die() – print an error message and exit(1) */
static void die(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    fprintf(stderr, "[FATAL] ");
    vfprintf(stderr, fmt, ap);
    va_end(ap);
    fputc('\n', stderr);
    fflush(stderr);
    exit(1);
}

/* info() – echo a step, similar to `set -x` */
static void info(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    fprintf(stdout, "[INFO] ");
    vfprintf(stdout, fmt, ap);
    va_end(ap);
    fputc('\n', stdout);
    fflush(stdout);
}

/*
 * run() – execute a shell command via system(3).
 * Aborts on non-zero exit, like `set -e`.
 */
static void run(const char *fmt, ...) {
    char cmd[4096];
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(cmd, sizeof(cmd), fmt, ap);
    va_end(ap);

    info("%s", cmd);
    int rc = system(cmd);
    if (rc != 0)
        die("command failed (exit %d): %s", rc, cmd);
}

/*
 * run_nofail() – like run() but ignores non-zero exits.
 * Useful for grep/test-style probes.
 */
static int run_nofail(const char *fmt, ...) {
    char cmd[4096];
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(cmd, sizeof(cmd), fmt, ap);
    va_end(ap);

    info("%s", cmd);
    return system(cmd);
}

/* path_exists() – returns 1 if the path exists (file or dir) */
static int path_exists(const char *path) {
    struct stat st;
    return stat(path, &st) == 0;
}

/*
 * link_if_missing() – create a symlink `link` → `target`
 * only when `link` does not already exist.
 */
static void link_if_missing(const char *target, const char *link) {
    if (!path_exists(link)) {
        info("ln -s %s %s", target, link);
        if (symlink(target, link) != 0)
            die("symlink(%s, %s): %s", target, link, strerror(errno));
    }
}

/* mkdir_p() – create a directory (and its parents) if absent */
static void mkdir_p(const char *path) {
    if (!path_exists(path)) {
        char cmd[2048];
        snprintf(cmd, sizeof(cmd), "mkdir -p '%s'", path);
        run("%s", cmd);
    }
}

/* append_line_if_missing() – idempotent echo … >> file (with sudo) */
static void sudo_append_line_if_missing(const char *line, const char *file) {
    /* grep -qxF exits 0 if found, non-zero otherwise */
    char probe[2048];
    snprintf(probe, sizeof(probe),
             "sudo grep -qxF '%s' '%s' 2>/dev/null", line, file);
    if (run_nofail("%s", probe) != 0) {
        run("echo '%s' | sudo tee -a '%s' >/dev/null", line, file);
    }
}

void hyprland_setup(void) {
    run("sudo pacman -S --noconfirm --needed " HYPRLAND_PKGS);
    run("paru -S --noconfirm --needed " NOCTALIA_SHELL);
}

void mango_setup(void) {
    run("sudo pacman -S --noconfirm --needed " MANGO_PKGS);
    run("paru -S --noconfirm --needed " NOCTALIA_SHELL);
}

int main(void) {
    /* Refuse root */
    if (geteuid() == 0) die("Do not run this script as root.");

    const char *home = getenv("HOME");
    if (!home) die("$HOME is not set.");

    /* Verify the script lives inside .almaconf/<something>/ */
    {
        char cwd[4096];
        if (!getcwd(cwd, sizeof(cwd)))
            die("getcwd: %s", strerror(errno));

        /* dirname of cwd */
        char *slash = strrchr(cwd, '/');
        if (!slash) die("Unexpected cwd: %s", cwd);
        *slash = '\0'; /* cwd is now the parent directory */
        const char *grandparent_base = strrchr(cwd, '/');
        if (!grandparent_base) die("Unexpected cwd after trim: %s", cwd);
        ++grandparent_base;

        if (strcmp(grandparent_base, ".almaconf") != 0)
            die("The directory name which this script is located in must be "
                ".almaconf.");
    }

    /* Build common path prefixes */
    char almaconf[1024], config[1024];
    snprintf(almaconf, sizeof(almaconf), "%s/.almaconf", home);
    snprintf(config,   sizeof(config),   "%s/.config",   home);

    /* Keep sudo credential alive */
    run("sudo -v");

    /* ── 1. rEFInd theme ─────────────────────────────────────────────────── */
    {
        const char *theme   = "refind_almagest";
        const char *refind  = "/boot/EFI/refind";
        const char *conf    = "/boot/EFI/refind/refind.conf";
        char themes_dir[512], theme_dst[512], include_line[256], src[512];

        snprintf(themes_dir,   sizeof(themes_dir),   "%s/themes",      refind);
        snprintf(theme_dst,    sizeof(theme_dst),    "%s/themes/%s",   refind, theme);
        snprintf(include_line, sizeof(include_line),
                 "include themes/%s/theme.conf", theme);
        snprintf(src, sizeof src, "%s/refind/%s", almaconf, theme);

        if (!path_exists(theme_dst)) {
            run("sudo mkdir -p '%s'", themes_dir);
            run("sudo cp -r '%s' '%s'", src, themes_dir);
            sudo_append_line_if_missing(include_line, conf);
        }
    }

    /* ── 2. rustup ───────────────────────────────────────────────────────── */
    if (run_nofail("command -v rustup >/dev/null 2>&1") != 0) {
        run("sudo pacman -S --noconfirm --needed rustup");
        run("rustup default stable");
    }

    /* ── 3. paru ─────────────────────────────────────────────────────────── */
    run("sudo pacman -S --noconfirm --needed base-devel");
    if (run_nofail("command -v paru >/dev/null 2>&1") != 0) {
        run("git clone --depth 1 https://aur.archlinux.org/paru.git");
        run("cd paru && makepkg -si");
        run("rm -rf paru");
    }

    run("sudo pacman -Syyu");

    /* ── 4. base packages ────────────────────────────────────────────────── */
    run("sudo pacman -S --noconfirm --needed "
        "git cmake make gcc keyd bat lazygit libsecret gnome-keyring ufw "
        "zip unzip brave-bin blueman kdeconnect");

    run("systemctl --user enable gnome-keyring-daemon");
    run("systemctl --user start  gnome-keyring-daemon");

    /* ── 5. keyd ─────────────────────────────────────────────────────────── */
    {
        char src[512];
        snprintf(src, sizeof(src), "%s/keyboard/keyd/default.conf", almaconf);
        run("sudo cp '%s' /etc/keyd/default.conf", src);
        run("sudo systemctl enable keyd --now");
    }

    /* ── 6. SDDM ─────────────────────────────────────────────────────────── */
    run("sudo pacman -S --noconfirm --needed "
        "sddm qt6 qt6-svg qt6-virtualkeyboard qt6-multimedia-ffmpeg");
    run("sudo systemctl enable sddm");

    if (!path_exists("/usr/share/sddm/themes/almagest-sddm")) {
        char src_theme[512], src_conf[512];
        snprintf(src_theme, sizeof(src_theme), "%s/sddm/almagest-sddm", almaconf);
        snprintf(src_conf,  sizeof(src_conf),  "%s/sddm/sddm.conf",     almaconf);
        run("sudo cp -r '%s' /usr/share/sddm/themes", src_theme);
        run("sudo cp '%s' /etc/sddm.conf",            src_conf);
    }

    /* ── 7. audio / bluetooth ────────────────────────────────────────────── */
    run("sudo pacman -S --noconfirm --needed "
        "pipewire wireplumber pipewire-alsa pipewire-pulse rtkit "
        "bluez bluez-utils lib32-alsa-plugins pavucontrol");

    run("sudo systemctl enable --now rtkit-daemon.service");

    /* PipeWire low-latency config */
    run("sudo mkdir -p /etc/pipewire/pipewire.conf.d");
    run("sudo tee /etc/pipewire/pipewire.conf.d/92-low-latency.conf >/dev/null <<'EOF'\n"
        "context.properties = {\n"
        "  default.clock.rate = 48000\n"
        "  default.clock.quantum = 1024\n"
        "  default.clock.min-quantum = 512\n"
        "  default.clock.max-quantum = 2048\n"
        "}\n"
        "EOF");

    /* WirePlumber Bluetooth config */
    run("sudo mkdir -p /etc/wireplumber/wireplumber.conf.d");
    run("sudo tee /etc/wireplumber/wireplumber.conf.d/50-bluez-properties.conf "
        ">/dev/null <<'EOF'\n"
        "monitor.bluez.properties = {\n"
        "  bluez5.enable-sbc-xq = false\n"
        "  bluez5.enable-msbc = true\n"
        "  bluez5.enable-hw-volume = true\n"
        "  bluez5.roles = [ a2dp_sink a2dp_source hsp_hs hsp_ag hfp_hf hfp_ag ]\n"
        "}\n"
        "EOF");

    run("systemctl --user enable --now pipewire pipewire-pulse wireplumber");

    /* ── 8. Hyprland + desktop environment ───────────────────────────────── */
#if defined(HYPRLAND)
		hyprland_setup();
#elif defined(MANGO)
		mango_setup();
#else
#error "No Window Manager is selected. Use -DHYPRLAND or -DMANGO in compilation"
#endif

    /* cursor */
    {
        char icons_dir[512], cursor_src[512], cursor_dst[512];
        snprintf(icons_dir,   sizeof(icons_dir), "%s/.local/share/icons", home);
        snprintf(cursor_src,  sizeof(cursor_src), "%s/cursors/LilpaTheme", almaconf);
        snprintf(cursor_dst,  sizeof(cursor_dst), "%s/LilpaTheme", icons_dir);
        mkdir_p(icons_dir);
        link_if_missing(cursor_src, cursor_dst);
    }

    /* default PDF reader */
    run("mimeo --add application/pdf org.pwmt.zathura-pdf-mupdf.desktop");

    /* ── 9. gaming ───────────────────────────────────────────────────────── */
    run("sudo pacman -S --noconfirm --needed " GAMING);

    /* ── 10. utilities ───────────────────────────────────────────────────── */
    run("sudo pacman -S --noconfirm --needed "
        "mpv zathura zathura-djvu zathura-pdf-mupdf");

    run("paru -S --noconfirm --needed synology-drive");

    /* ── 11. symlinks ────────────────────────────────────────────────────── */

    /* Remove existing fish config (may be a real dir, not a link) */
    {
        char fish_dir[512];
        snprintf(fish_dir, sizeof fish_dir, "%s/fish", config);
        if (path_exists(fish_dir))
            run("rm -rf '%s'", fish_dir);
    }

    /* Helper macro-like struct for the link table */
    struct { const char *rel_src; const char *rel_dst; } links[] = {
#if defined(HYPRLAND)
        { "wm/hypr",             "hypr"     },
#elif defined(MANGO)
        { "wm/mango",            "mango"    },
        { "utils/kanshi",        "kanshi"   },
#endif
        { "utils/nvim",          "nvim"     },
        { "shell/fish",          "fish"     },
        { "shell/nushell_linux", "nushell"  },
        { "terminals/kitty",     "kitty"    },
        { "terminals/ghostty",   "ghostty"  },
        { "utils/noctalia",      "noctalia" },
    };

    for (size_t i = 0; i < ARR_LEN(links); i++) {
        char src[1024], dst[1024];
        snprintf(src, sizeof(src), "%s/%s", almaconf, links[i].rel_src);
        snprintf(dst, sizeof(dst), "%s/%s", config,   links[i].rel_dst);
        link_if_missing(src, dst);
    }

    /* wallpapers */
    {
        char wp_src[512], wp_dst[512];
        snprintf(wp_src, sizeof(wp_src), "%s/wallpapers",      almaconf);
        snprintf(wp_dst, sizeof(wp_dst), "%s/alma-wallpapers", config);
        link_if_missing(wp_src, wp_dst);
    }

    /* scripts */
    {
        char script_src[512], script_dst[512];
        snprintf(script_src, sizeof(script_src), "%s/script",       almaconf);
        snprintf(script_dst, sizeof(script_dst), "%s/alma-scripts", config);
        link_if_missing(script_src, script_dst);
    }

    /* ── 12. git global config ───────────────────────────────────────────── */
    run("git config --global user.name  'Sungbae Jeong'");
    run("git config --global user.email 'almagest0328@gmail.com'");
    run("git config --global credential.helper "
        "/usr/lib/git-core/git-credential-libsecret");

    /* ── 13. ~/.local/bin symlinks ───────────────────────────────────────── */
    {
        char local_bin[512], bin_src[512];
        snprintf(local_bin, sizeof(local_bin), "%s/.local/bin", home);
        snprintf(bin_src,   sizeof(bin_src),   "%s/bin",        almaconf);
        mkdir_p(local_bin);

        /*
         * Iterate over every file in ~/.almaconf/bin/ and create a
         * symlink in ~/.local/bin/.  We delegate the glob to the shell
         * to keep this file self-contained (no <dirent.h> iteration).
         */
        char script[2048];
        snprintf(script, sizeof(script),
                 "for f in '%s'/*; do "
                 "  b=\"$(basename \"$f\")\"; "
                 "  link='%s'/\"$b\"; "
                 "  [ -e \"$link\" ] || ln -s \"$f\" \"$link\"; "
                 "done",
                 bin_src, local_bin);
        run("%s", script);
    }

    info("Setup complete.");
    return 0;
}

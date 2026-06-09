-- ======================================================================
-- lsp.lua  -  language server configuration
--
-- ae.lsp_config(language, {
--     command    = "<server binary on your PATH>",
--     args       = { ... },          -- optional launch arguments
--     extensions = { "ext", ... },   -- file extensions that start it
-- })
--
-- The server starts lazily the first time you open a matching file, so an
-- entry whose binary you have not installed is harmless until then (you'll
-- just see an error in ae.lsp_status() when you open that file type).
--
-- Install the binaries yourself; ae does not bundle them. In the editor,
-- `:lsp restart | stop | enable | disable` controls the running servers, `K`
-- shows hover (put the cursor on a symbol), diagnostics appear inline, and
-- `<space>F` (or `:format`) formats the buffer via the server's formatter.
--
-- Debugging: launch with AE_LSP_LOG=/path/to/lsp.log to capture the server's
-- own stderr to that file - useful when a server "says ready" but produces no
-- hover or diagnostics (the log usually explains why).
-- ======================================================================

-- ---------- Rust : rust-analyzer ----------
-- install: rustup component add rust-analyzer   (or your distro package)
ae.lsp_config("rust", {
    command    = "rust-analyzer",
    args       = {},
    extensions = { "rs" },
})

-- ---------- LaTeX / TeX : texlab ----------
-- install: cargo install texlab   (or download a release / distro package)
ae.lsp_config("latex", {
    command    = "texlab",
    args       = {},
    extensions = { "tex", "latex", "sty", "cls", "bib" },
})

-- ---------- Python : pyright (or pylsp) ----------
-- install: npm i -g pyright        -> command "pyright-langserver", {"--stdio"}
--      or: pip install python-lsp-server  -> command "pylsp", {}
-- ae.lsp_config("python", {
--     command    = "pyright-langserver",
--     args       = { "--stdio" },
--     extensions = { "py", "pyi" },
-- })

-- ---------- C / C++ : clangd ----------
-- install: your distro's clang/clangd package
-- ae.lsp_config("c", {
--     command    = "clangd",
--     args       = {},
--     extensions = { "c", "h", "cpp", "cc", "cxx", "hpp" },
-- })

-- ---------- Go : gopls ----------
-- install: go install golang.org/x/tools/gopls@latest
-- ae.lsp_config("go", {
--     command    = "gopls",
--     args       = {},
--     extensions = { "go" },
-- })

-- ---------- TypeScript / JavaScript ----------
-- install: npm i -g typescript typescript-language-server
-- ae.lsp_config("typescript", {
--     command    = "typescript-language-server",
--     args       = { "--stdio" },
--     extensions = { "ts", "tsx", "js", "jsx" },
-- })

-- ---------- Lua : lua-language-server ----------
-- install: your distro package, or a release from LuaLS
-- ae.lsp_config("lua", {
--     command    = "lua-language-server",
--     args       = {},
--     extensions = { "lua" },
-- })

-- Note: vesti (.ves) has no language server. texlab understands LaTeX, not
-- vesti's docclass/useenv syntax, so pointing it at .ves would mostly report
-- noise; it is intentionally left unconfigured.

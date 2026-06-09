ae.add_language{
    extensions = { "toml" },
    library = ae.append_path { ae.config_dir, "tree-sitter", "toml", "toml.dll" },
    symbol = "tree_sitter_toml",
    highlights_file = ae.append_path { ae.config_dir, "tree-sitter", "toml", "highlights.scm" },
}
ae.add_language{
    extensions = { "lua" },
    library = ae.append_path { ae.config_dir, "tree-sitter", "lua", "lua.dll" },
    symbol = "tree_sitter_lua",
    highlights_file = ae.append_path { ae.config_dir, "tree-sitter", "lua", "highlights.scm" },
}
ae.add_language{
    extensions = { "ves" },
    library = ae.append_path { ae.config_dir, "tree-sitter", "vesti", "vesti.dll" },
    symbol = "tree_sitter_vesti",
    highlights_file = ae.append_path { ae.config_dir, "tree-sitter", "vesti", "highlights.scm" },
}
ae.add_language{
    extensions = { "toml" },
    library = ae.append_path { ae.config_dir, "tree-sitter", "toml", "toml.dll" },
    symbol = "tree_sitter_toml",
    highlights_file = ae.append_path { ae.config_dir, "tree-sitter", "toml", "highlights.scm" },
}

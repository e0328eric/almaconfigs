;;; lalrpop-mode.el --- major mode for lalrpop  -*- lexical-binding: t; -*-

(require 'tree-sitter)

(defconst lalrpop--font-lock-defaults
      (let* (
            ;; define several category of keywords
            (x-keywords '("as" "async" "await" "break" "const" "continue" "crate" "dyn" "else" "enum"
                          "extern" "false" "fn" "for" "grammar" "if" "impl" "in" "let" "loop" "match"
                          "mod" "move" "mut" "pub" "ref" "return" "self" "static" "struct" "super"
                          "trait" "true" "type" "union" "unsafe" "use" "where" "while"))
            (x-types '("bool" "char" "str"
                       "f32" "f64"
                       "i8" "i16" "i32" "i64" "i128" "isize"
                       "u8" "u16" "u32" "u64" "u128" "usize"
                       "Box" "HashMap" "HashSet" "Self" "String" "Vec" "VecDeque"))
            (x-macros '("concat!" "format!" "panic!" "print!" "println!"
                        "vec!" "write!" "writeln!" "todo!" "unimplemented!" "unreachable!"
                        ))
            ;;(x-constants '("ACTIVE" "AGENT" "ALL_SIDES" "ATTACH_BACK"))
            ;;(x-events '("at_rot_target" "at_target" "attach"))

            ;; generate regex string for each category of keywords
            (x-keywords-regexp (regexp-opt x-keywords 'symbols))
            (x-types-regexp (regexp-opt x-types 'symbols))
            (x-macros-regexp (regexp-opt x-macros 'symbols)))
            ;;(x-constants-regexp (regexp-opt x-constants 'words))
            ;;(x-events-regexp (regexp-opt x-events 'words))

        `(
          (,x-types-regexp . 'font-lock-type-face)
          (,x-macros-regexp . 'font-lock-function-name-face)
          (,x-keywords-regexp . 'font-lock-keyword-face)
          ;; (,x-constants-regexp . 'font-lock-constant-face)
          ;; (,x-events-regexp . 'font-lock-builtin-face)
          ;; note: order above matters, because once colored, that part won't change.
          ;; in general, put longer words first
          )))

(defvar lalrpop-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?\{ "(}" st)
    (modify-syntax-entry ?\} "){" st)
    (modify-syntax-entry ?\( "()" st)
    (modify-syntax-entry ?\) ")(" st)
    (modify-syntax-entry ?\[ ")]" st)
    (modify-syntax-entry ?\] ")[" st)
    (modify-syntax-entry ?< ")>" st)
    (modify-syntax-entry ?> ")<" st)

    ;; - and _ are word constituents
    (modify-syntax-entry ?_ "w" st)

    ;; both single and double quotes makes strings
    (modify-syntax-entry ?\" "\"" st)
    (modify-syntax-entry ?' "'" st)

    ;; Comments
    (modify-syntax-entry ?/  ". 124b" st)
    (modify-syntax-entry ?*  ". 23n"  st)
    (modify-syntax-entry ?\n "> b"    st)
    (modify-syntax-entry ?\^m "> b"   st)

    st))

(defvar lalrpop-mode-abbrev-table nil
  "Abbreviation table used in `lalrpop-mode' buffers.")

(define-abbrev-table 'lalrpop-mode-abbrev-table
  '())

(tree-sitter-require 'lalrpop)

;;;###autoload
(define-derived-mode lalrpop-mode prog-mode "lalrpop"
  "Major mode for lalrpop files."
  :set-syntax-table lalrpop-mode-syntax-table
  :abbrev-table lalrpop-mode-abbrev-table
  (setq font-lock-defaults '(lalrpop--font-lock-defaults))
  ;;(setq-local comment-start "//")
  ;;(setq-local comment-start-skip "//+[\t ]*")
  (setq-local indent-line-function nil)
  (setq-local indent-tabs-mode t))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.lalrpop" . lalrpop-mode))

(provide 'lalrpop-mode)

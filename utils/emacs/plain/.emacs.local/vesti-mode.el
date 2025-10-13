;;; vesti-mode.el -- Regex highlighting for Vesti -*- lexical-binding: t; -*-

;;; Commentary:
;; Regex-based highlighting for the Vesti language, derived from the public
;; tree-sitter-vesti repo’s surface constructs (declarations like useenv/begenv/
;; endenv/defun/defenv/etc., bracket/brace args, jlcode fences #jl:…:jl#).
;;
;; Save as vesti-mode.el, then:
;;   (add-to-list 'auto-mode-alist '("\\.ves\\'" . vesti-mode))
;;   (with-eval-after-load 'vesti-mode
;;     (custom-set-faces
;;      '(vesti-jlcode-fence-face ((t :inherit font-lock-preprocessor-face :weight bold)))
;;      '(vesti-jlcode-body-face  ((t :inherit font-lock-doc-face)))))

(require 'rx)

(defgroup vesti nil
  "Major mode for the Vesti language"
  :group 'languages)

(defface vesti-command-face
  '((t :inherit font-lock-keyword-face))
  "Face for top-level Vesti commands."
  :group 'vesti)

(defface vesti-arg-key-face
  '((t :inherit font-lock-type-face))
  "Face for option keys inside [...] argument lists."
  :group 'vesti)

(defface vesti-brace-face
  '((t :inherit font-lock-builtin-face))
  "Face for braces and brackets."
  :group 'vesti)

(defface vesti-jlcode-fence-face
  '((t :inherit font-lock-preprocessor-face :weight bold))
  "Face for #jl: … :jl# fences."
  :group 'vesti)

(defface vesti-jlcode-body-face
  '((t :inherit font-lock-doc-face))
  "Face for jlcode body content."
  :group 'vesti)

;; A best-effort list of surface commands gleaned from the grammar:
(defconst vesti--commands
  '("docclass" "singlepkg" "multipkg" "importmod" "copyfile" "importves" "getfp"
    "compile_type" "useenv" "begenv" "endenv" "defun" "defenv" "defthm" "defn"
    "import" "include" "usepkg" "addtocounter" "proof")
  "Top-level Vesti commands or declarations to highlight.")

;; Regex helpers
(defconst vesti--command-rx
  (rx line-start (* space)
      (group (or
              ;; plain word commands
              (regexp (eval (regexp-opt vesti--commands 'symbols)))
              ;; fallback: any identifier at bol treated as a command-ish thing
              (seq (any alpha "_") (* (any alnum "_")))))
      symbol-end))

(defvar vesti-mode-syntax-table
  (let ((st (make-syntax-table)))
    ;; Strings
    (modify-syntax-entry ?\" "\"" st)
	
    ;; Comments:
    ;;  1) // line comments
    (modify-syntax-entry ?/ ". 124b" st)
    (modify-syntax-entry ?\n "> b" st)
    ;;  2) % line comments (LaTeX-ish) — many Vesti snippets mix TeX
    (modify-syntax-entry ?% "<" st)
    ;;  3) # … end-of-line comments if not a jl fence (we handle jl in propertize)
    ;; We won’t mark # as comment starter here to avoid fighting the jl fence.
    ;; Braces/brackets are punctuation
    (modify-syntax-entry ?{ "(}" st)
    (modify-syntax-entry ?} "){" st)
    (modify-syntax-entry ?[ "(]" st)
	(modify-syntax-entry ?] ")[" st)
    st)
  "Syntax table for `vesti-mode'.")

;; Font-lock:

(defconst vesti--string-rx
  (rx ?\" (* (or (seq ?\\ ?) (not ?\"))) ?\"))

(defconst vesti--number-rx
  (rx symbol-start (? (any ?+ ?-))
      (or
       ;; integer
       (seq (+ digit))
       ;; float
       (seq (+ digit) ?. (+ digit) (? (seq (any ?e ?E) (? (any ?+ ?-)) (+ digit))))
       ;; .123, 1., etc.
       (seq ?. (+ digit))))
  )

(defconst vesti--braces-rx
  (rx (any ?\{ ?\} ?\[ ?\])))

(defconst vesti--optkey-rx
  ;; inside [...] treat foo=bar key as a 'type-ish' token
  (rx symbol-start (+ (any alpha "_")) (* (any alnum "_" ?-)) ?=))

;; jlcode fences and body via syntax-propertize + auxiliary matcher
(defconst vesti--jl-fence-open-rx
  (rx line-start (* space) "#jl:" (* space) "<" (* (not (any ?\n ?\>))) ">" (* space) line-end))
(defconst vesti--jl-fence-close-rx
  (rx line-start (* space) ":jl#" (* space) line-end))

(defun vesti--font-lock-jlcode (limit)
  "Font-lock matcher that highlights #jl: <lang> ... :jl# blocks up to LIMIT."
  (when (re-search-forward vesti--jl-fence-open-rx limit t)
    (let* ((beg (match-beginning 0))
           (fence-beg (match-beginning 0))
           (fence-end (match-end 0)))
      ;; fence line
      (put-text-property fence-beg fence-end 'face 'vesti-jlcode-fence-face)
      ;; body: up to closing fence or limit
      (let ((body-beg fence-end))
        (if (re-search-forward vesti--jl-fence-close-rx limit t)
            (let ((body-end (match-beginning 0))
                  (close-beg (match-beginning 0))
                  (close-end (match-end 0)))
              (put-text-property body-beg body-end 'face 'vesti-jlcode-body-face)
              (put-text-property close-beg close-end 'face 'vesti-jlcode-fence-face)
              (set-match-data (list beg close-end))
              t)
          ;; no closing fence found; color to limit
          (put-text-property body-beg limit 'face 'vesti-jlcode-body-face)
          (set-match-data (list beg limit))
          t)))))

(defvar vesti-font-lock-keywords
  `(
    ;; Commands at BOL (and generic identifiers at BOL as a fallback)
    (,vesti--command-rx (1 'vesti-command-face))
    ;; Braces and brackets
    (,vesti--braces-rx . 'vesti-brace-face)
    ;; Strings
    (,vesti--string-rx . font-lock-string-face)
    ;; Numbers
    (,vesti--number-rx . font-lock-number-face)
    ;; Option keys inside [...]
    (,(rx "[" (*? anything) (group (eval vesti--optkey-rx)) (*? anything) "]")
     (1 'vesti-arg-key-face t))
    ;; jlcode fence blocks (matchers must run early)
    (vesti--font-lock-jlcode)
    )
  "Font-lock rules for `vesti-mode'.")

;; Simple imenu (captures names in defun/defenv like: defun foo [opts] { ... })
(defconst vesti--imenu-generic-expressions
  `(("Functions" ,(rx line-start (* space) (or "defun" "defn")
                      (+ space) (group (+ (or (syntax word) (syntax symbol)))))
     1)
    ("Environments" ,(rx line-start (* space) (or "defenv" "begenv" "endenv")
                         (+ space) (group (+ (or (syntax word) (syntax symbol)))))
     1)))

;; Ultra-basic indentation: indent by 2 * brace-depth; treat 'endenv' like a dedenter
(defun vesti--line-opens-block-p ()
  (save-excursion
    (back-to-indentation)
    (looking-at-p (rx (or (seq (or "begenv" "defenv" "defun" "defn"))
                          symbol-end)
                      (* not-newline) "{"))))

(defun vesti--line-closes-block-p ()
  (save-excursion
    (back-to-indentation)
    (or (looking-at-p (rx "}"))
        (looking-at-p (rx (or "endenv") symbol-end)))))

(defun vesti-calc-indent ()
  (let* ((ppss (syntax-ppss))
         (depth (car ppss))
         (base (* 2 depth)))
    (save-excursion
      (back-to-indentation)
      (cond
       ((vesti--line-closes-block-p) (max 0 (- base 2)))
       ((vesti--line-opens-block-p)  (+ base 2))
       (t base)))))

(defun vesti-indent-line ()
  "Indent current line as Vesti."
  (interactive)
  (let ((col (current-column))
        (indent (vesti-calc-indent)))
    (indent-line-to indent)
    (when (> col (current-indentation))
      (move-to-column col))))

;; Syntax-propertize: keep default; jlcode is done in font-lock matcher.

;;;###autoload
(define-derived-mode vesti-mode prog-mode "Vesti"
  "Major mode for editing Vesti files (regex-based highlighting)."
  :syntax-table vesti-mode-syntax-table
  (setq-local font-lock-defaults '(vesti-font-lock-keywords))
  (setq-local comment-start "% ")
  (setq-local comment-end   "")
  (setq-local indent-line-function #'vesti-indent-line)
  (setq-local imenu-generic-expression vesti--imenu-generic-expressions)
  ;; Make bracket/brace faces show up even if user theme is minimal:
  (font-lock-add-keywords nil vesti-font-lock-keywords))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.ves\\'" . vesti-mode))

(provide 'vesti-mode)
;;; vesti-mode.el ends here


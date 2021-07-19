#lang racket/base

(require racket/format)
(require racket/match)
(require "command.rkt")

(define-values (command handler args)
  (match (current-command-line-arguments)
    [(vector command args ...)
     (values command (hash-ref all-commands (string->symbol command) (handle-unknown command)) args)]

    [_
     (values "help" handle-help null)]))

(define (main)
  (parameterize ([current-command-line-arguments (list->vector args)]
                 [current-program-name (~a (current-program-name) " " command)])
    (handler)))

(main)

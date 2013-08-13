(in-package :cl-user)

(setq *atms-code-path* "/home/wiselib/LISP/dekleer-v2/")

(load (concatenate 'string *atms-code-path* "defsys.lisp"))

(excl::compile-system :atms :recompile t)

(excl::load-system :atms)

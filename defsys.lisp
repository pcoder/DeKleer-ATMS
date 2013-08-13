(in-package :cl-user)

(defpackage atms (:use common-lisp) (:size 1000))

(excl::defsystem :atms (:default-package :atms
			   :default-pathname #.*atms-code-path*)
  (:serial "atms"
	   "atest"))
	   
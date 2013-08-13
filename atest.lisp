;;; -*- mode: lisp; syntax: common-lisp; -*-

;;;; Test code
;; Last edited 1/29/93, by KDF
;; Last edited 7/12/2007 by JdK.
;;; Version 2.

;;; Copyright (c) 1993, Kenneth D. Forbus, Northwestern University,
;;; and Johan de Kleer, the Xerox Corporation.
;;; All rights reserved.

;;; See the file legal.txt for a paragraph stating scope of permission
;;; and disclaimer of warranty.  The above copyright notice and that
;;; paragraph must be included in any separate copy of this file.

(in-package :atms)

(defvar a)
(defvar b)
(defvar c)
(defvar d)
(defvar e)
(defvar f)
(defvar *atms*)

(defun atms-test1 ()
  (setq *atms* (create-atms "atms-test1" :debugging t)
	a (tms-create-node *atms* "A")
	b (tms-create-node *atms* "B")
	c (tms-create-node *atms* "C")
	d (tms-create-node *atms* "D")
	e (tms-create-node *atms* "E")
	f (tms-create-node *atms* "F"))
  (assume-node a)
  (assume-node b)
  (assume-node c)
  (justify-node 'J1 d (list a b))
  (justify-node 'J2 e (list b c))
  (justify-node 'J3 f (list d e)))

(defun atms-test2 ()
  (justify-node 'simpler d (list a)))

(defun atms-test3 ()
  (nogood-nodes 'atms-test3 (list a b)))

;;; an example from de Kleer's paper by Gitchang

(defvar x=1)
(defvar y=x)
(defvar x=z)
(defvar y=1)
(defvar z=1)

(defun step-1 ()
  (setq *atms* (create-atms "Step-1")
	a (tms-create-node *atms* "A")
	b (tms-create-node *atms* "B")
	c (tms-create-node *atms* "C")
	x=1 (tms-create-node *atms* "x=1")
	y=x (tms-create-node *atms* "y=x")
	x=z (tms-create-node *atms* "x=z")
	y=1 (tms-create-node *atms* "y=1")
	z=1 (tms-create-node *atms* "z=1") )
  (assume-node a)
  (assume-node b)
  (assume-node c)
  (justify-node 'j1 x=1 (list a))
  (justify-node 'j2 y=x (list b))
  (justify-node 'j3 x=z (list c))
  (why-nodes *atms*)
  (print-envs *atms*)

  (format t "~2%Now register nogood{A,B}")
  (nogood-nodes 'NOGOOD (list a b))
  (why-nodes *atms*)
  (print-envs *atms*)

  (format t "~2%x=1, y=x => y=1")
  (justify-node 'j4 y=1 (list x=1 y=x))
  (why-nodes *atms*)
  (print-envs *atms*)

  (format t "~2%We have a premise z=1")
  (justify-node 'Premise z=1 nil)
  (why-nodes *atms*)
  (print-envs *atms*)

  (format t "~2%z=1, x=z => x=1")
  (justify-node 'j5 x=1 (list z=1 x=z))
  (why-nodes *atms*)
  (print-envs *atms*) )


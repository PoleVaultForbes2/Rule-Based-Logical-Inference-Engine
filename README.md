# Rule-Based-Logical-Inference-Engine

This project implements a simple **rule-based logical inference engine** in Common Lisp. The system evaluates whether certain conclusions (goals) can be derived from a set of initial facts and inference rules using propositional logic with operators such as AND, OR, and NOT.

---

## Author

Josh Forbes

## Overview

The system allows you to:

- Define **facts**: basic statements considered true.
- Define **rules**: logical implications that infer new facts from existing ones.
- Query whether a particular goal fact can be **proven** using the current facts and rules.

The inference engine supports compound logical expressions involving:
- `AND` conjunction
- `OR` disjunction
- `NOT` negation

---

## Files

- `expertSystem.lisp`: The core inference engine implementing facts, rules, and the prove mechanism.
- `test.lisp`: A test script that loads `expertSystem.lisp` and runs example queries demonstrating the system’s behavior.

---

## Usage

### Running in CLISP
~~~~~~~~~~~~~~~~
clisp test.lisp
~~~~~~~~~~~~~~~~
**OR**
~~~~~~~~~~~~~~~~~
clisp
(load "expertSystem.lisp")
(prove? facts rules 'A)  ; Should return T (true)
(prove? facts rules 'D)  ; Should return T (true)
(prove? facts rules 'J)  ; Should return NIL (false)
~~~~~~~~~~~~~~~~~~

## How it Works
* The system starts with a set of facts (true statements).
* It recursively applies the rules:
  * Each rule has a condition (a logical expression) and a conclusion.
  * The condition can combine facts with AND, OR, and NO
* The prove? function attempts to prove a goal by checking if it is a fact or can be inferred from the rules.
* The engine supports chaining proofs by recursively checking sub-goals.

#!/bin/bash

readmacs() {
  emacs "$1" --eval '(setq buffer-read-only t)'
}

readmacs "$1"
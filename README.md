# LLVM-kernel
A hello world kernel, written in LLVM ir

## Why
This kernel was inspired by an [article by Marek](https://idea.popcount.org/2013-07-24-ir-is-better-than-assembly/).
LLVM ir is a powerful tool for cross platform programming. It is more low-level than C, while still being easier than assembly languages such as NASM.
It features basic variable and function support that make programming easier. Also I wanted to have some fun.

## How to build
You'll need `llvm` (duh) and `make` as well as a i386 `gcc` and `ld`. Those last two are named `x86_64-elf-gcc/ld` in the Makefile, but you should change that
if yours are named differently (e.g. `i386-elf-gcc/ld`).
To test your build you'll need `qemu` i.e. `qemu-system-i386`

; LLVM-kernel (c) Nikolas Wipper 2020

target triple = "i386-elf"

@g1 = constant i32 464367618, section "multiboot", align 4
@g2 = constant i32 0, section "multiboot", align 4
@g3 = constant i32 -464367618, section "multiboot", align 4

define void @write(i8 %char, i64 %index) {
    ; Create char pointer
    %1 = alloca i8*, align 8
    ; Set its address
    store i8* inttoptr (i64 753664 to i8*), i8** %1, align 8

    ; Make an array out of it
    %2 = load i8*, i8** %1, align 8
    ; Get index
    %3 = getelementptr inbounds i8, i8* %2, i64 %index
    ; Write Char
    store i8 %char, i8* %3, align 1

    ret void
} 

define void @_start() {
    ; H
    call void @write(i8 72,  i64 0)
    ; e
    call void @write(i8 101, i64 2)
    ; ll
    call void @write(i8 108, i64 4)
    call void @write(i8 108, i64 6)
    ; o
    call void @write(i8 111, i64 8)
    ; Space
    call void @write(i8 32,  i64 10)
    ; W
    call void @write(i8 87,  i64 12)
    ; o
    call void @write(i8 111, i64 14)
    ; r
    call void @write(i8 114, i64 16)
    ; l
    call void @write(i8 108, i64 18)
    ; d
    call void @write(i8 100, i64 20)

    ; Clearing boot message
    call void @write(i8 32,  i64 22)
    call void @write(i8 32,  i64 24)
    call void @write(i8 32,  i64 26)
    call void @write(i8 32,  i64 28)
    call void @write(i8 32,  i64 30)
    call void @write(i8 32,  i64 32)
    call void @write(i8 32,  i64 34)
    call void @write(i8 32,  i64 36)
    call void @write(i8 32,  i64 38)
    call void @write(i8 32,  i64 40)
    call void @write(i8 32,  i64 42)
    call void @write(i8 32,  i64 44)

    ; Infinite loop so we don't crash
    br label %1
1:
    br label %1
    ret void
}
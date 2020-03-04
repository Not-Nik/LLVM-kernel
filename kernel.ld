/* LLVM-kernel (c) Nikolas Wipper 2020 */

ENTRY(_start)

SECTIONS
{
    . = 0x100000;
    .text :
    {
        /*Put the multiboot header in front of everything (for grub)*/
        *(.multiboot)
        *(.text)
    }

    .data ALIGN(4096) :
    {
        *(.data)
    }

    .rodata ALIGN(4096) :
    {
        *(.rodata)
    }

    .bss ALIGN(4096) :
    {
        *(.bss)
    }


    /DISCARD/ : { *(.fini_array*) *(.comment) }
}

OUTPUT_FORMAT(elf64-x86-64)
OUTPUT_ARCH(i386:x86-64)
ENTRY(_start)


MEMORY
{
  cod (RWX)  : ORIGIN = 0x20000 , LENGTH = 114688
  mem (RW)  : ORIGIN = 0x400000 , LENGTH = 30720
}

SECTIONS
{
  .code_bin  0x20000 : {
    code.o
    crc32 = 0x20c0de;
    inflate = 0x21d00d;
  } >cod
  .data_bin  0x400000 : {
    *(.data.data)
    data.o
    crc32Table = 0x400add;
  } > mem
  .data : {
    *(.data.test)
    test.o
  }
  .text : {
    *(.text.test)
    test.o
  }
  .dynamic : {
    *(.dynamic)
  }
  .dynsym : {
    *(.dynsym)
  }
  .dynstr : {
    *(.dynstr)
  }
  .gnu.version : {
    *(.gnu.version)
  }
  .gnu.version_d : {
    *(.gnu.version_d)
  }
  .gnu.version_r : {
    *(.gnu.version_r)
  }
  .rel.dyn : {
    *(.rel.dyn)
  }
  .rela.dyn : {
    *(.rela.dyn)
  }
  .rela.plt : {
    *(.rela.plt)
  }
  .init : {
    *(.init)
  }
  .plt : {
    *(.plt)
  }
  .fini : {
    *(.fini.test)
  }
  .bss : {
    *(.bss)
  }
  /DISCARD/ : {
    *(.note.ABI-tag)
    *(.eh_frame)
  }
}

OUTPUT_FORMAT(elf64-x86-64)




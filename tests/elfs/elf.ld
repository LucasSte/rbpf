PHDRS
{
  text PT_LOAD  ;
  rodata PT_LOAD ;
  data PT_LOAD ;
  dynamic PT_DYNAMIC ;
}

SECTIONS
{
  . = SIZEOF_HEADERS;
  .text : { *(.text*) } :text
  .rodata : { *(.rodata*) } :rodata
  .data.rel.ro : { *(.data.rel.ro*) } :rodata
  .data : { *(.data*) } :data
  .bss : { *(.bss*) } :data
  /DISCARD/ : {
      *(.eh_frame*)
      *(.gnu.hash*)
      *(.hash*)
      *(.dynamic)
      *(.dynsym)
      *(.dynstr)
      *(.rel.dyn)
    }
}

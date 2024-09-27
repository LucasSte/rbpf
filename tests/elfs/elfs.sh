#!/bin/bash -ex

# Requires Latest release of Solana's custom LLVM
# https://github.com/solana-labs/platform-tools/releases

TOOLCHAIN=/Users/lucasste/Documents/rust/build/aarch64-apple-darwin/stage1/bin
LLVM_PATH=/Users/lucasste/Documents/llvm-project/build/bin
RC_COMMON="$TOOLCHAIN/rustc --target sbf-solana-solana --crate-type lib -C panic=abort -C opt-level=2"
RC="$RC_COMMON -C target_cpu=sbfv2"
RC_V1="$RC_COMMON"
LD_COMMON="$LLVM_PATH/ld.lld -z notext -shared --Bdynamic -entry entrypoint --script elf.ld --section-start=.text=0x100000000 --pack-dyn-relocs=relr --no-pie --apply-dynamic-relocs --strip-all"
LD="$LD_COMMON"
LD_V1=$LD_COMMON

CLANG_CMD="$LLVM_PATH/clang -Werror -target sbf -O2 -mcpu=v1 -fno-builtin -fno-PIC -fno-pie -static -o reloc_64_relative_data.o -c reloc_64_relative_data.c"

# $CLANG_CMD
#$RC_V1 --emit=llvm-ir reloc_64_relative.rs
# $RC_V1 -o reloc_64_64.o reloc_64_64.rs
$LD_V1 -o reloc_64_relative_data.so reloc_64_relative_data.o

#$RC -o relative_call.o relative_call.rs
#$LD -o relative_call.so relative_call.o
#
#$RC_V1 -o syscall_reloc_64_32.o syscall_reloc_64_32.rs
#$LD_V1 -o syscall_reloc_64_32.so syscall_reloc_64_32.o
#
#$RC -o syscall_static.o syscall_static.rs
#$LD -o syscall_static.so syscall_static.o
#
#$RC -o bss_section.o bss_section.rs
#$LD -o bss_section.so bss_section.o
#
#$RC -o data_section.o data_section.rs
#$LD -o data_section.so data_section.o
#
#$RC_V1 -o rodata_section.o rodata_section.rs
#$LD_V1 -o rodata_section_sbpfv1.so rodata_section.o
#
#$RC -o rodata_section.o rodata_section.rs
#$LD -o rodata_section.so rodata_section.o
#
#$RC -o program_headers_overflow.o rodata_section.rs
#"$TOOLCHAIN"/llvm/bin/ld.lld -z notext -shared --Bdynamic -entry entrypoint --script program_headers_overflow.ld --noinhibit-exec -o program_headers_overflow.so program_headers_overflow.o
#
#$RC -o struct_func_pointer.o struct_func_pointer.rs
#$LD -o struct_func_pointer.so struct_func_pointer.o
#
#$RC -o reloc_64_64.o reloc_64_64.rs
#$LD -o reloc_64_64.so reloc_64_64.o
#
#$RC_V1 -o reloc_64_64.o reloc_64_64.rs
#$LD_V1 -o reloc_64_64_sbpfv1.so reloc_64_64.o
#
#$RC -o reloc_64_relative.o reloc_64_relative.rs
#$LD -o reloc_64_relative.so reloc_64_relative.o
#
#$RC_V1 -o reloc_64_relative.o reloc_64_relative.rs
#$LD_V1 -o reloc_64_relative_sbpfv1.so reloc_64_relative.o

# $RC -o reloc_64_relative_data.o reloc_64_relative_data.rs
# $LD -o reloc_64_relative_data.so reloc_64_relative_data.o# 

# $RC_V1 -o reloc_64_relative_data.o reloc_64_relative_data.rs
# $LD_V1 -o reloc_64_relative_data_sbpfv1.so reloc_64_relative_data.o

# rm *.o

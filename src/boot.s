/* 入口符号为 _start (在 boot.s 中声明) */
ENTRY(_start)

SECTIONS
{
  /* 将内核镜像加载到物理内存 1MB (0x100000) 处 */
  . = 1M;

  /* 代码段，包含 Multiboot 头部与可执行机器码 */
  .text BLOCK(4K) : ALIGN(4K)
  {
    *(.multiboot)
    *(.text)
  }

  /* 只读数据段 (包含常量字符串) */
  .rodata BLOCK(4K) : ALIGN(4K)
  {
    *(.rodata)
  }

  /* 已初始化的全局/静态变量 */
  .data BLOCK(4K) : ALIGN(4K)
  {
    *(.data)
  }

  /* 未初始化的全局变量和内核栈 (BSS 段) */
  .bss BLOCK(4K) : ALIGN(4K)
  {
    *(COMMON)
    *(.bss)
  }
}
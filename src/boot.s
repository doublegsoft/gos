/* 声明 multiboot 协议头部常量 */
.set ALIGN,    1<<0             /* 模块加载在 4KB 页面边界对齐 */
.set MEMINFO,  1<<1             /* 要求引导程序提供系统内存映射 */
.set FLAGS,    ALIGN | MEMINFO  /* multiboot 标志组合 */
.set MAGIC,    0x1BADB002       /* multiboot 协议魔数 */
.set CHECKSUM, -(MAGIC + FLAGS) /* 校验和: MAGIC + FLAGS + CHECKSUM 必须等于 0 */

/* 1. Multiboot 头段 */
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

/* 2. 16KB 内核堆栈空间 */
.section .bss
.align 16
stack_bottom:
.skip 16384 /* 16 KiB */
stack_top:

/* 3. 保护模式入口代码 */
.section .text
.global _start
.type _start, @function
_start:
  /* 初始化栈顶指针寄存器 esp */
  mov $stack_top, %esp

  /* 跳转进入 C 语言内核主逻辑 */
  extern kernel_main
  call kernel_main

  /* 内核返回后关闭中断并彻底挂起 CPU */
  cli
1:
  hlt
  jmp 1b

.size _start, . - _start
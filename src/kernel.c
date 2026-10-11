#include <stdint.h>
#include <stddef.h>

/* CGA/VGA 文本模式的物理基地址 */
static volatile uint16_t* const VGA_MEMORY = (uint16_t*) 0xB8000;
static const size_t VGA_WIDTH = 80;
static const size_t VGA_HEIGHT = 25;

/* VGA 文本模式下的字符封装：低字节为 ASCII，高字节为颜色属性 */
static inline uint16_t vga_entry(unsigned char ch, uint8_t color) {
  return (uint16_t)ch | ((uint16_t)color << 8);
}

/* 颜色配置：低 4 位前景色，高 4 位背景色 */
#define COLOR_WHITE_ON_BLACK 0x0F
#define COLOR_WHITE_ON_BLUE  0x1F

void kernel_main(void) {
  /* 1. 经典蓝底背景清屏 */
  for (size_t y = 0; y < VGA_HEIGHT; y++) {
    for (size_t x = 0; x < VGA_WIDTH; x++) {
      const size_t index = y * VGA_WIDTH + x;
      VGA_MEMORY[index] = vga_entry(' ', COLOR_WHITE_ON_BLUE);
    }
  }

  /* 2. 打印字符串到屏幕中央 */
  const char* str = "Hello, OS World! Welcome to My Tiny Kernel!";
  size_t start_row = 10;
  size_t start_col = 18;

  for (size_t i = 0; str[i] != '\0'; i++) {
    size_t index = start_row * VGA_WIDTH + (start_col + i);
    VGA_MEMORY[index] = vga_entry(str[i], COLOR_WHITE_ON_BLUE);
  }

  /* 3. 任务完成后挂起 */
  while (1) {
    __asm__ volatile("hlt");
  }
}
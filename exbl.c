
#include "uart.h"
#include "print.h"
#include "boot.h"
#include "encoding.h"
#include <stdint.h>
#include <string.h>
#include "mtrap.h"

#define SIZE_OF_DATA 1024*16
int g_test_data = 0;

char g_key=0x0f;


#define SLEEP_CNT 100000

//#define BASE_ADDR 0x80003000


void sleep_(int cnt)
{

	for(int i=0;i<cnt;i++){
		asm volatile("nop" : :);
	}

}

#define SFLS_BASE 0xc0000000
#define SFLS_SIZE 16*1024*1024
#define BOOT_ADDRESS 0
void main_(void)
{
  //_printf("exception\n");
  while(1);
}

void call(unsigned long addr)
{
  	asm volatile("jalr\t\t%0" : : "r" (addr));
  	asm volatile("nop" : :);
}

static void wake_harts()
{
  for (int hart = 0; hart < MAX_HARTS; ++hart)  *OTHER_HLS(hart)->ipi = 1; // wakeup the hart
}

#define SRAM_EMPTY 0xa0000000
#define DDR_EMPTY  0x80010000

void main_0(void)
{
	 Uart7_Init(115200);
	_printf("This is CPU 0\n");
 int a =0;
 int b =0;
     while(1){
    	 sleep_(10000000);
    	 _printf("0\n");
    	 a++;
    	 b= a;
     }

}

void main_1(void)
{

	_printf("This is CPU 1\n");
	 while(1){
		 sleep_(10000000);
		 _printf("1\n");
	 }

}

void main_2(void)
{
	_printf("This is CPU 2\n");
	 while(1){
		 sleep_(10000000);
		 _printf("2\n");
	}

}

void main_3(void)
{
	_printf("This is CPU 3\n");
	 while(1){
		 sleep_(10000000);
		_printf("3\n");
	}

}



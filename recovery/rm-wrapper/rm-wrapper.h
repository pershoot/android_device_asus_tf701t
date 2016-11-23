#ifndef _RM_WRAPPER_H_
#define _RM_WRAPPER_H_

#include <stdlib.h>
#include <stdio.h>

#define ENABLE_ANDROID_LOGGING 0
#define MINIMUM_LOGGING_LEVEL ANDROID_LOG_INFO

#define min(a,b) \
    ({ __typeof__ (a) _a = (a); \
       __typeof__ (b) _b = (b); \
       _a < _b ? _a : _b; })

int __android_log_print(int prio, const char *tag, const char *fmt, ...);
int str_between(const char* str, const char* prefix, const char* suffix, char* output, size_t out_size);

FILE* fopen(const char* path, const char* mode);
size_t fread(void* ptr, size_t size, size_t count, FILE* stream);

#endif

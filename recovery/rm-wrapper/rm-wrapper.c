#include "rm-wrapper.h"

#include <stdarg.h>
#include <dlfcn.h>
#include <string.h>
#include <math.h>
#include <unistd.h>
#include <android/log.h>

#if (ENABLE_ANDROID_LOGGING == 0)

#define __android_log_print_case(x) \
    case ANDROID_LOG_##x: \
        printf(#x); \
        break;

int __android_log_print(int prio, const char *tag, const char *fmt, ...) {
    if (prio < MINIMUM_LOGGING_LEVEL)
        return -1;

    va_list args;
    va_start(args, fmt);

    switch (prio) {
    __android_log_print_case(VERBOSE)
    __android_log_print_case(DEBUG)
    __android_log_print_case(INFO)
    __android_log_print_case(WARN)
    __android_log_print_case(ERROR)
    __android_log_print_case(FATAL)
    default:
        printf("???");
    }
    printf("/%s(%d): ", tag, getpid());

    // Make sure we don't have extra newlines
    size_t fmt_len = strlen(fmt);
    char* fmt_cpy = malloc(fmt_len);
    strcpy(fmt_cpy, fmt);
    while (fmt_len > 0 && fmt_cpy[fmt_len - 1] == '\n')
        fmt_cpy[--fmt_len] = 0;
    vprintf(fmt_cpy, args);

    printf("\n");
    va_end(args);
    return 0;
}

#endif

int str_between(const char* str, const char* prefix, const char* suffix, char* output, size_t out_size) {
    size_t str_len = strlen(str);
    size_t prefix_len = strlen(prefix);
    size_t suffix_len = strlen(suffix);

    if (strncmp(str, prefix, prefix_len) == 0 &&
        strncmp(str + str_len - suffix_len, suffix, suffix_len) == 0) {
        size_t out_len = min(out_size - 1, str_len - prefix_len - suffix_len);
        if (output != NULL) {
            strncpy(output, str + prefix_len, out_len);
            output[out_len] = 0;
        }
        return out_len;
    } else return -1;
}

unsigned char* POWER_MAGIC = "";

FILE* fopen(const char* path, const char* mode) {
    static FILE* (*_fopen)(const char*, const char*) = NULL;
    if (!_fopen)
        _fopen = dlsym(RTLD_NEXT, "fopen");

    if (str_between(path, "/sys/class/power_supply/", "/online", NULL, 0) >= 0) {
        FILE* ret = malloc(sizeof(FILE));
        ret->_p = POWER_MAGIC;
        return ret;
    }

    return _fopen(path, mode);
}

size_t fread(void* ptr, size_t size, size_t count, FILE* stream) {
    static size_t (*_fread)(void*, size_t, size_t, FILE*) = NULL;
    if (!_fread)
        _fread = dlsym(RTLD_NEXT, "fread");

    if (stream->_p == POWER_MAGIC)
        return 0;

    return _fread(ptr, size, count, stream);
}

int (*ts_main_init)();
int (*ts_main_resume)();
int (*ts_main_calc)();

int main() {
    void* dl = dlopen("ts.default.so", RTLD_NOW | RTLD_GLOBAL);
    if (!dl) {
        printf("Failed to load library: %s\n", dlerror());
        return 1;
    }

    ts_main_init = dlsym(dl, "ts_main_init");
    if (!ts_main_init) {
        printf("Failed to find ts_main_init: %s\n", dlerror());
        return 1;
    }
    ts_main_resume = dlsym(dl, "ts_main_resume");
    if (!ts_main_resume) {
        printf("Failed to find ts_main_resume: %s\n", dlerror());
        return 1;
    }
    ts_main_calc = dlsym(dl, "ts_main_calc");
    if (!ts_main_calc) {
        printf("Failed to find ts_main_calc: %s\n", dlerror());
        return 1;
    }

    ts_main_init();
    ts_main_resume();
    while (1) {
        ts_main_calc();
        sleep(5);
    }
}

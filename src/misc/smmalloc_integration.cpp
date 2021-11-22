#include "daScript/misc/platform.h"

#ifndef DAS_SMMALLOC_ENABLED
#define DAS_SMMALLOC_ENABLED        0
#endif

#ifndef DAS_SMMALLOC_POOL_SIZE
#define DAS_SMMALLOC_POOL_SIZE      (32*1024*1024)
#endif

#if defined(__has_feature)
#if __has_feature(thread_sanitizer)
    #define HAS_THREAD_SANITIZER
#endif
#endif

#if DAS_SMMALLOC_ENABLED && !defined(HAS_THREAD_SANITIZER)

#include <smmalloc.h>

#ifdef _MSC_VER
#pragma warning(disable:4290)
#endif

__forceinline sm_allocator & sm_space() {
    static sm_allocator G_SPACE = _sm_allocator_create(8, DAS_SMMALLOC_POOL_SIZE);
    return G_SPACE;
}

void * operator new[](std::size_t n) {
    return _sm_malloc(sm_space(), n, 16);
}

void operator delete  ( void* ptr ) {
    _sm_free(sm_space(), ptr);
}

void * operator new(std::size_t n)  {
    return _sm_malloc(sm_space(), n, 16);
}

void operator delete  ( void* ptr, size_t ) {
    _sm_free(sm_space(), ptr);
}

void  thread_cache_create() {
    _sm_allocator_thread_cache_create(sm_space(),  sm::CACHE_WARM, { 8192, 8192, 8192, 8192, 8192 });
}

void thread_cache_destroy() {
    _sm_allocator_thread_cache_destroy(sm_space());
}

#else

void thread_cache_create() {
}

void thread_cache_destroy() {
}

#endif
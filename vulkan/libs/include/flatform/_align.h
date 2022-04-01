#pragma once

#include <flatform/_inline.h>

typedef struct range {
    /** @brief The offset in bytes. */
    unsigned long long offset;
    /** @brief The size in bytes. */
    unsigned long long size;
} range;

INLINE unsigned long long get_aligned(unsigned long long operand, unsigned long long granularity) {
    return ((operand + (granularity - 1)) & ~(granularity - 1));
}

INLINE range get_aligned_range(offset, size, granularity) {
    return (range){get_aligned(offset, granularity), get_aligned(size, granularity)};
}

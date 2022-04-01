#pragma once

#include <flatform/_flatform.h>
#include <flatform/_inline.h>
#include <flatform/_align.h>
#include <flatform/_dllexport.h>

/** @brief Gets the number of bytes from amount of gibibytes (GiB) (1024*1024*1024) */
#define GIBIBYTES(amount) amount * 1024 * 1024 * 1024
/** @brief Gets the number of bytes from amount of mebibytes (MiB) (1024*1024) */
#define MEBIBYTES(amount) amount * 1024 * 1024
/** @brief Gets the number of bytes from amount of kibibytes (KiB) (1024) */
#define KIBIBYTES(amount) amount * 1024

/** @brief Gets the number of bytes from amount of gigabytes (GB) (1000*1000*1000) */
#define GIGABYTES(amount) amount * 1000 * 1000 * 1000
/** @brief Gets the number of bytes from amount of megabytes (MB) (1000*1000) */
#define MEGABYTES(amount) amount * 1000 * 1000
/** @brief Gets the number of bytes from amount of kilobytes (KB) (1000) */
#define KILOBYTES(amount) amount * 1000

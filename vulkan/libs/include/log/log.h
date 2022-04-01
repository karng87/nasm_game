#ifndef _LOG_H
#define _LOG_H

#include<stdbool.h>
#include<flatform/_dllexport.h>

#define LOG_WARN_ENABLE 1
#define LOG_INFO_ENABLE 1
#define LOG_DEBUG_ENABLE 1
#define LOG_TRACE_ENABLE 1

#if RELEASE == 1
#define LOG_DEBUG_ENABLE 0
#define LOG_TRACE_ENABLE 0
#endif

typedef enum log_level{
  LOG_LEVEL_FATAL=0,
  LOG_LEVEL_ERROR=1,
  LOG_LEVEL_WARN=2,
  LOG_LEVEL_INFO=3,
  LOG_LEVEL_DEBUG=4,
  LOG_LEVEL_TRACE=5,
}log_level;

bool init_log();
void shutdown_log();
API void log_output(log_level,const char*,...);

#define FATAL(msg, ...) log_output(LOG_LEVEL_FATAL, msg, ##__VA_ARGS__)
#ifndef ERROR
#define ERROR(msg, ...) log_output(LOG_LEVEL_ERROR,msg,##__VA_ARGS__)
#endif

#if LOG_WARN_ENABLE == 1
#define WARN(msg, ...) log_output(LOG_LEVEL_WARN,msg,##__VA_ARGS__)
#else
#define WARN(msg, ...)
#endif

#if LOG_INFO_ENABLE == 1
#define INFO(msg, ...) log_output(LOG_LEVEL_INFO,msg,##__VA_ARGS__)
#else
#define INFO(msg, ...)
#endif

#if LOG_DEBUG_ENABLE == 1
#define DEBUG(msg, ...) log_output(LOG_LEVEL_DEBUG,msg,##__VA_ARGS__)
#else
#define DEBUG(msg, ...)
#endif

#if LOG_TRACE_ENABLE == 1
#define TRACE(msg, ...) log_output(LOG_LEVEL_TRACE,msg,##__VA_ARGS__)
#else
#define TRACE(msg, ...)
#endif

#endif

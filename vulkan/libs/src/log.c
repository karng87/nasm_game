#include <log/log.h>

#include <stdarg.h>
#include <string.h>
#include <stdio.h>

bool init_log(){
  printf("init_log\n");
  return true;
}
void shutdown_log(){
  // TODO
}
void log_output (log_level level, const char* msg, ...){
  //bool is_error = level < LOG_LEVEL_WARN;
  char out_msg[32000];
  memset(out_msg,0,sizeof(out_msg));

  __builtin_va_list arg_ptr;
  va_start(arg_ptr,msg);
  vsnprintf(out_msg,32000,msg,arg_ptr);
  va_end(arg_ptr);

  char out_msg2[32000];
  const char* level_str[6] = {"[FATAL]: ", "[ERROR]: ", "[WARN]: ", "[INFO]: ", "[DEBUG]: ", "[TRACE]: "};
  sprintf(out_msg2,"%s%s\n",level_str[level],out_msg);
  printf("%s",out_msg2);
}

void report_assertion_failure(const char* expression, const char* message, const char* file, int line) {
    log_output(LOG_LEVEL_FATAL, "Assertion Failure: %s, message: '%s', in file: %s, line: %d\n", expression, message, file, line);
}

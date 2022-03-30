#include "log.h"

#include <stdarg.h>
#include <string.h>
#include <stdio.h>

bool init_log(){
  return true;
}
void shutdown_log(){
  // TODO
}
__attribute__((visibility("default"))) void log_output(log_level,const char*,...){
  // TODO
}


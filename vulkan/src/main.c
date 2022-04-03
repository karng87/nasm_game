#include<core/log.h>

int main(){
  FATAL("Test FATAL:%f",3.14f);
  ERROR("Test ERROR:%f",3.14f);
  WARN("Test WARN:%f",3.14f);
  INFO("Test INFO:%f",3.14f);
  DEBUG("Test DEBUG:%f",3.14f);
  TRACE("Test TRACE:%f",3.14f);
}

#include "win/windows.h"
#include <core/log.h>

int main(){
  FATAL("Test FATAL:%f",3.14f);
  ERROR("Test ERROR:%f",3.14f);
  WARN("Test WARN:%f",3.14f);
  INFO("Test INFO:%f",3.14f);
  DEBUG("Test DEBUG:%f",3.14f);
  TRACE("Test TRACE:%f",3.14f);
  platform_state p_state;
  if(platform_startup(&p_state, "Xcb", 100, 100, 800, 600)){
    while(1){
      platform_pump_messages(&p_state);
    }
  }
  platform_shutdown(&p_state);
  return 0;
}

#include <platform/platform.h>
#include <core/logger.h>

int main(){
  KFATAL("Test FATAL:%f",3.14f);
  KERROR("Test ERROR:%f",3.14f);
  KWARN("Test WARN:%f",3.14f);
  KINFO("Test INFO:%f",3.14f);
  KDEBUG("Test DEBUG:%f",3.14f);
  KTRACE("Test TRACE:%f",3.14f);
  platform_state p_state;
  if(platform_startup(&p_state, "Xcb", 100, 100, 800, 600)){
    while(1){
      platform_pump_messages(&p_state);
    }
  }
  platform_shutdown(&p_state);
  return 0;
}

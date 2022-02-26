#include <stdlib.h>
#include <stdio.h>
#include <vulkan/vulkan_core.h>

#define GLFW_INCLUDE_VULKAN
#include <GLFW/glfw3.h>
GLFWwindow * win;
VkInstance instance;
VkDebugUtilsMessengerEXT debugMessenger;
const char * validationLayers = "VK_LAYER_KHRONOS_validation";
#ifdef NDEBUG
const char enableValidationLayers = 0;
#else
const char enableValidationLayers = 1;
#endif


void winInit();
void gameLoop();
void gameClean();
void createInstance();

/* main */
int main() {
  winInit(win);
  gameLoop();
  createInstance();
  gameClean();
} // end of main()

/* function definitions */
void winInit(){
  glfwInit();
  glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
  glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);
  win = glfwCreateWindow(800, 600, "Vulkan", NULL, NULL);
}
void gameLoop(){while(!glfwWindowShouldClose(win)){glfwPollEvents();}}
void gameClean(){
  vkDestroyInstance(instance,NULL);
  glfwDestroyWindow(win);
  glfwTerminate();
}
void createInstance(){
   VkApplicationInfo vai={};
   {
     vai.sType = VK_STRUCTURE_TYPE_APPLICATION_INFO;
     vai.pApplicationName = "Hello Triangle";
     vai.pEngineName = "No Engine";
     vai.engineVersion = VK_MAKE_VERSION(1, 0, 0);
     vai.apiVersion = VK_API_VERSION_1_0;
   }
   VkInstanceCreateInfo vici={};
   {
     vici.sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO;
     vici.pApplicationInfo = &vai;
     {
       uint32_t glfwEXtensionCount = 0;
       const char ** glfwExtensions = glfwGetRequiredInstanceExtensions(&glfwEXtensionCount);
       printf ("glfwExtensions Count: %d",glfwEXtensionCount); 
       vici.enabledExtensionCount = glfwEXtensionCount;
       vici.ppEnabledExtensionNames = glfwExtensions;
     }
     vici.enabledExtensionCount = 0;
   } 
   if (vkCreateInstance(&vici, NULL, &instance) != VK_SUCCESS) 
     printf ("failed to create instance!\n"); 
   {
     uint32_t extensionCount = 0;
     vkEnumerateInstanceExtensionProperties(NULL, &extensionCount ,NULL);
     VkExtensionProperties extentions[extensionCount];
     vkEnumerateInstanceExtensionProperties(NULL, &extensionCount, extentions);
     {
       printf("available extensions:\n");
       for (int i = 0; i <= extensionCount; i++){
         printf("\t%s\n",extentions->extensionName);
       }
     }
   }
}

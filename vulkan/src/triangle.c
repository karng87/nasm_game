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

static VKAPI_ATTR VkBool32 VKAPI_CALL debugCallback(VkDebugUtilsMessageSeverityFlagBitsEXT messageSeverity, VkDebugUtilsMessageTypeFlagsEXT messageType, const VkDebugUtilsMessengerCallbackDataEXT* pCallbackData, void* pUserData) {
  printf ("validation layer: %s\n" ,pCallbackData->pMessage);
  return VK_FALSE;
}
VkResult CreateDebugUtilsMessengerEXT(VkInstance instance, const VkDebugUtilsMessengerCreateInfoEXT* pCreateInfo, const VkAllocationCallbacks* pAllocator, VkDebugUtilsMessengerEXT* pDebugMessenger) {
    if ((PFN_vkCreateDebugUtilsMessengerEXT) vkGetInstanceProcAddr(instance, "vkCreateDebugUtilsMessengerEXT") != NULL){
        return ((PFN_vkCreateDebugUtilsMessengerEXT) vkGetInstanceProcAddr(instance, "vkCreateDebugUtilsMessengerEXT"))(instance, pCreateInfo, pAllocator, pDebugMessenger);
    } else {
        return VK_ERROR_EXTENSION_NOT_PRESENT;
    }
}

void DestroyDebugUtilsMessengerEXT(VkInstance instance, VkDebugUtilsMessengerEXT debugMessenger, const VkAllocationCallbacks* pAllocator) {
    if ((PFN_vkDestroyDebugUtilsMessengerEXT) vkGetInstanceProcAddr(instance, "vkDestroyDebugUtilsMessengerEXT") != NULL) {
        ((PFN_vkDestroyDebugUtilsMessengerEXT) vkGetInstanceProcAddr(instance, "vkDestroyDebugUtilsMessengerEXT"))(instance, debugMessenger, pAllocator);
    }
}

char**  getRequiredExtensions() {
    uint32_t glfwExtensionCount = 0;
    const char** glfwExtensions;
    glfwExtensions = glfwGetRequiredInstanceExtensions(&glfwExtensionCount);

    if (enableValidationLayers) {
      strcat(glfwExtensions ,VK_EXT_DEBUG_UTILS_EXTENSION_NAME);
    }

    return glfwExtensions;
}
/* main */
int main() {
  winInit(win);
  gameLoop();
  createInstance();
  {
    if(!enableValidationLayers){return 0;}
    VkDebugUtilsMessengerCreateInfoEXT vdumcie = {};
    {
      vdumcie.sType = VK_STRUCTURE_TYPE_DEBUG_UTILS_MESSENGER_CREATE_INFO_EXT;
      vdumcie.messageSeverity = VK_DEBUG_UTILS_MESSAGE_SEVERITY_VERBOSE_BIT_EXT | VK_DEBUG_UTILS_MESSAGE_SEVERITY_WARNING_BIT_EXT | VK_DEBUG_UTILS_MESSAGE_SEVERITY_ERROR_BIT_EXT;
      vdumcie.messageType = VK_DEBUG_UTILS_MESSAGE_TYPE_GENERAL_BIT_EXT | VK_DEBUG_UTILS_MESSAGE_TYPE_VALIDATION_BIT_EXT | VK_DEBUG_UTILS_MESSAGE_TYPE_PERFORMANCE_BIT_EXT;
      vdumcie.pfnUserCallback = debugCallback;
    }
    if(createDebugUtilsMessengerEXT(instance,&vdumcie,NULL,&debugMessenger)){
      printf("failed to set up debug messenger!\n");
      exit(-1);
    }
  }
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
  if (enableValidationLayers) {
    DestroyDebugUtilsMessengerEXT(instance, debugMessenger, NULL);
  }

}
void createInstance(){
  if (enableValidationLayers && !checkValidationLayerSupport()) {
    printf("validation layers requested, but not available!");
  }

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
      extensions = getRequiredExtensions();
      createInfo.enabledExtensionCount = static_cast<uint32_t>(extensions.size());
      createInfo.ppEnabledExtensionNames = extensions.data();

     }
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

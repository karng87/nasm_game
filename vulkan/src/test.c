#include <stdio.h>
#include <log/log.h>
#include <flatform/asserts.h>
#include <string.h>
#include <regex.h>

int main(){
  FATAL("A test msg: %f",3.14f);

  char * targets = "e^x = sin(x) + cos(x)";
  //char * pattern = "[a-z]*([0-9]+)([a-z]*)";
  //char * pattern = "[a-z]*([0-9]+)([a-z]*)";
  char * pattern = "([^=)+)=([a-z0-9]*).*(cos.*)";
  size_t maxGroups = 3;

  regex_t rg_struct;
  regmatch_t rgm_indices[maxGroups];

  if (regcomp(&rg_struct, pattern, REG_EXTENDED))
    {
      printf("Could not compile regular expression.\n");
      return 1;
    };

  if (regexec(&rg_struct, targets, maxGroups, rgm_indices, 0) == 0)
    {
      unsigned int g = 0;
      for (g = 0; g < maxGroups; g++)
        {
          if (rgm_indices[g].rm_so == (size_t)-1)
            break;  // No more groups

          char targetCopy[strlen(targets) + 1];
          strcpy(targetCopy, targets);
          targetCopy[rgm_indices[g].rm_eo] = 0;
          printf("Group %u: [%2u-%2u]: %s\n",
                 g, rgm_indices[g].rm_so, rgm_indices[g].rm_eo,
                 targetCopy + rgm_indices[g].rm_so);
        }
    }

  regfree(&rg_struct);
  ASSERT(1==0);
}

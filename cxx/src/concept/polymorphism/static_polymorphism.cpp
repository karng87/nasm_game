#include <iostream>

template <typename T> 
concept speakable_c = requires(T t) {t.speak();};

struct Bird{void sing(){std::cout<<"I am a bird"<<std::endl;}};
struct Dog{void sing(){std::cout<<"I am a dog"<<std::endl;}};
struct Man1{void sing(){std::cout<<"I am a man"<<std::endl;} void speak(){std::cout<<"sing a man song"<<std::endl;}};
struct Woman{void sing(){std::cout<<"I am a woman"<<std::endl;} void speak(){std::cout<<"sing a woman song"<<std::endl;}};

template<speakable_c... Ts> void speakall(Ts... args){
  (args.speak(),...);
}

int main(){
  speakall(Man1{},Woman{});
}

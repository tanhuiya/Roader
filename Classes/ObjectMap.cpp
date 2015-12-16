#include "ObjectMap.h"
ObjectMap* ObjectMap::instance=nullptr;
ObjectMap* ObjectMap::getinstance(){
	if(instance){
		return instance;
	}else{
		instance=new ObjectMap();
		return instance;
	}
}
void ObjectMap::addMap(void* ptr1,void*ptr2){
	m_objmap.insert(std::make_pair(ptr1,ptr2));
}
void* ObjectMap::findSecond(void* ptr1){
	auto result=m_objmap.find(ptr1);
	if(result==m_objmap.end()){
		return NULL;
	}else{
		return result->second;
	}
}
ObjectMap::ObjectMap(){

}
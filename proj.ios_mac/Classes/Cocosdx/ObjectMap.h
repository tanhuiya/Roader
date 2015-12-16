#ifndef _H_OBJECTMAP_H
#define _H_OBJECTMAP_H
#include "cocos2d.h"
#include "map"
USING_NS_CC;
class ObjectMap{
public:
	static ObjectMap* getinstance();
	void addMap(void* ptr1,void*ptr2);
	void* findSecond(void* ptr1);
private:
	ObjectMap();
	static ObjectMap* instance;
	std::map<void*,void*>m_objmap;
};
#endif
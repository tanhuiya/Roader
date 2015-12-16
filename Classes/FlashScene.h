#ifndef __FLASH_SCENE_H__
#define __FLASH_SCENE_H__

#include "cocos2d.h"
USING_NS_CC;
class FlashScene : public cocos2d::Layer
{
public:
	
	static cocos2d::Scene* createScene();
	static FlashScene* create();
	// Here's a difference. Method 'init' in cocos2d-x returns bool, instead of returning 'id' in cocos2d-iphone
	bool init();
	void loadedCallBack(Object* pSender);
	void loading();
	void asyncLoad_Callback(Sprite3D* sprite, void* param);
private:
	int totalNum,haveLoadedNum;
	LabelTTF* ttf;
};
#endif
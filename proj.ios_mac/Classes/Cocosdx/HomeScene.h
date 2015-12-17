#ifndef H_HOME_H
#define H_HOME_H
#include "cocos2d.h"
USING_NS_CC;
class MainScene:public Layer{
public:
	static Scene* createScene();
	CREATE_FUNC(MainScene);
	bool init();
	void menuCallback(cocos2d::Ref* pSender);
    void menuCallbackIOS(cocos2d::Ref* pSender);
};
#endif
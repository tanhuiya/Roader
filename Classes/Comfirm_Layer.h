#ifndef H_CONFIRM_H
#define H_CONFIRM_H
#include "cocos2d.h"
#include "DieLayer.h"
USING_NS_CC;
class ConfirmLayer:public Layer{
public:
	static ConfirmLayer* createLayer(Dielayer* dielayer);
	virtual bool init(Dielayer* dielayer);
	
	void CallBack(Ref* pSender);
	void relive();
	void noCoin();
	static int times;
private:
	MenuItemSprite* fuhuoitem;
	MenuItemSprite* cancelitem;
	Dielayer* m_dielayer;
	Sprite* title;
	Size visibleSize;
	
};
#endif
#ifndef H_DIELAYER_H
#define H_DIELAYER_H
#include "cocos2d.h"
#include "Player.h"
#include "World.h"
USING_NS_CC;
class Dielayer:public Layer{
public:
	static Dielayer* createLayer(Player* player);
	virtual bool init(Player* player);
	//CREATE_FUNC(Dielayer);
	void CallBack(Ref* pSender);
	void Pop_layer();
	void addcomfirm_layer();
	Player* getPlayer();
	bool isChocked;
private:
	MenuItemSprite* backitem;
	MenuItemSprite* restartitem;
	Player* m_player;
    cocos2d::Size visibleSize;
//	World* m_world;
};
#endif
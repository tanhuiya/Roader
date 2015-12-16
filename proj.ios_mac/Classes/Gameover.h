#ifndef _GAMEOVER_
#define _GAMEOVER_
#include "cocos2d.h"
#include "Player.h"
#include "World.h"
using namespace cocos2d;
class Gameover : public cocos2d::Layer
{
public:

	static cocos2d::Scene* createScene(Player* player);

	virtual bool init(Player* player);  
	void addCoin(float delta);
	void newGame(cocos2d::Ref* pSender);
	void menuCloseCallback(cocos2d::Ref* pSender);
	static Gameover* create(Player* player);
private:
	int MaxScore;
	Label* labelCoin;
	int curCoin;
	int gotCoin;
	Player* m_player;
};
#endif
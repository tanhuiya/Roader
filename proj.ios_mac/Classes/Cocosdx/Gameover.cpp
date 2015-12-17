#include "Gameover.h"
#include "HomeScene.h"
#include "HelloWorldScene.h"
#include "FlashScene.h"

USING_NS_CC;

Scene* Gameover::createScene(Player* player)
{
	auto scene = Scene::create();

	auto layer = Gameover::create( player);

	scene->addChild(layer);

	return scene;
}
Gameover* Gameover::create(Player* player)
{ 
	Gameover *pRet = new Gameover(); 
	if (pRet && pRet->init(player)) 
	{ 
		pRet->autorelease(); 
		return pRet; 
	} 
	else 
	{ 
		delete pRet; 
		pRet = NULL; 
		return NULL; 
	} 
}
bool Gameover::init(Player* player)
{
	Layer::init();
	m_player=player;
	Size visibleSize = Director::getInstance()->getVisibleSize();
	auto background=Sprite::create("gameover.png");
	auto scalex=visibleSize.width/background->getContentSize().width;
	auto scaley=visibleSize.height/background->getContentSize().height;
	background->setScaleX(scalex);
	background->setScaleY(scaley);
	background->setOpacity(120);
	background->setPosition(visibleSize.width/2,visibleSize.height/2);
	this->addChild(background);
	auto overIcon = MenuItemImage::create(
		"home-1.png", 
		"home-1.png",
		CC_CALLBACK_1(Gameover::menuCloseCallback, this));
	overIcon->setPosition(Vec2( visibleSize.width /3*2 , visibleSize.height/4));
	auto newgame = MenuItemImage::create(
		"start1.png", 
		"start1.png",
		CC_CALLBACK_1(Gameover::newGame, this));

	newgame->setPosition(Vec2( visibleSize.width /3 , visibleSize.height/4));
	newgame->setScale(0.6);
	//UserDefault::getInstance()->getIntegerForKey("MaxScore",0);
	auto menu = Menu::create(overIcon,newgame, NULL);
	menu->setPosition(Vec2::ZERO);
	this->addChild(menu, 1);
	auto temp_score=m_player->getScore();
//	auto coin_num=m_player->getCoin();
	char str[20]={0};
	sprintf(str,"YOU SCORE:%d",temp_score);
	auto labelscore=Label::createWithBMFont("bitmapFontTest2.fnt", str);
//	auto labelscore=Label::create(str,"Consolas",38);
	labelscore->setColor(Color3B::BLUE);
	labelscore->setPosition(visibleSize.width/2,visibleSize.height/2);
	this->addChild(labelscore);
	MaxScore=UserDefault::getInstance()->getIntegerForKey("MaxScore",0);
	if(temp_score>MaxScore)
	{
		UserDefault::getInstance()->setIntegerForKey("MaxScore",temp_score);
		MaxScore=temp_score;
	}
	char buf[20]={0};
	sprintf(buf,"BEST SCORE:%d",MaxScore);
	auto labelbest=Label::createWithBMFont("bitmapFontTest2.fnt", buf);
//	auto labelbest=Label::create(buf,"Consolas",30);
	labelbest->setColor(Color3B::RED);
	labelbest->setPosition(Point(visibleSize.width/4,visibleSize.height-100));
	this->addChild(labelbest);
	curCoin=MaxScore=UserDefault::getInstance()->getIntegerForKey("TotalCoin",0);
	gotCoin=m_player->getCoin();
	UserDefault::getInstance()->setIntegerForKey("TotalCoin",curCoin+gotCoin);
	char str_coin[10]={0};
	sprintf(str_coin,"Coin:%d",curCoin);
	labelCoin=Label::createWithBMFont("bitmapFontTest2.fnt", str_coin);
//	labelCoin=Label::create(str_coin,"Consolas",40);
	labelCoin->setColor(Color3B::ORANGE);
	labelCoin->setPosition(Point(visibleSize.width/4*3,visibleSize.height-100));
	this->addChild(labelCoin);
	auto delay=DelayTime::create(1.0);
	auto s=Sequence::create(delay,CCCallFunc::create(
		[=](){
//		this->schedule(schedule_selector(Gameover::addCoin,this),0.15);
		Director::getInstance()->getScheduler()->
			scheduleSelector(schedule_selector(Gameover::addCoin),this,0.15,false);
	}
	),NULL);
	this->runAction(s);
	return true;
}
void Gameover::addCoin(float delta){
	if(gotCoin-->0){
		char str_coin[10]={0};
		curCoin++;
		sprintf(str_coin,"Coin:%d",curCoin);
		labelCoin->setString(str_coin);
	}else{
//		this->unschedule(schedule_selector(Gameover::addCoin,this));
		Director::getInstance()->getScheduler()->
			unscheduleSelector(schedule_selector(Gameover::addCoin),this);
	}
}
void Gameover::newGame(Ref* pSender)
{
	Director::getInstance()->getRunningScene()->unscheduleAllSelectors();
	Director::getInstance()->getRunningScene()->stopAllActions();
	Director::getInstance()->getRunningScene()->cleanup();
	Sprite3DCache::getInstance()->removeAllSprite3DData();
	Director::getInstance()->getTextureCache()->removeAllTextures();
	m_player=NULL;
	auto scene=FlashScene::createScene();
	Director::getInstance()->replaceScene(scene);
}
void Gameover::menuCloseCallback(Ref* pSender)
{

    auto scene=HelloWorld::createScene();
    Director::getInstance()->replaceScene(scene);


}

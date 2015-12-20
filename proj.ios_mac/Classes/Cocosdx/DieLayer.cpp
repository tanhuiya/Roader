#include "DieLayer.h"
#include "HelloWorldScene.h"
#include "HomeScene.h"
#include "Gameover.h"
#include "Comfirm_Layer.h"

Dielayer* Dielayer::createLayer(Player* player){
	auto pRet=new Dielayer();
	
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
bool Dielayer::init(Player* player){
	Layer::init();
	m_player=player;
	isChocked=false;
	this->setOpacity(120);
	visibleSize=Director::getInstance()->getWinSize();
	auto bk=Sprite::create("gameover.png");
	auto scalex=visibleSize.width/bk->getContentSize().width;
	auto scaley=visibleSize.height/bk->getContentSize().height;
	bk->setScaleX(scalex);
	bk->setScaleY(scaley);
	bk->setOpacity(120);
	bk->setPosition(visibleSize.width/2,visibleSize.height/2);
	this->addChild(bk);
	auto back=Sprite::create("continue-1.png");
	auto restart=Sprite::create("retry-1.png");
	backitem=MenuItemSprite::create(back,back,CC_CALLBACK_1(Dielayer::CallBack,this));
	restartitem=MenuItemSprite::create(restart,restart,CC_CALLBACK_1(Dielayer::CallBack,this));
	auto menu=Menu::create(backitem,restartitem,NULL);
	backitem->setPosition(visibleSize.width/4,visibleSize.height/3);
	restartitem->setPosition(visibleSize.width/4*3,visibleSize.height/3);
	this->addChild(menu);
	menu->setPosition(Point::ZERO);
	
	
	return true;
}
void Dielayer::Pop_layer(){
	this->setVisible(true);
	this->setSwallowsTouches(true);
//	auto main=(HelloWorld*)this->getParent();
	
}
void Dielayer::CallBack(Ref* pSender)
{
//	Director::getInstance()->resume();
	auto item=(MenuItemSprite*)pSender;
	if(!isChocked){
		Scene* scene;
		if(restartitem==item)
		{
			
			scene=Gameover::createScene(m_player);
			Director::getInstance()->replaceScene(scene);
		//	delete m_world;
		//	delete m_player;
		}
		else
		{
			addcomfirm_layer();
		}
	}
}
Player* Dielayer::getPlayer(){
	return m_player;
	
}
void Dielayer::addcomfirm_layer(){
	isChocked=true;
	auto confirm=ConfirmLayer::createLayer(this);
	this->setSwallowsTouches(false);
	this->getParent()->addChild(confirm,1001);
}
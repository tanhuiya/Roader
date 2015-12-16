#include "Comfirm_Layer.h"
int ConfirmLayer::times=0;
ConfirmLayer* ConfirmLayer::createLayer(Dielayer* dielayer){
	auto pRet=new ConfirmLayer();

	if (pRet && pRet->init(dielayer)) 
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
bool ConfirmLayer::init(Dielayer* dielayer){
	Layer::init();
	m_dielayer=dielayer;
	this->setOpacity(0);
	visibleSize=Director::getInstance()->getWinSize();
	this->setContentSize(visibleSize);
	this->setAnchorPoint(Vec2(1,1));
	Sprite* back=NULL;
	if(times==0){
		back=Sprite::create("20coin.png");
	}else if(times==1){
		back=Sprite::create("40coin.png");
	}else if(times==2){
		back=Sprite::create("80coin.png");
	}else{
		back=Sprite::create("die.png");
	}
	
	back->setPosition(visibleSize.width/2,visibleSize.height/2);
	this->addChild(back);
	auto relive=Sprite::create("fuhuo.png");
	auto cancel=Sprite::create("cancel.png");
	fuhuoitem=MenuItemSprite::create(relive,relive,CC_CALLBACK_1(ConfirmLayer::CallBack,this));
	cancelitem=MenuItemSprite::create(cancel,cancel,CC_CALLBACK_1(ConfirmLayer::CallBack,this));
	auto menu=Menu::create(fuhuoitem,cancelitem,NULL);
	fuhuoitem->setPosition(visibleSize.width/4,visibleSize.height/3);
	cancelitem->setPosition(visibleSize.width/4*3,visibleSize.height/3);
	this->addChild(menu);
	menu->setPosition(Point::ZERO);


	return true;
}
void ConfirmLayer::CallBack(Ref* pSender)
{
	/*if(!title){
		return;
	}*/
	m_dielayer->isChocked=false;
	auto item=(MenuItemSprite*)pSender;
	Scene* scene;
	if(cancelitem==item)
	{
		this->removeFromParent();
	}
	else
	{
		auto coins=UserDefault::getInstance()->getIntegerForKey("TotalCoin",0);
		if(times==0){
			if(coins>=20){
				UserDefault::getInstance()->setIntegerForKey("TotalCoin",coins-20);
				times++;
				relive();
			}else{
				noCoin();
			}
		}else
		if(times==1){
			if(coins>=40){
				UserDefault::getInstance()->setIntegerForKey("TotalCoin",coins-40);
				times++;
				relive();
			}else{
				noCoin();
			}
		}else
		if(times==2){
			if(coins>=80){
				UserDefault::getInstance()->setIntegerForKey("TotalCoin",coins-80);
				times++;
				relive();
			}else{
				noCoin();
			}
		}else{
			noCoin();
		}
	}
	
}
void ConfirmLayer::relive(){
	
	m_dielayer->getPlayer()->reLive();
	m_dielayer->setVisible(false);
	m_dielayer->setSwallowsTouches(false);
	m_dielayer->getPlayer()->setPause();
	this->removeFromParent();
}
void ConfirmLayer::noCoin(){
	title=Sprite::create("no.png");
	title->setPosition(visibleSize.width/2,visibleSize.height/3*2);
	this->addChild(title);
	auto delay=DelayTime::create(1.0);
	auto s=Sequence::create(delay,CCCallFunc::create(
		[=](){
			title->setVisible(false);
	}
		),NULL);
	title->runAction(s);
}

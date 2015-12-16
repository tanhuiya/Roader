#include "FlashScene.h"
#include "HelloWorldScene.h"
#include "HomeScene.h"
#include "SimpleAudioEngine.h"
using namespace CocosDenshion;
Scene* FlashScene::createScene()
{
	auto scene = Scene::create();
	auto layer = FlashScene::create();
	scene->addChild(layer);
	return scene;
}
FlashScene* FlashScene::create(){
	FlashScene* ret=new FlashScene();
	ret->init();
	ret->autorelease();
	return ret;
}
bool FlashScene::init()
{
	Layer::init();
	totalNum=20; //记录总的加载数量  
	haveLoadedNum=0;   //记录已加载的数量  
	this->loading();
	return true;
}
void FlashScene::loadedCallBack(Object* pSender){
	haveLoadedNum++;  
	this->runAction(CCDelayTime::create(15));  
	char tmp[10];  
	sprintf(tmp, "%%%d",(int)((float)haveLoadedNum/totalNum*100));  
	ttf->setString(tmp);  //更改加载进度  
	if (haveLoadedNum==18)  
	{  
		this->removeChild(ttf, true);   //加载完成后，移除加载进度显示  
		Scene *newscne=MainScene::createScene();  
		Director::getInstance()->replaceScene(newscne); //场景切换  
	}  
}
void FlashScene::loading(){
	SimpleAudioEngine::getInstance()->preloadBackgroundMusic("game.mp3");
	SimpleAudioEngine::getInstance()->preloadBackgroundMusic("jump.mp3");
	SimpleAudioEngine::getInstance()->preloadBackgroundMusic("FX088.mp3");
	SimpleAudioEngine::getInstance()->preloadBackgroundMusic("pickup_coin.mp3");
	Size size=CCDirector::sharedDirector()->getWinSize();  
	ttf=LabelTTF::create(" %0", "Arial", 30);    //显示加载进度
	LabelTTF *havettf=LabelTTF::create("Loading", "Arial",30);
	this->addChild(ttf,1);  
	this->addChild(havettf,1);  
	ttf->setPosition(ccp(size.width/3, size.height/2));  
	havettf->setPosition(ccp(size.width/2, size.height/2));
//	Director::getInstance()->getTextureCache()->
//		addImageAsync("model/coin.png",CC_CALLBACK_1(FlashScene::loadedCallBack,this));  
//	Director::getInstance()->getTextureCache()->
//		addImageAsync("model/character_color.png",CC_CALLBACK_1(FlashScene::loadedCallBack,this));  
//	Director::getInstance()->getTextureCache()->
//		addImageAsync("model/Leaves Transparent.png",CC_CALLBACK_1(FlashScene::loadedCallBack,this)); 
	Director::getInstance()->getTextureCache()->
		addImageAsync("Logs Side.png",CC_CALLBACK_1(FlashScene::loadedCallBack,this));
	Director::getInstance()->getTextureCache()->
		addImageAsync("Logs Top.png",CC_CALLBACK_1(FlashScene::loadedCallBack,this));
	Director::getInstance()->getTextureCache()->
		addImageAsync("road.png",CC_CALLBACK_1(FlashScene::loadedCallBack,this));
	Director::getInstance()->getTextureCache()->
		addImageAsync("street.png",CC_CALLBACK_1(FlashScene::loadedCallBack,this));
	Director::getInstance()->getTextureCache()->
		addImageAsync("gameover.png",CC_CALLBACK_1(FlashScene::loadedCallBack,this));  
	Director::getInstance()->getTextureCache()->
		addImageAsync("home-1.png",CC_CALLBACK_1(FlashScene::loadedCallBack,this)); 
	Sprite3D::createAsync("CHA.c3b","character_color.png",CC_CALLBACK_2(FlashScene::asyncLoad_Callback,this),(void*)nullptr);
	Sprite3D::createAsync("tree.c3t","Leaves Transparent.png",CC_CALLBACK_2(FlashScene::asyncLoad_Callback,this),(void*)nullptr);
	Sprite3D::createAsync("LJT.c3b","LJT.png",CC_CALLBACK_2(FlashScene::asyncLoad_Callback,this),(void*)nullptr);
	Sprite3D::createAsync("YZ.c3b","YZ.png",CC_CALLBACK_2(FlashScene::asyncLoad_Callback,this),(void*)nullptr);
	Sprite3D::createAsync("road.c3b",CC_CALLBACK_2(FlashScene::asyncLoad_Callback,this),(void*)nullptr);
	Sprite3D::createAsync("Coupe.c3b",CC_CALLBACK_2(FlashScene::asyncLoad_Callback,this),(void*)nullptr);
	Sprite3D::createAsync("SUV.c3b",CC_CALLBACK_2(FlashScene::asyncLoad_Callback,this),(void*)nullptr);
	Sprite3D::createAsync("Limo.c3b",CC_CALLBACK_2(FlashScene::asyncLoad_Callback,this),(void*)nullptr);
	Sprite3D::createAsync("Taxi.c3b",CC_CALLBACK_2(FlashScene::asyncLoad_Callback,this),(void*)nullptr);
	Sprite3D::createAsync("CopCar.c3b",CC_CALLBACK_2(FlashScene::asyncLoad_Callback,this),(void*)nullptr);
	Sprite3D::createAsync("street.c3b",CC_CALLBACK_2(FlashScene::asyncLoad_Callback,this),(void*)nullptr);
	Sprite3D::createAsync("coin010101.c3b","coin.png",CC_CALLBACK_2(FlashScene::asyncLoad_Callback,this),(void*)nullptr);
	
}
void FlashScene::asyncLoad_Callback(Sprite3D* sprite, void* param){
	loadedCallBack((Object*)param);
}

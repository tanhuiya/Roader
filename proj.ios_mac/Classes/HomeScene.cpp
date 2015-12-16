#include "HomeScene.h"
#include "HelloWorldScene.h"
Scene* MainScene::createScene(){
	auto scene=Scene::create();
	auto layer=MainScene::create();
	scene->addChild(layer);
	return scene;
}
bool MainScene::init(){
	Layer::init();
	auto menuitemS=MenuItemImage::create("start1.png","start1.png",CC_CALLBACK_1(MainScene::menuCallback,this));
	auto size=Director::getInstance()->getWinSize();
	//menuitemS->setPosition(Vec2(size.width/2,size.height/2));
	auto menu=Menu::create(menuitemS,NULL);
	
	this->addChild(menu);
	return true;
}
void MainScene::menuCallback(cocos2d::Ref* pSender){
	auto scene=HelloWorld::createScene();
	Director::getInstance()->replaceScene(scene);
}
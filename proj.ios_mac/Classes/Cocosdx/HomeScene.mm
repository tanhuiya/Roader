#include "HomeScene.h"
#import <UIKit/UIKit.h>
#include "HelloWorldScene.h"
#import "MTDealsViewController.h"
#import "MTNavigationController.h"
#import "RootViewController.h"
Scene* MainScene::createScene(){
	auto scene=Scene::create();
	auto layer=MainScene::create();
    auto ccLayer = LayerColor::create(Color4B::WHITE);
    ccLayer->setVisible(true);
    scene->addChild(ccLayer);
    
	scene->addChild(layer);
    
	return scene;
}
bool MainScene::init(){
	Layer::init();
	auto menuitemS=MenuItemImage::create("Icon-100.png","Icon-100.png",CC_CALLBACK_1(MainScene::menuCallback,this));
	auto size=Director::getInstance()->getWinSize();
	menuitemS->setPosition(Vec2(size.width/2-60,size.height/2));
    auto menuItemIos = MenuItemImage::create("aboutus_icon@2x.png","aboutus_icon@2x.png",CC_CALLBACK_1(MainScene::menuCallbackIOS,this));
    menuItemIos->setPosition(size.width/2+60 ,menuitemS->getPositionY());
	auto menu=Menu::create(menuitemS,menuItemIos,NULL);
    menu->setPosition(0, 0);
//    this->setAnchorPoint(Vec2(0, 0));
	this->addChild(menu);
    
    RootViewController* root=(RootViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;
    [root rotateToLandScape];
	return true;
}
void MainScene::menuCallback(cocos2d::Ref* pSender){
//    RootViewController* root=(RootViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;
//    [root rotateToLandScape];
	auto scene=HelloWorld::createScene();
	Director::getInstance()->replaceScene(scene);
}
void MainScene::menuCallbackIOS(cocos2d::Ref* pSender){
    MTDealsViewController* dealVc=[[MTDealsViewController alloc]init];
    RootViewController* root=(RootViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;

    [root rotateToPortrait];
    MTNavigationController* nav=[[MTNavigationController alloc]initWithRootViewController:dealVc];
    [root presentViewController:nav animated:YES completion:nil];
}
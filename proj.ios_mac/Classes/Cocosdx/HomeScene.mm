#include "HomeScene.h"
#import <UIKit/UIKit.h>
#include "HelloWorldScene.h"
#import "MTDealsViewController.h"
#import "MTNavigationController.h"
#import "RootViewController.h"
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
    auto menuItemIos = MenuItemImage::create("option_button.png","option_button.png",CC_CALLBACK_1(MainScene::menuCallbackIOS,this));
    menuItemIos->setPosition(menuitemS->getPositionX() ,menuitemS->getPositionY()+120);
	auto menu=Menu::create(menuitemS,menuItemIos,NULL);
	
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
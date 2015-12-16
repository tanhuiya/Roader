#include "HelloWorldScene.h"
#include "ObjectMap.h"
#include "Player.h"
#include "World.h"
#include "Comfirm_Layer.h"
#include "ChangeCamera.h"
#include "SimpleAudioEngine.h"
using namespace CocosDenshion;

Scene* HelloWorld::createScene()
{
    // 'scene' is an autorelease object
    auto scene = Scene::create();
    
    // 'layer' is an autorelease object
    auto layer = HelloWorld::create();

    // add layer as a child to scene
    scene->addChild(layer);

    // return the scene
    return scene;
}
HelloWorld::HelloWorld(){
	ConfirmLayer::times=0;
	m_world=NULL;
	m_player=NULL;
	m_camera=NULL;
}
// on "init" you need to initialize your instance
bool HelloWorld::init()
{
    //////////////////////////////
    // 1. super init first
    if ( !Layer::init() )
    {
        return false;
    }
	UserDefault::getInstance()->setIntegerForKey("TotalCoin",300);
	SimpleAudioEngine::getInstance()->playBackgroundMusic("audio/game.mp3",true);
    Size visibleSize = Director::getInstance()->getVisibleSize();
    Vec2 origin = Director::getInstance()->getVisibleOrigin();
	
	ui_layer=Layer::create();
//	ui_layer->retain();
	main_layer=Layer::create();
//	main_layer->retain();
	addChild(main_layer);
	addChild(ui_layer);

	
  //  this->addChild(m_player);

	m_camera=Camera::createPerspective(60,visibleSize.width/(visibleSize.height),0.01,300);
	m_camera->setCameraFlag(CameraFlag::USER1);
	m_camera->setRotation3D(Vec3(-60,0,0));
	m_camera->setPosition3D(Vec3(1,6,-4));
	
	m_player=Player::create(main_layer,ui_layer);
	main_layer->addChild(m_player);
	m_player->setCam(m_camera);
	
	ObjectMap::getinstance()->addMap(m_player->getSprite(),m_player);
	
	m_world=World::create(main_layer,m_player->getSprite(),m_camera);
	main_layer->addChild(m_world);
	m_player->setWorld(m_world);
	main_layer->addChild(m_camera);
	main_layer->setCameraMask(2);
	m_dielayer=Dielayer::createLayer(m_player);
	this->addChild(m_dielayer,1000);
	m_dielayer->setVisible(false);
	m_dielayer->setSwallowsTouches(false);
	m_dielayer->setTag(1000);
	
	camera_lay=cameraChange::create(m_camera,m_player->getSprite());
	ui_layer->addChild(camera_lay);
	//´¥Ãþ·´Ó¦
	auto action_listener=EventListenerTouchOneByOne::create();
	action_listener->onTouchBegan=[&](Touch* touch,Event* event){
		
		m_touchBeganPos=touch->getStartLocation();
		
		return true;
	};
	action_listener->onTouchEnded=[=](Touch* touch,Event* event){
		auto touch_end_pos=touch->getLocation();
		if(touch_end_pos.distance(m_touchBeganPos)<50)
			return;
		auto off=touch_end_pos-m_touchBeganPos;
		off.normalize();
		auto a=std::move(Vec2(1,0));
		auto result=Vec2::dot(a,off);
		if(fabs(result)>0.7){
			if(result>0){
				m_player->tryMove(RIGHT);
			}else{
				m_player->tryMove(LEFT);			
			}
		}else{
			if(off.y>0){
				m_player->tryMove(FORWARD);
			}else{
				m_player->tryMove(DOWN);
			}
		}
		
	};
	
	action_listener->setSwallowTouches(true);
	Director::getInstance()->getEventDispatcher()->addEventListenerWithSceneGraphPriority(action_listener,this);

    return true;
}




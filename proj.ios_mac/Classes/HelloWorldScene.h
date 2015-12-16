#ifndef __HELLOWORLD_SCENE_H__
#define __HELLOWORLD_SCENE_H__

#include "cocos2d.h"
#include "DieLayer.h"
#include "Player.h"
#include "World.h"
#include "ChangeCamera.h"
USING_NS_CC;
class HelloWorld : public cocos2d::Layer
{
public:
	HelloWorld();
    // there's no 'id' in cpp, so we recommend returning the class instance pointer
    static cocos2d::Scene* createScene();

    // Here's a difference. Method 'init' in cocos2d-x returns bool, instead of returning 'id' in cocos2d-iphone
    virtual bool init();
    
    // a selector callback
    
    
    // implement the "static create()" method manually
    CREATE_FUNC(HelloWorld);
	Dielayer* m_dielayer;
	Node* main_layer,*ui_layer;
	cameraChange* camera_lay;
private:
	Player* m_player;
	cocos2d::Vec2 m_touchBeganPos;
	World* m_world;
	Camera* m_camera;
	
};

#endif // __HELLOWORLD_SCENE_H__

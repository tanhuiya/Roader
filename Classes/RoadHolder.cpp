#include "RoadHolder.h"
#include "base_header.h"
#define  STREET_OFFSET 0.6
#define STREET_LENGTH_SCALE 0.3
#define STREET_WIDTH_SCALE 0.027
RoadHolder* RoadHolder::create(Vec3 startPos,Node* render_node,Sprite3D* sprite){
	RoadHolder *pRet = new RoadHolder(startPos,render_node,sprite); 
	if (pRet && pRet->init()) 
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
bool RoadHolder::init(){
	Layer::init();
	return true;
}
RoadHolder::RoadHolder(Vec3 startPos,Node* render_node,Sprite3D* sprite){
	render_node->addChild(this);
	road[0]=Sprite3D::create("model/road.c3b");
	road[0]->setScale(0.1);
	road[0]->setScaleY(STREET_LENGTH_SCALE);
	road[0]->setScaleZ(STREET_WIDTH_SCALE);
	road[0]->setPosition3D(Vec3(0,0,startPos.z-STREET_OFFSET));
	road[0]->setRotation3D(Vec3(0,0,-90));
	this->addChild(road[0]);

	road[1]=Sprite3D::create("model/road.c3b");
	road[1]->setScale(0.1);
	road[1]->setScaleY(STREET_LENGTH_SCALE);
	road[1]->setScaleZ(STREET_WIDTH_SCALE);
	road[1]->setPosition3D(Vec3(MAX_WIDTH-0.2,0,startPos.z-STREET_OFFSET));
	road[1]->setRotation3D(Vec3(0,0,-90));
	this->addChild(road[1]);

	road[2]=Sprite3D::create("model/road.c3b");
	road[2]->setScale(0.1);
	road[2]->setScaleY(STREET_LENGTH_SCALE);
	road[2]->setScaleZ(STREET_WIDTH_SCALE);
	road[2]->setPosition3D(Vec3(-MAX_WIDTH+0.2,0,startPos.z-STREET_OFFSET));
	road[2]->setRotation3D(Vec3(0,0,-90));
	this->addChild(road[2]);
	this->setCameraMask(2);
	render_node->setCameraMask(2);
	m_player=sprite;
	m_startPos=startPos;
}
void RoadHolder::autoLunch(){
	this->schedule(schedule_selector(RoadHolder::lunch),0.016);
}
void RoadHolder::lunch(float t){
	if((m_startPos-m_player->getPosition3D()).z>5){
		for(int i=0;i<ROAD_NUMBER;i++){
			road[i]->removeFromParentAndCleanup(true);
		}
		this->removeFromParentAndCleanup(true);
		
	}
}
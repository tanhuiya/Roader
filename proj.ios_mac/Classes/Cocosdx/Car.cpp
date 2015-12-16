#include "Car.h"
#include "ObjectMap.h"
Car* Car::create(std::string name,Sprite3D* sprite){
	Car *pRet = new Car(); 
	if (pRet && pRet->init(name,sprite)) 
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
bool Car::init(std::string name,Sprite3D* player){
	Sprite::init();
	m_player=player;
	m_Car=Sprite3D::create(name);
	this->addChild(m_Car);
	Director::getInstance()->getScheduler()->
		scheduleSelector(schedule_selector(Car::checkCar),this,0.016,false);

	return true;
}
void Car::checkCar(float dt){
	if(true){
		auto dis=this->getPosition3D().distance(m_player->getPosition3D());
		if(dis<0.9){
			void* player=ObjectMap::getinstance()->findSecond(m_player);
			((Player*)player)->hurt();
		}
	}
}

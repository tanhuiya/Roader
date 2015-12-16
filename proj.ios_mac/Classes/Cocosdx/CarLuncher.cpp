#include "CarLuncher.h"
#include "base_header.h"
#include "CCMoveBy3D.h"
#include "ObjectMap.h"
#include "CarAction.h"
#include "Car.h"
#include "SimpleAudioEngine.h"
using namespace CocosDenshion;
#define STREET_OFFSET 0.6
#define STREET_LENGTH_SCALE 0.3
#define STREET_WIDHT_SCALE 0.027
CarLuncher*CarLuncher:: create(Vec3 startpos,int side,Node* render_node,Sprite3D* sprite){
	CarLuncher *pRet = new CarLuncher(startpos,side,render_node,sprite); 
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
CarLuncher::~CarLuncher(){
	vcars.clear();
}
bool CarLuncher::init(){
	Layer::init();
	return true;
}
CarLuncher::CarLuncher(Vec3 startpos,int side,Node* render_node,Sprite3D* sprite){
	vcars.clear();
	m_startpos=startpos;
	m_render_node=render_node;
	m_render_node->addChild(this);
	m_sprite=sprite;
	m_side=side;
	m_coin=NULL;
	street[0]=Sprite3D::create("street.c3b");
	street[0]->setPosition3D(Vec3(0,0,startpos.z-STREET_OFFSET));
	street[0]->setScale(0.1);
	street[0]->setScaleY(STREET_LENGTH_SCALE);
	street[0]->setScaleZ(STREET_WIDHT_SCALE);
	street[0]->setRotation3D(Vec3(0,0,-90));
	this->addChild(street[0]);

	street[1]=Sprite3D::create("street.c3b");
	street[1]->setPosition3D(Vec3(MAX_WIDTH-0.2,0,startpos.z-STREET_OFFSET));
	street[1]->setScale(0.1);
	street[1]->setScaleY(STREET_LENGTH_SCALE);
	street[1]->setScaleZ(STREET_WIDHT_SCALE);
	street[1]->setRotation3D(Vec3(0,0,-90));
	this->addChild(street[1]);

	street[2]=Sprite3D::create("street.c3b");
	street[2]->setPosition3D(Vec3(-MAX_WIDTH+0.2,0,startpos.z-STREET_OFFSET));
	street[2]->setScale(0.1);
	street[2]->setScaleY(STREET_LENGTH_SCALE);
	street[2]->setScaleZ(STREET_WIDHT_SCALE);
	street[2]->setRotation3D(Vec3(0,0,-90));
	this->addChild(street[2]);
	this->setCameraMask(2);
	m_render_node->setCameraMask(2);
}
void CarLuncher::lunch_cop(float t){
	whichCar("CopCar.c3b",Vec3(0,0,0));
}
void CarLuncher::lunch_taxi(float t){
	whichCar("Taxi.c3b",Vec3(0,0,0));
}
void CarLuncher::lunch_limo(float t){
	whichCar("Limo.c3b",Vec3(0,90,0));
}
void CarLuncher::lunch_suv(float t){
	whichCar("SUV.c3b",Vec3(0,0,0));
}
void CarLuncher::lunch_school(float t){
//	whichCar("model/school bus.obj",0);
}
void CarLuncher::lunch_coupe(float t){
	whichCar("Coupe.c3b",Vec3(0,0,0));
}

void CarLuncher::whichCar(std::string carName,Vec3 rotations){
	if((m_startpos-m_sprite->getPosition3D()).z>5){
		for(int i=0;i<STREET_SIZE;i++)
			street[i]->removeFromParentAndCleanup(true);
		this->removeFromParentAndCleanup(true);
		return;
	}
	Sprite3D* car=NULL;
	car=Sprite3D::create(carName);
	vcars.pushBack(car);
	if(SIDE_LEFT==m_side){
		car->setPosition3D(Vec3(0,0,0)+m_startpos);
	}
	else{
		car->setPosition3D(Vec3(1,0,0)+m_startpos);
	}
	car->setScale(0.2);
	this->addChild(car,10);
	m_render_node->setCameraMask(2);
	Vec3 destination;
	if(m_side==SIDE_LEFT){
		destination=Vec3(MAX_WIDTH+1,0,0);
		car->setRotation3D(Vec3(0,90,0)+rotations);
	}
	else{
		destination=Vec3(-MAX_WIDTH-1,0,0);
		car->setRotation3D(Vec3(0,-90,0)+rotations);
	}
	auto move=MoveBy3D::create(3.0+m_speed,destination);
	auto seq=Sequence::create(move,CallFunc::create([=]()
	{
		car->removeFromParentAndCleanup(true);
		vcars.eraseObject(car);
	}),NULL);
//	auto result=ObjectMap::getinstance()->findSecond(m_sprite);
//	CarAction* action=CarAction::create((Player*)result);
	car->runAction(seq);
//	car->runAction(action);
}

void CarLuncher::autoLunch(){
	int randNumber=rand()%5+1;
	m_coin=Sprite3D::create("coin010101.c3b","coin.png");
	m_coin->setScale(0.2);
	m_coin->setRotation3D(Vec3(90,0,0));
	auto f0=FadeOut::create(3);
	auto fi=FadeIn::create(3);
	auto s=Sequence::create(f0,fi,NULL);
	auto repeat=Repeat::create(s,5);
	auto ss=Sequence::create(repeat,CCCallFunc::create(
		[=](){
			m_coin->removeFromParentAndCleanup(true);
			m_coin=NULL;
	}
		),NULL);
	m_coin->runAction(ss);
	int r=CCRANDOM_MINUS1_1()*7;
	m_coin->setPosition3D(Vec3(r,m_startpos.y+0.23,m_startpos.z));
	this->addChild(m_coin,5);
	auto player=ObjectMap::getinstance()->findSecond(m_sprite);
	m_speed=-((Player*)player)->getScore()*0.01;
	switch (randNumber)
	{
	case 1:
		m_speed+=1.2+CCRANDOM_MINUS1_1()*0.1;
		Director::getInstance()->getScheduler()->
			scheduleSelector(schedule_selector(CarLuncher::lunch_cop),this,1.1f+m_speed/2,false);
//		schedule(schedule_selector(CarLuncher::lunch_cop,this),1.0f+m_speed/2);
//警车
		break;
	case 2:
		m_speed+=1.9+CCRANDOM_MINUS1_1()*0.1;
		Director::getInstance()->getScheduler()->
			scheduleSelector(schedule_selector(CarLuncher::lunch_coupe),this,1.1f+m_speed/2,false);
//		schedule(schedule_selector(CarLuncher::lunch_coupe,this),1.0f+m_speed/2);
//红色
		break;	
	case 3:
		m_speed+=2.6+CCRANDOM_MINUS1_1()*0.1;
		Director::getInstance()->getScheduler()->
			scheduleSelector(schedule_selector(CarLuncher::lunch_suv),this,1.1f+m_speed/2,false);
//		schedule(schedule_selector(CarLuncher::lunch_suv,this),1.0f+m_speed/2);
//小黑车
		break;
	case 4:
		m_speed+=3.3+CCRANDOM_MINUS1_1()*0.1;
		Director::getInstance()->getScheduler()->
			scheduleSelector(schedule_selector(CarLuncher::lunch_taxi),this,1.1f+m_speed/2,false);
//		schedule(schedule_selector(CarLuncher::lunch_taxi,this),1.0f+m_speed/2);
//小黄出租
		break;
	case 5:
		m_speed+=3.9+CCRANDOM_MINUS1_1()*0.1;
		Director::getInstance()->getScheduler()->
			scheduleSelector(schedule_selector(CarLuncher::lunch_limo),this,1.1f+m_speed/2,false);
//		schedule(schedule_selector(CarLuncher::lunch_limo,this),1.0f+m_speed/2);
//林肯
		break;
	default:
		break;
	}
	Director::getInstance()->getScheduler()->
		scheduleSelector(schedule_selector(CarLuncher::checkCoin),this,0.016,false);
//	schedule(schedule_selector(CarLuncher::checkCoin,this),0.016);
}
void CarLuncher::checkCar(){
	void* player=ObjectMap::getinstance()->findSecond(m_sprite);
	for(int i=0;i<vcars.size();i++){
		Sprite3D* car=vcars.at(i);
		/*if(car->getBoundingBox().intersectsRect(m_sprite->getBoundingBox())){
			((Player*)player)->hurt();
		}
		*/
		auto dis=car->getPosition3D().distance(m_sprite->getPosition3D());
		if(dis<0.9){
			((Player*)player)->hurt();
		}
	}
}
void CarLuncher::checkCoin(float dt){
	auto distance=(m_startpos-m_sprite->getPosition3D()).z;
	if(distance<=-1||distance>=1){
		return;
	}
	checkCar();
	void* player=ObjectMap::getinstance()->findSecond(m_sprite);
	if(!((Player*)player)->JumpOver){
		return;
	}
	if(m_coin){
		auto dis=m_coin->getPosition3D().distance(m_sprite->getPosition3D());
		if(m_coin->isVisible()&&dis<=0.5){
			SimpleAudioEngine::getInstance()->playEffect("audio/pickup_coin.mp3");
			m_coin->setVisible(false);
			((Player*)player)->addCoin();
		}
	}
	
}

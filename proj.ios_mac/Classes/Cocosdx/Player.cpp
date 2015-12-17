#include"Player.h"
#include"CCMoveBy3D.h"

#include "RoadHolder.h"
#include "DieLayer.h"
#include "HomeScene.h"
#include "HelloWorldScene.h"
#include "SimpleAudioEngine.h"
using namespace CocosDenshion;
Player::~Player(){
//	m_sprite->removeFromParentAndCleanup(true);
	backward->release();
	forward->release();
	left->release();
	right->release();
//	delete m_cs;
//	delete m_num;
}
Player*Player:: create(Node* render_node,Node* ui_node){
	Player *pRet = new Player(render_node,ui_node); 
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
Player::Player(Node* render_node,Node* ui_node){
	
	auto ambientlight=AmbientLight::create(Color3B(100,100,100));
	this->addChild(ambientlight);
	auto Point_light=PointLight::create(Vec3(0,10,0),Color3B(255,255,0),4);
	m_sprite=Sprite3D::create("CHA.c3b");
//	m_sprite->setTexture("model/character_color.png");
	m_sprite->setPosition3D(Vec3(1,0,-5));
	m_sprite->addChild(Point_light);
	m_sprite->setRotation3D(Vec3(0,180,0));
	m_sprite->setScale(0.06);
	/*m_sprite=Sprite3D::create("model/girl.c3b");
	m_sprite->addChild(Point_light);
	m_sprite->setScale(0.009);
	m_sprite->setPosition3D(Vec3(1,0,-5));
	m_sprite->setRotation3D(Vec3(0,225,0));
	auto animation = Animation3D::create("model/girl.c3b");
	if (animation)
	{
		auto animate = Animate3D::create(animation);
		
		auto r=RepeatForever::create(animate);
		r->setTag(1000);
		m_sprite->runAction(r);
	}*/
	this->addChild(m_sprite);
	this->setCameraMask(2);
	m_direction=FORWARD;
	m_Alive=true;
	m_blink=false;
	m_num=Number::create(Vec2(50,500),Vec2(0,1));
	ui_node->addChild(m_num);
	isPause=false;
	m_world=NULL;
	m_cam=NULL;
	m_cs=Number::create(Vec2(900,500),Vec2(1,1));
	ui_node->addChild(m_cs);
	m_score=0;
	m_coin=0;
	m_render_node=render_node;
	m_ui_node=ui_node;
	JumpOver=true;
	isready=false;
	backward=NULL;
	forward=NULL;
	left=NULL;
	right=NULL;
}
bool Player::init(){
	Layer::init();
	backward=JumpBy3D::create(0.3,Vec3(0,0,1),0.8,1);
	forward=JumpBy3D::create(0.3,Vec3(0,0,-1),0.8,1);
	left=JumpBy3D::create(0.3,Vec3(-1,0,0),0.8,1);
	right=JumpBy3D::create(0.3,Vec3(1,0,0),0.8,1);
	backward->retain();
	forward->retain();
	left->retain();
	right->retain();
	return true;
}
void Player::setCam(Camera *cam){
	m_cam=cam;
}
Sprite3D* Player::getSprite(){
	return m_sprite;
}
void Player::setWorld(World* world){
	m_world=world;
	auto road=RoadHolder::create(Vec3(MAX_WIDTH-MAX_WIDTH/2-1,0,m_sprite->getPosition3D().z+1),m_render_node,m_sprite);
	road->autoLunch();
	auto road1=RoadHolder::create(Vec3(MAX_WIDTH-MAX_WIDTH/2-1,0,m_sprite->getPosition3D().z),m_render_node,m_sprite);
	road1->autoLunch();
/*	auto road2=RoadHolder::create(Vec3(MAX_WIDTH-MAX_WIDTH/2-1,0,m_sprite->getPosition3D().z-1),m_render_node,m_sprite);
	road2->autoLunch();
	auto road3=RoadHolder::create(Vec3(MAX_WIDTH-MAX_WIDTH/2-1,0,m_sprite->getPosition3D().z-2),m_render_node,m_sprite);
	road3->autoLunch();*/
	for(int i=1;i<=9;i++){
		m_world->generateNewRow(m_sprite->getPosition3D(),i,false,0);
	}
}
void Player::tryMove(Diretions dic){
	if(!isPause){
		if(m_direction==dic)
			move(dic);
		else{
			m_direction = dic;
			move(dic);
			turn(dic);
		}
	}
}
void Player::hurt(){

	if(m_Alive&&!m_blink){
		setPause();
		/*auto x = m_sprite->getScaleX();
		auto y = m_sprite->getScaleY();
		auto z =m_sprite->getScaleZ();
		m_sprite->setScaleX(x);
		m_sprite->setScaleY(y);
		m_sprite->setScaleZ(z);*/
		m_sprite->stopActionByTag(1000);
		m_sprite->setRotation3D(Vec3(90,180,0));
		m_Alive = false;
		auto delay=DelayTime::create(2.0);
		auto action=Sequence::create(delay,CCCallFunc::create(
			[&](){
				auto  die=(HelloWorld*)m_ui_node->getParent();
                //todo
				die->m_dielayer->Pop_layer();
				SimpleAudioEngine::getInstance()->pauseBackgroundMusic();
		}
			),NULL);
			m_sprite->runAction(action);
	}
}
void Player::setPause(){
	if(isPause){
		isPause=false;
	}else{
		isPause=true;
	}
}
void Player::setAlive(){
	if (m_Alive)
	{
		m_Alive=false;
	}else{
		m_Alive=true;
	}
}
void Player::reLive(){
	SimpleAudioEngine::getInstance()->resumeBackgroundMusic();
	SimpleAudioEngine::getInstance()->playEffect("audio/FX088.mp3");
	auto blink=Blink::create(3,8);
	m_sprite->setRotation3D(Vec3(0,180,0));
	setAlive();
	setBlink();
	auto s=Sequence::create(blink,CCCallFunc::create(
		[=](){
			setBlink();
	}
	),NULL);
	/*auto animation = Animation3D::create("model/girl.c3b");
	auto animate = Animate3D::create(animation);
	auto r=RepeatForever::create(animate);
	r->setTag(1000);
	m_sprite->runAction(r);*/
	m_sprite->runAction(s);
}
void Player::setBlink(){
	if (m_blink)
	{
		m_blink=false;
	}else{
		m_blink=true;
	}
}
void Player::move(Diretions dic){
	
//	JumpBy3D* jump=NULL;
	MoveBy3D* move1=NULL;
	Sequence* s=NULL;
	Vec2 pos=m_world->getPlayerGridPos(m_sprite->getPosition3D(),m_cam->getPosition3D());
	switch(dic){
	case FORWARD:
		if(m_world->isBlock(pos+Vec2(0,-1))){
			return;
		}
		if(JumpOver){
			SimpleAudioEngine::getInstance()->playEffect("audio/jump.mp3");
			JumpOver=false;
	//		jump=JumpBy3D::create(0.25,Vec3(0,0,-1),0.8,1);
			s=Sequence::create(forward,CCCallFunc::create(
				[=](){
					JumpOver=true;
			}
			),NULL);
			m_sprite->runAction(s);
			if(m_sprite->getPosition3D().z< m_cam->getPosition3D().z-3){
				if(!isready){
					isready=true;
					auto h=(HelloWorld*)(this->getParent()->getParent());
					h->camera_lay->isZoomIn=true;
				}
				
				addScore();
				move1=MoveBy3D::create(0.3,Vec3(0,0,-1));
				
				m_cam->runAction(move1);
				m_world->generateNewRow(m_sprite->getPosition3D(),7);
			}

		}
		
		break;
	case RIGHT:
		if(m_world->isBlock(pos+Vec2(1,0)))
		{
			return ;
		}
		if(JumpOver){
			SimpleAudioEngine::getInstance()->playEffect("audio/jump.mp3");
			JumpOver=false;
		//	jump=JumpBy3D::create(0.25,Vec3(1,0,0),0.8,1);
			s=Sequence::create(right,CCCallFunc::create(
				[=](){
					JumpOver=true;
			}
			),NULL);
			m_sprite->runAction(s);

			move1=MoveBy3D::create(0.3,Vec3(1,0,0));
			//	m_cam->runAction(move1);
		}
		
		break;
	case DOWN:
		if(m_world->isBlock(pos+Vec2(0,1)))
		{
			return ;
		}
		if(JumpOver){
			SimpleAudioEngine::getInstance()->playEffect("audio/jump.mp3");
			JumpOver=false;
		//	jump=JumpBy3D::create(0.25,Vec3(0,0,1),0.8,1);

			s=Sequence::create(backward,CCCallFunc::create(
				[=](){
					JumpOver=true;
			}
			),NULL);
			m_sprite->runAction(s);

		}
		
		break;
	case LEFT:
		if(m_world->isBlock(pos+Vec2(-1,0)))
		{
			
			return ;
		}
		if(JumpOver){
			SimpleAudioEngine::getInstance()->playEffect("audio/jump.mp3");
			JumpOver=false;
		//	jump = JumpBy3D::create(0.25,Vec3(-1,0,0),0.8,1);
			s=Sequence::create(left,CCCallFunc::create(
				[=](){
					JumpOver=true;
			}
			),NULL);
			m_sprite->runAction(s);
			move1=MoveBy3D::create(0.3,Vec3(-1,0,0));
			//	m_cam->runAction(move1);
		}
		
		break;
	
	}
}
int Player::getCoin(){
	return m_coin;
}
int Player::getScore(){
	return m_score;
}
void Player::turn(Diretions dic){
	switch(dic){
	case FORWARD:
		m_sprite->setRotation3D(Vec3(0,180,0));
		break;
	case RIGHT:
		m_sprite->setRotation3D(Vec3(0,90,0));
		break;
	case DOWN:
		m_sprite->setRotation3D(Vec3(0,0,0));
		break;
	case LEFT:
		m_sprite->setRotation3D(Vec3(0,270,0));
		break;
	default:
		break;
	}
}
void Player::addScore(){
	m_score++;
	m_num->setNum(m_score);
	
}
void Player::addCoin(){
	m_coin++;
	m_cs->setNum(m_coin);
}

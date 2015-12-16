#include "CarAction.h"
CarAction*CarAction:: create(Player* player){
	CarAction* ret=new CarAction(player);
	ret->autorelease();
	return ret;
}
CarAction::CarAction(Player* player){
	
	m_player=player;
	
}

bool CarAction::isDone() const{
	auto s=this->getTarget();
	if(s){
		return false;
	}else{
		return true;
	}
	
}
void CarAction::step(float t){
	auto s=getTarget();
	if(s){
		if(m_player->getSprite()->getBoundingBox().intersectsRect(s->getBoundingBox())){
			m_player->hurt();
		}
		//auto dis=s->getPosition3D().distance(m_player->getSprite()->getPosition3D());
		//if(dis<0.9){
		//	//m_player->getSprite()->setColor(Color3B(0,0,255));
		//	m_player->hurt();
		//}
	}
}
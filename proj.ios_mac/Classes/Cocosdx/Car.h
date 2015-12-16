#ifndef CAR
#define  CAR
#include "cocos2d.h"
#include "Player.h"
USING_NS_CC;
class Car:public Sprite{
public:
	static Car* create(std::string,Sprite3D* sprite);
	virtual bool init(std::string,Sprite3D* sprite);
	void checkCar(float dt);

	Sprite3D* m_player;
	Sprite3D* m_Car;
};
#endif

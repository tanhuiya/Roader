#ifndef _H_CARLUNCHER_H
#define _H_CARLUNCHER_H
#include"cocos2d.h"
#include <Vector>
#define SIDE_LEFT 0
#define SIDE_RIGHT 1
#define STREET_SIZE 3
USING_NS_CC;
class CarLuncher:public Layer
{
public:
	static CarLuncher* create(Vec3 startpos,int side,Node* render_node,Sprite3D* sprite);
	bool init();
	CarLuncher(Vec3 startpos,int side,Node* render_node,Sprite3D* sprite);
	void lunch_cop(float t);
	void lunch_taxi(float t);
	void lunch_limo(float t);
	void lunch_suv(float t);
	void lunch_school(float t);
	void lunch_coupe(float t);
	void autoLunch();
	void checkCoin(float dt);
	void checkCar();
	void whichCar(std::string carName,Vec3 rotations);
	~CarLuncher();
private:
	Vec3 m_startpos;
	Node* m_render_node;
	Sprite3D* m_sprite;
	int m_side;
	Sprite3D* street[STREET_SIZE];
	Sprite3D* m_coin;
	float m_speed;
	Vector<Sprite3D*>vcars;
};
#endif
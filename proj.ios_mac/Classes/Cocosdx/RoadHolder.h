#ifndef H_ROADHOLDER_H
#define  H_ROADHOLDER_H
#include "cocos2d.h"
#define ROAD_NUMBER 3
USING_NS_CC;
class RoadHolder:public Layer{
public:
	static RoadHolder* create(Vec3,Node* render_node,Sprite3D* sprite);
	bool init();
	RoadHolder(Vec3,Node* render_node,Sprite3D* sprite);
	void autoLunch();
	void lunch(float t);
private:
	Vec3 m_startPos;
	Sprite3D* road[ROAD_NUMBER];
	Sprite3D* m_player;
};
#endif
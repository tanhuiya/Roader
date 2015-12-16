#ifndef H_WORLD_H
#define H_WORLD_H
#include "cocos2d.h"

#include<vector>
#include "base_header.h"
#define WORLD_STREET 0
#define	WORLD_ROAD 1
#define WORLD_UNDEF -1
#define SIDE_LEFT 0
#define SIDE_RIGHT 1
USING_NS_CC;

struct tile
{
	bool result;
	Sprite3D* entity;
};
struct StreetOrRoad
{
	int len;
	int type;

};

class World:public Layer{
public:
	World(Node* render_node,Sprite3D* player,Camera* camera);
	~World();
	bool init();
	static World* create(Node* render_node,Sprite3D* player,Camera* camera);
	void generateNewRow(Vec3 playerPosition,int row,bool need_rebase=true,int offset=2);
	void add(Sprite3D* entity);
	void move(Vec2 pos,int direction);
	int getWorldRol(Vec3 pos);
	Vec2 getPlayerGridPos(Vec3 pos,Vec3 cam_pos);
	bool isBlock(Vec2 pos);
	void dump();
	void generateRoadOrStreet();
private:
	Sprite3D* m_player;
	Camera* m_camera;
	StreetOrRoad m_streetOrRoad;
	std::vector<Sprite3D*>removeQuene;
	std::vector<Sprite3D*>m_entityList;
	Node* m_render_node;
	tile m_map[MAX_HIGHT][MAX_WIDTH];
	void rebase();
	int m_currentGenerateType;
};

#endif
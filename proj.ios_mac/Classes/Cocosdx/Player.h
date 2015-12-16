#ifndef PLAYER_H
#define PLAYER_H
#include "cocos2d.h"
#include"World.h"
#include "Numbers.h"
#include "CCJumpBy3D.h"
//#include "DieLayer.h"
using namespace cocos2d;
enum Diretions
{
	FORWARD,
	RIGHT,
	LEFT,
	DOWN,
};
class Player:public Layer
{
public:
	Player(Node* render_node,Node* ui_node);
	~Player();
	bool init();
	static Player* create(Node* render_node,Node* ui_node);
	void setCam(Camera *cam);
	Sprite3D* getSprite();
	void tryMove(Diretions dic);
	void move(Diretions);
	void turn(Diretions);
	void setWorld(World* world);
	void getPlayer();
	void hurt();
	void addScore();
	int getScore();
	void addCoin();
	int getCoin();
	void setAlive();
	void setBlink();
	void reLive();
	void setPause();
	Number* m_num;
	Number* m_cs;
	bool JumpOver;
protected:
private:
	Sprite3D* m_sprite;
	int m_direction;
	bool m_Alive;
	bool m_blink;
	Node* m_render_node;
	Node* m_ui_node;
	Label* m_label,*m_coinLabel;
	int m_score;
	int m_coin;
	Camera *m_cam;
	World* m_world;
	bool isready;
	bool isPause;
	JumpBy3D* forward;
	JumpBy3D* left;
	JumpBy3D* right;
	JumpBy3D* backward;
//	Dielayer* m_dielayer;
};
#endif // !PLAYER_H

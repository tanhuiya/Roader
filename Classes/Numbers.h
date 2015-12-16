#ifndef Numbers
#define Numbers
#include"cocos2d.h"
USING_NS_CC;
class Number:public Layer{
public:
	static Number* create(Vec2 pos,Vec2 anc);
	bool init();
	Number(Vec2 pos,Vec2 anc);
	void setNum(int num);
	int getNum();
private:
	int m_num;
	Vec2 m_anc;
	
	Vec2 m_pos;
	Sprite* m_Number_Sp[3];
};
#endif // !Numbers

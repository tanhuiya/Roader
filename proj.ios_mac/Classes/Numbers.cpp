#include "Numbers.h"

Number* Number::create(Vec2 pos,Vec2 anc){
	Number *pRet = new Number(pos,anc); 
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
bool Number::init(){
	Layer::init();
	
	setNum(m_num);
	return true;
}
Number::Number(Vec2 pos,Vec2 anc){
	m_num=0;
	m_pos=pos;
	m_anc=anc;
	for(int i=0;i<3;i++){
		m_Number_Sp[i]=Sprite::create("number_0.png");
		m_Number_Sp[i]->setVisible(false);
	}
	
	
}
void Number::setNum(int num){
	m_num=num;
	int a[3]={0};
	int i=0;
	while(m_num){
		a[i++]=m_num%10;
		m_num=m_num/10;
		if(3==i)break;
	}
	
	char str[30]={0};
	for(i=0;i<3;i++){
		m_Number_Sp[i]->removeFromParentAndCleanup(true);
		sprintf(str,"number_%d.png",a[i]);
		m_Number_Sp[i]=Sprite::create(str);
		m_Number_Sp[i]->setAnchorPoint(m_anc);
		auto Numsize=m_Number_Sp[i]->getContentSize();
		m_Number_Sp[i]->setPosition(Vec2(m_pos.x-i*Numsize.width,m_pos.y));
		this->addChild(m_Number_Sp[i]);
	}
	if(a[2]==0)m_Number_Sp[2]->setVisible(false);
	if(a[2]==0&&a[1]==0)m_Number_Sp[1]->setVisible(false);
//	if(a[3]==0&&a[2]==0&&a[1]==0)m_Number_Sp[1]->setVisible(false);

}
int Number::getNum(){
	return m_num;
}
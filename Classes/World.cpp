#include "World.h"
#include"RoadHolder.h"
#include "CarLuncher.h"
#include"Player.h"
#include "ObjectMap.h"
World* World::create(Node* render_node,Sprite3D* player,Camera* camera){
	World *pRet = new World(render_node,player,camera); 
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
World::~World(){
	removeQuene.clear();
	m_entityList.clear();
}
World::World(Node* render_node,Sprite3D* player,Camera* camera){
	this->m_render_node=render_node;
	for(int i=0;i<MAX_HIGHT;i++)
		for(int j=0;j<MAX_WIDTH;j++){
			m_map[i][j].result=false;
			m_map[i][j].entity=NULL;
		}
	m_entityList.clear();
	m_player=player;
	m_camera=camera;
	m_streetOrRoad.len=3;
	m_streetOrRoad.type=WORLD_ROAD;
}
bool World::init(){
	Layer::init();
	return true;
}
void World::generateNewRow(Vec3 playerPosition,int row,bool need_rebase,int offset){
	Player* temp_player=(Player*)(ObjectMap::getinstance()->findSecond(m_player));
	if(need_rebase)rebase();
	if(m_streetOrRoad.len<=0){
		if(m_streetOrRoad.type==WORLD_STREET){
			m_streetOrRoad.len=rand()%2+1;
			m_streetOrRoad.type=WORLD_ROAD;
		}
		else{
			if(temp_player->getScore()<20){
				m_streetOrRoad.len=rand()%2+1;
			}else if(temp_player->getScore()<80){
				m_streetOrRoad.len=rand()%2+2;
			}else{
				m_streetOrRoad.len=rand()%2+3;
			}
			
			m_streetOrRoad.type=WORLD_STREET;
		}
	}
	for(int i=0;i<MAX_WIDTH;i++){
		if(row!=0&&m_streetOrRoad.type==WORLD_ROAD){
			int r=rand()%20;
			if(r<3){
				auto tree=Sprite3D::create("model/tree.c3t");
				tree->setPosition3D(Vec3(0,0.75,0));
				tree->setScale(0.0015);
				tree->setPosition3D(tree->getPosition3D()+Vec3(i-MAX_WIDTH/2,0,playerPosition.z)+Vec3(0,0,-row));
				this->add(tree);
				m_render_node->addChild(tree);
				m_render_node->setCameraMask(2);
				m_map[MAX_HIGHT-row-1-offset][i].result=true;
				m_map[MAX_HIGHT-row-1-offset][i].entity=tree;
			}else if(row!=1&&r==3){
				auto ton=Sprite3D::create("model/LJT.c3b","model/LJT.png");
			//	ton->setTexture("model/LJT.png");
				ton->setScaleZ(0.3);
				ton->setScaleX(0.3);
				ton->setPosition3D(Vec3(0,0.75,0));
				ton->setScaleY(0.2);
				ton->setPosition3D(Vec3(i-MAX_WIDTH/2,0,playerPosition.z)+Vec3(0,0,-row));
				this->add(ton);
				m_render_node->addChild(ton);
				m_render_node->setCameraMask(2);
				m_map[MAX_HIGHT-row-1-offset][i].result=true;
				m_map[MAX_HIGHT-row-1-offset][i].entity=ton;
			}else if(row!=1&&r<6){
				auto yz=Sprite3D::create("model/YZ.c3b","model/YZ.png");
		//		yz->setTexture("model/YZ.png");
				yz->setPosition3D(Vec3(0,0.75,0));
				yz->setScale(0.13);
				auto x=yz->getScaleX();
				yz->setScaleX(x*0.5);
				yz->setPosition3D(Vec3(i-MAX_WIDTH/2,0,playerPosition.z)+Vec3(0,0,-row));
				this->add(yz);
				m_render_node->addChild(yz);
				m_render_node->setCameraMask(2);
				m_map[MAX_HIGHT-row-1-offset][i].result=true;
				m_map[MAX_HIGHT-row-1-offset][i].entity=yz;
			}else{
				m_map[MAX_HIGHT-row-1-offset][i].result=false;
				m_map[MAX_HIGHT-row-1-offset][i].entity=NULL;
			}

		}else{
			m_map[MAX_HIGHT-row-1-offset][i].result=false;
			m_map[MAX_HIGHT-row-1-offset][i].entity=NULL;
		}
	}
	if(m_streetOrRoad.type==WORLD_STREET){
		//todo
		CarLuncher* carlunch=NULL;
		if(rand()%10>5){
			carlunch=CarLuncher::create(Vec3(-MAX_WIDTH/2,0,playerPosition.z)+Vec3(0,0,-row),SIDE_LEFT,m_render_node,m_player);
			carlunch->autoLunch();
		}else{
			carlunch=CarLuncher::create(Vec3(MAX_WIDTH-MAX_WIDTH/2-1,0,playerPosition.z)+Vec3(0,0,-row),SIDE_RIGHT,m_render_node,m_player);
			carlunch->autoLunch();
		}
		
	}
	else{
		auto road=RoadHolder::create(Vec3(-MAX_WIDTH-MAX_WIDTH/2-1,0,playerPosition.z)+Vec3(0,0,-row),m_render_node,m_player);
		
		road->autoLunch();
	}
	
	m_streetOrRoad.len--;
}
void World::add(Sprite3D* entity){
	m_entityList.push_back(entity);
}
void World::move(Vec2 pos,int direction){

}
int World::getWorldRol(Vec3 pos){
	return pos.x+MAX_WIDTH/2;
}
Vec2 World::getPlayerGridPos(Vec3 pos,Vec3 cam_pos){
	Vec2 result;
	result.x=getWorldRol(pos);
	result.y=cam_pos.z-pos.z;
	result.y=MAX_HIGHT-result.y;
	return result;
}
bool World::isBlock(Vec2 pos){
	if(pos.x<0||pos.y<0||pos.x>MAX_WIDTH-1||pos.y>MAX_HIGHT-1){
		return true;
	}
	else{
		return m_map[int(pos.y+0.5)][int(pos.x+0.5)].result;
	}
}
void World::dump(){
	for(auto i=removeQuene.begin();i!=removeQuene.end();i++){
		auto t=*i;
		t->removeFromParent();
	}

	removeQuene.clear();
	for(int i=0;i<MAX_WIDTH-1;i++){
		if(m_map[MAX_HIGHT-1][i].entity)
		removeQuene.push_back(m_map[MAX_HIGHT-1][i].entity);
	}
}
void World::generateRoadOrStreet(){

}
void World::rebase(){
	dump();
	for(int i=MAX_HIGHT-1;i>0;i--){
		for(int j=MAX_WIDTH-1;j>0;j--){
			m_map[i][j]=m_map[i-1][j];
		}
	}
}

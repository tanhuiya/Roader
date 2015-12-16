#include "ChangeCamera.h"
cameraChange* cameraChange::create(Camera* camera,Sprite3D* sprite3D){
	auto pRet=new cameraChange(camera,sprite3D);

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
cameraChange::cameraChange(Camera*camera,Sprite3D* sprite3D)
{
	_ZoomOutlabel=NULL;
	_ZoomInlabel=NULL;
	_camera=camera;
	_sprite3D=sprite3D;
	isZoomOut=false;
	isZoomIn=false;
}
bool cameraChange::init(){
	Layer::init();
	auto s = Director::getInstance()->getWinSize();
	_ZoomOutlabel = Label::create("zoom out","fonts/arial.ttf", 30);
	outItem=MenuItemLabel::create(_ZoomOutlabel,CC_CALLBACK_1(cameraChange::onTouchesZoomOut,this));
	_ZoomInlabel = Label::create("zoom in","fonts/arial.ttf", 30);
	inItem=MenuItemLabel::create(_ZoomInlabel,CC_CALLBACK_1(cameraChange::onTouchesZoomIn,this));
	inItem->setPosition(s.width-100, 30);
	inItem->setOpacity(120);
	outItem->setPosition(100,30);
	outItem->setOpacity(120);
	auto menu=Menu::create(outItem,inItem,NULL);
	menu->setPosition(Point::ZERO);
	this->addChild(menu);
	
	return true;
}
void cameraChange::onTouchesZoomOut(Ref* pSender)
{
	if(isZoomOut)
	{
		isZoomOut=false;
		isZoomIn=true;
		_ZoomInlabel->setOpacity(255);
		Vec3 lookDir = _camera->getPosition3D() - _sprite3D->getPosition3D();
		Vec3 cameraPos = _camera->getPosition3D();
		if(lookDir.length() <= 7)
		{
			cameraPos += lookDir.getNormalized()*0.5;
			_camera->setPosition3D(cameraPos);
		}

	}
}

void cameraChange::onTouchesZoomIn(Ref* pSender)
{
	if(isZoomIn)
	{
		isZoomOut=true;
		isZoomIn=false;
		_ZoomOutlabel->setOpacity(255);
		Vec3 lookDir = _camera->getPosition3D() - _sprite3D->getPosition3D();
		Vec3 cameraPos =_camera->getPosition3D();
		if(lookDir.length() >= 6.9)
		{
		cameraPos -= lookDir.getNormalized()*0.5;
		_camera->setPosition3D(cameraPos);
		}

	}
}

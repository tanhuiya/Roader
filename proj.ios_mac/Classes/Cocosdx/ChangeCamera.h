#ifndef CHANGE
#define CHANGE
#include "cocos2d.h"
USING_NS_CC;
class cameraChange:public Layer{
public:
	static cameraChange* create(Camera*,Sprite3D* );
	bool init();
	void onTouchesZoomOut(Ref* pSender);
	void onTouchesZoomIn(Ref* pSender);
	bool isZoomOut,isZoomIn;
private:
	cameraChange(Camera*,Sprite3D *);
	Camera* _camera;
	Sprite3D * _sprite3D;
	Label* _ZoomOutlabel,*_ZoomInlabel;
	
	MenuItemLabel* outItem,*inItem;
};
#endif
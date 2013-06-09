//
//  ThumbnailView.h
//  BlackTea
//
//  Created by Jue Wang on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ThumbnailsBrowserView.h"
#import "ThumbnailViewDelegate.h"
#import "ThumbnailViewDataSourceDelegate.h"
#import "Position.h"


@class ThumbnailView;
@class ThumbnailsBrowserView;

@interface ThumbnailView : UIImageView
{
     BOOL isEditing;
     UILongPressGestureRecognizer* longPressGR;
     UIButton* deletionButton;
     UITapGestureRecognizer* tapToStopGR;
     UITapGestureRecognizer* tapToDeleteGR;
    
    int indexPathInTheMutableArray;
    NSNumber* idNum;
    
}


@property(atomic, copy) Position* postionInTheBrowser;

//In case of the Position does not work
@property(nonatomic, assign) int row;
@property(nonatomic, assign) int column;

@property(nonatomic, assign) int indexPathInTheMutableArray;

@property(nonatomic, assign) id<ThumbnailViewDelegate> delegate;
@property(nonatomic, assign) id<ThumbnailViewDataSourceDelegate> thumbnailViewDataSourceDelegate;
@property(nonatomic, retain) UIButton* deletionButton;



-(void)startEditing;
-(void)stopEditing:(UIView*)fromUIView;
-(void)removeThisAD;
-(id)initWithFrame:(CGRect)frame;


@end




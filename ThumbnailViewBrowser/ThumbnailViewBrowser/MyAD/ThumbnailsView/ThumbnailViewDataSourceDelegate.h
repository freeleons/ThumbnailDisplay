//
//  ThumbnailViewDataSourceDelegate.h
//  BlackTea
//
//  Created by Jue Wang on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThumbnailView.h"

@class ThumbnailView;
@protocol ThumbnailViewDataSourceDelegate <NSObject>

-(void)removeThisThumbnailViewInBrowserView:(ThumbnailView*)thumbnailView;

@end

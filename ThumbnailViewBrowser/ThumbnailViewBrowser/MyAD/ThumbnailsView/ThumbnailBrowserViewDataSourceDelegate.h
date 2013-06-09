//
//  ThumbnailBrowserViewDataSourceDelegate.h
//  BlackTea
//
//  Created by Jue Wang on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThumbnailView.h"
#import "ThumbnailsBrowserView.h"
#import "ThumbnailViewDataSourceDelegate.h"

@class ThumbnailsBrowserView;
@class ThumbnailView;

@protocol ThumbnailBrowserViewDataSourceDelegate <NSObject>

@required


-(NSInteger)numberOfThumbnailsInBrowserView:(ThumbnailsBrowserView*)browserView;



-(ThumbnailView*)thumbnailInBrowserView:(ThumbnailsBrowserView*)browserView atPosition: (Position*)position;


//Remove the 
-(void)removeThisThumbnailViewInDataSource:(ThumbnailView*)thumbnailView;


@end

//
//  ThumbnailViewDelegate.h
//  BlackTea
//
//  Created by Jue Wang on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThumbnailView.h"

@class ThumbnailView;
@protocol ThumbnailViewDelegate <NSObject>

@optional
- (void)thumbnailViewBrowserShouldEnterEditingMode:(ThumbnailView*) thumbnailView;
- (void) thumbnailViewDidEnterEditingMode:(ThumbnailView *) thumbnailView;

-(void)thumbnailViewBrowserShouldLeaveEditingMode:(ThumbnailView *) thumbnailView;

-(void)thumbnailViewDidDeleted:(ThumbnailView *) thumbnailView atIndex:(NSInteger)index;

-(void)removeThisThumbnail:(ThumbnailView*)thumbnailView;


@end

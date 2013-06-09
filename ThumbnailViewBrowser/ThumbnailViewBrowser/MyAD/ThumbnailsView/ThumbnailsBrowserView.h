//
//  ThumbnailsBrowserView.h
//  BlackTea
//
//  Created by Jue Wang on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThumbnailView.h"
#import "ThumbnailsBrowserView.h"
#import "Position.h"
#import "ThumbnailBrowserViewDataSourceDelegate.h"
#import "ThumbnailViewDelegate.h"

@class ThumbnailsBrowserView;
@class ThumbnailView;

/*!
 @header    ThumbnailsBrowserView
 @abstract  The ThumbnailsBrowserView only provides two column style thumbnails for user to browse. User can hold the thumbnail for a while to remove the thumbnail from the thumbnail browser. The browser view maintain its own thumbnails in a mutable array. It will notify the data source the deletion of the thumbnail view by using -(void)removeThisThumbnailViewInBrowserView:(ThumbnailView*)thumbnailView; method

 @discussion 
 @author Jue Wang
 */

//@class ThumbnailsBrowserView;


@interface ThumbnailsBrowserView : UIScrollView <ThumbnailViewDelegate, ThumbnailViewDataSourceDelegate>
{
    //     ThumbnailView* aThumbnail;
    NSMutableArray* mutableThumbnailsArray;
    int column;
    int row;
    int numberOfLastRowThumbnails;
}

@property(nonatomic, assign) int numberOfThumbnails;
@property(nonatomic, assign) id<ThumbnailBrowserViewDataSourceDelegate> thumbnailBrowserViewDelegate;
@property(nonatomic, readonly, retain) NSMutableArray* mutableThumbnailsArray;


/*!
 @method    thumbnailBrowserInit
 @abstract  ask the data source how many thumbnails and 
 @discussion 
 */
//-(void)thumbnailBrowserInit;
//-(void)rearrangeThumbnailLayout;

@end




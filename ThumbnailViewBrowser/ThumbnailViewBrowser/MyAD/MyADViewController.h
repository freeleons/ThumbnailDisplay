//
//  MyADViewController.h
//  BlackTea
//
//  Created by Jue Wang on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ThumbnailsBrowserView.h"


@interface MyADViewController : UIViewController<ThumbnailBrowserViewDataSourceDelegate, UIScrollViewDelegate>
{
    NSMutableArray* thumbnailViewArray;

}


@property (retain, nonatomic) IBOutlet ThumbnailsBrowserView *thumbnailsBrowserView;



@end

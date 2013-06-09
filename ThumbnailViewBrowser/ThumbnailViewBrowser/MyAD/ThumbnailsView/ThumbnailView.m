//
//  ThumbnailView.m
//  BlackTea
//
//  Created by Jue Wang on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ThumbnailView.h"
#import "ThumbnailsBrowserView.h"

@implementation ThumbnailView
@synthesize delegate;
@synthesize thumbnailViewDataSourceDelegate;
@synthesize indexPathInTheMutableArray;
@synthesize postionInTheBrowser;
@synthesize deletionButton;

- (id)initWithFrame:(CGRect)frame
{
     self = [super initWithFrame:frame];
     if (self) 
     {
          // Initialization code
          
          //the deletion button on the left corner of the thumbnail
          
          longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(notifyThumbnailBrowserViewEnterEditingMode)];
          [self addGestureRecognizer:longPressGR];
          
          tapToStopGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(notifyThumbnailBrowserViewLeaveEditingMode)];
          [self addGestureRecognizer:tapToStopGR];
          
          tapToDeleteGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeThisAD)];
          deletionButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
          [deletionButton addGestureRecognizer:tapToDeleteGR];

          [deletionButton setImage:[UIImage imageNamed:@"del_01"] forState:UIControlStateNormal];
          
          self.userInteractionEnabled = YES;
     }
     return self;
}


-(void)removeThisAD
{
     NSLog(@"removeThisAD");
     
     
     [thumbnailViewDataSourceDelegate removeThisThumbnailViewInBrowserView:self];
}



-(void)notifyThumbnailBrowserViewLeaveEditingMode
{
     if (delegate != nil) 
     {
          [delegate thumbnailViewBrowserShouldLeaveEditingMode:self];
     }
}

-(void)notifyThumbnailBrowserViewEnterEditingMode
{
     NSLog(@"In notifyThumbnailBrowserViewEnterEditingMode");
     if (delegate != nil) 
     {
          [delegate thumbnailViewBrowserShouldEnterEditingMode:self];
     }
}

-(void)startEditing
{
     if (isEditing == YES)
     {
          return;
     }
     isEditing = YES;
     [deletionButton setHidden:NO];
     [deletionButton setEnabled:YES];
     // Wiggling Animation
     CGFloat rotation = 0.03;
     CABasicAnimation *wiggleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
     wiggleAnimation.duration = 0.13;
     wiggleAnimation.autoreverses = YES;
     wiggleAnimation.repeatCount  = MAXFLOAT;
     wiggleAnimation.removedOnCompletion = NO;
     wiggleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];
     wiggleAnimation.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, rotation, 0.0 ,0.0 ,1.0)];
     [self.layer addAnimation:wiggleAnimation forKey:@"wiggleAnimation"];
     [self addSubview:deletionButton];
     
}

-(void)stopEditing:(UIView*)fromUIView
{
//     NSLog(@"fromUIView: %@",[fromUIView description]);
     deletionButton.hidden = YES;
     deletionButton.enabled = NO;
     [self.layer removeAnimationForKey:@"wiggleAnimation"];
     isEditing = NO;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

-(void)dealloc
{
     [self.layer removeAllAnimations];
     [deletionButton release];
     [longPressGR release];
     [tapToStopGR release];
     
     [postionInTheBrowser release];

     [super dealloc];
}



@end

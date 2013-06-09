//
//  ThumbnailsBrowserView.m
//  BlackTea
//
//  Created by Jue Wang on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ThumbnailsBrowserView.h"

#define MARGIN_WIDTH_TO_THE_FRAME 10
#define MARGIN_LONGTH_TO_THE_FRAME 10

#define PADDING_BETWEEN_THUMBNAIL_WIDTH 10
#define PADDING_BETWEEN_THUMBNAIL_LONGTH 10

#define THUMBNAILVIEW_WIDTH 4*36
#define THUMBNAILVIEW_LONGTH 3*36

@implementation ThumbnailsBrowserView
@synthesize numberOfThumbnails;
@synthesize thumbnailBrowserViewDelegate;
@synthesize mutableThumbnailsArray;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
     
     //if we only want to redraw the updated thumbnail views after thumbnail editing like deletion we do not need to ask the datasource to provide us the data agai
     if (mutableThumbnailsArray == nil) 
     {
          mutableThumbnailsArray = [[NSMutableArray alloc] initWithCapacity:20];

     }
     
     column = 2;

     if (thumbnailBrowserViewDelegate != nil) 
     {
          
          //Knowing column num and then figure out the row number etc.
          numberOfThumbnails = [thumbnailBrowserViewDelegate numberOfThumbnailsInBrowserView:self];
          
          
          row = numberOfThumbnails/column + 1;
          
          numberOfLastRowThumbnails = numberOfThumbnails - column*(row-1);
          //The size of the contentSize
          self.contentSize = CGSizeMake(320, MARGIN_LONGTH_TO_THE_FRAME*2 + THUMBNAILVIEW_LONGTH*row + PADDING_BETWEEN_THUMBNAIL_LONGTH*row+40);
          
          //Use thumbnailViewIndex to retrieve the thumbview in the mutable array
          int thumbnailViewIndex = 0;
          
          //Ask the datasource to return the thumbnail for corresponding row and column
          for (int rowNum = 0; rowNum < row; rowNum++) 
          {
               for (int columnNum = 0; columnNum < column; columnNum++) 
               {
                    if (thumbnailViewIndex == numberOfThumbnails) {
                         return;
                    }
                    
                    Position* pos = [[Position alloc] initWithRow:rowNum andColumn:columnNum];
                    ThumbnailView* thumbnailView = [thumbnailBrowserViewDelegate thumbnailInBrowserView:self atPosition: pos];
                    [mutableThumbnailsArray addObject:thumbnailView];
                    
                    thumbnailView.delegate = self;
                    thumbnailView.thumbnailViewDataSourceDelegate = self;
                    
                    thumbnailView.postionInTheBrowser = pos;
                    thumbnailView.indexPathInTheMutableArray = thumbnailViewIndex;
                    [pos release];
                    
                    
                    
                    //Calculate the position coordinate on the screen for each thumbnails
                    CGFloat x_axis = MARGIN_WIDTH_TO_THE_FRAME + columnNum * THUMBNAILVIEW_WIDTH + columnNum*PADDING_BETWEEN_THUMBNAIL_WIDTH;
                    
                    CGFloat y_axis = MARGIN_LONGTH_TO_THE_FRAME + rowNum * THUMBNAILVIEW_LONGTH + rowNum*PADDING_BETWEEN_THUMBNAIL_LONGTH;
                    
                    thumbnailView.frame = CGRectMake(x_axis, y_axis, THUMBNAILVIEW_WIDTH, THUMBNAILVIEW_LONGTH);
                    thumbnailView.backgroundColor = [UIColor greenColor];
                    
                    /* For debug propose:
                     
                    NSLog(@"Row: %d, Column: %d, x: %f, y: %f, width: %d, longth: %d", rowNum, columnNum, x_axis, y_axis, THUMBNAILVIEW_WIDTH, THUMBNAILVIEW_LONGTH);
                     */
                    
                    [self addSubview:thumbnailView];
                    
                    thumbnailViewIndex++;
               }//end of column for loop
          }//end of row for loop
     }//end of drawing thumbnail method
}






-(void)thumbnailViewBrowserShouldEnterEditingMode:(ThumbnailView*) thumbnailView
{
     ThumbnailView* thumbnailViewLocal = nil;
     for (thumbnailViewLocal in mutableThumbnailsArray) 
     {
          [thumbnailViewLocal startEditing];
     }
}

-(void)thumbnailViewBrowserShouldLeaveEditingMode:(ThumbnailView *)thumbnailView
{
     
     ThumbnailView* thumbnailViewLocal = nil;
     for (thumbnailViewLocal in mutableThumbnailsArray) 
     {
          [thumbnailViewLocal stopEditing:self];
     }
}


-(void)moveTheThumbnailView:(ThumbnailView*) thumbnailView toTheRect:(CGRect)theRect withAnimation:(NSString*) animation
{
     [UIView beginAnimations:nil context:animation];
     [UIView setAnimationDuration:0.5];
     [UIView setAnimationRepeatCount:1];
     thumbnailView.frame = theRect;
     [UIView commitAnimations];
}



-(CGRect)calculationThePositionCoordinatesforRow:(int)rowNum andColumn:(int)columnNum
{
     //Calculate the position coordinate on the screen for each thumbnails
     CGFloat x_axis = MARGIN_WIDTH_TO_THE_FRAME + columnNum * THUMBNAILVIEW_WIDTH + columnNum*PADDING_BETWEEN_THUMBNAIL_WIDTH;
     
     CGFloat y_axis = MARGIN_LONGTH_TO_THE_FRAME + rowNum * THUMBNAILVIEW_LONGTH + rowNum*PADDING_BETWEEN_THUMBNAIL_LONGTH;
     
     CGRect frame = CGRectMake(x_axis, y_axis, THUMBNAILVIEW_WIDTH, THUMBNAILVIEW_LONGTH);
     return frame;
}



-(void)dealloc
{
     [mutableThumbnailsArray removeAllObjects];
     [mutableThumbnailsArray release];
     [super dealloc];
}

#pragma -
#pragma mark ThumbnailView Data Source
-(void)removeThisThumbnailViewInBrowserView:(ThumbnailView*)thumbnailView
{
     
     
/* For debug propose:
 
     NSLog(@"Thumbnail View: %d", thumbnailView.indexPathInTheMutableArray);
     NSLog(@"The removal view indexPath: %d, %d", thumbnailView.postionInTheBrowser.row, thumbnailView.postionInTheBrowser.column);
     NSLog(@"the number of thunmbnail view before one thumbailview removal: %d", [mutableThumbnailsArray count]);
*/
     
     //Animate the thumbnailviews behind the one have been removed to the correct position.
     CGRect previousThumnailViewFrame = thumbnailView.frame;
     Position* previousPosition = thumbnailView.postionInTheBrowser;
     int previousThumbnailIndexInTheMutableArray = thumbnailView.indexPathInTheMutableArray;
     
     
     /*
      For debug propose:

     NSLog(@"The frame of the removal thumbnail: %f, %f, %f, %f", thumbnailView.frame.origin.x, thumbnailView.frame.origin.y, thumbnailView.frame.size.width, thumbnailView.frame.size.height);
      
      */

     
     [UIView animateWithDuration:0.5 animations:^{
          thumbnailView.alpha = 0.0;
          [thumbnailView setFrame:CGRectMake(self.frame.origin.x+50, self.frame.origin.y+50, 0, 0)];
          [thumbnailView.deletionButton setFrame:CGRectMake(0, 0, 0, 0)];
     }completion:^(BOOL finished) {
          [thumbnailView removeFromSuperview];
     }];

     
     
     
     
     
     // the mark to stop the for loop in below
     int stopIndex = [mutableThumbnailsArray count]-1;
     for(int i = thumbnailView.indexPathInTheMutableArray; i < stopIndex; i++)
     {
          
          /* 
          For debug propose:
           
          NSLog(@"ThumbnailView Index i: %d", i);
           
          */
          
          if ([mutableThumbnailsArray count] == (i+1)) {
               NSLog(@"For Loop Breaks because the index exceeds the range of the array at: %d", i);
               break;
          }
          
          
          ThumbnailView* thumbnailViewBehind = [mutableThumbnailsArray objectAtIndex:(i+1)];
          //Record the current thumbnail which is going to move forward into a thumbnail
          CGRect tempFrame = thumbnailViewBehind.frame;
          Position* tempPosition = thumbnailViewBehind.postionInTheBrowser;
          int tempIndexOfThumbnail = thumbnailViewBehind.indexPathInTheMutableArray;
          
          //Update the status of the current thumbnail which is going to move forward into a thumbnail
          [self moveTheThumbnailView:thumbnailViewBehind toTheRect:previousThumnailViewFrame withAnimation:nil];
          thumbnailViewBehind.postionInTheBrowser = previousPosition;
          thumbnailViewBehind.indexPathInTheMutableArray = previousThumbnailIndexInTheMutableArray;
          
          //Update the status of previous thumbnail
          previousThumnailViewFrame = tempFrame;
          previousPosition = tempPosition;
          previousThumbnailIndexInTheMutableArray = tempIndexOfThumbnail;

     }
     
     
     [mutableThumbnailsArray removeObjectAtIndex:thumbnailView.indexPathInTheMutableArray];
     
     [thumbnailBrowserViewDelegate removeThisThumbnailViewInDataSource:thumbnailView];
     
     /* For debug propose:

     NSLog(@"the number of thunmbnail view after one thumbailview removal: %d", [mutableThumbnailsArray count]);
      
      */
}

@end

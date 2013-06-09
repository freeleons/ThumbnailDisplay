//
//  MyADViewController.m
//  BlackTea
//
//  Created by Jue Wang on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyADViewController.h"
#import "ThumbnailView.h"
@interface MyADViewController ()

@end

@implementation MyADViewController
@synthesize thumbnailsBrowserView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
     thumbnailsBrowserView.thumbnailBrowserViewDelegate = self;
     thumbnailsBrowserView.delegate = self;
     thumbnailsBrowserView.frame = CGRectMake(0, 0, 320, 480);
}

-(void)viewDidAppear:(BOOL)animated
{
     
    
}


- (void)viewDidLoad
{
     [super viewDidLoad];
     // Do any additional setup after loading the view from its nib.
//     UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//     [backButton addTarget:self action:@selector(backButtonTapped) forControlEvents:UIControlEventTouchUpInside];
//     [backButton setImage:[UIImage imageNamed:@"back_03"] forState:UIControlStateNormal];
//     [backButton setImage:[UIImage imageNamed:@"back_04"] forState:UIControlStateHighlighted];
//     UIBarButtonItem* backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//     self.navigationItem.leftBarButtonItem = backBarButton;
//     [backButton release];
    
     thumbnailViewArray = [[NSMutableArray alloc] initWithCapacity:20];
     
     for (int i = 0; i < 26; i++) {
          [thumbnailViewArray addObject:[NSNumber numberWithInt:i]];
     }
}

- (void)viewDidUnload
{
     
     [self setThumbnailsBrowserView:nil];
     [super viewDidUnload];
     // Release any retained subviews of the main view.
     // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
     return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark ThumbnailBrowserView Data Source Delegate

-(NSInteger)numberOfThumbnailsInBrowserView:(ThumbnailsBrowserView*)browserView
{
     return [thumbnailViewArray count];
}

-(ThumbnailView*)thumbnailInBrowserView:(ThumbnailsBrowserView*)browserView atPosition: (Position*)position
{
     
     ThumbnailView* thumbnailView = [[ThumbnailView alloc] initWithFrame:CGRectZero];
     
     thumbnailView.delegate =  thumbnailsBrowserView;
     
//     [thumbnailMutableArray addObject:thumbnailMutableArray];
     
//     thumbnailView.backgroundColor = [UIColor colorWithRed:rand() green:rand() blue:rand() alpha:1];
     
     return thumbnailView;
}

-(void)removeThisThumbnailViewInDataSource:(ThumbnailView*)thumbnailView
{
     
//     NSLog(@"In AD VC, remove thumbnail view: %@", [thumbnailView description]);
     
}

- (void)dealloc 
{
     [thumbnailViewArray release];
     [thumbnailsBrowserView release];     
     [super dealloc];
}
@end

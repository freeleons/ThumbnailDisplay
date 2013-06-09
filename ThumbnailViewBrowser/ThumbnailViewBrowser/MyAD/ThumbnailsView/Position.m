//
//  Position.m
//  IndexView
//
//  Created by Zhenzhao Liu on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Position.h"

@implementation Position
@synthesize row;
@synthesize column;

- (id)initWithRow:(int)aRow andColumn:(int)aColumn
{
    self = [super init];
    if (self) 
    {
        // Initialization code
        row = aRow;
        column = aColumn;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
     Position* aCopyPosition = [[Position alloc] initWithRow:row andColumn:column];
     return aCopyPosition;
}

@end

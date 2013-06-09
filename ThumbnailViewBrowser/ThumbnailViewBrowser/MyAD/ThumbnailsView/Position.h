//
//  Position.h
//  IndexView
//
//  Created by Zhenzhao Liu on 12-2-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Position : NSObject<NSCopying>
@property(nonatomic, assign) int row;
@property(nonatomic, assign) int column;

- (id)initWithRow:(int)aRow andColumn:(int)aColumn;
@end

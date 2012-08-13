//
//  Card.h
//  BlackJack
//
//  Created by Ran Tao on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (nonatomic, strong) NSString* label;
@property (nonatomic) int value;
@property (nonatomic, strong) NSString* suit;
-(Card*) initWithLabel:(NSString*)lbl withValue:(int)val withSuit:(NSString*)s;
@end

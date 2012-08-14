//
//  Hand.h
//  BlackJack
//
//  Created by Ran Tao on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Hand : NSObject

@property (nonatomic, strong) NSMutableArray* cards;
@property (nonatomic) int value;
@property (nonatomic) bool isDealersHand;
@property (nonatomic) bool isBusted;
-(bool) isBlackJack;

@end

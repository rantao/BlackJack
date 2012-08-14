//
//  Card.m
//  BlackJack
//
//  Created by Ran Tao & Eddie Kim on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Card.h"

@implementation Card
@synthesize label = _label;
@synthesize value = _value;
@synthesize suit = _suit;

-(Card*) initWithLabel:(NSString*)lbl withValue:(int)val withSuit:(NSString*)s {
    self.label = lbl;
    self.value = val;
    self.suit = s;
    return self;
}

-(NSString*) description {
    NSString* ret = [NSString stringWithFormat:@"[%@%@]", self.label, self.suit];
    return ret;
}

@end

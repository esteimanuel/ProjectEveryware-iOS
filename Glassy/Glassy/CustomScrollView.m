//
//  CustomScrollView.m
//  Glassy
//
//  Created by Niek Willems on 26/05/14.
//  Copyright (c) 2014 InnoYou. All rights reserved.
//

#import "CustomScrollView.h"

@implementation CustomScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@"CustomScrollView touches began");
//    NSLog(@"CustomScrollView touched %@", self);
//    NSLog(@"CustomScrollView nextResponder = %@", self.nextResponder);
//    //[super touchesBegan:touches withEvent:event];
//    [[self nextResponder] touchesBegan:touches withEvent:event];
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //[super touchesMoved:touches withEvent:event];
//    [[self nextResponder] touchesMoved:touches withEvent:event];
//}
//
//-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
//{
//    NSLog(@"Touches ended: CustomScrollView");
//    //[super touchesEnded:touches withEvent:event];
//    [self.nextResponder touchesEnded:touches withEvent:event];
//}


@end

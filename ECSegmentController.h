//
//  ECSegmentController.h
//  CustomSegment
//
//  Created by EC on 16/09/2016.
//  Copyright © 2016 EC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
	SelectionCircle,
	SelectionSquare,
	SelectionLine,
} SelectionFrameType;


@interface ECSegmentController : UIControl

@property	(nonatomic)			NSUInteger selectedIndex;

- (void)setFont:(UIFont*)font;
- (void) setColorForActiveText:(UIColor*)color;
- (void) setColorForNonActiveText:(UIColor*)color;
- (void) setItems:(NSArray*)items;
- (void) setAnimated:(BOOL)animated;
- (void) setAnimationDuration:(NSTimeInterval)interval;
- (void) setColorForSelectionView:(UIColor*)color;
- (void) setSelectionViewType:(SelectionFrameType)type;
- (void) setSelectionViewFrame:(CGRect)frame;


@end

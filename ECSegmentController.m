//
//  Segment.m
//  CustomSegment
//
//  Created by iMac on 16/09/2016.
//  Copyright © 2016 iMac. All rights reserved.
//

#import "ECSegmentController.h"
@interface ECSegmentController()
@property	(strong,nonatomic)  NSMutableArray		*labels;
@property	(strong,nonatomic)  UIView				*thumbView;
@property	(nonatomic)			NSUInteger			calculatedIndex;
@property	(strong,nonatomic)  UIColor				*borderColor;
@property	(strong,nonatomic)  UIColor				*activeIndexTextColor;
@property	(strong,nonatomic)	UIColor				*nonActiveIndexTextColor;
@property	(strong,nonatomic)  UIFont				*textFont;
@property	(nonatomic)			NSTimeInterval		animationDuration;
@property	(strong,nonatomic)	NSArray				*items;
@property	(nonatomic)			CGFloat				borderWidth;
@property	(nonatomic)			UIColor				*selectionBackgroundColor;
@property	(nonatomic)			UIColor				*viewBackgroundColor;
@property	(nonatomic)			NSTimeInterval		animaionDuration;
@property	(nonatomic)			BOOL				animated;
@property	(nonatomic)			CGRect				selectionFrame;
@property	(nonatomic)			SelectionFrameType  selectionType;

@end
@implementation ECSegmentController

-(id)initWithFrame:(CGRect)frame{
	self = [super initWithFrame:frame];
	if (self){
	}
	return self;
	
}
-(void)setUpLabels{
	for (UILabel *label in self.labels){
		[label removeFromSuperview];
	}
	self.labels =[[ NSMutableArray alloc]init];
	
	for (int i = 0 ; i<self.items.count;i++){
		UILabel	*label = [[UILabel alloc]initWithFrame:CGRectZero];
		label.text = self.items[i];
		label.textAlignment= NSTextAlignmentCenter;
		[label setFont:_textFont];
		label.textColor = [UIColor whiteColor];
		[self addSubview:label];
		[self.labels addObject:label];
		
}
	
}
- (void)displaySelectedIndex{
	[self.labels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		UILabel	*label = obj;
		label.textColor = self.nonActiveIndexTextColor;
	}];
	UILabel * label = self.labels[self.calculatedIndex];
	label.textColor = _activeIndexTextColor;
	
	[UIView animateWithDuration:_animaionDuration animations:^{
		CGRect frame = _selectionFrame;
		frame.origin.x = label.frame.origin.x;
		
		self.thumbView.frame =frame;
	}];
	
}


- (void) setUpView{

	self.layer.cornerRadius= self.frame.size.height/2;
	self.layer.borderColor = self.borderColor.CGColor;
	self.layer.borderWidth=self.borderWidth;
	[self setUpLabels];
	self.thumbView= [[UIView alloc]initWithFrame:_selectionFrame];
	[self insertSubview:self.thumbView atIndex:0];


	
}
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
	CGPoint location = [touch locationInView:self];
	
	[_labels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if (CGRectContainsPoint([obj frame], location)){
			_calculatedIndex = idx;
			
			
		}
		
	}];
	if (self.calculatedIndex!=self.selectedIndex){
		_selectedIndex= _calculatedIndex;
		[self sendActionsForControlEvents:UIControlEventValueChanged];
		
	}
	[self displaySelectedIndex];
	
	return NO;

}

-(void)layoutSubviews{
	[super layoutSubviews];
	

	self.thumbView.frame =_selectionFrame; // frame
	self.thumbView.backgroundColor = self.selectionBackgroundColor;
	
	if (self.selectionType == SelectionCircle) self.thumbView.layer.cornerRadius= self.thumbView.frame.size.height/2;
	
	

	CGFloat labelWidth = self.bounds.size.width/self.labels.count;
	
	for (int i = 0 ; i<self.labels.count;i++){
		UILabel	*label = self.labels[i];
		CGFloat xPosition = i*labelWidth;
		label.frame = CGRectMake(xPosition, 0, labelWidth, _selectionFrame.size.height);
	}
	[self displaySelectedIndex];
	
	
}
-(void)start{
[self setUpView];
}

-(NSUInteger)getSelectedIndex{
	return self.calculatedIndex;
}
- (void)setFont:(UIFont*)font{
	_textFont = font;
}

- (void) setColorForActiveText:(UIColor*)color{
	_activeIndexTextColor = color;
}

- (void) setColorForNonActiveText:(UIColor*)color{
	_nonActiveIndexTextColor = color;
}

-(void) setColorForSelectionView:(UIColor*)color{
	_selectionBackgroundColor = color;

}
- (void) setItems:(NSArray*)items{
	_items = [items copy];
}
- (void) setAnimated:(BOOL)animated{
	_animated=animated;
}
- (void) setAnimationDuration:(NSTimeInterval)interval{
	_animaionDuration=interval;
}
- (void) setSelectionViewFrame:(CGRect)frame{
	_selectionFrame=frame;
}

- (void) setSelectionViewType:(SelectionFrameType)type{
	CGRect frame = self.bounds;
	_selectionType=type;
	frame.size.width =self.bounds.size.width/self.items.count;
	if (type ==SelectionCircle){
		
	
	}else if (type==SelectionLine){
		frame.origin.y = CGRectGetMaxY(frame)-4;
		frame.size.height=4;
	}
	_selectionFrame = frame;
}
@end

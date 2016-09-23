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

@property   (strong,nonatomic)    NSMutableArray          *views;
@property   (strong,nonatomic)    NSMutableArray          *changesViews;
@property   (nonatomic) BOOL isLabels;

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
-(void)setUpViews{
    for (UIView *view in self.views){
        [view removeFromSuperview];
    }
    self.views =[[ NSMutableArray alloc]init];
    CGFloat postitionX = self.bounds.size.width/self.items.count;
    
    for (int i = 0 ; i<self.items.count;i++){
        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(postitionX*i, 0, postitionX, self.bounds.size.height)];
        [view setContentMode:UIViewContentModeScaleAspectFit];
        CGRect subviewFrame = CGRectMake(view.center.x, view.center.y, view.frame.size.width/2, view.frame.size.height/2) ;
       
        view.image = [(UIImageView*)self.items[i]image];
        [view setFrame:subviewFrame];
        [self addSubview:view];
        [view setCenter:view.center];
        [self.views addObject:view];
        
    }
    
}

- (void)displaySelectedIndex{
    if (_isLabels){
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
    }else{
        [self.views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [(UIImageView*)obj setImage:[(UIImageView*)self.items[idx]image]];
            
        }];
        UIImageView * view = self.views[self.calculatedIndex];
        
       [view setImage:self.changesViews[self.calculatedIndex]];
        
        
        [UIView animateWithDuration:_animaionDuration animations:^{
            CGRect frame = _selectionFrame;
            frame.origin.x = view.frame.origin.x;
            
            self.thumbView.frame =frame;
        }];

        
    }
	
}


- (void) setUpView{

	self.layer.cornerRadius= self.frame.size.height/2;
	self.layer.borderColor = self.borderColor.CGColor;
	self.layer.borderWidth=self.borderWidth;
    if ([self.items.firstObject isKindOfClass:[NSString class]]){
        [self setUpLabels];
        _isLabels =YES;
    }else{
        [self setUpViews];
        
    }
    
	self.thumbView= [[UIView alloc]initWithFrame:_selectionFrame];
	[self insertSubview:self.thumbView atIndex:0];


	
}
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
	CGPoint location = [touch locationInView:self];
    id object;
    if (_isLabels)object=_labels;
    else object = _views;
    
	[object enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
	
	
    if (_isLabels){
        
        CGFloat labelWidth = self.bounds.size.width/self.labels.count;
        CGFloat labelHeight = self.bounds.size.height;
	for (int i = 0 ; i<self.labels.count;i++){
		UILabel	*label = self.labels[i];
		CGFloat xPosition = i*labelWidth;
		label.frame = CGRectMake(xPosition, 0, labelWidth, labelHeight);
	}
    }else{
        
        CGFloat labelWidth = self.bounds.size.width/self.views.count;
        CGFloat labelHeight = self.bounds.size.height;
        for (int i = 0 ; i<self.views.count;i++){
            UIView	*view = self.views[i];
            CGFloat xPosition = i*labelWidth;
            view.frame = CGRectMake(xPosition, 0, labelWidth, labelHeight);
        }

    }
	[self displaySelectedIndex];
	
	
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
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
- (void)setChangesViews:(NSArray*)array {
    _changesViews = array;
}
@end

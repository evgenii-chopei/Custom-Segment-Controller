# custom.segment
Custom segment controller iOS
You can customise it with methods:

1. Add files to your project. 
2. Import Header   ( #import "Segment.h")



- (void)setFont:(UIFont*)font;
- (void) setColorForActiveText:(UIColor*)color;
- (void) setColorForNonActiveText:(UIColor*)color;
- (void) setItems:(NSArray*)items;
- (void) setAnimated:(BOOL)animated;
- (void) setAnimationDuration:(NSTimeInterval)interval;
- (void) setColorForSelectionView:(UIColor*)color;
- (void) setSelectionViewType:(SelectionFrameType)type;
- (void) setSelectionViewFrame:(CGRect)frame;



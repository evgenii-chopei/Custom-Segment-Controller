# Custom Segment Controller iOS 
WITH VERY flexible adjustment


1. Add files to your project. 
2. Import Header   ( #import "ECSegmentController.h")
![alt tag](https://media.giphy.com/media/l0MYS9YDMhI8E12Ba/giphy.gif)

You can customise it with methods:

- (void)setFont:(UIFont*)font;
- (void) setColorForActiveText:(UIColor*)color;
- (void) setColorForNonActiveText:(UIColor*)color;
- (void) setItems:(NSArray*)items;
- (void) setAnimated:(BOOL)animated;
- (void) setAnimationDuration:(NSTimeInterval)interval;
- (void) setColorForSelectionView:(UIColor*)color;
- (void) setSelectionViewType:(SelectionFrameType)type;
- (void) setSelectionViewFrame:(CGRect)frame;

Example : 

	-	ECSegmentController * seg = [[ECSegmentController alloc]initWithFrame:CGRectMake(0, 0, -self.view.frame.size.width, 100)];
	-	[seg setItems:@[@"Item 1",@"Item 2",@"Item 3"]];
	-	[seg setSelectionViewType:SelectionCircle];
	-	[seg setBackgroundColor:[UIColor blueColor]];
	-	[seg setColorForActiveText:[UIColor whiteColor]];
	-	[seg setColorForNonActiveText:[UIColor grayColor]];
	-	[seg setColorForSelectionView:[UIColor blackColor]];
	-	[seg setAnimationDuration:0.5];
	-	[self.view addSubview:seg];
	 	[seg addTarget:self action:@selector(segmentControllerTappe:) forControlEvents:UIControlEventValueChanged];
```
- (void)segmentControllerTappe:(ECSegmentController*)segment
{
if (segment.selectedIndex==2){
//do something
}




	
	
	

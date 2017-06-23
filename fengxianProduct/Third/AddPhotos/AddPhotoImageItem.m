
#import <QuartzCore/QuartzCore.h>
#import "AddPhotoImageItem.h"

#define iphone6Ps 100
#define iphone5 80

@implementation AddPhotoImageItem
@synthesize isEditing,isRemovable,index;
@synthesize delegate;




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id) initWithButton:(NSString *)buttonImageName withImageName:(NSString *)imageName atIndex:(NSInteger)aIndex editable:(BOOL)removable isShowButtonImage:(BOOL)isShow{
//    if ([[PathTools deviceType]isEqualToString:@"iPhone4"] || [[PathTools deviceType]isEqualToString:@"iPhone5"]) {
//        
//        self = [super initWithFrame:CGRectMake(0, 0, 80, 80)];
//
//    }else if ([[PathTools deviceType]isEqualToString:@"iPhone6"]){
//        
//        self = [super initWithFrame:CGRectMake(0, 0, 100, 100)];
//
//    }
    
    if (UI_IS_IPHONE4) {
        
        self = [super initWithFrame:CGRectMake(0, 0, 50, 50)];

        
    }else if (UI_IS_IPHONE5){
        
        self = [super initWithFrame:CGRectMake(0, 0, 50, 50)];

    }else if (UI_IS_IPHONE6){
        
        self = [super initWithFrame:CGRectMake(0, 0, 90, 90)];

        
    }else{
        
        self = [super initWithFrame:CGRectMake(0, 0,100, 100)];
        
    }
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        normalImage = [UIImage imageNamed:imageName];
        self.isEditing = NO;
        index = aIndex;
        self.isRemovable = removable;
        

        // place a clickable button on top of everything
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setFrame:self.bounds];
        [button setBackgroundImage:normalImage forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor clearColor]];
        button.layer.cornerRadius = 7;
        button.clipsToBounds = YES;
        if (isShow) {
            
            [button setImage:[UIImage imageNamed:buttonImageName] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            
            NSMutableArray * array = [[NSArray arrayWithContentsOfFile:saveIamgePath] mutableCopy];
            
            [button setBackgroundImage:[self obtainImage:array.count - 1] forState:UIControlStateNormal];
            button.userInteractionEnabled = YES;
            UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(button.frame) + 1, CGRectGetHeight(button.frame) + 1)];
            imageV.center = CGPointMake(button.center.x, button.center.y);
            imageV.image =normalImage;
            imageV.layer.cornerRadius = 4;
            imageV.clipsToBounds = YES;
            [button addSubview:imageV];
        }
   
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressedLong:)];
        [self addGestureRecognizer:longPress];
        longPress = nil;
        [self addSubview:button];
        
        if (self.isRemovable) {
            
            // place a remove button on top right corner for removing item from the board
            deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
            float w = 80;
            float h = 80;
            
            [deleteButton setFrame:CGRectMake(self.frame.size.width - 80,self.frame.origin.y, w, h)];
            UIImageView * imageV = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(deleteButton.frame) - 30, 10, 20, 20)];
            imageV.image = [UIImage imageNamed:@"Delete_Image_Icon"];
            [deleteButton addSubview:imageV];
//            [deleteButton setBackgroundColor:[UIColor redColor]];
//            [deleteButton setImage:[UIImage imageNamed:@"imageDelete.png"] forState:UIControlStateNormal];
//            [deleteButton setImageEdgeInsets:UIEdgeInsetsMake(0, CGRectGetWidth(deleteButton.frame) - 30, 50, 0)];
//           [deleteButton setBackgroundImage:[UIImage imageNamed:@"imageDelete.png"] forState:UIControlStateNormal];
            [deleteButton addTarget:self action:@selector(removeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [deleteButton setHidden:YES];
            [self addSubview:deleteButton];
        }
    }
    return self;
}
//获取沙盒中存储的图片
-(UIImage *)obtainImage:(NSInteger)num{
    
    NSMutableArray * array = [[NSArray arrayWithContentsOfFile:saveIamgePath] mutableCopy];
    
    NSData *imageData = array[num];
    
    UIImage * saveImage = [[UIImage alloc]initWithData:imageData];
    
    return saveImage;
}
//drawing
//- (void)drawRect:(CGRect)rect{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGMutablePathRef path = CGPathCreateMutable();
    
//    CGPathAddRect(path, nil, self.bounds);
//    CGContextAddPath(context, path);
//    //[[UIColor colorWithWhite:1.0f alpha:0.0f]setFill];
//    [[UIColor colorWithWhite:1 alpha:1.0f] setStroke];
//    CGContextSetLineWidth(context, 5.0f);
//    CGContextDrawPath(context, kCGPathStroke);
//    float radius = 15;
//    float w = self.bounds.size.width;
//    float h = self.bounds.size.height;
//    float x = self.bounds.origin.x;
//    float y = self.bounds.origin.y;
//    
//    CGPathMoveToPoint(path, NULL, x, y + radius);
//    CGPathAddArcToPoint(path, NULL,x, y, x, y + radius, radius);
//    CGPathAddArcToPoint(path, NULL, x + w, y, x + w, y + radius, radius);
//    CGPathAddArcToPoint(path, NULL, x + w, y + h, x + w - radius, y + h, radius);
//    CGPathAddArcToPoint(path, NULL, x, y + h, x, y + h - radius, radius);
//
//    CGPathCloseSubpath(path);
//    CGContextAddPath(context, path);
//    CGContextSetLineWidth(context, 15.0f);
//    [[UIColor colorWithWhite:1 alpha:1.0f] setStroke];
//    CGContextStrokePath(context);
//    CGPathRelease(path);
//}
#pragma mark - UI actions

- (void) clickItem:(id)sender {
    [delegate gridItemDidClicked:self];
}
- (void) pressedLong:(UILongPressGestureRecognizer *) gestureRecognizer{
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            point = [gestureRecognizer locationInView:self];
            [delegate gridItemDidEnterEditingMode:self];
            //放大这个item
            [self setAlpha:1.0];
            NSLog(@"press long began");
            break;
        case UIGestureRecognizerStateEnded:
            point = [gestureRecognizer locationInView:self];
//            [delegate gridItemDidEndMoved:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            //变回原来大小
            [self setAlpha:1.0];
            NSLog(@"press long ended");
            break;
        case UIGestureRecognizerStateFailed:
            NSLog(@"press long failed");
            break;
        case UIGestureRecognizerStateChanged:
            //移动
            
//          [delegate gridItemDidMoved:self withLocation:point moveGestureRecognizer:gestureRecognizer];
            NSLog(@"press long changed");
            break;
        default:
            NSLog(@"press long else");
            break;
    }
    
    //CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    
}

- (void) removeButtonClicked:(id) sender  {
    [delegate gridItemDidDeleted:self atIndex:index];
}

#pragma mark - Custom Methods

- (void) enableEditing {
    
    if (self.isEditing == YES)
        return;
    
    // put item in editing mode
    self.isEditing = YES;
    
    // make the remove button visible
    [deleteButton setHidden:NO];
    [button setEnabled:NO];
    // start the wiggling animation
    CGFloat rotation = 0.03;
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
    shake.duration = 0.13;
    shake.autoreverses = YES;
    shake.repeatCount  = MAXFLOAT;
    shake.removedOnCompletion = NO;
    shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,-rotation, 0.0 ,0.0 ,1.0)];
    shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, rotation, 0.0 ,0.0 ,1.0)];
    
    [self.layer addAnimation:shake forKey:@"shakeAnimation"];
    
    // inform the springboard that the menu items are now editable so that the springboard
    // will place a done button on the navigationbar 
    //[(SESpringBoard *)self.delegate enableEditingMode];
    
}
- (void) disableEditing {
    [self.layer removeAnimationForKey:@"shakeAnimation"];
    [deleteButton setHidden:YES];
    [button setEnabled:YES];
    self.isEditing = NO;
}

# pragma mark - Overriding UiView Methods

//- (void) removeFromSuperview{
//
//    [UIView animateWithDuration:0.2 animations:^{
//        self.alpha = 0.0;
//        [self setFrame:CGRectMake(self.frame.origin.x+50, self.frame.origin.y+50, 0, 0)];
//        [deleteButton setFrame:CGRectMake(0, 0, 0, 0)];
//    }completion:^(BOOL finished) {
//        [super removeFromSuperview];
//    }]; 
//}

@end

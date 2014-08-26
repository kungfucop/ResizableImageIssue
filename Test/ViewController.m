

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong)UIImageView* backgroundAImageView;


@end

@implementation ViewController
const CGFloat ARROW_SIZE = 12.0f;
const CGFloat ARROW_ANIMATION_DISTANCE = 10.0;
//const CGFloat UP_ARROW_WIDTH = 11.0f;
const CGFloat UP_ARROW_WIDTH = 20.0f;

const CGFloat BACKGROUND_ALPHA = 0.84;

const CGFloat FADE_IN_ANIMATION_DURATION = 0.3;
const CGFloat FADE_OUT_ANIMATION_DURATION = 0.2;
const CGFloat DEFAULT_DELAY = 0.5;

const NSInteger DEFAULT_REPEAT_INTERVAL = 5;
const NSInteger DEFAULT_REPEAT_LIMIT = 3;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor greenColor];
    self.backgroundAImageView = [[UIImageView alloc]
                                 initWithImage:[self getResizeableBackgroundSideImage:UIImageOrientationUp]];
   
    
    CGRect frame = CGRectMake(0, 100, 100, 50 + ARROW_SIZE);
    CGFloat AWidth = floor(frame.size.width/2.0);
    self.backgroundAImageView.frame = CGRectMake(frame.origin.x, frame.origin.y, AWidth, frame.size.height);
    

self.backgroundAImageView.alpha = BACKGROUND_ALPHA;
self.backgroundAImageView.userInteractionEnabled = FALSE;
    [self.view addSubview:self.backgroundAImageView];


}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage*)getResizeableImage:(NSString*)imageName capInsets:(UIEdgeInsets)capInsets orientation:(UIImageOrientation)orientation
{
    UIImage* image = [UIImage imageNamed:imageName];
    
    // This orienation change works for things that don't have to swap
    // width and height.  Otherwise it breaks the resize edge insets on those
    // orintations, so I've switched to manually rotating by 90 deg and then
    // doing a different set of orienation changes. *sigh*  Google as I might
    // I can't figure out how to get this orientation stuff to work properly with
    // the edge insets.
    if (orientation == UIImageOrientationUp
        || orientation == UIImageOrientationUpMirrored
        || orientation == UIImageOrientationDown
        || orientation == UIImageOrientationDownMirrored) {
       // image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:orientation];
        return [image resizableImageWithCapInsets:capInsets];
    }
    
    image = [self imageRotatedByDegrees:image deg:90];
    UIImageOrientation newOrientation = orientation;
    
    if (orientation == UIImageOrientationLeft) {
        newOrientation = UIImageOrientationDown;
    } else if (orientation == UIImageOrientationLeftMirrored) {
        newOrientation = UIImageOrientationUpMirrored;
    } else if (orientation == UIImageOrientationRight) {
        newOrientation = UIImageOrientationUp;
    } else if (orientation == UIImageOrientationRightMirrored) {
        newOrientation = UIImageOrientationDownMirrored;
    }
    image = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:newOrientation];
    
    // Twist the insets 90 deg.
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(capInsets.left, capInsets.bottom, capInsets.right, capInsets.top)];
}

- (UIImage*)getResizeableBackgroundSideImage:(UIImageOrientation)orientation
{
    return [self getResizeableImage:@"onboarding_box_3x18_L2T15"  // changed to  editor_navbar_pressed_1x1 works
            //top left bottom right
                          capInsets:UIEdgeInsetsMake(15, 4, 2, 1)
            // capInsets:UIEdgeInsetsMake(12, 7, 7, 1)
                        orientation:orientation];
}

- (UIImage*)imageRotatedByDegrees:(UIImage*)oldImage deg:(CGFloat)degrees
{
    
    // calculate the size of the rotated view's containing box for our drawing space
    UIView* rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,oldImage.size.width, oldImage.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(degrees * M_PI / 180);
    rotatedViewBox.transform = t;
    
    CGSize rotatedSize = rotatedViewBox.frame.size;
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, (degrees * M_PI / 180));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-oldImage.size.width / 2, -oldImage.size.height / 2, oldImage.size.width, oldImage.size.height), [oldImage CGImage]);
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end

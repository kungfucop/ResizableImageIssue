

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong)UIImageView* backgroundAImageView;


@end

@implementation ViewController
const CGFloat ARROW_SIZE = 12.0f;
const CGFloat UP_ARROW_WIDTH = 20.0f;

const CGFloat BACKGROUND_ALPHA = 0.84;


- (void)viewDidLoad {
    [super viewDidLoad];
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

- (UIImage*)getResizeableImage:(NSString*)imageName capInsets:(UIEdgeInsets)capInsets orientation:(UIImageOrientation)orientation
{
    UIImage* image = [UIImage imageNamed:imageName];
    
    return [image resizableImageWithCapInsets:capInsets];
}

- (UIImage*)getResizeableBackgroundSideImage:(UIImageOrientation)orientation
{
    return [self getResizeableImage:@"onboarding_box_3x18_L2T15"  // changed to  editor_navbar_pressed_1x1 works
            //top left bottom right
                          capInsets:UIEdgeInsetsMake(12, 1, 2, 1)
            // capInsets:UIEdgeInsetsMake(12, 7, 7, 1)
                        orientation:orientation];
}


@end

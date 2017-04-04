//
//  ViewController.m
//  20_lecture_UIView_Animations
//
//  Created by Slava on 02.04.17.
//  Copyright © 2017 Slava. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

//@property (weak, nonatomic) UIView *testView;
@property (weak, nonatomic) UIImageView *testImgView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100 , 100, 100)];
//    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    UIImage *imgOne = [UIImage imageNamed:@"img1.png"];
    UIImage *imgTwo = [UIImage imageNamed:@"img2.png"];
    UIImage *imgThree = [UIImage imageNamed:@"img3.png"];
    
//    NSArray *arrayImges = @[imgOne, imgThree, imgTwo, imgThree];
    NSArray *arrayImg = @[imgOne, imgTwo, imgThree];
    
    view.animationImages = arrayImg;
    view.animationDuration = 1;
    [view startAnimating];
    
//    self.testView = view;
    self.testImgView = view;

}

// создаем анимацию
- (void) moveView:(UIView *) view {
    // создаем рандомные точки в родительском view в зоне видимости
    CGRect rectView = self.view.bounds;
    rectView = CGRectInset(rectView, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame));      // ширина
//    CGFloat x = arc4random() % (int)CGRectGetWidth(rectView) + CGRectGetMinX(rectView);             // рандомная точка X
//    CGFloat y = arc4random() % (int)CGRectGetHeight(rectView) + CGRectGetMinY(rectView);            // рандомная точка Y
    
//    CGFloat x = arc4random_uniform((int)CGRectGetWidth(rectView) + CGRectGetMinX(rectView));
//    CGFloat y = arc4random_uniform((int)CGRectGetHeight(rectView) + CGRectGetMinY(rectView));
    
//    CGFloat x = arc4random_uniform((u_int64_t) CGRectGetWidth(rectView) + CGRectGetMinX(rectView));
//    CGFloat y = arc4random_uniform((u_int64_t) CGRectGetHeight(rectView) + CGRectGetMinY(rectView));
    
    CGFloat x = (CGFloat)(arc4random() % (int)self.view.bounds.size.width);             // рандомная точка X
    CGFloat y = (CGFloat)(arc4random() % (int)self.view.bounds.size.height);            // рандомная точка Y

    
    // рандомный размер
    CGFloat scaleView = (float)(arc4random() % 151) / 100 + 0.5;  // from 0 to 1,5
    
    // rotation
    CGFloat rotationView = (float)(arc4random() * (int)(M_PI * 2 * 1000)) / 1000 - M_PI;   // from 0 to 2Pi
    
    // генерируем время
    CGFloat duratinoView = (float)(arc4random() % 20001) / 10000 + 2;   // from 0 to 4s
    
    // способ 1
    //    [UIView animateWithDuration:5
    //                     animations:^{
    //                         self.testView.center = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(self.testView.frame) / 2, 150);
    //                     }];
    
    // способ 2
    [UIView animateWithDuration:duratinoView    // продолжительность
                          delay:0    // задержка
                        options:UIViewAnimationOptionCurveLinear /*| UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse */    // каким образом происходит анимация (кривая анимации)
                     animations:^{
                         view.center = CGPointMake(x, y);   // выдем рандомные точки нашему view
                         //                         self.testView.transform = CGAffineTransformMakeTranslation(1, 250);
                         //                         self.testView.transform = CGAffineTransformMakeScale(2, .5); // изменяем размер
                         CGAffineTransform scale = CGAffineTransformMakeScale(scaleView, scaleView);
                         CGAffineTransform rotation = CGAffineTransformMakeRotation(rotationView);
                         CGAffineTransform transform = CGAffineTransformConcat(scale, rotation);
                         view.transform = transform;
                         
                         
                         
                         view.backgroundColor = [self randomColor ];   // меняем цвет на рандомный
                         
                         // разворачиваем
                         //                         self.testView.transform = CGAffineTransformMakeRotation(M_PI); // поворачиваем на угол 3.14
                     }
                     completion:^(BOOL finished) { // загружается после окончания
                         NSLog(@"end animation %d", finished);
                         NSLog(@"view frame = %@, bounds = %@", NSStringFromCGRect(view.frame), NSStringFromCGRect(view.bounds));
                         
                         // создаем слабую ссылку на view
                         __weak UIView *v = view;
                         [self moveView:v];
                     }];
    //
    //
    //    // отменяем анимацию
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        [self.testView.layer removeAllAnimations];
    //
    //
    //        [UIView animateWithDuration:4   // продолжительность
    //                              delay:0   // задержка
    //                            options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionBeginFromCurrentState   // каким образом происходит анимация (кривая анимации)
    //
    //         //        UIViewAnimationOptionBeginFromCurrentState  чет не работает
    //
    //                         animations:^{
    //                             self.testView.center = CGPointMake(200, 250);
    //                         }
    //                         completion:^(BOOL finished) { // загружается после окончания
    //                             NSLog(@"end animation %d", finished);
    //                         }];
    //        
    //    });
    //
}

// создаем анимацию
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    [self moveView:self.testView];
    [self moveView:self.testImgView ];


}

- (CGFloat) formZeroToOne {
    return (float)(arc4random() % 256) / 255;
}

- (UIColor *) randomColor {
    CGFloat r = [self formZeroToOne];
    CGFloat g = [self formZeroToOne];
    CGFloat b = [self formZeroToOne];
    UIColor *color = [[UIColor alloc] initWithRed:r
                                            green:g
                                             blue:b
                                            alpha:1];
    return color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

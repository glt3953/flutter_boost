//
//  NativeViewController.m
//  Runner
//
//  Created by yujie on 2019/12/26.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "NativeViewController.h"
#import <Flutter/Flutter.h>
#import <flutter_boost/FlutterBoost.h>
#import <WebKit/Webkit.h>
#import "Masonry.h"

@interface NativeViewController ()
@property (nonatomic, strong) FBFlutterViewContainer *flutterContainer;
@property (nonatomic, strong) WKWebView *baichuanWebView;
@property (nonatomic) CGFloat flutterContainerViewOriginY;
@end

@implementation NativeViewController

- (instancetype)init{
    if (self = [super init]) {
        _flutterContainer = [[FBFlutterViewContainer alloc]init];
//        [_flutterContainer setName:@"embedded" uniqueId:nil params:@{} opaque:YES];
        [_flutterContainer setName:@"showDialog" uniqueId:nil params:@{} opaque:YES];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
//    
//    [NSTimer scheduledTimerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"Timer run");
//        CGRect frame = self.flutterContainer.view.frame;
//        frame.size.height += 10;
//        [self.flutterContainer.view setFrame:frame];
//        
//    }];

    CGFloat originX = 20;
    CGFloat originY = 20 + 44 + 40;
    CGFloat flutterContainerHeight = 128;
    CGFloat spaceY = 0;
//    CGFloat height = self.view.bounds.size.height - originY - flutterContainerHeight;
//    _baichuanWebView = [[WKWebView alloc] initWithFrame:CGRectMake(originX, originY, width, height)];
    _baichuanWebView = [[WKWebView alloc] init];
    _baichuanWebView.inspectable = YES;
    // 设置 Cookie
    NSURL *url = [NSURL URLWithString:@"https://baiying-test.baichuan-ai.com"];
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"__bc_token__" forKey:NSHTTPCookieName];
    [cookieProperties setObject:@"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.fd7b4d8b258667b3148bd1a3f62a9748309219bd904a2232ac73831d35cc2ae5f2e278dccc5f3188c1e42f2d0f133104ecf8f7cf7880634b8a67538a7922124ccf5a5e67380bb4b481aac3d9aa5d683345357b5e16403b147682c7f84aae8acd0e47368c1e18cb53ee91b2406307ef59251ec67d199e631da34e1ab88b5ba669.GzPsV5tZwYeSqe-Pj-Syh7_C_YYn6wT96EAi6Vv4SnI" forKey:NSHTTPCookieValue];
    [cookieProperties setObject:@"unique_id" forKey:NSHTTPCookieName];
    [cookieProperties setObject:@"WeI5o1E9" forKey:NSHTTPCookieValue];
    [cookieProperties setObject:url.host forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:[NSDate dateWithTimeIntervalSinceNow:36000000000] forKey:NSHTTPCookieExpires];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    NSURLRequest *request = [NSURLRequest requestWithURL:url]; //https://baiying-test.baichuan-ai.com，https://www.baidu.com
    [_baichuanWebView loadRequest:request];
    [self.view addSubview:_baichuanWebView];
//    UIEdgeInsets padding = UIEdgeInsetsMake(20 + 44 + 40, 20, 10, 20);
    [_baichuanWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(originY);
        make.left.equalTo(self.view.mas_left).with.offset(originX);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-flutterContainerHeight);
        make.right.equalTo(self.view.mas_right).with.offset(-originX);
    }];
    // 根据_flutterContainer.view的高度调整_baichuanWebView的高度
//    [_baichuanWebView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.flutterContainer.view.mas_top);
////        make.height.mas_equalTo(newHeight); // 根据_flutterContainer.view的高度调整_baichuanWebView的高度
//    }];
    
    _flutterContainerViewOriginY = self.view.frame.size.height - spaceY - flutterContainerHeight;
    CGFloat width = CGRectGetWidth(self.view.bounds) - 2 * originX;
    self.flutterContainer.view.frame = CGRectMake(originX, _flutterContainerViewOriginY, width, flutterContainerHeight);
    [self.view addSubview:self.flutterContainer.view];
//    [self.flutterContainer.view setBackgroundColor:[UIColor blueColor]];
    [self addChildViewController:self.flutterContainer];
//    [self.flutterContainer.view mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.top.mas_equalTo(_baichuanWebView.mas_bottom);
//        make.top.mas_equalTo(self.view.mas_bottom).with.offset(-(flutterContainerHeight+spaceY));
//        make.left.mas_equalTo(self.view.mas_left).with.offset(originX);
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(-spaceY);
//        make.right.mas_equalTo(self.view.mas_right).with.offset(-originX);
////        make.height.mas_greaterThanOrEqualTo(flutterContainerHeight);
//        make.height.mas_equalTo(flutterContainerHeight);
//    }];
//    [self.flutterContainer.view mas_updateConstraints:^(MASConstraintMaker *make) {
////        make.top.mas_equalTo(self.view.mas_bottom).with.offset(-(flutterContainerHeight+spaceY));
//        make.top.mas_lessThanOrEqualTo(100);
////        make.bottom.mas_lessThanOrEqualTo(0);
////        make.height.mas_greaterThanOrEqualTo(flutterContainerHeight);
//    }];
    
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"container_height_channel" binaryMessenger:self.flutterContainer.binaryMessenger];
        [channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
            if ([call.method isEqualToString:@"updateHeight"]) {
                CGFloat height = [call.arguments[@"height"] floatValue];
                [self updateFlutterContainerHeight:height];
            }
        }];
    
    // 注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
}

- (void)updateFlutterContainerHeight:(CGFloat)height {
    // Update the height of the Flutter Container here
    // You can adjust the height of the Flutter Container based on the received height
    CGRect frame = self.flutterContainer.view.frame;
    NSLog(@"start updateFlutterContainerHeight frame.origin.y:%f, frame.size.height:%f", frame.origin.y, frame.size.height);
    CGFloat spaceY = height - frame.size.height;
    frame.origin.y -= spaceY;
    frame.size.height += spaceY;
    NSLog(@"end updateFlutterContainerHeight frame.origin.y:%f, frame.size.height:%f", frame.origin.y, frame.size.height);
    [self.flutterContainer.view setFrame:frame];
//    [self.flutterContainer.view mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_lessThanOrEqualTo(100);
//        make.height.mas_equalTo(height);
//    }];
}

- (void)pushMe
{
    UIViewController *vc = [[UIViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //注意这行代码不可缺少
    [self.flutterContainer.view setNeedsLayout];
    [self.flutterContainer.view layoutIfNeeded];
}

//NOTES: embed情景下必须实现！！！
- (void)didMoveToParentViewController:(UIViewController *)parent {
    [self.flutterContainer didMoveToParentViewController:parent];
    [super didMoveToParentViewController:parent];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc{
    NSLog(@"dealloc native controller%p", self.flutterContainer);
    // 移除键盘通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat keyboardHeight = keyboardSize.height;
    
    CGRect frame = self.flutterContainer.view.frame;
    frame.origin.y = _flutterContainerViewOriginY - keyboardHeight;
//    frame.origin.y -= keyboardHeight;
    [self.flutterContainer.view setFrame:frame];
    
//    NSLog(@"Keyboard will show. Height: %f", keyboardHeight);
    // 在这里可以对键盘弹起进行处理，比如调整界面布局
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGRect frame = self.flutterContainer.view.frame;
    frame.origin.y = _flutterContainerViewOriginY;
    [self.flutterContainer.view setFrame:frame];
    
//    NSLog(@"Keyboard will hide.");
    // 在这里可以对键盘隐藏进行处理
}

@end

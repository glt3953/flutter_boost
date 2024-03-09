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

    CGFloat originX = 20;
    CGFloat originY = 20 + 44 + 40;
    CGFloat width = self.view.bounds.size.width - 2 * originX;
    CGFloat flutterContainerHeight = 80;
    CGFloat height = self.view.bounds.size.height - originY - flutterContainerHeight;
    _baichuanWebView = [[WKWebView alloc] initWithFrame:CGRectMake(originX, originY, width, height)];
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
    
    _flutterContainerViewOriginY = originY + height + 10;
    height = flutterContainerHeight - 20;
    self.flutterContainer.view.frame = CGRectMake(originX, _flutterContainerViewOriginY, width, height);
    [self.view addSubview:self.flutterContainer.view];
    [self addChildViewController:self.flutterContainer];
    
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

- (void)pushMe
{
    UIViewController *vc = [[UIViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //注意这行代码不可缺少
//    [self.flutterContainer.view setNeedsLayout];
//    [self.flutterContainer.view layoutIfNeeded];
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
    [self.flutterContainer.view setFrame:frame];
    
    NSLog(@"Keyboard will show. Height: %f", keyboardHeight);
    // 在这里可以对键盘弹起进行处理，比如调整界面布局
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGRect frame = self.flutterContainer.view.frame;
    frame.origin.y = _flutterContainerViewOriginY;
    [self.flutterContainer.view setFrame:frame];
    
    NSLog(@"Keyboard will hide.");
    // 在这里可以对键盘隐藏进行处理
}

@end

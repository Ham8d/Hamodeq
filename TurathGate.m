// ╔══════════════════════════════════════════════╗
// ║   التراث ستور — TurathGate                   ║
// ║   عدّل السطور أدناه فقط                      ║
// ╚══════════════════════════════════════════════╝

// ── رمز الدخول (غيّره من هنا) ─────────────────
#define PASSCODE  @"123000"

// ── رابط تيليغرام ──────────────────────────────
#define TELEGRAM  @"https://t.me/turath_st"

// ── رابط الرمز (اتركه فارغاً إذا ما عندك رابط) ─
#define CODE_LINK @""

// ── اسم المتجر في الشاشة ──────────────────────
#define STORE_TITLE @"التراث ستور"

// ══════════════════════════════════════════════
//  لا تعدّل ما بعد هذا السطر
// ══════════════════════════════════════════════

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static UIWindow *_gw;

@interface TGVc : UIViewController
@property (strong) UITextField *f;
@end

@implementation TGVc

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat W = self.view.bounds.size.width;
    CGFloat cx = W/2;

    // خلفية
    CAGradientLayer *g = [CAGradientLayer layer];
    g.frame  = self.view.bounds;
    g.colors = @[(id)[UIColor colorWithRed:.03 green:.07 blue:.20 alpha:1].CGColor,
                 (id)[UIColor colorWithRed:.04 green:.11 blue:.28 alpha:1].CGColor,
                 (id)[UIColor colorWithRed:.02 green:.04 blue:.14 alpha:1].CGColor];
    g.locations = @[@0,@.5,@1];
    [self.view.layer insertSublayer:g atIndex:0];

    // نجوم
    for(int i=0;i<55;i++){
        CGFloat s=(arc4random_uniform(3)+1)*.5;
        UIView *v=[[UIView alloc]initWithFrame:CGRectMake(arc4random_uniform(W),arc4random_uniform(self.view.bounds.size.height*.7),s,s)];
        v.layer.cornerRadius=s/2;v.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:.4];
        [self.view addSubview:v];
    }

    // عنوان
    [self lb:STORE_TITLE font:[UIFont boldSystemFontOfSize:26] color:[UIColor whiteColor] y:80 cx:cx];
    [self lb:@"— TURATH STORE —" font:[UIFont systemFontOfSize:11] color:[UIColor colorWithRed:.4 green:.7 blue:1 alpha:.8] y:106 cx:cx];

    // لوغو
    UIView *lo=[[UIView alloc]initWithFrame:CGRectMake(cx-65,125,130,130)];
    lo.layer.cornerRadius=65;lo.layer.borderWidth=2.5;
    lo.layer.borderColor=[UIColor colorWithRed:.25 green:.5 blue:1 alpha:.8].CGColor;
    lo.backgroundColor=[UIColor colorWithRed:.06 green:.12 blue:.35 alpha:.9];
    lo.layer.shadowColor=[UIColor colorWithRed:.2 green:.5 blue:1 alpha:1].CGColor;
    lo.layer.shadowRadius=18;lo.layer.shadowOpacity=.8;lo.layer.shadowOffset=CGSizeZero;
    [self.view addSubview:lo];
    [self lb:@"★" font:[UIFont systemFontOfSize:62] color:[UIColor colorWithRed:.4 green:.7 blue:1 alpha:1] y:65 cx:65 in:lo];

    CGFloat m=24,fw=W-m*2,y=295;

    // حقل الرمز
    UIView *box=[[UIView alloc]initWithFrame:CGRectMake(m,y,fw,50)];
    box.backgroundColor=[UIColor colorWithRed:.07 green:.13 blue:.32 alpha:.85];
    box.layer.cornerRadius=12;box.layer.borderWidth=1.2;
    box.layer.borderColor=[UIColor colorWithRed:.3 green:.55 blue:1 alpha:.5].CGColor;
    [self.view addSubview:box];
    [self lb:@"🔒" font:[UIFont systemFontOfSize:18] color:nil y:14 cx:14 in:box];
    self.f=[[UITextField alloc]initWithFrame:CGRectMake(44,4,fw-54,42)];
    self.f.textColor=[UIColor whiteColor];self.f.tintColor=[UIColor colorWithRed:.4 green:.7 blue:1 alpha:1];
    self.f.textAlignment=NSTextAlignmentRight;self.f.secureTextEntry=YES;
    self.f.keyboardType=UIKeyboardTypeNumberPad;self.f.font=[UIFont systemFontOfSize:17];
    self.f.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"الرمـز"
        attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:1 alpha:.3]}];
    [box addSubview:self.f]; y+=58;

    // زر تأكيد
    UIButton *ok=[UIButton buttonWithType:UIButtonTypeCustom];
    ok.frame=CGRectMake(m,y,fw,50);ok.layer.cornerRadius=12;
    ok.backgroundColor=[UIColor colorWithRed:.1 green:.34 blue:.9 alpha:1];
    ok.layer.shadowColor=[UIColor colorWithRed:.1 green:.3 blue:1 alpha:1].CGColor;
    ok.layer.shadowRadius=10;ok.layer.shadowOpacity=.6;ok.layer.shadowOffset=CGSizeZero;
    [ok setTitle:@"✓  تأكيد الدخول" forState:0];ok.titleLabel.font=[UIFont boldSystemFontOfSize:17];
    [ok addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ok]; y+=65;

    // نص توجيه
    [self lb:@"للحصول على الرمز الرجاء الذهاب الى :" font:[UIFont systemFontOfSize:11]
      color:[UIColor colorWithWhite:1 alpha:.45] y:y cx:cx]; y+=26;

    // زر تيليغرام
    [self outBtn:CGRectMake(m,y,fw,50) title:@"   ✈  اولا - الانضمام في القناة" sel:@selector(tg)]; y+=58;

    // زر الرابط الثاني
    [self outBtn:CGRectMake(m,y,fw,50) title:@"   🔗  ثانيا - ادخل هنا للحصول على رمز الدخول" sel:@selector(lnk)];
}

// ── مساعدات ─────────────────────────────────────────────────────────────
- (void)lb:(NSString*)t font:(UIFont*)f color:(UIColor*)c y:(CGFloat)y cx:(CGFloat)cx {
    UILabel *l=[UILabel new]; l.text=t; l.font=f;
    l.textColor=c?:[UIColor clearColor]; l.textAlignment=NSTextAlignmentCenter;
    [l sizeToFit]; l.center=CGPointMake(cx,y); [self.view addSubview:l];
}
- (void)lb:(NSString*)t font:(UIFont*)f color:(UIColor*)c y:(CGFloat)y cx:(CGFloat)cx in:(UIView*)p {
    UILabel *l=[UILabel new]; l.text=t; l.font=f;
    l.textColor=c?:[UIColor clearColor]; l.textAlignment=NSTextAlignmentCenter;
    [l sizeToFit]; l.center=CGPointMake(cx,y); [p addSubview:l];
}
- (void)outBtn:(CGRect)r title:(NSString*)t sel:(SEL)s {
    UIButton *b=[UIButton buttonWithType:UIButtonTypeCustom]; b.frame=r;
    b.backgroundColor=[UIColor colorWithRed:.07 green:.12 blue:.30 alpha:.9];
    b.layer.cornerRadius=12; b.layer.borderWidth=1;
    b.layer.borderColor=[UIColor colorWithRed:.2 green:.45 blue:.9 alpha:.4].CGColor;
    [b setTitle:t forState:0]; b.titleLabel.font=[UIFont systemFontOfSize:13];
    b.titleLabel.numberOfLines=1;
    [b addTarget:self action:s forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
}

// ── أحداث ────────────────────────────────────────────────────────────────
- (void)confirm {
    if ([self.f.text isEqualToString:PASSCODE]) {
        [UIView animateWithDuration:.35 animations:^{ self.view.alpha=0; }
                         completion:^(BOOL d){ _gw.hidden=YES; _gw=nil; }];
    } else {
        self.f.text=@"";
        CAKeyframeAnimation *a=[CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        a.values=@[@(-12),@(12),@(-8),@(8),@(-4),@(4),@0]; a.duration=.4;
        [self.f.superview.layer addAnimation:a forKey:nil];
    }
}
- (void)tg  { [[UIApplication sharedApplication] openURL:[NSURL URLWithString:TELEGRAM] options:@{} completionHandler:nil]; }
- (void)lnk { if(CODE_LINK.length) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:CODE_LINK] options:@{} completionHandler:nil]; }
- (UIStatusBarStyle)preferredStatusBarStyle { return UIStatusBarStyleLightContent; }
@end

// ── Constructor ──────────────────────────────────────────────────────────
__attribute__((constructor)) static void TGInit(void) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(.1*NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        if(_gw) return;
        UIWindowScene *sc=nil;
        for(UIScene *s in UIApplication.sharedApplication.connectedScenes)
            if([s isKindOfClass:UIWindowScene.class]){sc=(UIWindowScene*)s;break;}
        _gw = sc?[[UIWindow alloc]initWithWindowScene:sc]
               :[[UIWindow alloc]initWithFrame:UIScreen.mainScreen.bounds];
        _gw.windowLevel=UIWindowLevelAlert+999;
        _gw.rootViewController=[TGVc new];
        _gw.hidden=NO;
        [_gw makeKeyAndVisible];
    });
}

//
//  PersonInfoViewController.m
//  Globefish
//
//  Created by 草帽~小子 on 2019/10/13.
//  Copyright © 2019 OnePiece. All rights reserved.
//

#import "PersonInfoViewController.h"

@interface PersonInfoViewController ()

@property (nonatomic, strong) UIScrollView *backScrollV;
@property (nonatomic, strong) UIButton *headPortrait;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) UITextField *textFd1;
@property (nonatomic, strong) UITextView *textFd2;

@property (nonatomic, strong) NSArray *tagArr;
@property (nonatomic, strong) NSMutableArray *selectArr;

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人信息";
    
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
    NSDictionary *para = @{@"userid":userid};
    [[HWAFNetworkManager shareManager] userInfo:para getUserInfo:^(BOOL success, id  _Nonnull request) {
        if (success) {
            if (![HWUtil isBlankString:request[@"username"]]) {
                self.textFd1.text = request[@"username"];
            }
            if (![HWUtil isBlankString:request[@"userprofile"]]) {
                self.textFd2.text = request[@"userprofile"];
            }
            
        }
    }];
    
    //创建一个UIButton
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
    //设置UIButton的图像
    [backButton setImage:[UIImage imageNamed:@"turnleft"] forState:UIControlStateNormal];
    [[backButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    //覆盖返回按键
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)setupSubViews {
    
    self.backScrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, [HWStyle navigationbarHeight], KSCREEN_WIDTH, KSCREEN_HEIGHT - [HWStyle navigationbarHeight] - [HWStyle toolbarHeight])];
    self.backScrollV.contentSize = CGSizeMake(KSCREEN_WIDTH, KSCREEN_HEIGHT);
    self.backScrollV.userInteractionEnabled = YES;
    [self.view addSubview:self.backScrollV];
    
    self.headPortrait = [UIButton buttonWithType:UIButtonTypeCustom];
    self.headPortrait.frame = CGRectMake((KSCREEN_WIDTH - 100) / 2, 20, 100, 100);
    [self.backScrollV addSubview:self.headPortrait];
    [self.headPortrait setBackgroundImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [[self.headPortrait rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __block typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf selectedImageForIcon];
    }];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(10, self.headPortrait.bottom + 30, 80, 40)];
    lab1.textColor = KColor_212121;
    lab1.font = KFontNormalSize14;
    lab1.text = @"昵    称";
    [self.backScrollV addSubview:lab1];
    
    self.textFd1 = [[UITextField alloc] initWithFrame:CGRectMake(lab1.right, lab1.top, KSCREEN_WIDTH - 10 * 2, lab1.height)];
    self.textFd1.placeholder = @"请输入昵称（不得超过10个字）";
    self.textFd1.font = KFontNormalSize10;
    [self.backScrollV addSubview:self.textFd1];
    //    textFd1.layer.borderColor = LIGHTGRAYCOLOR.CGColor;
    //    textFd1.layer.borderWidth = KLineWidthMeasure05;
    
    [[self.textFd1 rac_textSignal] subscribeNext:^(id x) {
        NSString *str = [NSString stringWithFormat:@"%@", x];
        if (str.length >= 10) {
            str = [str substringToIndex:10];
        }
    }];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(10, self.textFd1.bottom, KSCREEN_WIDTH - 10 * 2, KLineWidthMeasure05)];
    line1.backgroundColor = KColor_Line;
    [self.backScrollV addSubview:line1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(10, lab1.bottom + 10, lab1.width, lab1.height)];
    lab2.textColor = KColor_212121;
    lab2.font = KFontNormalSize14;
    lab2.text = @"个性签名";
    [self.backScrollV addSubview:lab2];
    
    self.textFd2 = [[UITextView alloc] initWithFrame:CGRectMake(lab1.left, lab2.bottom + 10, KSCREEN_WIDTH - 10 * 2, 50)];
    self.textFd2.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    //self.textFd2.text = @"请输入个性签名（不得超过50个字）";
    self.textFd2.textAlignment = NSTextAlignmentCenter;
    self.textFd2.font = KFontNormalSize12;
    [self.backScrollV addSubview:self.textFd2];
    [[self.textFd2 rac_textSignal] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSString *str = [NSString stringWithFormat:@"%@", x];
        if (str.length >= 50) {
            str = [str substringToIndex:50];
        }
        
    }];
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(10, self.textFd2.bottom + 20, 80, 40)];
    lab3.textColor = KColor_212121;
    lab3.font = KFontNormalSize14;
    lab3.text = @"个人标签";
    [self.backScrollV addSubview:lab3];
    
    UILabel *lab33 = [[UILabel alloc] initWithFrame:CGRectMake(lab3.right, lab3.bottom - 20, 100, 20)];
    lab33.textColor = KColor_212121;
    lab33.font = KFontNormalSize12;
    lab33.text = @"（最多选择三个）";
    [self.backScrollV addSubview:lab33];
    
    CGFloat wid = (KSCREEN_WIDTH - 10 * 6) / 5;
    CGFloat hig = 23;
    for (NSInteger i = 0; i < self.tagArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10 + (i % 5) * (wid + 10), lab3.bottom + 20 + (i / 5) * (hig + 10), wid, hig);
        btn.backgroundColor = [UIColor whiteColor];
        //        btn.layer.cornerRadius = 2;
        //        btn.layer.masksToBounds = YES;
        btn.titleLabel.font = KFontNormalSize12;
        //[UIView HWShadowDraw:btn shadowColor:KColorGradient_light shadowOffset:CGSizeMake(0, 2) shadowOpacity:0.5 shadowRadius:1];
        [self.backScrollV addSubview:btn];
        [btn setTitle:self.tagArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:KColor_212121 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton *login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(95, self.backScrollV.height - 100, KSCREEN_WIDTH - 95 * 2, 40);
    login.layer.cornerRadius = 20;
    login.layer.masksToBounds = YES;
    [self.backScrollV addSubview:login];
    [login setTitle:@"确 定" forState:UIControlStateNormal];
    [login setTintColor:[UIColor whiteColor]];
    [HWUtil gradientLayer:login startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) colorArr1:KColorGradient_dark colorArr2:KColorGradient_light location1:0 location2:0];
    [[login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if (strongSelf.selectArr.count > 3) {
            //[HWPorgressHUD HWHudShowStatus:@"最多只能选择3个标签!"];
            return ;
        }
        
        NSString *userid = [NSUserDefaultMemory defaultGetwithUnityKey:USERID];
        //userid （必须传）usertel,useremail,userpassword, userimg,username,userprofile,cardone,cardtwo,cardthree
        NSDictionary *para = @{@"userid":[HWUtil isBlankString:userid]?@"":[HWUtil isBlankString:userid]?@"":userid,
                               @"username":[HWUtil isBlankString:self.textFd1.text]?@"":self.textFd1.text,
                               @"userprofile":[HWUtil isBlankString:strongSelf.textFd2.text]?@" ":strongSelf.textFd2.text,
                               @"cardone":(strongSelf.selectArr.count==1)?strongSelf.selectArr[0]:@"",
                               @"cardtwo":strongSelf.selectArr.count==2?strongSelf.selectArr[1]:@"",
                               @"cardthree":strongSelf.selectArr.count==3?strongSelf.selectArr[2]:@"",
                               };
        [[HWAFNetworkManager shareManager] userInfo:para postUserInfo:^(BOOL success, id  _Nonnull request) {
            if (success) {
                [SVProgressHUD showWithStatus:request[@"statusMessage"]];
                [SVProgressHUD dismissWithDelay:1];
                if ([request[@"statusMessage"] isEqualToString:@"更新成功"]) {
                    [strongSelf.navigationController popViewControllerAnimated:YES];
                }
            }
        }];
        
//        if (strongSelf.personalInfoBlock) {
//            strongSelf.personalInfoBlock(strongSelf.textFd1.text, strongSelf.textFd2.text, strongSelf.selectArr);
//        }
    }];
    
    UITapGestureRecognizer *regisFirst = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerTextField:)];
    [self.backScrollV addGestureRecognizer:regisFirst];
    
}

-(void)selectedImageForIcon
{
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCamera=[UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *actionPhotoLIbrary=[UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *actionPhotoAlbum=[UIAlertAction actionWithTitle:@"打开图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:actionCamera];
    
    [alertController addAction:actionPhotoAlbum];
    
    [alertController addAction:actionPhotoLIbrary];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)btnAction:(UIButton *)send {
    send.selected = !send.selected;
    if (send.selected) {
        if (self.selectArr.count <= 2) {
            [self.selectArr addObject:send.titleLabel.text];
            send.backgroundColor = KColorGradient_light;
        }else {
            //[HWPorgressHUD HWHudShowStatus:@"最多选择三个标签！"];
            send.backgroundColor = [UIColor whiteColor];
        }
    }else {
        if (self.selectArr.count > 0) {
            for (NSString *str in self.selectArr) {
                if ([str isEqualToString:send.titleLabel.text]) {
                    //[self.selectArr removeObject:str];
                }
            }
        }
        send.backgroundColor = [UIColor whiteColor];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [self.headPortrait setBackgroundImage:info[@"UIImagePickerControllerOriginalImage"] forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark getter

- (UIImagePickerController *)imagePickerController {
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}

- (NSArray *)tagArr {
    if (!_tagArr) {
        _tagArr = @[@"会英语", @"沟通能力强",@"责任心强",@"阳光",@"勤奋",@"潮流",@"效率高",@"团队能力",@"执行力",@"亲和力",@"激情",];
    }
    return _tagArr;
}

- (NSArray *)selectArr {
    if (!_selectArr) {
        _selectArr = [[NSMutableArray alloc] init];
    }
    return _selectArr;
}

- (void)registerTextField:(UITextField *)tx {
    if (self.textFd2.text.length == 0) {
        self.textFd2.text = @"请输入个性签名（不得超过50个字）";
    }
    [self.textFd1 resignFirstResponder];
    [self.textFd2 resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

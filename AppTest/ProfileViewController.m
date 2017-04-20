//
//  ProfileViewController.m
//  AppTest
//
//  Created by Rafael Perez on 3/7/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "ProfileViewController.h"
#import "VKSideMenu.h"
#import "UIViewController+SLPhotoSelection.h"
#import "FDKeyChain.h"
#import "User.h"
#import "ChangePasswordViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface ProfileViewController ()<VKSideMenuDelegate, VKSideMenuDataSource, UIAlertViewDelegate>
@property (nonatomic, strong) VKSideMenu *menuLeft;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) User *user;

@end

@implementation ProfileViewController
NSString *loggedIn;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoBixi2ß"]];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fondo"] forBarMetrics:UIBarMetricsDefault];
     _user = [[User alloc]init];
     self.menuLeft = [[VKSideMenu alloc] initWithSize:280 andDirection:VKSideMenuDirectionFromLeft];
     self.menuLeft.dataSource = self;
     self.menuLeft.delegate   = self;
     [self.menuLeft addSwipeGestureRecognition:self.view];
      self.menuLeft.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    NSString *token =[FDKeychain itemForKey:@"usertoken" forService:@"BIXI" inAccessGroup:nil error:nil];

    //**GET USER**
        NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/index.php/restserver/user/"];
        NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
        [rq setHTTPMethod:@"GET"];
    
     
        [rq setValue:token forHTTPHeaderField:@"X-Request-Id"];
        [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //[rq setValue:[NSString stringWithFormat:@"%ld", (long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
        [NSURLConnection sendAsynchronousRequest:rq
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response,
                                                   NSData *data, NSError *connectionError)
         {
             NSError* error;
             NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                  options:kNilOptions
                                                                    error:&error];
             NSArray *sceResponseCode = [json objectForKey:@"sceResponseCode"];
    
             NSLog(@"codigo: %@", sceResponseCode);
             NSString *message = [json objectForKey:@"sceResponseMsg"];
             NSArray *result = [json objectForKey:@"result"];
             NSDictionary *holis = [json objectForKey:@"result"];
             NSLog(@"%@",result);
             if ([message isEqualToString:@"OK"]) {
                 
                     _user.firstName = [holis objectForKey:@"first_name"];
                     _user.lastName = [holis objectForKey:@"last_name"];
                     _user.phone1 = [holis objectForKey:@"phone1"];
                     _user.phone2 = [holis objectForKey:@"phone2"];
                     _user.documentId = [holis objectForKey:@"document_id"];
                     _user.address = [holis objectForKey:@"address"];
                     _user.gender = [holis objectForKey:@"gender"];
                     _user.email = [holis objectForKey:@"email"];
                     _user.birthDate = [holis objectForKey:@"birth_date"];
                     _user.image = [holis objectForKey:@"image"];
                     _user.balancePoints = [holis objectForKey:@"balance_points"];
                 _lblUserName.text = [NSString stringWithFormat:@"%@ %@",_user.firstName, _user.lastName];
                 _lblPoints.text = [NSString stringWithFormat:@"%@ B", _user.balancePoints ];
                 _lblEmail.text = _user.email;
                 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                 [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                 NSDate *orignalDate   =  [dateFormatter dateFromString:_user.birthDate];
                 
                 [dateFormatter setDateFormat:@"MMMM dd, yyyy"];
                 NSString *finalString = [dateFormatter stringFromDate:orignalDate];
                 _lblBirthDate.text = finalString;
                 _lblGender.text = _user.gender;
                 _lblPhone1.text = _user.phone1;
       
                 
                 
                 NSLog(@"codigo: %@", result);
             }

             [_imageView sd_setImageWithURL:[NSURL URLWithString:self.user.image]
                                 placeholderImage:[UIImage imageNamed:@"Garage-50"]];
         }];
    
    
    
}

-(IBAction)callHome:(id)sender{
    [self performSegueWithIdentifier:@"callHomeProfile" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"callNewPassword"]) {
        ChangePasswordViewController *changePassViewController = [segue destinationViewController];
        //     [cell getCurrentIndex];
        changePassViewController.user= self.user;
        
    }
    
    
}


-(IBAction)buttonMenuLeft:(id)sender
{
    [self.menuLeft show:self.navigationController.view];
}

#pragma mark - SLPhotoSelection methods

- (IBAction)addImageView:(id)sender
{
    __weak UIImageView *imageView = self.imageView;
    
    [self addPhotoWithCompletionHandler:^(BOOL success, UIImage *image) {
        if (success) {
             NSString *token =[FDKeychain itemForKey:@"usertoken" forService:@"BIXI" inAccessGroup:nil error:nil];
            NSString *imagen = [self encodeToBase64String:image];
            NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                            NULL,
                                                                                                            (CFStringRef)imagen,
                                                                                                            NULL,
                                                                                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                            kCFStringEncodingUTF8 ));
            //NSLog(@"%@",imagen);
            imageView.image = image;
            //imagen = [imagen stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
            
            NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/index.php/restserver/user/"];
            NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
            [rq setHTTPMethod:@"POST"];
            
            NSData *jsonData = [[NSString stringWithFormat:@"{\"first_name\":\"%@\",\"last_name\":\"%@\",\"document_id\":\"%@\",\"phone1\":\"%@\",\"phone2\":\"%@\",\"address\":\"%@\",\"gender\":\"%@\",\"email\":\"%@\",\"birth_date\":\"%@\",\"image\":\"%@\",\"old_password\":\"radapepi030291\"}", self.user.firstName, self.user.lastName, self.user.documentId, self.user.phone1, self.user.phone2, self.user.address, self.user.gender, self.user.email,self.user.birthDate, encodedString] dataUsingEncoding:NSUTF8StringEncoding];
            [rq setHTTPBody:jsonData];
            [rq setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Data-Type"];
            [rq setValue:token forHTTPHeaderField:@"X-Request-Id"];
            [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            //[rq setValue:[NSString stringWithFormat:@"%ld", (long)[jsonData length]] forHTTPHeaderField:@"Content-Length"];
            [NSURLConnection sendAsynchronousRequest:rq
                                               queue:[NSOperationQueue mainQueue]
                                   completionHandler:^(NSURLResponse *response,
                                                       NSData *data, NSError *connectionError)
             {
                 NSError* error;
                 NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:kNilOptions
                                                                        error:&error];
                 NSNumber *sceResponseCode = [json objectForKey:@"sceResponseCode"];
                 NSString *sceResponseMsg = [json objectForKey:@"sceResponseMsg"];
                 
                 if ([sceResponseCode longLongValue]==0) {
                     
                 
                 }
             }];

        }
    }];
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma mark - VKSideMenuDataSource

-(NSInteger)numberOfSectionsInSideMenu:(VKSideMenu *)sideMenu
{
    return (sideMenu == self.menuLeft) ? 1 : 2;
}

-(NSInteger)sideMenu:(VKSideMenu *)sideMenu numberOfRowsInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft)
        return 7;
    
    return section == 0 ? 1 : 2;
}

-(VKSideMenuItem *)sideMenu:(VKSideMenu *)sideMenu itemForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This solution is provided for DEMO propose only
    // It's beter to store all items in separate arrays like you do it in your UITableView's. Right?
    VKSideMenuItem *item = [VKSideMenuItem new];
    
    loggedIn = [FDKeychain itemForKey: @"loggedin"
                           forService: @"BIXI"
                                error: nil];
    if ([loggedIn isEqualToString:@"YES"]){
        
        if (sideMenu == self.menuLeft) // All LEFT and TOP menu items
        {
            switch (indexPath.row)
            {
                case 0:
                    item.title = @"Inicio";
                    item.icon  = [UIImage imageNamed:@"Home-50"];
                    break;
                    
                case 1:
                    item.title = @"Mi Perfil";
                    item.icon  = [UIImage imageNamed:@"ic_option_1"];
                    break;
                    
                case 2:
                    item.title = @"Agregar Puntos";
                    item.icon  = [UIImage imageNamed:@"Add-50"];
                    
                    break;
                    
                case 3:
                    item.title = @"Ofertas que me gustan";
                    item.icon  = [UIImage imageNamed:@"Like-50"];
                    break;
                    
                case 4:
                    item.title = @"Ofertas cerca de mí";
                    item.icon  = [UIImage imageNamed:@"Near Me-50"];
                    break;
                    
                case 5:
                    item.title = @"Transacciones";
                    item.icon  = [UIImage imageNamed:@"Transaction List-50"];
                    
                    break;
                    
                case 6:
                    item.title = @"Salir";
                    item.icon  = [UIImage imageNamed:@"Exit-50"];
                    break;
                    
                default:
                    break;
            }
        }
        else if (indexPath.section == 0) // RIGHT menu first section items
        {
            item.title = @"Login";
        }
        else // RIGHT menu second section items
        {
            switch (indexPath.row)
            {
                case 0:
                    item.title = @"Like";
                    break;
                    
                case 1:
                    item.title = @"Share";
                    break;
                default:
                    break;
            }
        }
    }
    else{
        if (sideMenu == self.menuLeft) // All LEFT and TOP menu items
        {
            switch (indexPath.row)
            {
                case 0:
                    item.title = @"Inicio";
                    item.icon  = [UIImage imageNamed:@"Home-50"];
                    break;
                    
                case 1:
                    item.title = @"Mi Perfil";
                    item.icon  = [UIImage imageNamed:@"ic_option_1"];
                    break;
                    
                case 2:
                    item.title = @"Agregar Puntos";
                    item.icon  = [UIImage imageNamed:@"Add-50"];
                    
                    break;
                    
                case 3:
                    item.title = @"Ofertas que me gustan";
                    item.icon  = [UIImage imageNamed:@"Like-50"];
                    break;
                    
                case 4:
                    item.title = @"Ofertas cerca de mí";
                    item.icon  = [UIImage imageNamed:@"Near Me-50"];
                    break;
                    
                case 5:
                    item.title = @"Transacciones";
                    item.icon  = [UIImage imageNamed:@"Transaction List-50"];
                    
                    break;
                    
                case 6:
                    item.title = @"Iniciar Sesión";
                    item.icon  = [UIImage imageNamed:@"Circled User Male-50"];
                    break;
                    
                default:
                    break;
            }
        }
        else if (indexPath.section == 0) // RIGHT menu first section items
        {
            item.title = @"Login";
        }
        else // RIGHT menu second section items
        {
            switch (indexPath.row)
            {
                case 0:
                    item.title = @"Like";
                    break;
                    
                case 1:
                    item.title = @"Share";
                    break;
                default:
                    break;
            }
        }
        
    }
    
    
    return item;
}

#pragma mark - VKSideMenuDelegate

-(void)sideMenu:(VKSideMenu *)sideMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row ==0) {
//        [self performSegueWithIdentifier:@"callHomeProfile" sender:self];
//    }
//    if (indexPath.row == 1) {
//        [self performSegueWithIdentifier:@"callProfile" sender:self];
//    }
//    if (indexPath.row ==2) {
//        [self performSegueWithIdentifier:@"callMap" sender:self];
//    }
//    if (indexPath.row ==4) {
//       // [self logOut:self];
//    }
//    NSLog(@"SideMenu didSelectRow: %@", indexPath);
    
    loggedIn = [FDKeychain itemForKey: @"loggedin"
                           forService: @"BIXI"
                                error: nil];
    if ([loggedIn isEqualToString:@"YES"]){
        if (indexPath.row ==0) {
            [self performSegueWithIdentifier:@"callHomeProfile" sender:self];
        }
        if (indexPath.row == 1) {
            //[self performSegueWithIdentifier:@"callProfile" sender:self];
        }
        if (indexPath.row ==2) {
            [self performSegueWithIdentifier:@"callAddPointsProfile" sender:self];
            
            //        [self dismissViewControllerAnimated:YES completion:nil];
            //        [self removeFromParentViewController];
            //        [self.view removeFromSuperview];
        }
        if (indexPath.row == 3) {
            [self performSegueWithIdentifier:@"callLikedOffersProfile" sender:self];
        }
        
        if (indexPath.row ==6) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"Salir"
                                  message: @"Está seguro que desea salir de BIXI?"
                                  delegate: self
                                  cancelButtonTitle:@"NO"
                                  otherButtonTitles:@"SI",nil];
            [alert show];
            
        }
        if (indexPath.row == 5) {
            [self performSegueWithIdentifier:@"callTransactionsProfile" sender:self];
        }
        NSLog(@"SideMenu didSelectRow: %@", indexPath);
    }
    else{
        if (indexPath.row ==0) {
            
        }
        if (indexPath.row == 1) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"BIXI"
                                  message: @"Debe iniciar sesión o registrarse"
                                  delegate: self
                                  cancelButtonTitle:@"Cancelar"
                                  otherButtonTitles:@"Aceptar",nil];
            [alert show];
            //[self performSegueWithIdentifier:@"callProfile" sender:self];
        }
        if (indexPath.row ==2) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"BIXI"
                                  message: @"Debe iniciar sesión o registrarse"
                                  delegate: self
                                  cancelButtonTitle:@"Cancelar"
                                  otherButtonTitles:@"Aceptar",nil];
            [alert show];
            //[self performSegueWithIdentifier:@"callFavorites" sender:self];
            
            //        [self dismissViewControllerAnimated:YES completion:nil];
            //        [self removeFromParentViewController];
            //        [self.view removeFromSuperview];
        }
        if (indexPath.row == 3) {
            [self performSegueWithIdentifier:@"callMapProfile" sender:self];
        }
        
        if (indexPath.row ==4) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"BIXI"
                                  message: @"Debe iniciar sesión o registrarse"
                                  delegate: self
                                  cancelButtonTitle:@"Cancelar"
                                  otherButtonTitles:@"Aceptar",nil];
            [alert show];
            
        }
        if (indexPath.row == 5) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"BIXI"
                                  message: @"Debe iniciar sesión o registrarse"
                                  delegate: self
                                  cancelButtonTitle:@"Cancelar"
                                  otherButtonTitles:@"Aceptar",nil];
            [alert show];
            //[self performSegueWithIdentifier:@"callTransactions" sender:self];
        }
        
        if (indexPath.row == 6) {
            [self performSegueWithIdentifier:@"callRegisterProfile" sender:self];
        }
        NSLog(@"SideMenu didSelectRow: %@", indexPath);
        
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView.title isEqualToString:@"BIXI"]) {
        if (buttonIndex == 1) {
            [self performSegueWithIdentifier:@"callRegisterHome" sender:self];
        }
        else {
            
        }
    }
    else{
        if (buttonIndex == 1) {
            [self logOut:self];
        }
        else {
            
        }
    }
}

-(IBAction)logOut:(id)sender{
    [FDKeychain saveItem:@"NO" forKey:@"loggedin" forService:@"BIXI" error:nil];
    [FDKeychain deleteItemForKey:@"usertoken" forService:@"BIXI" error:nil];
//    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
//    [loginManager logOut];
//    
//    [FBSDKAccessToken setCurrentAccessToken:nil];
//    //[self performSegueWithIdentifier:@"backLogIn" sender:self];
//    [[GIDSignIn sharedInstance] signOut];
    [self performSegueWithIdentifier:@"callHomeProfile" sender:self];
}

-(void)sideMenuDidShow:(VKSideMenu *)sideMenu
{
    NSString *menu = @"";
    
    if (sideMenu == self.menuLeft)
        menu = @"LEFT";
    
    
    NSLog(@"%@ VKSideMenue did show", menu);
}

-(void)sideMenuDidHide:(VKSideMenu *)sideMenu
{
    NSString *menu = @"";
    
    if (sideMenu == self.menuLeft)
        menu = @"LEFT";
    
    
    NSLog(@"%@ VKSideMenue did hide", menu);
}

-(NSString *)sideMenu:(VKSideMenu *)sideMenu titleForHeaderInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft)
        return nil;
    
    switch (section)
    {
        case 0:
            return @"Profile";
            break;
            
        case 1:
            return @"Actions";
            break;
            
        default:
            return nil;
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

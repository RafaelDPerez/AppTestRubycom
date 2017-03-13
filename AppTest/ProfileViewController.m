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

@interface ProfileViewController ()<VKSideMenuDelegate, VKSideMenuDataSource>
@property (nonatomic, strong) VKSideMenu *menuLeft;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) User *user;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_BIXI"]];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fondo"] forBarMetrics:UIBarMetricsDefault];
     _user = [[User alloc]init];
     self.menuLeft = [[VKSideMenu alloc] initWithSize:280 andDirection:VKSideMenuDirectionFromLeft];
     self.menuLeft.dataSource = self;
     self.menuLeft.delegate   = self;
     [self.menuLeft addSwipeGestureRecognition:self.view];
      self.menuLeft.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    NSString *token =[FDKeychain itemForKey:@"usertoken" forService:@"BIXI" inAccessGroup:nil error:nil];

    //**REGISTER**
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
                 _lblPoints.text = _user.balancePoints;
       
                 
                 
                 NSLog(@"codigo: %@", result);
             }

             
         }];
    
    
    
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
            imageView.image = image;
        }
    }];
}

#pragma mark - VKSideMenuDataSource

-(NSInteger)numberOfSectionsInSideMenu:(VKSideMenu *)sideMenu
{
    return (sideMenu == self.menuLeft) ? 1 : 2;
}

-(NSInteger)sideMenu:(VKSideMenu *)sideMenu numberOfRowsInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft)
        return 5;
    
    return section == 0 ? 1 : 2;
}

-(VKSideMenuItem *)sideMenu:(VKSideMenu *)sideMenu itemForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This solution is provided for DEMO propose only
    // It's beter to store all items in separate arrays like you do it in your UITableView's. Right?
    VKSideMenuItem *item = [VKSideMenuItem new];
    
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
                item.title = @"Ofertas que me gustan";
                item.icon  = [UIImage imageNamed:@"Like-50"];
                break;
                
            case 3:
                item.title = @"Configuración";
                item.icon  = [UIImage imageNamed:@"ic_option_4"];
                break;
                
            case 4:
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
    
    return item;
}

#pragma mark - VKSideMenuDelegate

-(void)sideMenu:(VKSideMenu *)sideMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        [self performSegueWithIdentifier:@"callHomeProfile" sender:self];
    }
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"callProfile" sender:self];
    }
    if (indexPath.row ==2) {
        [self performSegueWithIdentifier:@"callMap" sender:self];
    }
    if (indexPath.row ==4) {
       // [self logOut:self];
    }
    NSLog(@"SideMenu didSelectRow: %@", indexPath);
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

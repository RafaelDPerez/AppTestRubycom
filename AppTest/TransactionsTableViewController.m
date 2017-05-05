//
//  TransactionsTableViewController.m
//  AppTest
//
//  Created by Rafael Perez on 3/26/17.
//  Copyright © 2017 Rafael Perez. All rights reserved.
//

#import "TransactionsTableViewController.h"
#import "Transaction.h"
#import "FDKeyChain.h"
#import "TransactionsTableViewCell.h"
#import "VKSideMenu.h"
#import "FDKeyChain.h"
@interface TransactionsTableViewController ()<VKSideMenuDelegate, VKSideMenuDataSource, UIAlertViewDelegate>
@property (nonatomic, strong) VKSideMenu *menuLeft;
@end

@implementation TransactionsTableViewController
NSString *loggedInTransactions;
@synthesize TransactionArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = self.view.center;
    [self.view addSubview:spinner];
    [spinner startAnimating];
    self.menuLeft = [[VKSideMenu alloc] initWithSize:280 andDirection:VKSideMenuDirectionFromLeft];
    self.menuLeft.dataSource = self;
    self.menuLeft.delegate   = self;
    [self.menuLeft addSwipeGestureRecognition:self.navigationController.view];
    self.menuLeft.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoBixi2"]];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"fondo"] forBarMetrics:UIBarMetricsDefault];
    TransactionArray = [[NSMutableArray alloc]init];
    NSString *token =[FDKeychain itemForKey:@"usertoken" forService:@"BIXI" inAccessGroup:nil error:nil];
    
    
    NSURL *url = [NSURL URLWithString:@"http://rubycom.net/bocetos/DEMO-BIXI/restserver/historical/"];
    NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
    [rq setHTTPMethod:@"POST"];
    
    
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
        // NSArray *sceResponseCode = [json objectForKey:@"sceResponseCode"];
          NSNumber *sceResponseCode = [json objectForKey:@"sceResponseCode"];
        // NSLog(@"codigo: %@", sceResponseCode);
         NSString *message = [json objectForKey:@"sceResponseMsg"];
         NSArray *result = [json objectForKey:@"result"];
         NSDictionary *holis = [json objectForKey:@"result"];
         NSLog(@"%@",result);
         if ([sceResponseCode longLongValue]==1) {
             UIAlertView *alert = [[UIAlertView alloc]
                                   initWithTitle: @"BIXI"
                                   message: @"Debe iniciar sesión o registrarse"
                                   delegate: self
                                   cancelButtonTitle:@"Cancelar"
                                   otherButtonTitles:@"Aceptar",nil];
             [alert show];
         }
         if ([message isEqualToString:@"OK"]) {
             NSArray *result = [json objectForKey:@"result"];
             if ([result count]>0) {
             for (int i = 0; i<= result.count - 1; i++) {
                 //now let's dig out each and every json object
                 Transaction *trans = [[Transaction alloc]init];
                 
                 NSDictionary *dict3 = [result objectAtIndex:i];
                 trans.TransactionCommerce = [dict3 objectForKey:@"commerce_name"];
                 trans.TransactionDescription = [dict3 objectForKey:@"description"];
                 trans.TransactionPoints = [dict3 objectForKey:@"points"];
                 trans.TransactionDate = [dict3 objectForKey:@"cdate"];
                 trans.TransactionType = [dict3 objectForKey:@"type"];
                 [TransactionArray addObject:trans];
                 [self.tableView reloadData];
                 }
                 
             }
         [spinner stopAnimating];
         }
         
         
     }];

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    loggedInTransactions = [FDKeychain itemForKey: @"loggedin"
                           forService: @"BIXI"
                                error: nil];
    if ([loggedInTransactions isEqualToString:@"YES"]){
        
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
    
    loggedInTransactions = [FDKeychain itemForKey: @"loggedin"
                           forService: @"BIXI"
                                error: nil];
    if ([loggedInTransactions isEqualToString:@"YES"]){
        if (indexPath.row ==0) {
            [self performSegueWithIdentifier:@"callHomeTransactions" sender:self];
        }
        if (indexPath.row == 1) {
            [self performSegueWithIdentifier:@"callProfileTransactions" sender:self];
        }
        if (indexPath.row ==2) {
            [self performSegueWithIdentifier:@"callAddPointsTransactions" sender:self];
            
            //        [self dismissViewControllerAnimated:YES completion:nil];
            //        [self removeFromParentViewController];
            //        [self.view removeFromSuperview];
        }
        if (indexPath.row == 3) {
            [self performSegueWithIdentifier:@"callFavoritesTransactions" sender:self];
        }
        if (indexPath.row == 4) {
            [self performSegueWithIdentifier:@"callMapTransactions" sender:self];
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
          //  [self performSegueWithIdentifier:@"callTransactions" sender:self];
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
            [self performSegueWithIdentifier:@"callMap" sender:self];
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
            [self performSegueWithIdentifier:@"callRegisterHome" sender:self];
        }
        NSLog(@"SideMenu didSelectRow: %@", indexPath);
        
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView.title isEqualToString:@"BIXI"]) {
        if (buttonIndex == 1) {
            [self performSegueWithIdentifier:@"callRegisterTransaction" sender:self];
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


-(IBAction)logOut:(id)sender{
    [FDKeychain saveItem:@"NO" forKey:@"loggedin" forService:@"BIXI" error:nil];
    [FDKeychain deleteItemForKey:@"usertoken" forService:@"BIXI" error:nil];
//    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
//    [loginManager logOut];
//    
//    [FBSDKAccessToken setCurrentAccessToken:nil];
//    //[self performSegueWithIdentifier:@"backLogIn" sender:self];
//    [[GIDSignIn sharedInstance] signOut];
     [self performSegueWithIdentifier:@"callHomeTransactions" sender:self];
}




-(IBAction)buttonMenuLeft:(id)sender
{
    [self.menuLeft show:self.navigationController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if ([TransactionArray count]==0) {
        return 0;
    }
    else
    return [TransactionArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransactionsTableViewCell *cell = (TransactionsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"transCell" forIndexPath:indexPath];
    Transaction *trans = [[Transaction alloc]init];
    trans = [TransactionArray objectAtIndex:indexPath.row];
    cell.lblOfferName.text = trans.TransactionCommerce;
    cell.lblOfferdate.text = trans.TransactionDate;
    if ([trans.TransactionType isEqualToString:@"DEBITO"]) {
        cell.lblOfferPoints.text = [NSString stringWithFormat:@"-%@",trans.TransactionPoints];
    }
    else
        cell.lblOfferPoints.text = [NSString stringWithFormat:@"+%@",trans.TransactionPoints];
    cell.lblOfferDescription.text = trans.TransactionDescription;
 
   
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

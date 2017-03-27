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
@interface TransactionsTableViewController ()

@end

@implementation TransactionsTableViewController
@synthesize TransactionArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_BIXI"]];
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
         NSArray *sceResponseCode = [json objectForKey:@"sceResponseCode"];
         
         NSLog(@"codigo: %@", sceResponseCode);
         NSString *message = [json objectForKey:@"sceResponseMsg"];
         NSArray *result = [json objectForKey:@"result"];
         NSDictionary *holis = [json objectForKey:@"result"];
         NSLog(@"%@",result);
         if ([message isEqualToString:@"OK"]) {
             NSArray *result = [json objectForKey:@"result"];
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
                 
             }
         }
                  
     }];

    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

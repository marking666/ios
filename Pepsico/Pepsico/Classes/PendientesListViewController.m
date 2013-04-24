//
//  PendientesListViewController.m
//  Pepsico
//
//  Created by marking daniel cuevas ceron on 19/04/13.
//  Copyright (c) 2013 marking daniel cuevas ceron. All rights reserved.
//

#import "PendientesListViewController.h"
#import "PendienteDetailViewController.h"

@interface PendientesListViewController ()
 

@end

@implementation PendientesListViewController
 
 @synthesize customImage = _customImage;
 @synthesize pendientes = _pendientes;
 @synthesize responseData = _responseData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    responseData = [NSMutableData data];
    //pendientesJson.do
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://vanjaweb.dyndns.org:8080/pepsicoMobile/pendientesJson.do"]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self ];

   // HUD = [[MBProgressHUD alloc] initWithView:self.view];
	//[self.view addSubview:HUD];
    
    
    HUD.delegate = self;
   // HUD.labelText = @"Loading...";
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
	 
    NSString *user = [[NSUserDefaults standardUserDefaults]  stringForKey: @"userName"];
    NSString *password = [[NSUserDefaults standardUserDefaults]  stringForKey: @"password"];
    
    NSLog(user);
     NSLog(password);
    
     }


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
    currentLength = 0;
    HUD.mode = MBProgressHUDModeDeterminate;
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
    currentLength += [data length];
	HUD.progress = currentLength / (float)expectedLength;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed: %@", [error description]);
    	[HUD hide:YES];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSError* error;

    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData //1
                          
                          options:kNilOptions
                          error:&error];
   
 // NSLog(@"%@",json);
    NSArray *response = [json objectForKey:@"Pendientes"];
    
    self.pendientes = [[NSArray alloc] initWithArray:response];
      NSLog(@" self.pendientes %d",self.pendientes.count);
    
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	HUD.mode = MBProgressHUDModeCustomView;
	[HUD hide:YES afterDelay:2];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


 

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"SampleCell";
    
    NSDictionary *pendiente=[self.pendientes objectAtIndex:indexPath.row];
  
    //NSInteger nomina = [(NSNumber *) [json objectForKey:@"nomina"] integerValue];
    NSString *url= (NSString*)[pendiente objectForKey:@"url"];
      NSString *fechaInicio= (NSString*)[pendiente objectForKey:@"fechaInicio"];
      NSString *nombreEmpSolicita= (NSString*)[pendiente objectForKey:@"nombreEmpSolicita"];
       NSString *descripcionProceso= (NSString*)[pendiente objectForKey:@"descripcionProceso"];
     
    
    
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        UIImage	 *twitterLogo = [UIImage imageNamed:@"pepsi.png"];
        
        CGRect imageFrame = CGRectMake(2, 8, 40, 40);
        self.customImage = [[UIImageView alloc] initWithFrame:imageFrame];
        self.customImage.image = twitterLogo;
        [cell.contentView addSubview:self.customImage];
        
        CGRect contentFrame = CGRectMake(45, 2, 320, 30);
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:contentFrame];
        contentLabel.tag = 0011;
        contentLabel.numberOfLines = 2;
        contentLabel.font = [UIFont boldSystemFontOfSize:12];
        [cell.contentView addSubview:contentLabel];
        
        CGRect userFrame = CGRectMake(55, 30, 265, 10);
        
        UILabel *userLabel = [[UILabel alloc] initWithFrame:userFrame];
        userLabel.tag = 0012;
        userLabel.numberOfLines = 2;
        userLabel.font = [UIFont boldSystemFontOfSize:12];
        
        [cell.contentView addSubview:userLabel];
        
        CGRect dateFrame = CGRectMake(45, 50, 265, 10);
        UILabel *dateLabel = [[UILabel alloc] initWithFrame:dateFrame];
        dateLabel.tag = 0013;
        dateLabel.font = [UIFont systemFontOfSize:10];
        [cell.contentView addSubview:dateLabel];
    }
	
	UILabel *contentLabel = (UILabel *)[cell.contentView viewWithTag:0011];
    contentLabel.text = descripcionProceso;
	
	UILabel *userLabel = (UILabel *)[cell.contentView viewWithTag:0012];
    userLabel.text =  nombreEmpSolicita;
    
    UILabel *dateLabel = (UILabel *)[cell.contentView viewWithTag:0013];
    dateLabel.text =  fechaInicio;

 // cell.textLabel.text = [self.sampleItems objectAtIndex:indexPath.row];
    
    return cell;
}

- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
 
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
return self.pendientes.count;
}

 

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *pendiente=[self.pendientes objectAtIndex:indexPath.row];
    
    //NSInteger nomina = [(NSNumber *) [json objectForKey:@"nomina"] integerValue];
    NSString *url_= (NSString*)[pendiente objectForKey:@"url"];

    PendienteDetailViewController *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"pendienteDetail"];
    NSURL *url=[NSURL URLWithString:url_];
    
    detail.url=url;
    
    [self.navigationController pushViewController:detail animated:YES];
}
 

@end

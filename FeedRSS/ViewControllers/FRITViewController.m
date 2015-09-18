//
//  FRHomeViewController.m
//  FeedRSS
//
//  Created by KinhNM1 on 9/18/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRITViewController.h"
#import "FRDetailViewController.h"
#import "FRITBusinessController.h"
#import "HomeCell.h"

@interface FRITViewController ()
{
    FRITBusinessController *businessController;
}

@end

@implementation FRITViewController
@synthesize table;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([HomeCell class]) bundle:nil] forCellReuseIdentifier:@"HomeCell"];
    businessController = [[FRITBusinessController alloc] init];
    self.table.dataSource = businessController.dataSource;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    __weak __typeof(self)weakSelf = self;
    [businessController loadAllNews:^{
        [weakSelf.table reloadData];
    } failure:^(NSString *errorMessage) {
        //Alert
    }];
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

/**LIST VIEW*/


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 78;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"ViewITAction" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"prepareForSegue");
    
    if ([segue.identifier isEqualToString:@"ViewITAction"]) {
        
        NSIndexPath *indexPath = [self.table indexPathForSelectedRow];
        
        FRDetailViewController *destViewController = segue.destinationViewController;
        
        destViewController.Url = @"http://www.dantri.com.vn";
        
    }
    
}

@end

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
#import "FRNewsObject.h"
#import "FRITBusinessController.h"

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
    self.title =@"IT";
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
    //return self.posts.count;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [self performSegueWithIdentifier:@"ViewITAction" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 78;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"prepareForSegue");
    
    if ([segue.identifier isEqualToString:@"ViewITAction"]) {
        
        NSIndexPath *indexPath = [self.table indexPathForSelectedRow];
        FRNewsObject *newObj = [businessController.dataSource.news objectAtIndex:indexPath.row];
        FRDetailViewController *destViewController = segue.destinationViewController;
        destViewController.Url = newObj.link;
        
    }
    
}

@end

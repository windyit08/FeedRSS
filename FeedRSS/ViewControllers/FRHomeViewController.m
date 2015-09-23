//
//  FRHomeViewController.m
//  FeedRSS
//
//  Created by KinhNM1 on 9/18/15.
//  Copyright (c) 2015 Training. All rights reserved.
//

#import "FRHomeViewController.h"
#import "FRDetailViewController.h"
#import "HomeCell.h"
#import "FRNewsObject.h"
#import "FRHomeBusinessController.h"

@interface FRHomeViewController ()

@end

@implementation FRHomeViewController{
    
    FRHomeBusinessController *homeBusinessController;
    
}
@synthesize table;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Home";
    
    homeBusinessController = [[FRHomeBusinessController alloc] init];
    self.table.dataSource = homeBusinessController.dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    __weak __typeof(self)weakSelf = self;
    [homeBusinessController loadAllNews:^(){
        [weakSelf.table reloadData];
    } failure:^(NSString *errorMessage) {
        //Alert
    }];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    {
        HomeCell * cell = nil;
        static NSString *simpleTableIndentifier = @"HomeCell";
        cell = (HomeCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIndentifier];
        if(cell == nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomeCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
//        cell.nameLabel.text = newsObj.title;
        //cell.thumbnailImageView.contentMode = UIViewContentModeScaleToFill;
//        cell.thumbnailImageView.image = [UIImage imageNamed:@"husky.jpg"];

        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
// ThanhDM disable
//    UIAlertView *messageAlert = [[UIAlertView alloc]
//                                 initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [self performSegueWithIdentifier:@"ViewHomeAction" sender:self];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 78;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"prepareForSegue");
    if ([segue.identifier isEqualToString:@"ViewHomeAction"]) {
        NSIndexPath *indexPath = [self.table indexPathForSelectedRow];
        FRNewsObject *newObj = [homeBusinessController.dataSource.news objectAtIndex:indexPath.row];
        FRDetailViewController *destViewController = segue.destinationViewController;
        destViewController.Url = newObj.link;
    }
}

@end

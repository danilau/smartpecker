//
//  SPASubjectsViewController.m
//  SmartPecker
//
//  Created by majstrak on 05.05.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPASubjectsViewController.h"
#import "SPASubjectsTitleCell.h"
#import "SPASubjectsCell.h"
#import "SPASubjectAttributesViewController.h"
#import "SPAModelSubjectsActivationDelegate.h"
#import "SPAModelCoordinator.h"
#import "SPASubject.h"
#import "SPAAppDelegate.h"
#import "JASidePanelController.h"

@interface SPASubjectsViewController (){
    UIActivityIndicatorView *_indicator;
    __weak NSArray *subjects;
}

@end

@implementation SPASubjectsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.backgroundColor = [UIColor colorWithRed:153/255.0f green:125/255.0f blue:91/255.0f alpha:1];
    [self.tableView setSeparatorColor:[UIColor colorWithRed:92/255.0f green:77/255.0f blue:68/255.0f alpha:1]];
    [self.tableView registerNib:[UINib nibWithNibName:@"SPASubjectsTitleCell" bundle:nil] forCellReuseIdentifier:@"SubjectsTitleCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SPASubjectsCell" bundle:nil] forCellReuseIdentifier:@"SubjectsCell"];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    SPAModelCoordinator* modelCoordinator = [SPAModelCoordinator sharedModelCoordinator];

    if(modelCoordinator.subjects == nil){
        if(_indicator == nil){
            _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            _indicator.frame = CGRectMake(0.0,0.0,47.0,47.0);
            _indicator.center = self.tableView.center;
            [self.tableView addSubview:_indicator];
        }
        for (UIView* subview in [self.tableView subviews]) {
            subview.hidden = YES;
        }

        
        [_indicator startAnimating];

        
    }else{
        subjects = modelCoordinator.subjects;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    return (subjects!=nil)?([subjects count]+1):0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *titleCellIdentifier = @"SubjectsTitleCell";
    static NSString *CellIdentifier = @"SubjectsCell";
    
    if(indexPath.row == 0){
    
        SPASubjectsTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCellIdentifier];
        if (cell == nil) {
            cell = [[SPASubjectsTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleCellIdentifier];
        }
        // Configure the cell...
        return cell;
    }else{
        SPASubjectsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[SPASubjectsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        // Configure the cell...
        if(subjects!=nil){
            cell.nameLabel.text = ((SPASubject*)subjects[indexPath.row-1]).name;
            cell.subjectId = ((SPASubject*)subjects[indexPath.row-1]).subjectId;
            //cell.nameLabel.text = @"DFG";
        }
        return cell;
    }

}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65.0f;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SPAAppDelegate *appDelegate = (SPAAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [appDelegate.jaSidePanelController showCenterPanelAnimated:YES];
    
    SPASubjectAttributesViewController *spaSubjectAttributesViewController = [[SPASubjectAttributesViewController alloc] init];
    spaSubjectAttributesViewController.subjectName = ((SPASubject*)subjects[indexPath.row-1]).name;
    self.spaScheduleViewController.navigationItem.backBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Назад"
                                                                            style:UIBarButtonItemStyleBordered
                                                                           target:nil
                                                                           action:nil];
    self.spaScheduleViewController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.spaScheduleViewController.navigationController pushViewController:spaSubjectAttributesViewController animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });

}

#pragma mark - SPAModelSubjectsActivationDelegate implementation

- (void) didActivateSubjectsWithResult:(BOOL) result{
    
    [_indicator stopAnimating];
    [_indicator removeFromSuperview];
    
    SPAModelCoordinator* modelCoordinator = [SPAModelCoordinator sharedModelCoordinator];
    subjects = modelCoordinator.subjects;
    
    [self.tableView reloadData];
    
    for (UIView* subview in [self.tableView subviews]) {
        subview.hidden = NO;
    }
    
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end

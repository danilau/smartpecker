//
//  SPAScheduleViewController.m
//  SmartPecker
//
//  Created by majstrak on 05.05.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPAScheduleViewController.h"
#import "SPAScheduleCell.h"
#import "SPASubjectsViewController.h"
#import "SPASubjectAttributesViewController.h"
#import "SPACalendarNavigationView.h"
#import "SPAAppDelegate.h"
#import "SPACalendarMonthContainerViewDelegate.h"
#import "SPAModelCoordinator.h"
#import "SPARenderedLesson.h"


@interface SPAScheduleViewController (){
    NSInteger _activeDay;
    NSInteger _activeMonth;
    NSInteger _activeYear;
    NSInteger _activeWeekDay;
}

@end

@implementation SPAScheduleViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate* todayDate = [NSDate date];
        NSDateComponents* todayComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:todayDate];
        _activeDay = [todayComponents day];
        _activeMonth = [todayComponents month];
        _activeYear = [todayComponents year];
        _activeWeekDay = [todayComponents weekday];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SPAAppDelegate *appDelegate = (SPAAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    [self setTitle:@"SmartPecker"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SPAScheduleCell" bundle:nil] forCellReuseIdentifier:@"ScheduleCell"];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //SPACalendarNavigationView
    
    SPACalendarNavigationView* spaCalendarNavigationView = [[SPACalendarNavigationView alloc] initWithController:self];
    [spaCalendarNavigationView.leftButton addTarget:appDelegate.jaSidePanelController action:@selector(toggleLeftPanel:) forControlEvents:UIControlEventTouchUpInside];
    
   
    [self.navigationItem setTitleView:spaCalendarNavigationView];

    
    
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
    SPAModelCoordinator* coordinator = [SPAModelCoordinator sharedModelCoordinator];
    
    return [coordinator.week[_activeWeekDay-1] count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SPAModelCoordinator* coordinator = [SPAModelCoordinator sharedModelCoordinator];
    
    SPARenderedLesson* lesson = (SPARenderedLesson*)coordinator.week[_activeWeekDay-1][indexPath.row];
    
    
    SPASubjectAttributesViewController *spaSubjectAttributesViewController = [[SPASubjectAttributesViewController alloc] init];
    spaSubjectAttributesViewController.subjectName = lesson.subjectName;
    self.navigationItem.backBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"Назад"
                                                                            style:UIBarButtonItemStyleBordered
                                                                           target:nil
                                                                           action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.navigationController pushViewController:spaSubjectAttributesViewController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ScheduleCell";
    SPAScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SPAScheduleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    // Configure the cell...
    SPAModelCoordinator* coordinator = [SPAModelCoordinator sharedModelCoordinator];
    
    SPARenderedLesson* lesson = (SPARenderedLesson*)coordinator.week[_activeWeekDay-1][indexPath.row];
    
    NSArray* startDateComponents = [lesson.startTime componentsSeparatedByString:@" "];
    NSArray* startTimeComponents = [(NSString*)startDateComponents[1] componentsSeparatedByString:@":"];
    NSArray* finishDateComponents = [lesson.finishTime componentsSeparatedByString:@" "];
    NSArray* finishTimeComponents = [(NSString*)finishDateComponents[1] componentsSeparatedByString:@":"];
    
    cell.startTimeLabel.text = [NSString stringWithFormat:@"%@:%@",startTimeComponents[0],startTimeComponents[1]];
    cell.finishTimeLabel.text = [NSString stringWithFormat:@"%@:%@",finishTimeComponents[0],finishTimeComponents[1]];
    cell.subjectLabel.text = [NSString stringWithFormat:@"%@",lesson.subjectName];
    cell.teacherLabel.text = [NSString stringWithFormat:@"%@",lesson.teacherName];
    cell.classesLabel.text = [NSString stringWithFormat:@"%@",lesson.classesName];
    cell.locationLabel.text = [NSString stringWithFormat:@"%@",lesson.locationName];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65.0f;
}

#pragma mark SPACalendarMonthContainerViewDelegate protocol implementation
- (void) dateFromCalendarWithDay:(NSInteger) day AndMonth:(NSInteger) month AndYear:(NSInteger) year AndWeekDay:(NSInteger)weekday{
    _activeDay = day;
    _activeMonth = month;
    _activeYear = year;
    _activeWeekDay = weekday;
    
    [self.tableView reloadData];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  MainViewController.m
//  Runtime
//
//  Created by Alexey Gross on 15/03/2019.
//  Copyright © 2019 Alexey Gross. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewController.h"
#import "Company.h"
#import "Constants.h"

@interface MainViewController ()

@property (nonatomic, strong) MainTableViewController * tableController;
@property (nonatomic, strong) Company * company;

@end

@implementation MainViewController

- (id)init {
    self = [super init];
    if (self) {
        
        _mainView = [[MainView alloc] initWithFrame:CGRectZero];
        
        _tableController = [[MainTableViewController alloc] init];
        _mainView.tableView.delegate = _tableController;
        _mainView.tableView.dataSource = _tableController;
        _tableController.tableView = _mainView.tableView;
        
        _company = [[Company alloc] init];
    }
    return self;
}

- (void)loadView {
    _mainView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view = _mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    // Update view with specific navigation bar height
    CGFloat navigationBarHeight = ([UIApplication sharedApplication].statusBarFrame.size.height + (self.navigationController.navigationBar.frame.size.height ?: 0.0));
    [self.mainView setValue:@(navigationBarHeight) forKey:@"navigationBarHeight"];
    [self.mainView layoutIfNeeded];

    [self setupTargets];
    [self dataInit];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doIpoCompleted)
                                                 name:kConstantNotification_DoIpoCompleted
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(runMarketingCampaignCompleted)
                                                 name:kConstantNotification_RunMarketingCampaignCompleted
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doAllWorkCompleted)
                                                 name:kConstantNotification_DidAllWork
                                               object:nil];
}

- (void)setupNavigationBar {
    
    self.title = @"Objective-C Runtime";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow-back"]
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self.navigationController
                                                                   action:@selector(popViewControllerAnimated:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    
    UIBarButtonItem * sumButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sum"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(sumAllSalary)];
    self.navigationItem.rightBarButtonItem = sumButton;
}

- (void)setupTargets {
    [self.mainView.actionButton addTarget:self
                                   action:@selector(actionButtonTap:)
                         forControlEvents:UIControlEventTouchUpInside];
}

- (void)dataInit {
    
    int salaryMax = 10000;
    
    // Make a list of all employees
    Employee * founder = [[Founder alloc] init];
    founder.name = @"John";
    founder.lastname = @"Smith";
    founder.salary = arc4random_uniform(salaryMax);
    
    Employee * newFounder = [[Founder alloc] init];
    newFounder.name = @"Karl";
    newFounder.lastname = @"Schmidt";
    newFounder.salary = arc4random_uniform(salaryMax);
    
    Employee * marketer_1 = [[Marketer alloc] init];
    marketer_1.name = @"Rud Van";
    marketer_1.lastname = @"Nistelrooy";
    marketer_1.salary = arc4random_uniform(salaryMax);
    
    Employee * marketer_2 = [[Marketer alloc] init];
    marketer_2.name = @"Oliver";
    marketer_2.lastname = @"Kahn";
    marketer_2.salary = arc4random_uniform(salaryMax);
    
    Employee * developer_1 = [[Developer alloc] init];
    developer_1.name = @"Raul";
    developer_1.lastname = @"Gonzalez";
    developer_1.salary = arc4random_uniform(salaryMax);
    
    Employee * developer_2 = [[Developer alloc] init];
    developer_2.name = @"Francesco";
    developer_2.lastname = @"Totti";
    developer_2.salary = arc4random_uniform(salaryMax);
    
    Employee * developer_3 = [[Developer alloc] init];
    developer_3.name = @"Francesco";
    developer_3.lastname = @"Totti";
    developer_3.salary = arc4random_uniform(salaryMax);
    
    // Set ivars with KVC
    [self.company setValue:@"Galley" forKey:kConstant_NamePropertyKey];
    
    // Only one founder is allowed. Try to add another one, it should be replaced
    [self.company setValue:founder forKey:kConstant_FounderPropertyKey];
    [self.company setValue:newFounder forKey:kConstant_FounderPropertyKey];
    NSLog(@"Founder is: %@", ((Employee *)[_company valueForKey:kConstant_FounderPropertyKey]).fullname);
    
    [self.company addEmployee:marketer_1];
    [self.company addEmployee:marketer_2];
    [self.company addEmployee:developer_1];
    [self.company addEmployee:developer_2];
    
    [self.company addObserver:self forKeyPath:kConstant_EmployeesPropertyKey options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"observeValueForKeyPath: %@ change: %@", keyPath, change);
    
    if ([keyPath isEqualToString:kConstant_EmployeesPropertyKey]) {
        self.tableController.employees = self.company.employees;

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableController.tableView reloadData];
        });
    }
}

#pragma mark - Button events

- (void)actionButtonTap:(UIButton *)sender {
    if (!self.tableController.selectedCell) {
        [self showAlertWithTitle:@"Nothing to do" message:@"Select somebody from the list"];
    } else {
        
        Employee * employee = self.tableController.selectedCell.employee;
        
        // We intentionally address the task to the company, so the company decided who is better to do the task
        if ([employee isMemberOfClass:[Founder class]]) {
            [self.company goIPO];
            
        } else if ([employee isMemberOfClass:[Marketer class]]) {
            [self.company runMarketingCampaign];
            
        } else if ([employee isMemberOfClass:[Developer class]]) {
            [self.company doAllWork];
        }
    }
}

- (void)sumAllSalary {
    
    // KVC: how to operate with objects via keyPath
    NSNumber * allSalary = [self.company valueForKeyPath:@"employees.@sum.salary"];
    
    [self showAlertWithTitle:[NSString stringWithFormat:@"$%ld", (long)allSalary.integerValue] message:@"Report on total wages"];
}

#pragma mark - Alerts

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title
                                                                    message:message
                                                             preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          
                                                      }];
    
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma marl - Notification Center

- (void)doIpoCompleted {
    [self showAlertWithTitle:@"Woah!" message:@"Going public!"];
}

- (void)runMarketingCampaignCompleted {
    [self showAlertWithTitle:@"Woah!" message:@"Just launched a marketing company"];
}

- (void)doAllWorkCompleted {
    [self showAlertWithTitle:@"Hard work" message:@"A lot of work has been done"];
}

@end

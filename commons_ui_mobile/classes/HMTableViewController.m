// Hive Mobile
// Copyright (C) 2008-2014 Hive Solutions Lda.
//
// This file is part of Hive Mobile.
//
// Hive Mobile is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Hive Mobile is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Hive Mobile. If not, see <http://www.gnu.org/licenses/>.

// __author__    = João Magalhães <joamag@hive.pt>
// __version__   = 1.0.0
// __revision__  = $LastChangedRevision$
// __date__      = $LastChangedDate$
// __copyright__ = Copyright (c) 2008-2014 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "HMTableViewController.h"

@implementation HMTableViewController

- (id)init {
    // calls the super
    self = [super init];

    // casts the table view (safe)
    HMTableView *tableView = (HMTableView *) self.tableView;

    // sets the view controller in the table view
    tableView.viewController = self;

    // returns self
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style {
    // calls the super
    self = [super initWithStyle:style];

    // casts the table view (safe)
    HMTableView *tableView = (HMTableView *) self.tableView;

    // sets the view controller in the table view
    tableView.viewController = self;

    // returns self
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    // calls the super
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    // casts the table view (safe)
    HMTableView *tableView = (HMTableView *) self.tableView;

    // sets the view controller in the table view
    tableView.viewController = self;

    // returns self
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    // calls the super
    [super viewDidAppear:animated];

    // casts the table view (safe)
    HMTableView *tableView = (HMTableView *) self.tableView;

    // calls the did appear handler in
    // the table view
    [tableView didAppear];
}

- (void)viewDidDisappear:(BOOL)animated {
    // calls the super
    [super viewDidDisappear:animated];

    // casts the table view (safe)
    HMTableView *tableView = (HMTableView *) self.tableView;

    // calls the did disappear handler in
    // the table view
    [tableView didDisappear];
}

- (void)viewWillAppear:(BOOL)animated {
    // calls the super
    [super viewWillAppear:animated];

    // casts the table view (safe)
    HMTableView *tableView = (HMTableView *) self.tableView;

    // calls the will appear handler in
    // the table view
    [tableView willAppear];
}

- (void)viewWillDisappear:(BOOL)animated {
    // calls the super
    [super viewWillDisappear:animated];

    // casts the table view (safe)
    HMTableView *tableView = (HMTableView *) self.tableView;

    // calls the will disappear handler in
    // the table view
    [tableView willDisappear];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // returns yes to provide interface rotation
    return YES;
}

- (void)didReceiveMemoryWarning {
    // calls the super
    [super didReceiveMemoryWarning];

    // prints a debug message
    NSLog(@"View did receive memory warning");
}

@end

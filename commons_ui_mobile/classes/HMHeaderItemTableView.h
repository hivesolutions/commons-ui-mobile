// Hive Mobile
// Copyright (C) 2008 Hive Solutions Lda.
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
// __revision__  = $LastChangedRevision: 2390 $
// __date__      = $LastChangedDate: 2009-04-02 08:36:50 +0100 (qui, 02 Abr 2009) $
// __copyright__ = Copyright (c) 2008 Hive Solutions Lda.
// __license__   = GNU General Public License (GPL), Version 3

#import "Dependencies.h"

#import "HMItemTableView.h"

@interface HMHeaderItemTableView : HMItemTableView {
    @private NSString *_title;
    @private NSString *_subTitle;
    @private NSString *_image;
    @private UIView *_normalHeaderView;
    @private UIView *_editHeaderView;
    @private UILabel *_titleLabel;
    @private UILabel *_subTitleLabel;
    @private UIImageView *_imageImage;
    @private UITextField *_titleTextField;
    @private UITextField *_subTitleTextField;
    @private UIImageView *_imageAddImage;
}

@property (retain) NSString *title;
@property (retain) NSString *subTitle;
@property (retain) NSString *image;
@property (retain) UIView *normalHeaderView;
@property (retain) UIView *editHeaderView;
@property (assign) UILabel *titleLabel;
@property (assign) UILabel *subTitleLabel;
@property (assign) UIImageView *imageImage;
@property (assign) UITextField *titleTextField;
@property (assign) UITextField *subTitleTextField;
@property (assign) UIImageView *imageAddImage;

/**
 * Constructs the view components and adds them
 * to the view.
 */
- (void)constructView;

/**
 * Constructs the normal view components.
 */
- (void)constructNormalView;

/**
 * Constructs the edit view components.
 */
- (void)constructEditView;

/**
 * Called when editing mode shows.
 */
- (void)showEditing;

/**
 * Called when editing mode hides.
 */
- (void)hideEditing;

@end

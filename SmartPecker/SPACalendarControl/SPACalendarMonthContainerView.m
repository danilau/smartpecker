//
//  SPACalendarMonthContainerView.m
//  SmartPecker
//
//  Created by majstrak on 18.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import "SPACalendarMonthContainerView.h"
#import "SPACalendarMonthLabel.h"

@interface SPACalendarMonthContainerView (){
    SPACalendarMonthLabel* _monthLabel;
}

@end

@implementation SPACalendarMonthContainerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //Month Left Button
        UIImage* monthLeftButtonImage = [UIImage imageNamed:@"calendar_monthleft.png"];
        UIButton* monthLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(8.0, 0.0, 44.0, 44.0)];
        [monthLeftButton setImage:monthLeftButtonImage forState:UIControlStateNormal];
        [monthLeftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        //Month Right Button
        UIImage* monthRightButtonImage = [UIImage imageNamed:@"calendar_monthright.png"];
        UIButton* monthRightButton = [[UIButton alloc] initWithFrame:CGRectMake(268.0, 0.0, 44.0, 44.0)];
        [monthRightButton setImage:monthRightButtonImage forState:UIControlStateNormal];
        [monthRightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        //MonthLabel
        _monthLabel = [[SPACalendarMonthLabel alloc] initWithFrame:CGRectMake(52.0, 0.0, 216.0, 44.0)];
        [_monthLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:monthLeftButton];
        [self addSubview:monthRightButton];
        [self addSubview:_monthLabel];
        //Weekday strap
        for(int i = 1; i <= 7; i++){
            UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(6.0+(i-1)*44.0, 44.0, 44.0, 22.0)];
            label.text = [self dayNameFromId:i];
            label.textColor = [UIColor whiteColor];
            label.font = [label.font fontWithSize:12.0];
            [label setTextAlignment:NSTextAlignmentCenter];
            [self addSubview:label];
        }
        
        

    }
    return self;
}

- (void) leftButtonClicked:(UIButton*) sender{
    [_monthLabel setPrevMonth];
}

- (void) rightButtonClicked:(UIButton*) sender{
    [_monthLabel setNextMonth];
}

- (NSString*) dayNameFromId:(NSInteger)identifier{
    switch (identifier) {
        case 1:
            return @"Пн";
            break;
        case 2:
            return @"Вт";
            break;
        case 3:
            return @"Ср";
            break;
        case 4:
            return @"Чт";
            break;
        case 5:
            return @"Пт";
            break;
        case 6:
            return @"Сб";
            break;
        case 7:
            return @"Вс";
            break;
        default:
            return nil;
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

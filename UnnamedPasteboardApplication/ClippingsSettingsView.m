//
//  ClippingsSettingsView.m
//  Clippings
//
//  Created by Thomas Cole on 8/6/13.
//  Copyright (c) 2013 co1e. All rights reserved.
//

#import "ClippingsSettingsView.h"

@interface ClippingsSettingsView()
{
    UISwitch *runInBackgroundSwitch;
}
@end

@implementation ClippingsSettingsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    UILabel *runInBackgroundLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    runInBackgroundSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setRunInBackground:)];
    
    [runInBackgroundSwitch addGestureRecognizer:tgr];
    [self.view addSubview:runInBackgroundLabel];
    [self.view addSubview:runInBackgroundSwitch];
}

- (void)setRunInBackground:(UITapGestureRecognizer *)tapRec
{
    if (tapRec.numberOfTouches == 1) {
        if (runInBackgroundSwitch.on == YES) {
            
        } else {
            
        }
    }
}

@end

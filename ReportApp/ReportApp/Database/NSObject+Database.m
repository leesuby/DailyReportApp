//
//  NSObject+Database.m
//  ReportApp
//
//  Created by LAP15335 on 27/09/2022.
//

#import "NSObject+Database.h"



@implementation DatabaseFirebase

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ref = [[FIRDatabase database] reference];
    }
    return self;
}

- (void)saveReport{
    [[[self.ref child:@"users"] child: @"1"]
        setValue:@{@"username": @"long"}];
}


- (void) readAllReport: (NSMutableArray*) reportList collectionView :(UICollectionView*) cv{
    [_ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
      // Get user value
        
        
        NSMutableArray *reportArray  =  [[NSMutableArray alloc] init ];
        for(FIRDataSnapshot* child in snapshot.children)
        {
            Report* tmp = [[Report alloc] init];
            [tmp initDateWithDate:child.key];
        
            [reportArray addObject:tmp];
            
            [reportList setArray:reportArray];
            [cv reloadData];
            
        }
        
      // ...
    }];
}
- (void) readDetailReport : (NSMutableArray*) reportDetailList collectionView :(UICollectionView*) cv dateofReport: (NSString*) date{
    
    [[_ref child:date] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
      
    
        for(FIRDataSnapshot* child in snapshot.children)
        {
            NSLog(@"%@", child.value);
            
        }
        

      // ...
    }];
    
}


@end

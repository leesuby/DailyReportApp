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
            [tmp setDate:child.key];
        
            [reportArray addObject:tmp];
            
        }
        
        [reportList setArray:reportArray];
        [cv reloadData];
        
      // ...
    }];
}
- (void) readDetailReport : (NSMutableArray*) reportDetailList collectionView :(UICollectionView*) cv dateofReport: (NSString*) date{
    
    [[_ref child:date] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSMutableArray *reportArray  =  [[NSMutableArray alloc] init ];
        for(FIRDataSnapshot* user in snapshot.children)
        {
            
            Report* tmp = [[Report alloc] init];
            [tmp setUserName:user.key];
           
            
            if(user.hasChildren){
                NSMutableArray* tasks = [[NSMutableArray alloc] init ];
                for(FIRDataSnapshot* task in user.children)
                {
                    Task* tmpTask = [[Task alloc] init];
                    
                    [tmpTask setNote:task.value[@"note"]];
                    [tmpTask setTitle:task.value[@"title"]];
                    [tmpTask setDetail:task.value[@"detail"]];
                    [tmpTask setStatus:[task.value[@"status"] integerValue]];
                    
                    [tasks addObject:tmpTask];
                }
                
                NSArray* arrayTask = [tasks copy];
                [tmp setTasks:arrayTask];
            }
            
            [reportArray addObject:tmp];

        }
        
        [reportDetailList setArray:reportArray];
        [cv reloadData];

      // ...
    }];
    
}

- (void) readTaskUser: (NSMutableArray*) reportDetailList collectionView :(UICollectionView*) cv dateofReport: (NSString*) date{
    
    [[[_ref child:date] child:[UserSession.username lowercaseString]]observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSMutableArray *taskArray  =  [[NSMutableArray alloc] init ];
        for(FIRDataSnapshot* task in snapshot.children)
        {
            
            Task* tmpTask = [[Task alloc] init];
            
            [tmpTask setNote:task.value[@"note"]];
            [tmpTask setTitle:task.value[@"title"]];
            [tmpTask setDetail:task.value[@"detail"]];
            [tmpTask setStatus:[task.value[@"status"] integerValue]];
            
            [taskArray addObject:tmpTask];

        }
        
        [reportDetailList setArray:taskArray];
        [cv reloadData];

      // ...
    }];
}

@end

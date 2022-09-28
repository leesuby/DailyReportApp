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

- (void) readAllReport:(void (^)(NSArray * _Nonnull))completionBlock{
    [_ref observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {

        NSMutableArray *reportArray  =  [[NSMutableArray alloc] init ];
        for(FIRDataSnapshot* child in snapshot.children)
        {
            Report* tmp = [[Report alloc] init];
            [tmp setDate:child.key];
        
            [reportArray addObject:tmp];
            
        }
    
        completionBlock([NSArray arrayWithArray:reportArray]);
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

- (void) readDetailReportWithDate:(NSString*)date completion:(void(^)(NSArray *))completionBlock{
    
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
        
        completionBlock([NSArray arrayWithArray:reportArray]);

      // ...
    }];
    
}

- (void)readTaskUserWithDate:(NSString*)date completion:(void(^)(NSArray *))completionBlock{
    [[[_ref child:date] child:[UserSession.username lowercaseString]]observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        ///
        ///LOAD DATA..
        NSMutableArray *taskArray = [[NSMutableArray alloc] init ];
        
        for(FIRDataSnapshot* task in snapshot.children)
        {
            
            Task* tmpTask = [[Task alloc] init];
            
            [tmpTask setNote:task.value[@"note"]];
            [tmpTask setTitle:task.value[@"title"]];
            [tmpTask setDetail:task.value[@"detail"]];
            [tmpTask setStatus:[task.value[@"status"] integerValue]];
            [tmpTask setId:task.key];
            
            [taskArray addObject:tmpTask];

        }
        
        
        completionBlock([NSArray arrayWithArray:taskArray]);
    }];
}

- (void)saveTaskUser:(Task *)task dateofReport: (NSString*) date{
    
    [[[[self.ref child:date] child:[UserSession.username lowercaseString]] child:task.id]
     setValue:@{@"title": task.title,
                @"note": task.note,
                @"status": [NSNumber numberWithLong:task.status],
                @"detail": task.detail
              }];
}

- (void) editTaskUser: (Task*) task dateofReport: (NSString*) date{
    [[[[self.ref child:date] child:[UserSession.username lowercaseString]] child:task.id]
     setValue:@{@"title": task.title,
                @"note": task.note,
                @"status": [NSNumber numberWithLong:task.status],
                @"detail": task.detail
              }];
}

- (void) deleteTaskUser: (Task*) task dateofReport: (NSString*) date{
    [[[[self.ref child:date] child:[UserSession.username lowercaseString]] child:task.id]
     removeValue];
}

@end

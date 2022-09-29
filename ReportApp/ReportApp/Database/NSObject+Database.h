//
//  NSObject+Database.h
//  ReportApp
//
//  Created by LAP15335 on 27/09/2022.
//

#import <Foundation/Foundation.h>



@import FirebaseCore;
@import FirebaseFirestore;
@import FirebaseAuth;
@import FirebaseDatabase;
@class Task;



NS_ASSUME_NONNULL_BEGIN

@interface DatabaseFirebase : NSObject

@property (strong, nonatomic) FIRDatabaseReference *ref;


- (void) readAllReport:(void(^)(NSArray *))completionBlock;

- (void) readDetailReportWithDate: (NSString*)date completion:(void(^)(NSArray *))completionBlock;

- (void) readTaskUserWithDate:(NSString*)date completion:(void(^)(NSArray *))completionBlock;

- (void) saveTaskUser: (Task*) task dateofReport: (NSString*) date;

- (void) editTaskUser: (Task*) task dateofReport: (NSString*) date;

- (void) deleteTaskUser: (Task*) task dateofReport: (NSString*) date;

- (void) createReport: (NSString*) date;
@end

NS_ASSUME_NONNULL_END

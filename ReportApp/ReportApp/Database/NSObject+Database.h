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
@class User;



NS_ASSUME_NONNULL_BEGIN

@interface DatabaseFirebase : NSObject

@property (strong, nonatomic) FIRDatabaseReference *ref;


- (void) readAllReport:(void(^)(NSArray *))completionBlock;

- (void) readDetailReportWithDate: (NSString*)date completion:(void(^)(NSArray *))completionBlock;

- (void) readTaskUserWithDate:(NSString*)date completion:(void(^)(NSArray *))completionBlock;

- (void) readRecentTasks: (void(^)(NSArray *))completionBlock;

- (void) readARecentTask: (NSString*)id completion:(void(^)(Task*))completionBlock;

- (void) saveTaskUser: (Task*) task dateofReport: (NSString*) date;

- (void) editTaskUser: (Task*) task dateofReport: (NSString*) date;

- (void) deleteTaskUser: (Task*) task dateofReport: (NSString*) date;

- (void) createReport: (NSString*)date;

- (void) updateRecentTask: (NSArray*)listTask;

- (void) updateStatusReport: (NSString*)status date:(NSString*)d;

- (void) createUser: (User*)user name:(NSString*)username;

- (void) checkUser: (User*)user name:(NSString*)username completionBlock:(void(^)(NSInteger))completionBlock;
@end

NS_ASSUME_NONNULL_END

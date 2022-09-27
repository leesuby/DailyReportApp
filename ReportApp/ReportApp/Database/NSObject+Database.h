//
//  NSObject+Database.h
//  ReportApp
//
//  Created by LAP15335 on 27/09/2022.
//

#import <Foundation/Foundation.h>
#import "ReportApp-Swift.h"

@import FirebaseCore;
@import FirebaseFirestore;
@import FirebaseAuth;
@import FirebaseDatabase;



NS_ASSUME_NONNULL_BEGIN

@interface DatabaseFirebase : NSObject

@property (strong, nonatomic) FIRDatabaseReference *ref;


- (void) readAllReport:(void(^)(NSArray *))completionBlock;

- (void) readDetailReportWithDate:(NSString*)date completion:(void(^)(NSArray *))completionBlock;

- (void)readTaskUserWithDate:(NSString*)date completion:(void(^)(NSArray *))completionBlock ;

- (void) saveTaskUser: (Task*) task dateofReport: (NSString*) date;
@end

NS_ASSUME_NONNULL_END

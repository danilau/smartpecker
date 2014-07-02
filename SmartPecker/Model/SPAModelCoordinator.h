//
//  SPAModelCoordinator.h
//  SmartPecker
//
//  Created by majstrak on 25.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPAWebServiceCoordinator.h"
#import "SPAWebServiceCoordinatorDelegate.h"
#import "SPAModelActivationDelegate.h"
#import "SPAModelSubjectsActivationDelegate.h"

typedef enum _SPAModelActivationMode {
    SPAModelActivationModeCoreData = 0,
    SPAModelActivationModeWebService,
    SPAModelActivationModeUndefined
} SPAModelActivationMode;

@interface SPAModelCoordinator : NSObject <SPAWebServiceCoordinatorDelegate>

@property (nonatomic, readonly) BOOL activated;
@property (nonatomic, readonly) SPAModelActivationMode activationMode;
@property (nonatomic,strong) SPAWebServiceCoordinator* webServiceCoordinator;
@property (nonatomic,weak) id<SPAModelActivationDelegate> activationDelegate;
@property (nonatomic,weak) id<SPAModelSubjectsActivationDelegate> subjectsActivationDelegate;
//Core Data
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//Logic
@property (readonly, strong, nonatomic) NSArray* week;
@property (readonly, strong, nonatomic) NSMutableArray* subjects;
@property (readonly, strong, nonatomic) NSMutableArray* teachers;
@property (readonly, strong, nonatomic) NSMutableArray* lessons;

+ (id)sharedModelCoordinator;

- (void) activateViaCoreData;
- (void) activateViaWebServiceWithLogin:(NSString*) login AndPassword:(NSString*) password;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

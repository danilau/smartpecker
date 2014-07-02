//
//  SPAModelCoordinator.m
//  SmartPecker
//
//  Created by majstrak on 25.06.14.
//  Copyright (c) 2014 Danilau. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "SPAModelCoordinator.h"
#import "ManagedObjects/InformationSchema.h"
#import "SPALesson.h"
#import "SPASubject.h"

@interface SPAModelCoordinator ()

- (SPAModelActivationMode) checkActivationMode;

//CoreData methods
- (void) initSchema;
- (NSNumber*) getSchemaParameter:(NSString*) param;
- (void) updateSchemaParameter:(NSString*) param WithValue:(NSInteger) integer;

@end

@implementation SPAModelCoordinator

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (id)sharedModelCoordinator {
    static SPAModelCoordinator *sharedModelCoordinator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedModelCoordinator = [[self alloc] init];
    });
    return sharedModelCoordinator;
}

- (id)init {
    if (self = [super init]) {
        _activated = NO;
        self.webServiceCoordinator = [[SPAWebServiceCoordinator alloc] initWithURL:[NSURL URLWithString:@"http://spectest.usbelar.by/smartpecker"]];
        self.webServiceCoordinator.delegate = self;
        
        //CoreData initialization
        [self initSchema];
        
        _activationMode = [self checkActivationMode];
        
   
        
    }
    return self;
}

#pragma mark - Activation

- (SPAModelActivationMode) checkActivationMode{
    
    NSNumber* baseInstalledValue = [self getSchemaParameter:@"baseInstalled"];
    
    switch ([baseInstalledValue integerValue]) {
        case 0:{
            return SPAModelActivationModeWebService;
        };break;
        case 1:{
            return SPAModelActivationModeCoreData;
        };break;
        default:{
            return SPAModelActivationModeUndefined;
        };break;
    }
    
}

- (void) activateViaCoreData{
    if([[self activationDelegate] respondsToSelector:@selector(modelActivationDone)]) {
        [[self activationDelegate] modelActivationDone];
    }
}

- (void) activateViaWebServiceWithLogin:(NSString*) login AndPassword:(NSString*) password{
    [self.webServiceCoordinator makeAuthorizationWithName:login AndPass:password];

}

#pragma mark - SPAWebServiceCoordinatorDelegate implementation

- (void) didMakeAuthenticationWithError:(BOOL)error{
    NSLog(@"Authentication is made");
    if([[self activationDelegate] respondsToSelector:@selector(modelAuthenticationDoneWithError:)]) {
        [[self activationDelegate] modelAuthenticationDoneWithError:error];
    }
    if(!error) [_webServiceCoordinator getRenderedWeek];
}

- (void) didReceiveRenderedWeek:(NSArray*) week{
    _week = week;
    _activated = YES;
    if([[self activationDelegate] respondsToSelector:@selector(modelActivationDone)]) {
        [[self activationDelegate] modelActivationDone];
    }
    [_webServiceCoordinator getSubjects];
}

- (void) didReceiveScheduleWithLessons:(NSMutableArray *)lessons{
    _lessons = lessons;
    NSLog(@"dsfs");
}

- (void) didReceiveSubjects:(NSMutableArray *)subjects{
    
    _subjects = subjects;
    if([[self subjectsActivationDelegate] respondsToSelector:@selector(didActivateSubjectsWithResult:)]) {
        [[self subjectsActivationDelegate] didActivateSubjectsWithResult:YES];
    }
  
    
}

- (void) didReceiveLocations{
    
}

- (void) didReceiveTeachers:(NSMutableArray *)teachers{
    _teachers = teachers;
}

#pragma mark - CoreData methods implementation
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SPAModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SPAModel.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {

        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (void) initSchema{
    
    NSNumber* schemaInitializedValue = [self getSchemaParameter:@"schemaInitialized"];
    
    if([schemaInitializedValue integerValue] == 1) return;
    
    
    NSDictionary* schemaDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@1,@"schemaInitialized",@0,@"baseInstalled", nil];
    
    for(NSString* key in schemaDictionary){
        InformationSchema* schemaObject = [NSEntityDescription insertNewObjectForEntityForName:@"InformationSchema" inManagedObjectContext:self.managedObjectContext];
        
        NSLog(@"%@", [schemaDictionary objectForKey:key]);
        
        if(schemaObject!=nil){
            
            schemaObject.name = key;
            schemaObject.value = [schemaDictionary objectForKey:key];
            
            NSError* savingError;
            
            if ([self.managedObjectContext save:&savingError]){
                NSLog(@"Successfully saved the context.");
            } else {
                NSLog(@"Failed to save the context. Error = %@", savingError);
            }
        }else{
            NSLog(@"Failed to create new record in InformationSchema.");
        }
        
    }

    
}

- (NSNumber*) getSchemaParameter:(NSString*) param{
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"InformationSchema"];
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name == %@",param ]];
    
    
    NSError *requestError = nil;

    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&requestError];
    
    if([results count] > 0){
    
        //NSLog(@"RequestError - %@",requestError);
    
        InformationSchema *schemaInitializedObject = (InformationSchema *)results[0];
        
        return schemaInitializedObject.value;
        
    }else{
   
        return nil;
    }
}

- (void) updateSchemaParameter:(NSString*) param WithValue:(NSInteger) integer{
    
}


#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end

# GCD-Signal
GCD Stuff

Example:

- (void)viewDidLoad 
{
  [super viewDidLoad];
  
  SyncRequestMethod *sync = [[SyncRequestMethod alloc] initWithArray:@[@"request1", @"request2"] withAny:self];
}

- (void)request1
{
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager POST:url
   parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id responseObject) {

        [sync setSignalForContinue];

      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [sync setSignalForContinue];


  }];

}

- (void)request2
{
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager POST:url
   parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id responseObject) {

        [sync setSignalForBreak];

      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [sync setSignalForBreak];


  }];
}

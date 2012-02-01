//
//  Defesa.h
//  Defenda-se
//
//  Created by Argemiro Neto on 16/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SobreViewController;

@interface DefesaTableViewController : UITableViewController
{
    UITableView *table;
    UISearchBar *search;
    
    NSDictionary *allDefesas;
    NSMutableDictionary *defesas;
    NSMutableArray *categorias;
    
    CGFloat fontSize;
    BOOL isSearching;
    
    SobreViewController *sobreController;
}

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UISearchBar *search;

- (void)resetSearch;
- (void)handleSearchForTerm:(NSString *)searchTerm;

@end

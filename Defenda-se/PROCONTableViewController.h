//
//  BuscaTableViewController.h
//  Defenda-se
//
//  Created by Argemiro Neto on 26/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDictionary+NSDictionary_MutableDeepCopy.h"

@interface PROCONTableViewController : UITableViewController
{
    UISearchBar *search;
    UITableView *table;
    
    //Itens da busca
    NSDictionary *allProcons;
    NSMutableDictionary *procons;
    NSMutableArray *estados;
    NSMutableArray *indices;
    
    BOOL isSearching;
}

@property (nonatomic, retain) IBOutlet UISearchBar *search;
@property (nonatomic, retain) IBOutlet UITableView *table;

- (void)resetSearch;
- (void)handleSearchForTerm:(NSString *)searchTerm;

@end

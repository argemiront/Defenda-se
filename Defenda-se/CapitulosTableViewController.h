//
//  CapitulosCDCTableViewController.h
//  Defenda-se
//
//  Created by Argemiro Neto on 24/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CapitulosTableViewController : UITableViewController
{
    NSString *fileName;
    NSString *item;
    
    NSArray *titulos, *subtitulos, *arqs, *rangeBusca;
    UITableView *table;
    NSDictionary *artigos;
    
    UISearchBar *search;
    NSMutableArray *baseBusca;
    NSMutableArray *resultadoBusca;
    BOOL buscaArtigo;
}

@property (nonatomic, retain) NSString *fileName;
@property (nonatomic, retain) NSString *item;
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) IBOutlet UISearchBar *search;

-(void)carregaDadosBusca;
- (void)resetSearch;
- (void)handleSearchForTerm:(NSString *)searchTerm;

@end

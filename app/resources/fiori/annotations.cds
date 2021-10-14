using CatalogService as catalog from '../../../srv/catalog-service';

annotate catalog.Sales with @(
    UI: {
        Identification: [ {Value: country} ],
        SelectionFields: [ ],
        LineItem: [
            {Value: ID},
            {Value: region},
            {Value: country},
            {Value: amount, Criticality: criticality},
            {$Type: 'UI.DataFieldForAction', Label: '{i18n>boost}', Action: 'CatalogService.boost', Inline: true},
            {Value: comments}
        ],
        HeaderInfo: {
            TypeName: '{i18n>country}',
            TypeNamePlural: '{i18n>countries}',
            Title: {Value: country},
            Description: {Value: ID}
        },
FieldGroup #Description : {Data : [{ $Type : 'UI.DataField', Value : region },    
                                   { $Type : 'UI.DataField', Value : country },
                                  ]},
FieldGroup #Details : {Data : [ { $Type : 'UI.DataField', Value : amount },
                                { $Type : 'UI.DataField', Value : comments },                                 
                        ]},
Facets : [ { $Type  : 'UI.CollectionFacet', ID: 'PODetails', Label: '{i18n>productInfo}',
             Facets : [{ $Type  : 'UI.ReferenceFacet', Label  : '{i18n>priceInfo}', Target : '@UI.FieldGroup#Details' }]
           },          
           { $Type  : 'UI.ReferenceFacet', Label  : '{i18n>marketsInfo}', Target : 'toProduct/@UI.LineItem' }]
   }
   ); 
    

annotate catalog.Products with @(
    UI: {
SelectionFields: [toProductGroup_ID],
PresentationVariant : {SortOrder : [{ $Type : 'Common.SortOrderType', Property   : toProductGroup.name, Descending : false },
                                    { $Type : 'Common.SortOrderType', Property   : productID, Descending : false }]},
Identification : [ { Value: productUUID }],
LineItem: [ { $Type : 'UI.DataField', Value : toProductGroup.imageURL, ![@UI.Importance]: #High },
            { $Type : 'UI.DataField', Value : toProductGroup_ID, ![@UI.Importance]: #High },   
            { $Type : 'UI.DataField', Value : productID, ![@UI.Importance]: #High },
            { $Type : 'UI.DataField', Value : price, ![@UI.Importance]: #High },
            { $Type : 'UI.DataField', Value : taxRate, ![@UI.Importance]: #High },
            { $Type : 'UI.DataField', Value : height, ![@UI.Importance]: #High },
            { $Type : 'UI.DataField', Value : width, ![@UI.Importance]: #High },
            { $Type : 'UI.DataField', Value : depth, ![@UI.Importance]: #High }
           ],
HeaderInfo : { TypeName : 'Product', TypeNamePlural : 'Products', Title : {Value : toProductGroup_ID}, },
HeaderFacets : [ { $Type : 'UI.ReferenceFacet', Target : '@UI.FieldGroup#Description', ![@UI.Importance] : #Medium }],
FieldGroup #Description : {Data : [{ $Type : 'UI.DataField', Value : toProductGroup_ID },    
                                   { $Type : 'UI.DataField', Value : toProductGroup.imageURL },
                                   { $Type : 'UI.DataField', Value : productID },
                                  ]},
FieldGroup #Details : {Data : [ { $Type : 'UI.DataField', Value : toProductGroup_ID },
                                { $Type : 'UI.DataField', Value : productID },   
                                { $Type : 'UI.DataField', Value : price},
                                { $Type : 'UI.DataField', Value : taxRate }
                        ]},
FieldGroup #Details3 : {Data : [ { $Type : 'UI.DataField', Value : depth },
                                 { $Type : 'UI.DataField', Value : width },
                                 { $Type : 'UI.DataField', Value : height }
                        ]},
FieldGroup #AdministrativeData : {Data : [ { $Type : 'UI.DataField',  Value : createdBy },
                                           { $Type : 'UI.DataField',  Value : createdAt }
                                  ]},
Facets : [ { $Type  : 'UI.CollectionFacet', ID: 'PODetails', Label: '{i18n>productInfo}',
             Facets : [{ $Type  : 'UI.ReferenceFacet', Label  : '{i18n>priceInfo}', Target : '@UI.FieldGroup#Details' },
                       { $Type  : 'UI.ReferenceFacet', Label  : '{i18n>dimentionsInfo}', Target : '@UI.FieldGroup#Details3'}]
           },
           { $Type  : 'UI.CollectionFacet', ID: 'POAdmininfo', Label  : '{i18n>adminInfo}',
             Facets : [{ $Type  : 'UI.ReferenceFacet', Label  : '{i18n>adminInfo}', Target : '@UI.FieldGroup#AdministrativeData' }]},
   ]
   }
   ); 

annotate catalog.Sales with {
    ID       @title:'{i18n>ID}' @UI.HiddenFilter;
    region   @title:'{i18n>region}';
    country  @title:'{i18n>country}';
    amount   @title:'{i18n>amount}';
    comments @title:'{i18n>comments}';
};

annotate catalog.Products with {
    productUUID          @title: '{i18n>productID}';
    productID            @title: '{i18n>productID}';
    price                @title: '{i18n>price}';
    taxRate              @title: '{i18n>taxRate}';
    height               @title: '{i18n>height}';
    width                @title: '{i18n>width}';
    depth                @title: '{i18n>depth}';
    currencyCode_code    @title: '{i18n>currency}';
    toProductGroup       @title: '{i18n>product}' @Common.Text: toProductGroup.name @Common.TextArrangement: #TextFirst;
};







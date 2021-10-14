using { cuid, managed } from '@sap/cds/common';

context saaspoc.db {

entity Sales {
  key ID          : Integer;
      region      : String(100);
      country     : String(100);
      org         : String(4);
      amount      : Integer;
      comments    : String(100);
      criticality : Integer;
      toProduct                     : Composition of many Products on toProduct.toSales = $self;
}

entity Products: managed {
       key productUUID               : UUID;
       productID                     : String;
       height                        : Decimal(13,3);
       depth                         : Decimal(13,3);
       width                         : Decimal(13,3);      
       price                         : Decimal(15,2);
       //currencyCode                  : Currency default 'EUR';
       taxRate                       : Decimal(5,2);
       productNetAmount              : Decimal(15,2);
       productTaxAmount              : Decimal(15,2);
       productGrossAmount            : Decimal(15,2);
       toProductGroup                : Association to ProductGroups;
       toSales                       : Association to Sales;
}

entity ProductGroups {
    key ID           : String(3);
    name             : String(20);
    imageURL         : String @UI.IsImageURL;
    imageType        : String @Core.IsMediaType; 
}


}

@cds.persistence.exists
@cds.persistence.calcview
entity CV_SALES {
  key REGION  : String(100);
      AMOUNT  : Integer;
}

@cds.persistence.exists
@cds.persistence.calcview
entity CV_SESSION_INFO {
  key ITEM     : String(5000);
      VALUE    : String(5000);
}

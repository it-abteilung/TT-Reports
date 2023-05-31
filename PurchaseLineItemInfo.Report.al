#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50048 PurchaseLineItemInfo
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PurchaseLineItemInfo.rdlc';
    Caption = 'Artikel in Einkauf anzeigen';

    dataset
    {
        dataitem("Purchase Line";"Purchase Line")
        {
            DataItemTableView = sorting("Document Type","Document No.","Line No.") order(ascending);
            RequestFilterFields = "No.";
            column(ReportForNavId_100000000; 100000000)
            {
            }
            column(DocumentType;"Document Type")
            {
            }
            column(DocumentNo;"Document No.")
            {
            }

            trigger OnPreDataItem()
            begin
                "Purchase Line".SetRange(Type,"Purchase Line".Type::Item);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}


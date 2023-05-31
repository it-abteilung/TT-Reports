#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50047 KorrekturArtikelposten
{
    Permissions = TableData "Item Ledger Entry"=rm,
                  TableData "Warehouse Entry"=rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purchase Line";"Purchase Line")
        {
            column(ReportForNavId_100000000; 100000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Purchase Line"."Outstanding Quantity" <> 0 then begin
                  "Purchase Line"."Location Code" := 'WHV';
                  Modify;
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Document Type","Purchase Line"."document type"::Order);
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


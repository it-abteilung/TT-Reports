#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50008 "Artikel Seriennrpflichtig"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item;Item)
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Item."Item Tracking Code" := 'SNALLE';
                Item.Modify;
            end;

            trigger OnPreDataItem()
            begin
                Item.SetRange("No.",'500575');
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

    var
        PurchRcptLine: Record "Purch. Rcpt. Line";
}


#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50010 Batchlauf
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("BOM Component";"BOM Component")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "BOM Component"."Unit of Measure Code" = 'STÜCK' then begin
                  "BOM Component"."Unit of Measure Code" := 'STK.';
                  Modify;
                end;
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


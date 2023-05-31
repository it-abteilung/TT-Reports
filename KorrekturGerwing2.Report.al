#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50024 "Korrektur Gerwing 2"
{
    Permissions = TableData "Purch. Rcpt. Line"=rm,
                  TableData "Posted Whse. Receipt Line"=rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Posted Whse. Receipt Line";"Posted Whse. Receipt Line")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "No." = '0000022' then begin
                  if "Location Code" = 'WHV1' then begin
                    "Location Code" := 'WHV';
                    Modify;
                  end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                //SETRANGE("Document Type","Document Type"::Order);
                SetRange("No.",'0000022');
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
        AusstattungPosten2: Record Ausstattung_Posten;
}


#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50072 CheckPurchaseHeader
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CheckPurchaseHeader.rdlc';

    dataset
    {
        dataitem("Purch. Rcpt. Header";"Purch. Rcpt. Header")
        {
            DataItemTableView = sorting("No.") order(ascending);
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(PurchaseHeader__No;"No.")
            {
            }
            column(PurchaseHeader__JobNo;"Job No.")
            {
            }
            column(ProjektNo;ProjektNo)
            {
            }

            trigger OnAfterGetRecord()
            var
                PurchRcptLine: Record "Purch. Rcpt. Line";
            begin
                ProjektNo := '';
                PurchRcptLine.SetRange("Document No.","No.");

                if PurchRcptLine.FindFirst() then
                  repeat
                    if (ProjektNo = '') and (PurchRcptLine."Job No." <> '') then
                      ProjektNo := PurchRcptLine."Job No.";
                  until(PurchRcptLine.Next() = 0);
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Job No.",'');
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
        ProjektNo: Code[20];
}


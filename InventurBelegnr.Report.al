#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50014 "Inventur Belegnr."
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Item Journal Line";"Item Journal Line")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Item Journal Line"."Document No." = '' then begin
                  "Item Journal Line"."Document No." := 'INV_18';
                  Modify;
                end;
            end;

            trigger OnPreDataItem()
            begin
                //SETRANGE("Phys. Inventory",TRUE);
                SetRange("Journal Batch Name",'INVENTUR');
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


#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50038 "Wareneingang Karton Barcode"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Wareneingang Karton Barcode.rdlc';

    dataset
    {
        dataitem("Purchase Header";"Purchase Header")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(Feld1;"Purchase Header"."Job No." + '/' +"Purchase Header"."No.")
            {
            }
            column(Feld2;"Purchase Header"."Buy-from Vendor Name")
            {
            }
            column(Feld3;Format(Today))
            {
            }
            column(Feld4;'Besteller: ' + "Purchase Header".Bestellername)
            {
            }
            column(Feld5;'')
            {
            }
            column(Barcode;'')
            {
            }

            trigger OnAfterGetRecord()
            begin
                CalcFields(Bestellername);
                if not JobRec.Get("Purchase Header"."Job No.") then
                  JobRec.Init;
                if not MultiTableRec.Get('SCHIFF',JobRec.Object) then
                  MultiTableRec.Init;
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
        JobRec: Record Job;
        MultiTableRec: Record "Multi Table";
}


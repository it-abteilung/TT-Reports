#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50037 "Wareneingang Artikel Barcode"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Wareneingang Artikel Barcode.rdlc';

    dataset
    {
        dataitem("Purchase Line";"Purchase Line")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(Feld1;"Purchase Line"."Job No." + '/' + PurchaseHeader."No." + ' / ' + MultiTableRec.Description + ' / ' + "Purchase Line".Baugruppe + ' / ' + "Purchase Line".Pos)
            {
            }
            column(Feld2;"Purchase Line"."No." + ' - ' + "Purchase Line".Description)
            {
            }
            column(Feld3;"Purchase Line"."Description 2")
            {
            }
            column(Feld4;Format(Today) + ' / Ch.: ' + "Purchase Line"."LOT-Nr. / Chargennr.")
            {
            }
            column(Feld5;'')
            {
            }
            column(Barcode;'*' + "Purchase Line"."No." + '*')
            {
            }

            trigger OnAfterGetRecord()
            begin
                if not PurchaseHeader.Get("Purchase Line"."Document Type","Purchase Line"."Document No.") then
                  PurchaseHeader.Init;
                if not JobRec.Get("Purchase Line"."Job No.") then
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
            area(content)
            {
                group(Options)
                {
                    field(AnzahlEtiketten;AnzahlKopien)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Anzahl Etiketten';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        PurchaseHeader: Record "Purchase Header";
        JobRec: Record Job;
        MultiTableRec: Record "Multi Table";
        AnzahlKopien: Integer;
}


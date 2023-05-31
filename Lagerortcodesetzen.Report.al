#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50046 "Lagerortcode setzen"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Artikel-Seriennr";"Artikel-Seriennr")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin

                if ItemRec.Get("Artikel-Seriennr"."Item No.") then begin
                if not ItemRec."Seriennr. pflichtig" then begin
                  ItemRec."Seriennr. pflichtig" := true;
                  ItemRec.Modify;
                end;

                Clear(Ausstattung_Posten);
                Ausstattung_Posten.SetRange("Artikel Nr","Item No.");
                Ausstattung_Posten.SetRange(Offen,true);
                Ausstattung_Posten.SetRange(Seriennummer,"Serial No.");
                if Ausstattung_Posten.FindLast then begin
                  Clear(ItemJournalLine);
                  ItemJournalLine.SetRange("Journal Template Name",'ARTIKEL');
                  ItemJournalLine.SetRange("Journal Batch Name",'SYSTEM');
                  if ItemJournalLine.FindLast then
                    lfdnr := ItemJournalLine."Line No.";
                  lfdnr += 10000;

                  Clear(ItemJournalLine);
                  ItemJournalLine."Journal Template Name" := 'ARTIKEL';
                  ItemJournalLine."Journal Batch Name" := 'SYSTEM';
                  ItemJournalLine.Validate("Line No.",lfdnr);
                  ItemJournalLine.Validate("Posting Date",Today);
                  ItemJournalLine.Validate("Entry Type",ItemJournalLine."entry type"::"Positive Adjmt.");
                  ItemJournalLine.Validate("Document No.",Ausstattung_Posten."Projekt Nr");
                  ItemJournalLine.Validate("Item No.","Item No.");
                  ItemJournalLine.Validate("Location Code",'PROJ');
                  ItemJournalLine.Validate(Quantity,1);
                  ItemJournalLine.Validate("Serial No.","Serial No.");
                  ItemJournalLine.Insert(true);
                end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                //SETRANGE("Item No.",'400473');
                SetFilter("Serial No.",'<>%1','');
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
        ItemJournalLine: Record "Item Journal Line";
        Ausstattung_Posten: Record Ausstattung_Posten;
        ItemRec: Record Item;
        lfdnr: Integer;
}


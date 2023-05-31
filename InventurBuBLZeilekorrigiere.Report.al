#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50035 "Inventur BuBL Zeile korrigiere"
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
                ItemJournalLineRec := "Item Journal Line";
                ItemJournalLineRec."Journal Batch Name" := 'INV_YORIC2';
                ItemJournalLineRec.Insert;
                /*
                CLEAR(ItemLedgerEntry);
                ItemLedgerEntry.SETCURRENTKEY("Item No.","Entry Type","Variant Code","Drop Shipment","Location Code","Posting Date");
                ItemLedgerEntry.SETRANGE("Item No.",ItemJournalLineRec."Item No.");
                ItemLedgerEntry.SETFILTER("Posting Date",'..%1',20182812D);
                ItemLedgerEntry.CALCSUMS(Quantity);
                ItemJournalLineRec.Quantity := ItemJournalLineRec.Quantity - ItemLedgerEntry.Quantity;
                ItemJournalLineRec.VALIDATE(Quantity);
                */
                ItemJournalLineRec.Validate("Posting Date",20190201D);
                ItemJournalLineRec.Validate(Quantity);
                Item.Get(ItemJournalLineRec."Item No.");
                ItemJournalLineRec.Validate("Unit Amount",Item."Last Direct Cost");
                ItemJournalLineRec.Validate("Unit Cost",Item."Last Direct Cost");
                ItemJournalLineRec.Modify;

            end;

            trigger OnPreDataItem()
            begin
                SetRange("Journal Template Name",'ARTIKEL');
                SetRange("Journal Batch Name",'INV_YORICK');
                //SETRANGE("Posting Date",20190402D);
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
        ItemJournalLineRec: Record "Item Journal Line";
        ItemLedgerEntry: Record "Item Ledger Entry";
        Item: Record Item;
}


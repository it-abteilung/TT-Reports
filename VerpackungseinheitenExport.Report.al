#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50039 "Verpackungseinheiten Export"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                RowNo += 1;
                ExcelÜbergabe(RowNo, 1, Item."No.", true, false, '@');
                ExcelÜbergabe(RowNo, 2, Item.Description, true, false, '@');
                ExcelÜbergabe(RowNo, 3, Item."Base Unit of Measure", true, false, '@');
                if ItemUnitofMeasure.Get(Item."No.", Item."Base Unit of Measure") then
                    ExcelÜbergabe(RowNo, 4, Format(ItemUnitofMeasure."Qty. per Unit of Measure"), true, false, '@');
                i := 4;
                Clear(ItemUnitofMeasure);
                ItemUnitofMeasure.SetRange("Item No.", "No.");
                if ItemUnitofMeasure.FindSet then
                    repeat
                        if ItemUnitofMeasure.Code <> Item."Base Unit of Measure" then begin
                            i += 1;
                            ExcelÜbergabe(RowNo, i, ItemUnitofMeasure.Code, true, false, '@');
                            i += 1;
                            ExcelÜbergabe(RowNo, i, Format(ItemUnitofMeasure."Qty. per Unit of Measure"), true, false, '@');

                        end;
                    until ItemUnitofMeasure.Next = 0;
            end;

            trigger OnPostDataItem()
            begin
                // Excelpuffer.CreateBookAndOpenExcel(ServerFileName, 'Artikel-Verpackungseinheiten', 'Artikel-Verpackungseinheiten', COMPANYNAME, UserId);
            end;

            trigger OnPreDataItem()
            begin
                ExcelÜbergabe(1, 1, 'Artikelnr.', true, true, '@');
                ExcelÜbergabe(1, 2, 'Beschreibung', true, true, '@');
                ExcelÜbergabe(1, 3, 'Basiseinheitencode', true, true, '@');
                ExcelÜbergabe(1, 4, 'Menge (Basiseinheitencode)', true, true, '@');
                ExcelÜbergabe(1, 5, 'Einheit 1', true, true, '@');
                ExcelÜbergabe(1, 6, 'Menge (Einheit 1)', true, true, '@');
                ExcelÜbergabe(1, 7, 'Einheit 2', true, true, '@');
                ExcelÜbergabe(1, 8, 'Menge (Einheit 2)', true, true, '@');
                RowNo := 1;
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
        Excelpuffer: Record "Excel Buffer" temporary;
        ItemUnitofMeasure: Record "Item Unit of Measure";
        RowNo: Integer;
        ServerFileName: Text;
        i: Integer;


    procedure "ExcelÜbergabe"(Row: Integer; Column: Integer; Text: Text[250]; Fett: Boolean; Unter: Boolean; NumFormat: Text[30])
    begin
        Clear(Excelpuffer);
        Excelpuffer.Validate("Row No.", Row);
        Excelpuffer.Validate("Column No.", Column);
        Excelpuffer."Cell Value as Text" := Text;
        Excelpuffer.Bold := Fett;
        Excelpuffer.Underline := Unter;
        Excelpuffer.NumberFormat := NumFormat;
        Excelpuffer.Insert;
    end;
}


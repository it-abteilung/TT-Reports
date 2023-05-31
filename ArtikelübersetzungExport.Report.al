Report 50033 "Artikelübersetzung Export"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                RowNo += 1;
                ExcelÜbergabe(RowNo, 1, Item."No.", true, false, '@');   //G-ERP.RS 2021-07-15 Anfrage#2311413
                ExcelÜbergabe(RowNo, 2, 'ENU', true, false, '@');

                //G-ERP.RS 2021-07-15 +++ Anfrage#2311413
                // IF ItemTranslation.GET(Item."No.",'ENU') THEN BEGIN
                if ItemTranslation.Get(Item."No.", '', 'ENU') then begin
                    // ExcelÜbergabe(RowNo,1,Item."No.",TRUE,FALSE,'@');
                    // ExcelÜbergabe(RowNo,2,ItemTranslation."Language Code",TRUE,FALSE,'@');
                    //G-ERP.RS 2021-07-15 --- Anfrage#2311413
                    ExcelÜbergabe(RowNo, 3, ItemTranslation.Description, true, false, '@');
                    ExcelÜbergabe(RowNo, 4, ItemTranslation."Description 2", true, false, '@');
                end;
                //G-ERP.RS 2021-07-15 +++ Anfrage#2311413
                // ELSE BEGIN
                //  ExcelÜbergabe(RowNo,1,Item."No.",TRUE,FALSE,'@');
                //  ExcelÜbergabe(RowNo,2,'ENU',TRUE,FALSE,'@');
                //  ExcelÜbergabe(RowNo,3,Item.Description,TRUE,FALSE,'@');
                //  ExcelÜbergabe(RowNo,4,Item."Description 2",TRUE,FALSE,'@');
                // END;
                ExcelÜbergabe(RowNo, 5, 'DEU', true, false, '@');
                ExcelÜbergabe(RowNo, 6, Item.Description, true, false, '@');
                ExcelÜbergabe(RowNo, 7, Item."Description 2", true, false, '@');
                //G-ERP.RS 2021-07-15 --- Anfrage#2311413
            end;

            trigger OnPostDataItem()
            begin
                Excelpuffer.CreateNewBook('Artikelübersetzung');
                Excelpuffer.WriteSheet('Artikelübersetzung', COMPANYNAME, UserId);
                Excelpuffer.CloseBook;
                Excelpuffer.OpenExcel;
            end;

            trigger OnPreDataItem()
            begin
                ExcelÜbergabe(1, 1, 'Artikelnr.', true, true, '@');
                ExcelÜbergabe(1, 2, 'Sprache', true, true, '@');
                ExcelÜbergabe(1, 3, 'Beschreibung', true, true, '@');
                ExcelÜbergabe(1, 4, 'Beschreibung 2', true, true, '@');
                ExcelÜbergabe(1, 5, 'Sprache', true, true, '@');         //G-ERP.RS 2021-07-15 Anfrage#2311413
                ExcelÜbergabe(1, 6, 'Beschreibung', true, true, '@');    //G-ERP.RS 2021-07-15 Anfrage#2311413
                ExcelÜbergabe(1, 7, 'Beschreibung 2', true, true, '@');  //G-ERP.RS 2021-07-15 Anfrage#2311413
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
        ItemTranslation: Record "Item Translation";
        RowNo: Integer;
        ServerFileName: Text;


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


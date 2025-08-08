Report 50029 "Import Kalkulation from Excel"
{
    Caption = 'Import Budget from Excel';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Job; Job)
        {
            trigger OnAfterGetRecord()
            begin
                Clear(ImportKalkulation);
                ImportKalkulation.SetRange("Job No.", "No.");
                if ImportKalkulation.FindSet then
                    ImportKalkulation.DeleteAll;

                Job."Nachlass in Euro" := Hilfswert;
                Job.Modify;

                // TempExcelBuf.OpenBook(ServerFileName, SheetName);
                // TempExcelBuf.ReadSheet;
                //ReadExcelSheet;
                AnalyzeData;
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

    trigger OnPreReport()
    var
        TempNameValueBufferOut: Record "Name/Value Buffer" temporary;
    begin
        if UploadIntoStream('Read Excel', '', '', ServerFileName, Stream_in) then begin
            // alternativ: mehrere Blätter oder immer genau das erste, zweite...
            // dann würde man die Variable TempNameValueBufferOut benötigen
            //tempexcelbuf.GetSheetsNameListFromStream(Stream_in, TempNameValueBufferOut);
            // if TempNameValueBufferOut.FindFirst() then begin  
            //     SheetName := TempNameValueBufferOut.Value;
            //     Message('sheetname is %1', SheetName);
            //     // Todo: Abarbeitung mehrer Blätter hintereinander
            // end;
            // Alternativ: Auswahl des Blattes im Dialog
            SheetName := TempExcelBuf.SelectSheetsNameStream(Stream_in);
            TempExcelBuf.OpenBookStream(Stream_in, SheetName);
            TempExcelBuf.ReadSheet();
            // Verarbeitung der Sätze
            Message('number of record read %1', TempExcelBuf.Count);
        end;
    end;

    var
        Text000: label 'You must specify a budget name to import to.';
        Text001: label 'Do you want to create %1 %2.';
        Text002: label '%1 %2 is blocked. You cannot import entries.';
        Text003: label 'Are you sure you want to %1 for %2 %3.';
        Text004: label '%1 table has been successfully updated with %2 entries.';
        Text005: label 'Imported from Excel ';
        Text006: label 'Import Excel File';
        Text007: label 'Analyzing Data...\\';
        Text008: label 'You cannot specify more than 8 dimensions in your Excel worksheet.';
        Text009: label 'G/L ACCOUNT NO';
        Text010: label 'G/L Account No.';
        Text011: label 'The text G/L Account No. can only be specified once in the Excel worksheet.';
        Text012: label 'The dimensions specified by worksheet must be placed in the lines before the table.';
        Text013: label 'Dimension ';
        Text014: label 'Date';
        Text015: label 'Dimension 1';
        Text016: label 'Dimension 2';
        Text017: label 'Dimension 3';
        Text018: label 'Dimension 4';
        Text019: label 'Dimension 5';
        Text020: label 'Dimension 6';
        Text021: label 'Dimension 7';
        Text022: label 'Dimension 8';
        Text023: label 'You cannot import the same information twice.\';
        Text024: label 'The combination G/L Account No. - Dimensions - Date must be unique.';
        Text025: label 'G/L Accounts have not been found in the Excel worksheet.';
        Text026: label 'Dates have not been recognized in the Excel worksheet.';
        Text027: label 'Replace entries,Add entries';
        Text028: label 'A filter has been used on the %1 when the budget was exported. When a filter on a dimension has been used, a column with the same dimension must be present in the worksheet imported. The column in the worksheet must specify the dimension value codes the program should use when importing the budget.';
        TempExcelBuf: Record "Excel Buffer" temporary;
        JobsSetup: Record "Jobs Setup";
        Stream_in: InStream;
        FileName: Text[250];
        UploadedFileName: Text[1024];
        SheetName: Text[250];
        ImportOption: Option "Replace entries","Add entries";
        Window: Dialog;
        TotalRecNo: Integer;
        RecNo: Integer;
        ImportKalkulation: Record "Job Planning Line";
        Hilfswert: Decimal;
        Einlesen: Boolean;
        i: Integer;
        LetzteNr: Integer;
        ZeileEinlesen: Boolean;
        Baugr: Code[20];
        PosNr: Code[20];
        ServerFileName: Text;
        FileMgt: Codeunit "File Management";
        ExcelFileExtensionTok: label '.xlsx', Locked = true;
        Lief: Boolean;
        Leist: Boolean;
        Transp: Boolean;
        Hotelk: Boolean;
        Flugkos: Boolean;
        "Auslö": Boolean;
        Nachlass: Boolean;
        ZeileNachlass: Integer;

    local procedure AnalyzeData()
    begin
        Window.Open(
          Text007 +
          '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.Update(1, 0);
        TotalRecNo := TempExcelBuf.Count;
        RecNo := 0;
        JobsSetup.Get();

        TempExcelBuf.SetFilter("Row No.", '%1..', 7);
        if TempExcelBuf.Find('-') then begin
            Einlesen := false;
            i := 0;
            repeat
                RecNo := RecNo + 1;
                Window.Update(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                //    IF (TempExcelBuf."Row No." = 8) AND (TempExcelBuf."Column No." = 16) AND (TempExcelBuf."Cell Value as Text" <> '') THEN BEGIN
                if (TempExcelBuf."Row No." = 7) and (TempExcelBuf."Column No." = 14) and (TempExcelBuf."Cell Value as Text" <> '') then begin
                    Evaluate(Job."Reparatur  in Euro", TempExcelBuf."Cell Value as Text");
                    Job.Modify;
                end;
                //    IF (TempExcelBuf."Row No." = 8) AND (TempExcelBuf."Column No." = 18) AND (TempExcelBuf."Cell Value as Text" <> '') THEN BEGIN
                if (TempExcelBuf."Row No." = 8) and (TempExcelBuf."Column No." = 14) and (TempExcelBuf."Cell Value as Text" <> '') then begin
                    Evaluate(Job."Gütesicherung  in Euro", TempExcelBuf."Cell Value as Text");
                    Job.Modify;
                end;
                //    IF (TempExcelBuf."Row No." = 8) AND (TempExcelBuf."Column No." = 21) AND (TempExcelBuf."Cell Value as Text" <> '') THEN BEGIN
                if (TempExcelBuf."Row No." = 9) and (TempExcelBuf."Column No." = 14) and (TempExcelBuf."Cell Value as Text" <> '') then begin
                    Evaluate(Job."Brandwache  in Euro", TempExcelBuf."Cell Value as Text");
                    Job.Modify;
                end;
                // Ändern
                // Maschinenstunden
                if (TempExcelBuf."Row No." = 10) and (TempExcelBuf."Column No." = 14) and (TempExcelBuf."Cell Value as Text" <> '') then begin
                    Evaluate(Job."Maschinenstunden  in Euro", TempExcelBuf."Cell Value as Text");
                    Job.Modify;
                end;
                if (TempExcelBuf."Row No." = 11) and (TempExcelBuf."Column No." = 14) and (TempExcelBuf."Cell Value as Text" <> '') then begin
                    Evaluate(Job."Job e  in Euro", TempExcelBuf."Cell Value as Text");
                    Job.Modify;
                end;
                if (TempExcelBuf."Row No." = 12) and (TempExcelBuf."Column No." = 14) and (TempExcelBuf."Cell Value as Text" <> '') then begin
                    Evaluate(Job."Job f  in Euro", TempExcelBuf."Cell Value as Text");
                    Job.Modify;
                end;
                if (TempExcelBuf."Row No." = 13) and (TempExcelBuf."Column No." = 14) and (TempExcelBuf."Cell Value as Text" <> '') then begin
                    Evaluate(Job."Job g  in Euro", TempExcelBuf."Cell Value as Text");
                    Job.Modify;
                end;

                if (TempExcelBuf."Row No." = 7) and (TempExcelBuf."Column No." = 17) and (TempExcelBuf."Cell Value as Text" <> '') then begin
                    Evaluate(Job."Lagermaterialzuschlag %", TempExcelBuf."Cell Value as Text");
                    Job."Lagermaterialzuschlag %" := Job."Lagermaterialzuschlag %" * 100;
                    Job.Modify;
                end;
                if (TempExcelBuf."Row No." = 8) and (TempExcelBuf."Column No." = 17) and (TempExcelBuf."Cell Value as Text" <> '') then begin
                    Evaluate(Job."Fremdzuschlag %", TempExcelBuf."Cell Value as Text");
                    Job."Fremdzuschlag %" := Job."Fremdzuschlag %" * 100;
                    Job.Modify;
                end;
                // Fremdlieferung
                if (TempExcelBuf."Row No." = 9) and (TempExcelBuf."Column No." = 17) and (TempExcelBuf."Cell Value as Text" <> '') then begin
                    Evaluate(Job."Fremdlieferungzuschlag %", TempExcelBuf."Cell Value as Text");
                    Job."Fremdlieferungzuschlag %" := Job."Fremdlieferungzuschlag %" * 100;
                    Job.Modify;
                end;
                if (TempExcelBuf."Row No." = 10) and (TempExcelBuf."Column No." = 17) and (TempExcelBuf."Cell Value as Text" <> '') then begin
                    Evaluate(Job."Transportezuschlag %", TempExcelBuf."Cell Value as Text");
                    Job."Transportezuschlag %" := Job."Transportezuschlag %" * 100;
                    Job.Modify;
                end;
                if (TempExcelBuf."Row No." = 11) and (TempExcelBuf."Column No." = 17) and (TempExcelBuf."Cell Value as Text" <> '') then begin
                    Evaluate(Job."Hotelkostenzuschlag %", TempExcelBuf."Cell Value as Text");
                    Job."Hotelkostenzuschlag %" := Job."Hotelkostenzuschlag %" * 100;
                    Job.Modify;
                end;
                if (TempExcelBuf."Row No." = 12) and (TempExcelBuf."Column No." = 17) and (TempExcelBuf."Cell Value as Text" <> '') then begin
                    Evaluate(Job."Flugkostenzuschlag %", TempExcelBuf."Cell Value as Text");
                    Job."Flugkostenzuschlag %" := Job."Flugkostenzuschlag %" * 100;
                    Job.Modify;
                end;
                if (TempExcelBuf."Row No." = 13) and (TempExcelBuf."Column No." = 17) and (TempExcelBuf."Cell Value as Text" <> '') then begin
                    Evaluate(Job."Auslösezuschlag %", TempExcelBuf."Cell Value as Text");
                    Job."Auslösezuschlag %" := Job."Auslösezuschlag %" * 100;
                    Job.Modify;
                end;
                if (TempExcelBuf."Row No." > 19) and (TempExcelBuf."Column No." = 1) and (TempExcelBuf."Cell Value as Text" = '') then begin
                    ZeileEinlesen := false;
                    LetzteNr := 0;
                end;
                if (TempExcelBuf."Row No." > 19) and (TempExcelBuf."Column No." = 1) and (TempExcelBuf."Cell Value as Text" <> '') then begin
                    ZeileEinlesen := true;
                    Baugr := TempExcelBuf."Cell Value as Text";
                    LetzteNr := TempExcelBuf."Row No.";
                end;
                if (TempExcelBuf."Row No." > 19) and (TempExcelBuf."Column No." = 2) and (TempExcelBuf."Cell Value as Text" <> '') and
                   (TempExcelBuf."Cell Value as Text" = '0') and ZeileEinlesen then begin
                    ZeileEinlesen := false;
                    PosNr := TempExcelBuf."Cell Value as Text";
                    i += 10000;
                    Clear(ImportKalkulation);
                    ImportKalkulation."Job No." := Job."No.";
                    ImportKalkulation."Line No." := i;
                    ImportKalkulation.Baugruppe := Baugr;
                    ImportKalkulation.Pos := PosNr;
                    ImportKalkulation.Type := ImportKalkulation.Type::Text;
                    //      ImportKalkulation.VALIDATE("No.",'1');
                    ImportKalkulation.Description := '';
                    ImportKalkulation."Baugruppe Tree" := 0;
                    ImportKalkulation.Insert;
                end else begin
                    if (TempExcelBuf."Row No." > 19) and (TempExcelBuf."Column No." = 2) and (TempExcelBuf."Cell Value as Text" <> '') and
                       ZeileEinlesen then begin
                        PosNr := TempExcelBuf."Cell Value as Text";
                        i += 10000;
                        Clear(ImportKalkulation);
                        ImportKalkulation."Job No." := Job."No.";
                        ImportKalkulation."Line No." := i;
                        ImportKalkulation.Baugruppe := Baugr;
                        ImportKalkulation.Pos := PosNr;
                        ImportKalkulation.Type := ImportKalkulation.Type::Resource;
                        ImportKalkulation.Validate("No.", '1');
                        ImportKalkulation.Description := '';
                        ImportKalkulation."Baugruppe Tree" := 1;
                        ImportKalkulation.Insert;
                    end;
                end;

                if (TempExcelBuf."Row No." > 19) and (TempExcelBuf."Column No." = 4) and (TempExcelBuf."Cell Value as Text" <> '') and
                   //       (LetzteNr = TempExcelBuf."Row No.") AND ZeileEinlesen THEN BEGIN
                   (LetzteNr = TempExcelBuf."Row No.") then begin
                    ImportKalkulation.Description := CopyStr(TempExcelBuf."Cell Value as Text", 1, 50);
                    ImportKalkulation.Modify;
                end;

                // Lohnstunden
                if (TempExcelBuf."Row No." > 19) and (TempExcelBuf."Column No." = 7) and (TempExcelBuf."Cell Value as Text" <> '') and
                   (LetzteNr = TempExcelBuf."Row No.") and ZeileEinlesen then begin
                    Evaluate(Hilfswert, TempExcelBuf."Cell Value as Text");
                    ImportKalkulation.Quantity += Hilfswert;
                    ImportKalkulation.Validate(Quantity);
                    ImportKalkulation.Modify;
                end;

                // Stundensatz
                if (TempExcelBuf."Row No." > 19) and (TempExcelBuf."Column No." = 8) and (TempExcelBuf."Cell Value as Text" <> '') and
                   (LetzteNr = TempExcelBuf."Row No.") and ZeileEinlesen then begin
                    case TempExcelBuf."Cell Value as Text" of
                        'a':
                            begin
                                ImportKalkulation."Unit Price (LCY)" := Job."Reparatur  in Euro";
                                ImportKalkulation.Lohnkosten := ImportKalkulation."Unit Price (LCY)" * ImportKalkulation.Quantity;
                                ImportKalkulation."EK-Lohnkosten" := ImportKalkulation.Quantity * JobsSetup."Reparatur intern ░";
                            end;
                        'b':
                            begin
                                ImportKalkulation."Unit Price (LCY)" := Job."Gütesicherung  in Euro";
                                ImportKalkulation.Lohnkosten := ImportKalkulation."Unit Price (LCY)" * ImportKalkulation.Quantity;
                                ImportKalkulation."EK-Lohnkosten" := ImportKalkulation.Quantity * JobsSetup."Gütesicherung intern ░";
                            end;
                        'c':
                            begin
                                ImportKalkulation."Unit Price (LCY)" := Job."Brandwache  in Euro";
                                ImportKalkulation.Lohnkosten := ImportKalkulation."Unit Price (LCY)" * ImportKalkulation.Quantity;
                                ImportKalkulation."EK-Lohnkosten" := ImportKalkulation.Quantity * JobsSetup."Brandwache intern ░";
                            end;
                        'd':
                            begin
                                // Ändern
                                ImportKalkulation."Unit Price (LCY)" := Job."Maschinenstunden  in Euro";
                                ImportKalkulation.Lohnkosten := ImportKalkulation."Unit Price (LCY)" * ImportKalkulation.Quantity;
                                ImportKalkulation."EK-Lohnkosten" := ImportKalkulation.Quantity * JobsSetup."Brandwache intern ░";
                            end;
                        'e':
                            begin
                                // Ändern
                                ImportKalkulation."Unit Price (LCY)" := Job."Job e  in Euro";
                                ImportKalkulation.Lohnkosten := ImportKalkulation."Unit Price (LCY)" * ImportKalkulation.Quantity;
                                ImportKalkulation."EK-Lohnkosten" := ImportKalkulation.Quantity * JobsSetup."Brandwache intern ░";
                            end;
                        'f':
                            begin
                                // Ändern
                                ImportKalkulation."Unit Price (LCY)" := Job."Job f  in Euro";
                                ImportKalkulation.Lohnkosten := ImportKalkulation."Unit Price (LCY)" * ImportKalkulation.Quantity;
                                ImportKalkulation."EK-Lohnkosten" := ImportKalkulation.Quantity * JobsSetup."Brandwache intern ░";
                            end;
                        'g':
                            begin
                                // Ändern
                                ImportKalkulation."Unit Price (LCY)" := Job."Job g  in Euro";
                                ImportKalkulation.Lohnkosten := ImportKalkulation."Unit Price (LCY)" * ImportKalkulation.Quantity;
                                ImportKalkulation."EK-Lohnkosten" := ImportKalkulation.Quantity * JobsSetup."Brandwache intern ░";
                            end;
                    end;
                    ImportKalkulation.Modify;
                end;

                // Lagermaterial
                if (TempExcelBuf."Row No." > 19) and (TempExcelBuf."Column No." = 12) and (TempExcelBuf."Cell Value as Text" <> '') and
                   (LetzteNr = TempExcelBuf."Row No.") and ZeileEinlesen then begin
                    Evaluate(Hilfswert, TempExcelBuf."Cell Value as Text");
                    ImportKalkulation."EK-Materialkosten" := Hilfswert;
                    ImportKalkulation.Modify;
                end;
                if (TempExcelBuf."Row No." > 19) and (TempExcelBuf."Column No." = 13) and (TempExcelBuf."Cell Value as Text" <> '') and
                   (LetzteNr = TempExcelBuf."Row No.") and ZeileEinlesen then begin
                    Evaluate(Hilfswert, TempExcelBuf."Cell Value as Text");
                    ImportKalkulation.Materialkosten := ROUND(Hilfswert, 0.01);
                    ImportKalkulation.Modify;
                end;

                // Fremdmaterial/-zuschlag
                if (TempExcelBuf."Row No." > 19) and (TempExcelBuf."Column No." = 14) and (TempExcelBuf."Cell Value as Text" <> '') and
                   (LetzteNr = TempExcelBuf."Row No.") and ZeileEinlesen then begin
                    //EVALUATE(Hilfswert,TempExcelBuf."Cell Value as Text");
                    Lief := false;
                    Leist := false;
                    Transp := false;
                    Hotelk := false;
                    Flugkos := false;
                    Auslö := false;
                    case TempExcelBuf."Cell Value as Text" of
                        'Lieferung':
                            Lief := true;
                        'Leistung':
                            Leist := true;
                        'Transporte':
                            Transp := true;
                        'Hotelkosten':
                            Hotelk := true;
                        'Flugkosten':
                            Flugkos := true;
                        'Auslöse':
                            Auslö := true;
                    end;
                end;

                if (TempExcelBuf."Row No." > 19) and (TempExcelBuf."Column No." = 17) and (TempExcelBuf."Cell Value as Text" <> '') and
                   (LetzteNr = TempExcelBuf."Row No.") and ZeileEinlesen then begin
                    Evaluate(Hilfswert, TempExcelBuf."Cell Value as Text");
                    if Leist then
                        ImportKalkulation."EK-Fremdarbeitenkosten" := Hilfswert;
                    if Lief then
                        ImportKalkulation."EK-Fremdlieferungkosten" := Hilfswert;
                    if Transp then
                        ImportKalkulation."EK-Transport" := Hilfswert;
                    if Hotelk then
                        ImportKalkulation."EK-Hotelkosten" := Hilfswert;
                    if Flugkos then
                        ImportKalkulation."EK-Reisekosten" := Hilfswert;
                    if Auslö then
                        ImportKalkulation."EK-Auslöse" := Hilfswert;
                    ImportKalkulation.Modify;
                end;
                if (TempExcelBuf."Row No." > 19) and (TempExcelBuf."Column No." = 18) and (TempExcelBuf."Cell Value as Text" <> '') and
                   (LetzteNr = TempExcelBuf."Row No.") and ZeileEinlesen then begin
                    Evaluate(Hilfswert, TempExcelBuf."Cell Value as Text");
                    if Leist then
                        ImportKalkulation.Fremdarbeitenkosten := Hilfswert;
                    if Lief then
                        ImportKalkulation.Fremdlieferungskosten := Hilfswert;
                    if Transp then
                        ImportKalkulation.Transportkosten := Hilfswert;
                    if Hotelk then
                        ImportKalkulation.Hotelkosten := Hilfswert;
                    if Flugkos then
                        ImportKalkulation.Flugkosten := Hilfswert;
                    if Auslö then
                        ImportKalkulation.Auslöse := Hilfswert;
                    ImportKalkulation.Modify;
                end;

                if (TempExcelBuf."Row No." > 19) and (TempExcelBuf."Column No." = 18) and (TempExcelBuf."Cell Value as Text" <> '') then begin
                    if TempExcelBuf."Cell Value as Text" = 'Nachlass (netto):' then begin
                        Nachlass := true;
                        ZeileNachlass := TempExcelBuf."Row No.";
                    end;
                end;

                if (TempExcelBuf."Row No." > 19) and (TempExcelBuf."Column No." = 19) and (TempExcelBuf."Cell Value as Text" <> '') and
                  Nachlass and (ZeileNachlass = TempExcelBuf."Row No.") then begin
                    Evaluate(Hilfswert, TempExcelBuf."Cell Value as Text");
                    Job."Nachlass in Euro" := Hilfswert;
                    Job.Modify;
                    Nachlass := false;
                    ZeileNachlass := 0;
                end;

            until TempExcelBuf.Next = 0;
        end;

        Window.Close;
    end;

    local procedure FormatData(TextToFormat: Text[250]): Text[250]
    var
        FormatInteger: Integer;
        FormatDecimal: Decimal;
        FormatDate: Date;
    begin
        case true of
            Evaluate(FormatInteger, TextToFormat):
                exit(Format(FormatInteger));
            Evaluate(FormatDecimal, TextToFormat):
                exit(Format(FormatDecimal));
            Evaluate(FormatDate, TextToFormat):
                exit(Format(FormatDate));
            else
                exit(TextToFormat);
        end;
    end;
}
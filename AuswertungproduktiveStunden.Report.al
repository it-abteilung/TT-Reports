Report 50019 "Auswertung produktive Stunden"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Job; Job)
        {
            DataItemTableView = where("Job Type" = filter('10000' | '20000' | '30000' | '60000' | '70000' | '90000'));

            trigger OnAfterGetRecord()
            begin
                Clear(JobLedgerEntry);
                JobLedgerEntry.SetRange("Job No.", Job."No.");
                JobLedgerEntry.SetRange("Posting Date", StartDatum, EndDatum);
                JobLedgerEntry.SetRange(Type, JobLedgerEntry.Type::Resource);
                JobLedgerEntry.SetFilter("No.", '2*|3*');
                JobLedgerEntry.CalcSums(Quantity);
                StdTT := JobLedgerEntry.Quantity; //eigene Stunden
                JobLedgerEntry.SetFilter("No.", '9*');
                JobLedgerEntry.CalcSums(Quantity);
                StdFremd := JobLedgerEntry.Quantity; //fremde Stunden

                if (StdTT <> 0) or (StdFremd <> 0) then begin
                    case Job."Job Type" of
                        '10000':
                            begin
                                ExcelUebergabe(RowNo1, 1, Job."No.", false, false, '@');
                                ExcelUebergabe(RowNo1, 2, Format(StdTT), false, false, '#,##0.00');
                                ExcelUebergabe(RowNo1, 3, Format(StdFremd), false, false, '#,##0.00');
                                ExcelUebergabeFormula(RowNo1, 4, '=B' + Format(RowNo1) + '+ C' + Format(RowNo1), false, false, '#,##0.00');
                                RowNo1 += 1;
                            end;
                        '20000':
                            begin
                                ExcelUebergabe(RowNo2, 6, Job."No.", false, false, '@');
                                ExcelUebergabe(RowNo2, 7, Format(StdTT), false, false, '#,##0.00');
                                ExcelUebergabe(RowNo2, 8, Format(StdFremd), false, false, '#,##0.00');
                                ExcelUebergabeFormula(RowNo2, 9, '=G' + Format(RowNo2) + '+ H' + Format(RowNo2), false, false, '#,##0.00');
                                RowNo2 += 1;
                            end;
                        '30000':
                            begin
                                ExcelUebergabe(RowNo3, 11, Job."No.", false, false, '@');
                                ExcelUebergabe(RowNo3, 12, Format(StdTT), false, false, '#,##0.00');
                                ExcelUebergabe(RowNo3, 13, Format(StdFremd), false, false, '#,##0.00');
                                ExcelUebergabeFormula(RowNo3, 14, '=L' + Format(RowNo3) + '+ M' + Format(RowNo3), false, false, '#,##0.00');
                                RowNo3 += 1;
                            end;
                        '60000':
                            begin
                                ExcelUebergabe(RowNo6, 16, Job."No.", false, false, '@');
                                ExcelUebergabe(RowNo6, 17, Format(StdTT), false, false, '#,##0.00');
                                ExcelUebergabe(RowNo6, 18, Format(StdFremd), false, false, '#,##0.00');
                                ExcelUebergabeFormula(RowNo6, 19, '=Q' + Format(RowNo6) + '+ R' + Format(RowNo6), false, false, '#,##0.00');
                                RowNo6 += 1;
                            end;
                        '70000':
                            begin
                                ExcelUebergabe(RowNo7, 21, Job."No.", false, false, '@');
                                ExcelUebergabe(RowNo7, 22, Format(StdTT), false, false, '#,##0.00');
                                ExcelUebergabe(RowNo7, 23, Format(StdFremd), false, false, '#,##0.00');
                                ExcelUebergabeFormula(RowNo7, 24, '=V' + Format(RowNo7) + '+ W' + Format(RowNo7), false, false, '#,##0.00');
                                RowNo7 += 1;
                            end;
                        '90000':
                            begin
                                ExcelUebergabe(RowNo9, 26, Job."No.", false, false, '@');
                                ExcelUebergabe(RowNo9, 27, Format(StdTT), false, false, '#,##0.00');
                                ExcelUebergabe(RowNo9, 28, Format(StdFremd), false, false, '#,##0.00');
                                ExcelUebergabeFormula(RowNo9, 29, '=AA' + Format(RowNo9) + '+ AB' + Format(RowNo9), false, false, '#,##0.00');
                                RowNo9 += 1;
                            end;
                    end;
                end;
            end;

            trigger OnPostDataItem()
            begin
                RowNo1 += RowFooterAbstand - 1;
                RowNo2 += RowFooterAbstand - 1;
                RowNo3 += RowFooterAbstand - 1;
                RowNo6 += RowFooterAbstand - 1;
                RowNo7 += RowFooterAbstand - 1;
                RowNo9 += RowFooterAbstand - 1;

                ExcelUebergabe(RowNo1, 1, 'Gesamt', true, false, '@');
                ExcelUebergabeFormula(RowNo1, 2, '=SUM(B' + Format(RowHeader) + ':B' + Format(RowNo1 - RowFooterAbstand) + ')', true, false, '#,##0.00');
                ExcelUebergabeFormula(RowNo1, 3, '=SUM(C' + Format(RowHeader) + ':C' + Format(RowNo1 - RowFooterAbstand) + ')', true, false, '#,##0.00');
                ExcelUebergabeFormula(RowNo1, 4, '=SUM(D' + Format(RowHeader) + ':D' + Format(RowNo1 - RowFooterAbstand) + ')', true, false, '#,##0.00');

                ExcelUebergabe(RowNo2, 6, 'Gesamt', true, false, '@');
                ExcelUebergabeFormula(RowNo2, 7, '=SUM(G' + Format(RowHeader) + ':G' + Format(RowNo2 - RowFooterAbstand) + ')', true, false, '#,##0.00');
                ExcelUebergabeFormula(RowNo2, 8, '=SUM(H' + Format(RowHeader) + ':H' + Format(RowNo2 - RowFooterAbstand) + ')', true, false, '#,##0.00');
                ExcelUebergabeFormula(RowNo2, 9, '=SUM(I' + Format(RowHeader) + ':I' + Format(RowNo2 - RowFooterAbstand) + ')', true, false, '#,##0.00');

                ExcelUebergabe(RowNo3, 11, 'Gesamt', true, false, '@');
                ExcelUebergabeFormula(RowNo3, 12, '=SUM(L' + Format(RowHeader) + ':L' + Format(RowNo3 - RowFooterAbstand) + ')', true, false, '#,##0.00');
                ExcelUebergabeFormula(RowNo3, 13, '=SUM(M' + Format(RowHeader) + ':M' + Format(RowNo3 - RowFooterAbstand) + ')', true, false, '#,##0.00');
                ExcelUebergabeFormula(RowNo3, 14, '=SUM(N' + Format(RowHeader) + ':N' + Format(RowNo3 - RowFooterAbstand) + ')', true, false, '#,##0.00');

                ExcelUebergabe(RowNo6, 16, 'Gesamt', true, false, '@');
                ExcelUebergabeFormula(RowNo6, 17, '=SUM(Q' + Format(RowHeader) + ':Q' + Format(RowNo6 - RowFooterAbstand) + ')', true, false, '#,##0.00');
                ExcelUebergabeFormula(RowNo6, 18, '=SUM(R' + Format(RowHeader) + ':R' + Format(RowNo6 - RowFooterAbstand) + ')', true, false, '#,##0.00');
                ExcelUebergabeFormula(RowNo6, 19, '=SUM(S' + Format(RowHeader) + ':S' + Format(RowNo6 - RowFooterAbstand) + ')', true, false, '#,##0.00');

                ExcelUebergabe(RowNo7, 21, 'Gesamt', true, false, '@');
                ExcelUebergabeFormula(RowNo7, 22, '=SUM(V' + Format(RowHeader) + ':V' + Format(RowNo7 - RowFooterAbstand) + ')', true, false, '#,##0.00');
                ExcelUebergabeFormula(RowNo7, 23, '=SUM(W' + Format(RowHeader) + ':W' + Format(RowNo7 - RowFooterAbstand) + ')', true, false, '#,##0.00');
                ExcelUebergabeFormula(RowNo7, 24, '=SUM(X' + Format(RowHeader) + ':X' + Format(RowNo7 - RowFooterAbstand) + ')', true, false, '#,##0.00');

                ExcelUebergabe(RowNo9, 26, 'Gesamt', true, false, '@');
                ExcelUebergabeFormula(RowNo9, 27, '=SUM(AA' + Format(RowHeader) + ':AA' + Format(RowNo9 - RowFooterAbstand) + ')', true, false, '#,##0.00');
                ExcelUebergabeFormula(RowNo9, 28, '=SUM(AB' + Format(RowHeader) + ':AB' + Format(RowNo9 - RowFooterAbstand) + ')', true, false, '#,##0.00');
                ExcelUebergabeFormula(RowNo9, 29, '=SUM(AC' + Format(RowHeader) + ':AC' + Format(RowNo9 - RowFooterAbstand) + ')', true, false, '#,##0.00');

                ExcelBuffer.CreateNewBook('Auswertung produktive Stunden');
                ExcelBuffer.WriteSheet('Auswertung produktive Stunden', CompanyName, UserId);
                ExcelBuffer.CloseBook();
                ExcelBuffer.SetFriendlyFilename(StrSubstNo('Auswertung produktive Stunden %1 %2', CurrentDateTime, UserId));
                ExcelBuffer.OpenExcel();
            end;

            trigger OnPreDataItem()
            begin
                ExcelUebergabe(1, 1, 'Produktive Stunden', true, true, '@');

                ExcelUebergabe(RowHeader, 1, 'Projekttyp 10000', true, false, '@');
                ExcelUebergabe(RowHeader, 6, 'Projekttyp 20000', true, false, '@');
                ExcelUebergabe(RowHeader, 11, 'Projekttyp 30000', true, false, '@');
                ExcelUebergabe(RowHeader, 16, 'Projekttyp 60000', true, false, '@');
                ExcelUebergabe(RowHeader, 21, 'Projekttyp 70000', true, false, '@');
                ExcelUebergabe(RowHeader, 26, 'Projekttyp 90000', true, false, '@');
                RowHeader += 1;

                for i := 1 to 6 do begin
                    ExcelUebergabe(RowHeader, ColumnHeader, 'Auftrag', true, false, '@');
                    ExcelUebergabe(RowHeader, 1 + ColumnHeader, 'Std.TT', true, false, '@');
                    ExcelUebergabe(RowHeader, 2 + ColumnHeader, 'Std.FP', true, false, '@');
                    ExcelUebergabe(RowHeader, 3 + ColumnHeader, 'Gesamt', true, false, '@');
                    ColumnHeader += 5;
                end;
                RowHeader += 1;

                RowNo1 := RowHeader;
                RowNo2 := RowHeader;
                RowNo3 := RowHeader;
                RowNo6 := RowHeader;
                RowNo7 := RowHeader;
                RowNo9 := RowHeader;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Optionen)
                {
                    field(Startdatum; StartDatum)
                    {
                        ApplicationArea = Basic;
                    }
                    field(Enddatum; EndDatum)
                    {
                        ApplicationArea = Basic;
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

    trigger OnInitReport()
    begin
        ColumnHeader := 1;
        RowHeader := 3;
        RowFooterAbstand := 2;
    end;

    var
        ExcelBuffer: Record "Excel Buffer" temporary;
        JobLedgerEntry: Record "Job Ledger Entry";
        ColumnHeader: Integer;
        RowHeader: Integer;
        i: Integer;
        RowNo1: Integer;
        RowNo2: Integer;
        RowNo3: Integer;
        RowNo6: Integer;
        RowNo7: Integer;
        RowNo9: Integer;
        StartDatum: Date;
        EndDatum: Date;
        RowFooterAbstand: Integer;
        StdTT: Decimal;
        StdFremd: Decimal;


    procedure ExcelUebergabe(Row: Integer; Column: Integer; Text: Text[250]; Fett: Boolean; Unter: Boolean; NumFormat: Text[30])
    begin
        Clear(ExcelBuffer);
        ExcelBuffer.Validate("Row No.", Row);
        ExcelBuffer.Validate("Column No.", Column);
        ExcelBuffer."Cell Value as Text" := Text;
        ExcelBuffer.Bold := Fett;
        ExcelBuffer.Underline := Unter;
        ExcelBuffer.NumberFormat := NumFormat;
        ExcelBuffer.Insert;
    end;


    procedure ExcelUebergabeFormula(Row: Integer; Column: Integer; Text: Text[250]; Fett: Boolean; Unter: Boolean; NumFormat: Text[30])
    begin
        Clear(ExcelBuffer);
        ExcelBuffer.Validate("Row No.", Row);
        ExcelBuffer.Validate("Column No.", Column);
        ExcelBuffer."Cell Value as Text" := '';
        ExcelBuffer.SetFormula(Text);
        ExcelBuffer.Bold := Fett;
        ExcelBuffer.Underline := Unter;
        ExcelBuffer.NumberFormat := NumFormat;
        ExcelBuffer.Insert;
    end;
}


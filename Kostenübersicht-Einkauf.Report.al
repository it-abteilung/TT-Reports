Report 50022 "Kostenübersicht - Einkauf"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Kostenübersicht - Einkauf.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Job; Job)
        {
            DataItemTableView = sorting("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.";
            column(Text_Nr_Header; "No.")
            {
            }
            column(Text_Schiff_Header; SchiffRec.Description)
            {
            }
            column(Text_Date_Header; WorkDate)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(Body_Nr_Header; "No.")
            {
            }
            column(Text_Schiff_Body2; SchiffRec.Description)
            {
            }
            column(Text_Date_Body; WorkDate)
            {
            }
            column(Text_Page_Body; CurrReport.PageNo)
            {
            }
            column(Caption_Ueberschrift_Header; Caption_Ueberschrift_HeaderLbl)
            {
            }
            column(Caption_Nr_Header; FieldCaption("No."))
            {
            }
            column(Caption_Schiff_Header; Caption_Schiff_HeaderLbl)
            {
            }
            column(Caption_Versand_Header; Caption_Versand_HeaderLbl)
            {
            }
            column(Caption_Betrag_Header; Caption_Betrag_HeaderLbl)
            {
            }
            column(Caption_Leistung_Header; Caption_Leistung_HeaderLbl)
            {
            }
            column(Caption_EinkName_Header; Caption_EinkName_HeaderLbl)
            {
            }
            column(Caption_Date1_Header; Caption_Date1_HeaderLbl)
            {
            }
            column(Caption_Nr1_Header; Caption_Nr1_HeaderLbl)
            {
            }
            column(Caption_Rechnung_Header; Caption_Rechnung_HeaderLbl)
            {
            }
            column(Caption_Datum_Header; Caption_Datum_HeaderLbl)
            {
            }
            column(Caption_Page_Header; Caption_Page_HeaderLbl)
            {
            }
            column(Caption_Leistungsart_Header; Caption_Leistungsart_HeaderLbl)
            {
            }
            column(Caption_Ueberschrift_Body; Caption_Ueberschrift_BodyLbl)
            {
            }
            column(Caption_Nr_Body; FieldCaption("No."))
            {
            }
            column(Caption_Schiff_Body; Caption_Schiff_BodyLbl)
            {
            }
            column(Caption_Versand_Body; Caption_Versand_BodyLbl)
            {
            }
            column(Caption_Betrag_Body; Caption_Betrag_BodyLbl)
            {
            }
            column(Caption_Leistung_Body; Caption_Leistung_BodyLbl)
            {
            }
            column(Caption_EinkName_Body; Caption_EinkName_BodyLbl)
            {
            }
            column(Caption_Date1_Body; Caption_Date1_BodyLbl)
            {
            }
            column(Caption_Nr1_Body; Caption_Nr1_BodyLbl)
            {
            }
            column(Caption_Rechnung_Body; Caption_Rechnung_BodyLbl)
            {
            }
            column(Caption_Datum_Body; Caption_Datum_BodyLbl)
            {
            }
            column(Caption_Page_Body; Caption_Page_BodyLbl)
            {
            }
            column(Caption_Leistungsart_Body; Caption_Leistungsart_BodyLbl)
            {
            }
            dataitem("Job Ledger Entry"; "Job Ledger Entry")
            {
                DataItemLink = "Job No." = field("No.");
                DataItemTableView = sorting("Job No.", "Job Task No.", "Entry Type", "Posting Date") where(Type = const(Item), "Source Code" = filter(<> 'EINKAUF'));
                column(Lagerwert; "Job Ledger Entry"."Total Cost (LCY)")
                {
                }
            }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemLink = "Job No." = field("No.");
                DataItemTableView = sorting("Document Type", "Document No.", "Job No.", Leistungsart) order(ascending) where("Document Type" = const(Order));

                trigger OnAfterGetRecord()
                var
                    l_PurchLine: Record "Purchase Line";
                    l_amount: Decimal;
                    l_amountVAT: Decimal;
                    l_Versand: Decimal;
                    l_PurchHeader: Record "Purchase Header";
                    l_AktSumme: Decimal;
                begin
                    // G-ERP.AG 2021-06-24+
                    l_PurchHeader.Get("Document Type", "Document No.");

                    if l_PurchHeader."Job No." = '' then begin
                        // G-ERP.AG 2021-06-24-
                        drucken := false;
                        Clear(DrNummer);
                        Clear(DrDatum);
                        Clear(DrName);
                        Clear(DrLeistung);
                        Clear(DrBetrag);
                        Clear(DrVersand);
                        Clear(DrMWST);
                        Clear(DrRechnung);

                        //SETRANGE(Leistungsart,Leistungsart);
                        SetRange("Document No.", "Document No.");
                        Find('+');
                        LetzteBelegnummer := '';
                        //SETRANGE(Leistungsart);
                        SetRange("Document No.");

                        if "Purchase Line"."Document No." <> LetzteBelegnummer then begin

                            waehrungsfaktor := 1;
                            if l_PurchHeader.Get("Purchase Line"."Document Type", "Purchase Line"."Document No.") then
                                waehrungsfaktor := l_PurchHeader."Currency Factor";
                            if waehrungsfaktor = 0 then
                                waehrungsfaktor := 1;
                            LetzteBelegnummer := "Purchase Line"."Document No.";
                            Clear(l_amount);
                            Clear(l_amountVAT);
                            Clear(l_Versand);
                            MengeSicher := 0;
                            l_PurchLine.Reset;
                            l_PurchLine.SetRange("Document Type", l_PurchLine."document type"::Order);
                            l_PurchLine.SetRange("Document No.", "Purchase Line"."Document No.");
                            //l_PurchLine.SETRANGE(Type,l_PurchLine.Type::Item);
                            l_PurchLine.SetRange("Job No.", "Purchase Line"."Job No.");
                            //  l_PurchLine.SETRANGE(Leistungsart,Leistungsart);
                            if l_PurchLine.Find('-') then
                                repeat
                                    Clear(l_AktSumme);
                                    //     l_AktSumme := ((l_PurchLine.Quantity - l_PurchLine."Quantity Invoiced") *
                                    /*
                                    l_AktSumme := ((l_PurchLine."Outstanding Quantity") *
                                                    l_PurchLine."Direct Unit Cost" / waehrungsfaktor);
                                    MengeSicher += l_PurchLine."Outstanding Quantity";
                                    */
                                    if l_PurchLine."Qty. to Invoice" <> l_PurchLine.Quantity then
                                        l_PurchLine."Qty. to Invoice" := l_PurchLine.Quantity - l_PurchLine."Quantity Invoiced";
                                    l_AktSumme := ((l_PurchLine."Qty. to Invoice") *
                                                    l_PurchLine."Direct Unit Cost" / waehrungsfaktor);
                                    MengeSicher += l_PurchLine."Qty. to Invoice";
                                    //Rabatt berücksichtigen, auch wenn noch nicht gebucht wurde
                                    if l_PurchLine."Line Discount %" <> 0 then
                                        //       l_AktSumme := l_AktSumme - (l_AktSumme / 100 * l_PurchLine."Line Discount Amount");
                                        l_AktSumme := l_AktSumme - (l_AktSumme / 100 * l_PurchLine."Line Discount %");

                                    l_amount := l_amount + l_AktSumme;
                                    l_amountVAT := l_amountVAT + l_AktSumme + (l_AktSumme / 100 * l_PurchLine."VAT %");
                                    if (l_PurchLine."No." = '999900') or (l_PurchLine."No." = '999901') then begin
                                        l_Versand := l_Versand + l_AktSumme;
                                    end;
                                until l_PurchLine.Next = 0;


                            Clear(PurchInvHeader);
                            PurchInvHeader.SetRange("Order No.", l_PurchHeader."No.");
                            if not PurchInvHeader.Find('-') then
                                PurchInvHeader.Init;
                            /*
                            IF Excel THEN BEGIN
                              RowNo += 1;
                              ExcelÜbergabe(RowNo,1,l_PurchHeader."No.",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,2,FORMAT(l_PurchHeader."Order Date"),TRUE,FALSE,'');
                              ExcelÜbergabe(RowNo,3,l_PurchHeader."Buy-from Vendor Name",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,4,l_PurchHeader.Leistung,TRUE,FALSE,'@');
                              IF (l_amount-l_Versand) <> 0 THEN
                                ExcelÜbergabe(RowNo,5,FORMAT((l_amount-l_Versand),0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              IF l_Versand <> 0 THEN
                                ExcelÜbergabe(RowNo,6,FORMAT(l_Versand,0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              IF (l_amountVAT-l_amount) <> 0 THEN
                                ExcelÜbergabe(RowNo,7,FORMAT((l_amountVAT-l_amount),0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              ExcelÜbergabe(RowNo,8,PurchInvHeader."Vendor Invoice No.",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,9,FORMAT(l_PurchHeader.Leistungsart),TRUE,FALSE,'@');
                            END;
                            */
                            //  IF l_amount <> 0 THEN
                            if MengeSicher <> 0 then
                                drucken := true;
                            DrNummer := l_PurchHeader."No.";
                            DrDatum := l_PurchHeader."Order Date";
                            DrName := l_PurchHeader."Buy-from Vendor Name";
                            DrLeistung := l_PurchHeader.Leistung;
                            //  DrBetrag := l_amount+l_Versand;
                            DrBetrag := l_amount;
                            DrVersand := l_Versand;
                            DrMWST := l_amountVAT - l_amount;
                            DrRechnung := PurchInvHeader."Vendor Invoice No.";
                            if Leistungszeitraum = '' then
                                Leistungszeitraum := l_PurchHeader.Leistungszeitraum;

                            if MengeSicher <> 0 then begin
                                PurchLine_temp := l_PurchLine;
                                if PurchLine_temp.Leistungsart = 0 then
                                    PurchLine_temp.Leistungsart := l_PurchHeader.Leistungsart;
                                PurchLine_temp."Line No." := 0;
                                PurchLine_temp."Qty. to Invoice" := MengeSicher;
                                PurchLine_temp."Direct Unit Cost" := l_amount;
                                PurchLine_temp."Unit Cost (LCY)" := l_Versand;
                                PurchLine_temp.Amount := l_amountVAT - l_amount;
                                PurchLine_temp.Insert;
                            end;


                        end;
                    end;                                 // G-ERP.AG 2021-06-24

                end;
            }
            dataitem("Purchase Header"; "Purchase Header")
            {
                DataItemLink = "Job No." = field("No.");
                DataItemTableView = sorting("Document Type", "No.") order(ascending) where("Document Type" = const(Order));

                dataitem(PurchaseLine2; "Purchase Line")
                {
                    DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                    DataItemTableView = sorting("Document Type", "Document No.", "Job No.", Leistungsart) order(ascending);

                    trigger OnAfterGetRecord()
                    var
                        l_PurchHeader: Record "Purchase Header";
                        l_PurchLine: Record "Purchase Line";
                        l_amount: Decimal;
                        l_amountVAT: Decimal;
                        l_Versand: Decimal;
                        l_AktSumme: Decimal;
                    begin
                        drucken := false;
                        Clear(DrNummer);
                        Clear(DrDatum);
                        Clear(DrName);
                        Clear(DrLeistung);
                        Clear(DrBetrag);
                        Clear(DrVersand);
                        Clear(DrMWST);
                        Clear(DrRechnung);

                        //SETRANGE(Leistungsart,Leistungsart);
                        //SETRANGE("Document No.","Document No.");
                        Find('+');
                        LetzteBelegnummer := '';
                        //SETRANGE(Leistungsart);
                        //SETRANGE("Document No.");

                        if "Document No." <> LetzteBelegnummer then begin

                            waehrungsfaktor := 1;
                            Clear(l_PurchHeader);
                            if l_PurchHeader.Get("Document Type", "Document No.") then
                                waehrungsfaktor := l_PurchHeader."Currency Factor";

                            if waehrungsfaktor = 0 then
                                waehrungsfaktor := 1;
                            LetzteBelegnummer := "Document No.";
                            Clear(l_amount);
                            Clear(l_amountVAT);
                            Clear(l_Versand);
                            MengeSicher := 0;
                            l_PurchLine.Reset;
                            l_PurchLine.SetRange("Document Type", l_PurchLine."document type"::Order);
                            l_PurchLine.SetRange("Document No.", "Document No.");
                            // G-ERP.AG 2021-06-24  l_PurchLine.SETRANGE("Job No.",'LV');
                            if l_PurchLine.Find('-') then
                                repeat
                                    Clear(l_AktSumme);
                                    if l_PurchLine."Qty. to Invoice" <> l_PurchLine.Quantity then
                                        l_PurchLine."Qty. to Invoice" := l_PurchLine.Quantity - l_PurchLine."Quantity Invoiced";
                                    l_AktSumme := ((l_PurchLine."Qty. to Invoice") *
                                                    l_PurchLine."Direct Unit Cost" / waehrungsfaktor);
                                    MengeSicher += l_PurchLine."Qty. to Invoice";
                                    //Rabatt berücksichtigen, auch wenn noch nicht gebucht wurde
                                    if l_PurchLine."Line Discount %" <> 0 then
                                        l_AktSumme := l_AktSumme - (l_AktSumme / 100 * l_PurchLine."Line Discount %");

                                    l_amount := l_amount + l_AktSumme;
                                    l_amountVAT := l_amountVAT + l_AktSumme + (l_AktSumme / 100 * l_PurchLine."VAT %");
                                    if (l_PurchLine."No." = '999900') or (l_PurchLine."No." = '999901') then begin
                                        l_Versand := l_Versand + l_AktSumme;
                                    end;
                                until l_PurchLine.Next = 0;

                            Clear(PurchInvHeader);
                            PurchInvHeader.SetRange("Order No.", l_PurchHeader."No.");
                            if not PurchInvHeader.Find('-') then
                                PurchInvHeader.Init;

                            /*
                            IF Excel AND (MengeSicher <> 0) THEN BEGIN
                              RowNo += 1;
                              ExcelÜbergabe(RowNo,1,l_PurchHeader."No.",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,2,FORMAT(l_PurchHeader."Order Date"),TRUE,FALSE,'');
                              ExcelÜbergabe(RowNo,3,l_PurchHeader."Buy-from Vendor Name",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,4,l_PurchHeader.Leistung,TRUE,FALSE,'@');
                              IF (l_amount-l_Versand) <> 0 THEN
                                ExcelÜbergabe(RowNo,5,FORMAT((l_amount-l_Versand),0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              IF l_Versand <> 0 THEN
                                ExcelÜbergabe(RowNo,6,FORMAT(l_Versand,0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              IF (l_amountVAT-l_amount) <> 0 THEN
                                ExcelÜbergabe(RowNo,7,FORMAT((l_amountVAT-l_amount),0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              ExcelÜbergabe(RowNo,8,PurchInvHeader."Vendor Invoice No.",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,9,FORMAT(l_PurchHeader.Leistungsart),TRUE,FALSE,'@');
                            END;
                            */
                            //  IF l_amount <> 0 THEN
                            if MengeSicher <> 0 then
                                drucken := true;
                            DrNummer := l_PurchHeader."No.";
                            DrDatum := l_PurchHeader."Order Date";
                            DrName := l_PurchHeader."Buy-from Vendor Name";
                            DrLeistung := l_PurchHeader.Leistung;
                            //  DrBetrag := l_amount+l_Versand;
                            DrBetrag := l_amount;
                            DrVersand := l_Versand;
                            DrMWST := l_amountVAT - l_amount;
                            DrRechnung := PurchInvHeader."Vendor Invoice No.";
                            if Leistungszeitraum = '' then
                                Leistungszeitraum := l_PurchHeader.Leistungszeitraum;

                            if MengeSicher <> 0 then begin
                                if PurchLine_temp.Get(l_PurchLine."Document Type", l_PurchLine."Document No.", 0) then begin
                                    PurchLine_temp."Direct Unit Cost" += l_amount;
                                    PurchLine_temp."Unit Cost (LCY)" += l_Versand;
                                    PurchLine_temp.Amount += l_amountVAT - l_amount;
                                    PurchLine_temp.Modify;
                                end
                                else begin
                                    PurchLine_temp := l_PurchLine;
                                    if PurchLine_temp.Leistungsart = 0 then
                                        PurchLine_temp.Leistungsart := l_PurchHeader.Leistungsart;
                                    PurchLine_temp."Line No." := 0;
                                    PurchLine_temp."Qty. to Invoice" := MengeSicher;
                                    PurchLine_temp."Direct Unit Cost" := l_amount;
                                    PurchLine_temp."Unit Cost (LCY)" := l_Versand;
                                    PurchLine_temp.Amount := l_amountVAT - l_amount;
                                    PurchLine_temp.Insert;
                                end;
                            end;

                        end;

                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    SetFilter("Job No.", '<>%1', '');       // G-ERP.AG 2021-06-24
                end;
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number);
                column(Text_Nr1_PurchaseLine3; DrNummer)
                {
                }
                column(Text_Datum1_PurchaseLine3; DrDatum)
                {
                }
                column(Text_EKName_PurchaseLine3; DrName)
                {
                }
                column(Text_Leistung_PurchaseLine3; DrLeistung)
                {
                }
                column(Text_Betrag_PurchaseLine3; DrBetrag)
                {
                }
                column(Text_Versand_PurchaseLine3; PurchLine_temp.Leistungszeitraum)
                {
                }
                column(Text_Rechnung_PurchaseLine3; DrRechnung)
                {
                }
                column(Text_Leistungsart_PurchaseLine3; PurchLine_temp.Leistungsart)
                {
                }
                column(Text_drucken_PurchaseLine3; drucken)
                {
                }
                column(Caption_Bestellung_PurchaseLine3; Caption_Bestellung_PurchaseLineLbl)
                {
                }
                column(Purchase_Line_Document_Type3; PurchLine_temp."Document Type")
                {
                }
                column(Purchase_Line_Document_No_3; PurchLine_temp."Document No.")
                {
                }
                column(Purchase_Line_Line_No_3; PurchLine_temp."Line No.")
                {
                }
                column(Purchase_Line_Job_No_3; PurchLine_temp."Job No.")
                {
                }

                trigger OnAfterGetRecord()
                var
                    l_PurchHeader: Record "Purchase Header";
                    l_PurchLine: Record "Purchase Line";
                    l_amount: Decimal;
                    l_amountVAT: Decimal;
                    l_Versand: Decimal;
                    l_AktSumme: Decimal;
                begin
                    if Number > 1 then
                        PurchLine_temp.Next;
                    drucken := false;
                    Clear(DrNummer);
                    Clear(DrDatum);
                    Clear(DrName);
                    Clear(DrLeistung);
                    Clear(DrBetrag);
                    Clear(DrVersand);
                    Clear(DrMWST);
                    Clear(DrRechnung);

                    Clear(l_PurchHeader);
                    if l_PurchHeader.Get(PurchLine_temp."Document Type", PurchLine_temp."Document No.") then
                        Clear(PurchInvHeader);
                    PurchInvHeader.SetRange("Order No.", l_PurchHeader."No.");
                    if not PurchInvHeader.Find('-') then
                        PurchInvHeader.Init;

                    if Excel then begin
                        RowNo += 1;
                        ExcelÜbergabe(RowNo, 1, l_PurchHeader."No.", true, false, '@');
                        ExcelÜbergabe(RowNo, 2, Format(l_PurchHeader."Order Date"), true, false, '');
                        ExcelÜbergabe(RowNo, 3, l_PurchHeader."Buy-from Vendor Name", true, false, '@');
                        ExcelÜbergabe(RowNo, 4, l_PurchHeader.Leistung, true, false, '@');
                        if (PurchLine_temp."Direct Unit Cost" - PurchLine_temp."Unit Cost (LCY)") <> 0 then
                            ExcelÜbergabe(RowNo, 5, Format((PurchLine_temp."Direct Unit Cost" - PurchLine_temp."Unit Cost (LCY)"), 0, '<Sign><Integer><Decimals>'), true, false, '');
                        if PurchLine_temp."Unit Cost (LCY)" <> 0 then
                            ExcelÜbergabe(RowNo, 6, Format(PurchLine_temp."Unit Cost (LCY)", 0, '<Sign><Integer><Decimals>'), true, false, '');
                        if (PurchLine_temp.Amount) <> 0 then
                            ExcelÜbergabe(RowNo, 7, Format((PurchLine_temp.Amount), 0, '<Sign><Integer><Decimals>'), true, false, '');
                        ExcelÜbergabe(RowNo, 8, PurchInvHeader."Vendor Invoice No.", true, false, '@');
                        ExcelÜbergabe(RowNo, 9, Format(l_PurchHeader.Leistungsart), true, false, '@');
                    end;


                    if PurchLine_temp."Qty. to Invoice" <> 0 then
                        drucken := true;

                    DrNummer := l_PurchHeader."No.";
                    DrDatum := l_PurchHeader."Order Date";
                    DrName := l_PurchHeader."Buy-from Vendor Name";
                    DrLeistung := l_PurchHeader.Leistung;
                    DrBetrag := PurchLine_temp."Direct Unit Cost";
                    DrVersand := PurchLine_temp."Unit Cost (LCY)";
                    DrMWST := PurchLine_temp.Amount;
                    DrRechnung := PurchInvHeader."Vendor Invoice No.";
                    if PurchLine_temp.Leistungszeitraum = '' then
                        PurchLine_temp.Leistungszeitraum := l_PurchHeader.Leistungszeitraum;
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.BREAK;
                    Integer.SetRange(Number, 1, PurchLine_temp.Count);
                    if PurchLine_temp.FindFirst then;
                end;
            }
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Job No." = field("No.");
                DataItemTableView = sorting("Document No.", "Job No.", Leistungsart) order(ascending);

                trigger OnAfterGetRecord()
                var
                    l_PurchInvLine: Record "Purch. Inv. Line";
                    l_amount: Decimal;
                    l_amountVAT: Decimal;
                    l_Versand: Decimal;
                    l_PurchInvHeader: Record "Purch. Inv. Header";
                begin
                    // G-ERP.AG 2021-06-24+
                    l_PurchInvHeader.Get("Document No.");

                    if l_PurchInvHeader."Job No." = '' then begin
                        // G-ERP.AG 2021-06-24-

                        drucken := false;
                        Clear(DrNummer);
                        Clear(DrDatum);
                        Clear(DrName);
                        Clear(DrLeistung);
                        Clear(DrBetrag);
                        Clear(DrVersand);
                        Clear(DrMWST);
                        Clear(DrRechnung);

                        //????SETRANGE(Leistungsart,Leistungsart);
                        SetRange("Document No.", "Document No.");
                        Find('+');
                        LetzteBelegnummer := '';
                        //????SETRANGE(Leistungsart);
                        SetRange("Document No.");


                        if "Purch. Inv. Line"."Document No." <> LetzteBelegnummer then begin
                            waehrungsfaktor := 1;
                            if l_PurchInvHeader.Get("Purch. Inv. Line"."Document No.") then
                                waehrungsfaktor := l_PurchInvHeader."Currency Factor";
                            if waehrungsfaktor = 0 then
                                waehrungsfaktor := 1;
                            LetzteBelegnummer := "Purch. Inv. Line"."Document No.";
                            Clear(l_amount);
                            Clear(l_amountVAT);
                            Clear(l_Versand);
                            l_PurchInvLine.Reset;
                            l_PurchInvLine.SetRange("Document No.", "Document No.");
                            //l_PurchInvLine.SETRANGE(Type,l_PurchInvLine.Type::Item);
                            l_PurchInvLine.SetRange("Job No.", "Job No.");
                            //????  l_PurchInvLine.SETRANGE(Leistungsart,Leistungsart);
                            if l_PurchInvLine.Find('-') then begin
                                repeat
                                    if l_PurchInvHeader."Prices Including VAT" then begin
                                        l_amount := l_amount + (l_PurchInvLine.Amount / waehrungsfaktor);
                                        l_amountVAT := l_amountVAT +
                                                       (l_PurchInvLine.Amount / waehrungsfaktor) +
                                                       (l_PurchInvLine.Amount / waehrungsfaktor / 100 * l_PurchInvLine."VAT %");
                                        if (l_PurchInvLine."No." = '999900') or (l_PurchInvLine."No." = '999901') then begin
                                            l_Versand := l_Versand + (l_PurchInvLine.Amount / waehrungsfaktor);
                                        end;
                                    end
                                    else begin
                                        l_amount := l_amount + (l_PurchInvLine."Line Amount" / waehrungsfaktor);
                                        l_amountVAT := l_amountVAT +
                                                       (l_PurchInvLine."Line Amount" / waehrungsfaktor) +
                                                       (l_PurchInvLine."Line Amount" / waehrungsfaktor / 100 * l_PurchInvLine."VAT %");
                                        if (l_PurchInvLine."No." = '999900') or (l_PurchInvLine."No." = '999901') then begin
                                            l_Versand := l_Versand + (l_PurchInvLine."Line Amount" / waehrungsfaktor);
                                        end;
                                    end;
                                until l_PurchInvLine.Next = 0;
                            end;
                            /*
                            IF Excel THEN BEGIN
                              RowNo += 1;
                              ExcelÜbergabe(RowNo,1,l_PurchInvHeader."No.",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,2,FORMAT(l_PurchInvHeader."Order Date"),TRUE,FALSE,'');
                              ExcelÜbergabe(RowNo,3,l_PurchInvHeader."Buy-from Vendor Name",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,4,l_PurchInvHeader.Leistung,TRUE,FALSE,'@');
                              IF (l_amount-l_Versand) <> 0 THEN
                                ExcelÜbergabe(RowNo,5,FORMAT((l_amount-l_Versand),0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              IF l_Versand <> 0 THEN
                                ExcelÜbergabe(RowNo,6,FORMAT(l_Versand,0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              IF (l_amountVAT-l_amount) <> 0 THEN
                                ExcelÜbergabe(RowNo,7,FORMAT((l_amountVAT-l_amount),0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              ExcelÜbergabe(RowNo,8,l_PurchInvHeader."Vendor Invoice No.",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,9,FORMAT(l_PurchInvHeader.Leistungsart),TRUE,FALSE,'@');
                            END;
                            */
                            if l_amount <> 0 then
                                drucken := true;
                            DrNummer := l_PurchInvHeader."Order No.";
                            DrDatum := l_PurchInvHeader."Order Date";
                            DrName := l_PurchInvHeader."Buy-from Vendor Name";
                            DrLeistung := l_PurchInvHeader.Leistung;
                            //  DrBetrag := l_amount+l_Versand;
                            DrBetrag := l_amount;
                            DrVersand := l_Versand;
                            DrMWST := l_amountVAT - l_amount;
                            DrRechnung := l_PurchInvHeader."Vendor Invoice No.";
                            if Leistungszeitraum = '' then
                                Leistungszeitraum := l_PurchInvHeader.Leistungszeitraum;

                            if l_amount <> 0 then begin
                                if PurchInvLine_temp.Get(l_PurchInvLine."Document No.", 0) then begin
                                    PurchInvLine_temp."Direct Unit Cost" += l_amount;
                                    PurchInvLine_temp."Unit Cost (LCY)" += l_Versand;
                                    PurchInvLine_temp.Amount += l_amountVAT - l_amount;
                                    PurchInvLine_temp.Modify;
                                end
                                else begin
                                    PurchInvLine_temp := l_PurchInvLine;
                                    if PurchInvLine_temp.Leistungsart = 0 then
                                        PurchInvLine_temp.Leistungsart := l_PurchInvHeader.Leistungsart;
                                    PurchInvLine_temp."Line No." := 0;
                                    PurchInvLine_temp."Direct Unit Cost" := l_amount;
                                    PurchInvLine_temp."Unit Cost (LCY)" := l_Versand;
                                    PurchInvLine_temp.Amount := l_amountVAT - l_amount;
                                    PurchInvLine_temp.Insert;
                                end;
                            end;

                        end;
                    end;                        // G-ERP.AG 2021-06-24

                end;
            }
            dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
            {
                DataItemLink = "Job No." = field("No.");
                DataItemTableView = sorting("No.");
                dataitem(Purch_Inv_Line2; "Purch. Inv. Line")
                {
                    DataItemLink = "Document No." = field("No.");
                    DataItemTableView = sorting("Document No.", "Line No.");
                    column(ReportForNavId_100000032; 100000032)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        l_PurchInvLine: Record "Purch. Inv. Line";
                        l_amount: Decimal;
                        l_amountVAT: Decimal;
                        l_Versand: Decimal;
                        l_PurchInvHeader: Record "Purch. Inv. Header";
                    begin
                        drucken := false;
                        Clear(DrNummer);
                        Clear(DrDatum);
                        Clear(DrName);
                        Clear(DrLeistung);
                        Clear(DrBetrag);
                        Clear(DrVersand);
                        Clear(DrMWST);
                        Clear(DrRechnung);

                        //????SETRANGE(Leistungsart,Leistungsart);
                        //SETRANGE("Document No.","Document No.");
                        Find('+');
                        LetzteBelegnummer := '';
                        //????SETRANGE(Leistungsart);
                        //SETRANGE("Document No.");


                        if "Document No." <> LetzteBelegnummer then begin
                            waehrungsfaktor := 1;
                            if l_PurchInvHeader.Get("Document No.") then
                                waehrungsfaktor := l_PurchInvHeader."Currency Factor";
                            if waehrungsfaktor = 0 then
                                waehrungsfaktor := 1;
                            LetzteBelegnummer := "Document No.";
                            Clear(l_amount);
                            Clear(l_amountVAT);
                            Clear(l_Versand);
                            l_PurchInvLine.Reset;
                            l_PurchInvLine.SetRange("Document No.", "Document No.");
                            // G-ERP.AG 2021-06-24  l_PurchInvLine.SETRANGE("Job No.",'LV');
                            if l_PurchInvLine.Find('-') then begin
                                repeat
                                    if l_PurchInvHeader."Prices Including VAT" then begin
                                        l_amount := l_amount + (l_PurchInvLine.Amount / waehrungsfaktor);
                                        l_amountVAT := l_amountVAT +
                                                       (l_PurchInvLine.Amount / waehrungsfaktor) +
                                                       (l_PurchInvLine.Amount / waehrungsfaktor / 100 * l_PurchInvLine."VAT %");
                                        if (l_PurchInvLine."No." = '999900') or (l_PurchInvLine."No." = '999901') then begin
                                            l_Versand := l_Versand + (l_PurchInvLine.Amount / waehrungsfaktor);
                                        end;
                                    end
                                    else begin
                                        l_amount := l_amount + (l_PurchInvLine."Line Amount" / waehrungsfaktor);
                                        l_amountVAT := l_amountVAT +
                                                       (l_PurchInvLine."Line Amount" / waehrungsfaktor) +
                                                       (l_PurchInvLine."Line Amount" / waehrungsfaktor / 100 * l_PurchInvLine."VAT %");
                                        if (l_PurchInvLine."No." = '999900') or (l_PurchInvLine."No." = '999901') then begin
                                            l_Versand := l_Versand + (l_PurchInvLine."Line Amount" / waehrungsfaktor);
                                        end;
                                    end;
                                until l_PurchInvLine.Next = 0;
                            end;
                            /*
                            IF Excel THEN BEGIN
                              RowNo += 1;
                              ExcelÜbergabe(RowNo,1,l_PurchInvHeader."No.",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,2,FORMAT(l_PurchInvHeader."Order Date"),TRUE,FALSE,'');
                              ExcelÜbergabe(RowNo,3,l_PurchInvHeader."Buy-from Vendor Name",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,4,l_PurchInvHeader.Leistung,TRUE,FALSE,'@');
                              IF (l_amount-l_Versand) <> 0 THEN
                                ExcelÜbergabe(RowNo,5,FORMAT((l_amount-l_Versand),0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              IF l_Versand <> 0 THEN
                                ExcelÜbergabe(RowNo,6,FORMAT(l_Versand,0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              IF (l_amountVAT-l_amount) <> 0 THEN
                                ExcelÜbergabe(RowNo,7,FORMAT((l_amountVAT-l_amount),0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              ExcelÜbergabe(RowNo,8,l_PurchInvHeader."Vendor Invoice No.",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,9,FORMAT(l_PurchInvHeader.Leistungsart),TRUE,FALSE,'@');
                            END;
                            */

                            if l_amount <> 0 then
                                drucken := true;
                            DrNummer := l_PurchInvHeader."Order No.";
                            DrDatum := l_PurchInvHeader."Order Date";
                            DrName := l_PurchInvHeader."Buy-from Vendor Name";
                            DrLeistung := l_PurchInvHeader.Leistung;
                            //  DrBetrag := l_amount+l_Versand;
                            DrBetrag := l_amount;
                            DrVersand := l_Versand;
                            DrMWST := l_amountVAT - l_amount;
                            DrRechnung := l_PurchInvHeader."Vendor Invoice No.";
                            if Leistungszeitraum = '' then
                                Leistungszeitraum := l_PurchInvHeader.Leistungszeitraum;

                            if l_amount <> 0 then begin
                                if PurchInvLine_temp.Get(l_PurchInvLine."Document No.", 0) then begin
                                    PurchInvLine_temp."Direct Unit Cost" += l_amount;
                                    PurchInvLine_temp."Unit Cost (LCY)" += l_Versand;
                                    PurchInvLine_temp.Amount += l_amountVAT - l_amount;
                                    PurchInvLine_temp.Modify;
                                end
                                else begin
                                    PurchInvLine_temp := l_PurchInvLine;
                                    if PurchInvLine_temp.Leistungsart = 0 then
                                        PurchInvLine_temp.Leistungsart := l_PurchInvHeader.Leistungsart;
                                    PurchInvLine_temp."Line No." := 0;
                                    PurchInvLine_temp."Direct Unit Cost" := l_amount;
                                    PurchInvLine_temp."Unit Cost (LCY)" := l_Versand;
                                    PurchInvLine_temp.Amount := l_amountVAT - l_amount;
                                    PurchInvLine_temp.Insert;
                                end;
                            end;

                        end;

                    end;
                }

                trigger OnPreDataItem()
                begin
                    SetFilter("Job No.", '<>%1', '');       // G-ERP.AG 2021-06-24
                end;
            }
            dataitem(Integer_Rech; "Integer")
            {
                DataItemTableView = sorting(Number);
                column(Text_Nr1_PurchaseInvLine; DrNummer)
                {
                }
                column(Text_Datum1_PurchaseInvLine; DrDatum)
                {
                }
                column(Text_EKName_PurchaseInvLine; DrName)
                {
                }
                column(Text_Leistung_PurchaseInvLine; DrLeistung)
                {
                }
                column(Text_Betrag_PurchaseInvLine; DrBetrag)
                {
                }
                column(Text_Versand_PurchaseInvLine; PurchInvLine_temp.Leistungszeitraum)
                {
                }
                column(Text_Rechnung_PurchaseInvLine; DrRechnung)
                {
                }
                column(Text_Leistungsart_PurchaseInvLine; PurchInvLine_temp.Leistungsart)
                {
                }
                column(Text_drucken2; drucken)
                {
                }
                column(Caption_EKRechnung_PurchaseINVLine; Caption_EKRechnung_PurchaseINVLineLbl)
                {
                }
                column(Purch__Inv__Line_Document_No_; PurchInvLine_temp."Document No.")
                {
                }
                column(Purch__Inv__Line_Line_No_; PurchInvLine_temp."Line No.")
                {
                }
                column(Purch__Inv__Line_Job_No_; PurchInvLine_temp."Job No.")
                {
                }

                trigger OnAfterGetRecord()
                var
                    l_PurchInvHeader: Record "Purch. Inv. Header";
                begin
                    if Number > 1 then
                        PurchInvLine_temp.Next;
                    drucken := false;
                    Clear(DrNummer);
                    Clear(DrDatum);
                    Clear(DrName);
                    Clear(DrLeistung);
                    Clear(DrBetrag);
                    Clear(DrVersand);
                    Clear(DrMWST);
                    Clear(DrRechnung);

                    Clear(l_PurchInvHeader);
                    if l_PurchInvHeader.Get(PurchInvLine_temp."Document No.") then;

                    if Excel then begin
                        RowNo += 1;
                        ExcelÜbergabe(RowNo, 1, l_PurchInvHeader."Order No.", true, false, '@');
                        ExcelÜbergabe(RowNo, 2, Format(l_PurchInvHeader."Order Date"), true, false, '');
                        ExcelÜbergabe(RowNo, 3, l_PurchInvHeader."Buy-from Vendor Name", true, false, '@');
                        ExcelÜbergabe(RowNo, 4, l_PurchInvHeader.Leistung, true, false, '@');
                        if (PurchInvLine_temp."Direct Unit Cost" - PurchInvLine_temp."Unit Cost (LCY)") <> 0 then
                            ExcelÜbergabe(RowNo, 5, Format((PurchInvLine_temp."Direct Unit Cost" - PurchInvLine_temp."Unit Cost (LCY)"), 0, '<Sign><Integer><Decimals>'), true, false, '');
                        if PurchInvLine_temp."Unit Cost (LCY)" <> 0 then
                            ExcelÜbergabe(RowNo, 6, Format(PurchInvLine_temp."Unit Cost (LCY)", 0, '<Sign><Integer><Decimals>'), true, false, '');
                        if (PurchInvLine_temp.Amount) <> 0 then
                            ExcelÜbergabe(RowNo, 7, Format((PurchInvLine_temp.Amount), 0, '<Sign><Integer><Decimals>'), true, false, '');
                        ExcelÜbergabe(RowNo, 8, l_PurchInvHeader."Vendor Invoice No.", true, false, '@');
                        ExcelÜbergabe(RowNo, 9, Format(l_PurchInvHeader.Leistungsart), true, false, '@');
                    end;


                    if PurchInvLine_temp."Direct Unit Cost" <> 0 then
                        drucken := true;

                    DrNummer := l_PurchInvHeader."Order No.";
                    DrDatum := l_PurchInvHeader."Order Date";
                    DrName := l_PurchInvHeader."Buy-from Vendor Name";
                    DrLeistung := l_PurchInvHeader.Leistung;
                    DrBetrag := PurchInvLine_temp."Direct Unit Cost";
                    DrVersand := PurchInvLine_temp."Unit Cost (LCY)";
                    DrMWST := PurchInvLine_temp.Amount;
                    DrRechnung := l_PurchInvHeader."Vendor Invoice No.";
                    if PurchInvLine_temp.Leistungszeitraum = '' then
                        PurchInvLine_temp.Leistungszeitraum := l_PurchInvHeader.Leistungszeitraum;
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.BREAK;

                    SetRange(Number, 1, PurchInvLine_temp.Count);
                    if PurchInvLine_temp.FindFirst then;
                end;
            }
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Job No." = field("No.");
                DataItemTableView = sorting("Document No.", "Job No.", Leistungsart) order(ascending);

                trigger OnAfterGetRecord()
                var
                    l_PurchCrMLine: Record "Purch. Cr. Memo Line";
                    l_amount: Decimal;
                    l_amountVAT: Decimal;
                    l_Versand: Decimal;
                    l_PurchCrMHeader: Record "Purch. Cr. Memo Hdr.";
                begin
                    // G-ERP.AG 2021-06-24+
                    l_PurchCrMHeader.Get("Document No.");

                    if l_PurchCrMHeader."Job No." = '' then begin
                        // G-ERP.AG 2021-06-24-

                        drucken := false;
                        Clear(DrNummer);
                        Clear(DrDatum);
                        Clear(DrName);
                        Clear(DrLeistung);
                        Clear(DrBetrag);
                        Clear(DrVersand);
                        Clear(DrMWST);
                        Clear(DrRechnung);

                        //SETRANGE(Leistungsart,Leistungsart);
                        SetRange("Document No.", "Document No.");
                        Find('+');
                        LetzteBelegnummer := '';
                        //SETRANGE(Leistungsart);
                        SetRange("Document No.");

                        if "Purch. Cr. Memo Line"."Document No." <> LetzteBelegnummer then begin
                            LetzteBelegnummer := "Purch. Cr. Memo Line"."Document No.";
                            waehrungsfaktor := 1;
                            if l_PurchCrMHeader.Get("Purch. Cr. Memo Line"."Document No.") then
                                waehrungsfaktor := l_PurchCrMHeader."Currency Factor";
                            if waehrungsfaktor = 0 then
                                waehrungsfaktor := 1;
                            Clear(l_amount);
                            Clear(l_amountVAT);
                            Clear(l_Versand);
                            l_PurchCrMLine.Reset;
                            l_PurchCrMLine.SetRange("Document No.", "Purch. Cr. Memo Line"."Document No.");
                            //l_PurchCrMLine.SETRANGE(Type,l_PurchCrMLine.Type::Item);
                            l_PurchCrMLine.SetRange("Job No.", "Purch. Cr. Memo Line"."Job No.");
                            //  l_PurchCrMLine.SETRANGE(Leistungsart,Leistungsart);
                            if l_PurchCrMLine.Find('-') then
                                repeat
                                    l_amount := l_amount + (l_PurchCrMLine.Quantity * l_PurchCrMLine."Direct Unit Cost" / waehrungsfaktor);
                                    l_amountVAT := l_amountVAT +
                                                   (l_PurchCrMLine."Line Amount" / waehrungsfaktor) +
                                                   (l_PurchCrMLine."Line Amount" / waehrungsfaktor / 100 * l_PurchCrMLine."VAT %");
                                    if (l_PurchCrMLine."No." = '999900') or (l_PurchCrMLine."No." = '999901') then begin
                                        l_Versand := l_Versand + (l_PurchCrMLine."Line Amount" / waehrungsfaktor);
                                    end;
                                until l_PurchCrMLine.Next = 0;

                            /*
                            IF Excel THEN BEGIN
                              RowNo += 1;
                              ExcelÜbergabe(RowNo,1,l_PurchCrMHeader."No.",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,2,FORMAT(l_PurchCrMHeader."Posting Date"),TRUE,FALSE,'');
                              ExcelÜbergabe(RowNo,3,l_PurchCrMHeader."Buy-from Vendor Name",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,4,l_PurchCrMHeader.Leistung,TRUE,FALSE,'@');
                              IF (l_amount-l_Versand) <> 0 THEN
                                ExcelÜbergabe(RowNo,5,FORMAT((l_amount-l_Versand),0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              IF l_Versand <> 0 THEN
                                ExcelÜbergabe(RowNo,6,FORMAT(l_Versand,0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              IF (l_amountVAT-l_amount) <> 0 THEN
                                ExcelÜbergabe(RowNo,7,FORMAT((l_amountVAT-l_amount),0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              ExcelÜbergabe(RowNo,8,l_PurchCrMHeader."Vendor Cr. Memo No.",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,9,FORMAT(l_PurchCrMHeader.Leistungsart),TRUE,FALSE,'@');
                            END;
                            */
                            if l_amount <> 0 then
                                drucken := true;
                            DrNummer := l_PurchCrMHeader."Pre-Assigned No.";
                            DrDatum := l_PurchCrMHeader."Posting Date";
                            DrName := l_PurchCrMHeader."Buy-from Vendor Name";
                            DrLeistung := l_PurchCrMHeader.Leistung;
                            //  DrBetrag := l_amount+l_Versand;
                            DrBetrag := l_amount;
                            DrVersand := l_Versand;
                            DrMWST := l_amountVAT - l_amount;
                            DrRechnung := l_PurchCrMHeader."Vendor Cr. Memo No.";
                            if Leistungszeitraum = '' then
                                Leistungszeitraum := l_PurchCrMHeader.Leistungszeitraum;

                            if l_amount <> 0 then begin
                                if PurchCrMemoLine_temp.Get(l_PurchCrMLine."Document No.", 0) then begin
                                    PurchCrMemoLine_temp."Direct Unit Cost" += l_amount;
                                    PurchCrMemoLine_temp."Unit Cost (LCY)" += l_Versand;
                                    PurchCrMemoLine_temp.Amount += l_amountVAT - l_amount;
                                    PurchCrMemoLine_temp.Modify;
                                end
                                else begin
                                    PurchCrMemoLine_temp := l_PurchCrMLine;
                                    if PurchCrMemoLine_temp.Leistungsart = 0 then
                                        PurchCrMemoLine_temp.Leistungsart := l_PurchCrMHeader.Leistungsart;
                                    PurchCrMemoLine_temp."Line No." := 0;
                                    PurchCrMemoLine_temp."Direct Unit Cost" := l_amount;
                                    PurchCrMemoLine_temp."Unit Cost (LCY)" := l_Versand;
                                    PurchCrMemoLine_temp.Amount := l_amountVAT - l_amount;
                                    PurchCrMemoLine_temp.Insert;
                                end;
                            end;


                        end;
                    end;                        // G-ERP.AG 2021-06-24

                end;
            }
            dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
            {
                DataItemLink = "Job No." = field("No.");
                DataItemTableView = sorting("No.");
                dataitem(Purch_Cr_MemoLine2; "Purch. Cr. Memo Line")
                {
                    DataItemLink = "Document No." = field("No.");
                    DataItemTableView = sorting("Document No.", "Line No.");
                    column(ReportForNavId_100000035; 100000035)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        l_PurchCrMLine: Record "Purch. Cr. Memo Line";
                        l_amount: Decimal;
                        l_amountVAT: Decimal;
                        l_Versand: Decimal;
                        l_PurchCrMHeader: Record "Purch. Cr. Memo Hdr.";
                    begin
                        drucken := false;
                        Clear(DrNummer);
                        Clear(DrDatum);
                        Clear(DrName);
                        Clear(DrLeistung);
                        Clear(DrBetrag);
                        Clear(DrVersand);
                        Clear(DrMWST);
                        Clear(DrRechnung);

                        //SETRANGE(Leistungsart,Leistungsart);
                        //SETRANGE("Document No.","Document No.");
                        Find('+');
                        LetzteBelegnummer := '';
                        //SETRANGE(Leistungsart);
                        //SETRANGE("Document No.");

                        if "Document No." <> LetzteBelegnummer then begin
                            LetzteBelegnummer := "Document No.";
                            waehrungsfaktor := 1;
                            if l_PurchCrMHeader.Get("Document No.") then
                                waehrungsfaktor := l_PurchCrMHeader."Currency Factor";
                            if waehrungsfaktor = 0 then
                                waehrungsfaktor := 1;
                            Clear(l_amount);
                            Clear(l_amountVAT);
                            Clear(l_Versand);
                            l_PurchCrMLine.Reset;
                            l_PurchCrMLine.SetRange("Document No.", "Document No.");
                            // G-ERP.AG 2021-06-24  l_PurchCrMLine.SETRANGE("Job No.",'LV');
                            if l_PurchCrMLine.Find('-') then
                                repeat
                                    l_amount := l_amount + (l_PurchCrMLine.Quantity * l_PurchCrMLine."Direct Unit Cost" / waehrungsfaktor);
                                    l_amountVAT := l_amountVAT +
                                                   (l_PurchCrMLine."Line Amount" / waehrungsfaktor) +
                                                   (l_PurchCrMLine."Line Amount" / waehrungsfaktor / 100 * l_PurchCrMLine."VAT %");
                                    if (l_PurchCrMLine."No." = '999900') or (l_PurchCrMLine."No." = '999901') then begin
                                        l_Versand := l_Versand + (l_PurchCrMLine."Line Amount" / waehrungsfaktor);
                                    end;
                                until l_PurchCrMLine.Next = 0;

                            /*
                            IF Excel THEN BEGIN
                              RowNo += 1;
                              ExcelÜbergabe(RowNo,1,l_PurchCrMHeader."No.",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,2,FORMAT(l_PurchCrMHeader."Posting Date"),TRUE,FALSE,'');
                              ExcelÜbergabe(RowNo,3,l_PurchCrMHeader."Buy-from Vendor Name",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,4,l_PurchCrMHeader.Leistung,TRUE,FALSE,'@');
                              IF (l_amount-l_Versand) <> 0 THEN
                                ExcelÜbergabe(RowNo,5,FORMAT((l_amount-l_Versand),0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              IF l_Versand <> 0 THEN
                                ExcelÜbergabe(RowNo,6,FORMAT(l_Versand,0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              IF (l_amountVAT-l_amount) <> 0 THEN
                                ExcelÜbergabe(RowNo,7,FORMAT((l_amountVAT-l_amount),0,'<Sign><Integer><Decimals>'),TRUE,FALSE,'');
                              ExcelÜbergabe(RowNo,8,l_PurchCrMHeader."Vendor Cr. Memo No.",TRUE,FALSE,'@');
                              ExcelÜbergabe(RowNo,9,FORMAT(l_PurchCrMHeader.Leistungsart),TRUE,FALSE,'@');
                            END;
                            */
                            if l_amount <> 0 then
                                drucken := true;
                            DrNummer := l_PurchCrMHeader."Pre-Assigned No.";
                            DrDatum := l_PurchCrMHeader."Posting Date";
                            DrName := l_PurchCrMHeader."Buy-from Vendor Name";
                            DrLeistung := l_PurchCrMHeader.Leistung;
                            DrBetrag := l_amount;
                            DrVersand := l_Versand;
                            DrMWST := l_amountVAT - l_amount;
                            DrRechnung := l_PurchCrMHeader."Vendor Cr. Memo No.";
                            if Leistungszeitraum = '' then
                                Leistungszeitraum := l_PurchCrMHeader.Leistungszeitraum;

                            if l_amount <> 0 then begin
                                if PurchCrMemoLine_temp.Get(l_PurchCrMLine."Document No.", 0) then begin
                                    PurchCrMemoLine_temp."Direct Unit Cost" += l_amount;
                                    PurchCrMemoLine_temp."Unit Cost (LCY)" += l_Versand;
                                    PurchCrMemoLine_temp.Amount += l_amountVAT - l_amount;
                                    PurchCrMemoLine_temp.Modify;
                                end
                                else begin
                                    PurchCrMemoLine_temp := l_PurchCrMLine;
                                    if PurchCrMemoLine_temp.Leistungsart = 0 then
                                        PurchCrMemoLine_temp.Leistungsart := l_PurchCrMHeader.Leistungsart;
                                    PurchCrMemoLine_temp."Line No." := 0;
                                    PurchCrMemoLine_temp."Direct Unit Cost" := l_amount;
                                    PurchCrMemoLine_temp."Unit Cost (LCY)" := l_Versand;
                                    PurchCrMemoLine_temp.Amount := l_amountVAT - l_amount;
                                    PurchCrMemoLine_temp.Insert;
                                end;
                            end;

                        end;

                    end;
                }

                trigger OnPreDataItem()
                begin
                    SetFilter("Job No.", '<>%1', '');       // G-ERP.AG 2021-06-24
                end;
            }
            dataitem(Integer_Gutschrift; "Integer")
            {
                DataItemTableView = sorting(Number);
                column(Text_Nr1_PurchaseCrLine; DrNummer)
                {
                }
                column(Text_Datum1_PurchaseCrLine; DrDatum)
                {
                }
                column(Text_EKName_PurchaseCrLine; DrName)
                {
                }
                column(Text_Leistung_PurchaseCrLine; DrLeistung)
                {
                }
                column(Text_Betrag_PurchaseCrLine; -DrBetrag)
                {
                }
                column(Text_Versand_PurchaseCrLine; PurchCrMemoLine_temp.Leistungszeitraum)
                {
                }
                column(Text_Rechnung_PurchaseCrLine; DrRechnung)
                {
                }
                column(Text_Leistungsart_PurchaseCrLine; PurchCrMemoLine_temp.Leistungsart)
                {
                }
                column(Text_drucken3; drucken)
                {
                }
                column(Caption_EKGutschrift_PurchaseCRLine; Caption_EKGutschrift_PurchaseCRLineLbl)
                {
                }
                column(Purch__Cr__Memo_Line_Document_No_; PurchCrMemoLine_temp."Document No.")
                {
                }
                column(Purch__Cr__Memo_Line_Line_No_; PurchCrMemoLine_temp."Line No.")
                {
                }
                column(Purch__Cr__Memo_Line_Job_No_; PurchCrMemoLine_temp."Job No.")
                {
                }

                trigger OnAfterGetRecord()
                var
                    l_PurchCrMHeader: Record "Purch. Cr. Memo Hdr.";
                begin
                    if Number > 1 then
                        PurchCrMemoLine_temp.Next;

                    drucken := false;
                    Clear(DrNummer);
                    Clear(DrDatum);
                    Clear(DrName);
                    Clear(DrLeistung);
                    Clear(DrBetrag);
                    Clear(DrVersand);
                    Clear(DrMWST);
                    Clear(DrRechnung);

                    Clear(l_PurchCrMHeader);
                    if l_PurchCrMHeader.Get(PurchCrMemoLine_temp."Document No.") then;

                    if Excel then begin
                        RowNo += 1;
                        ExcelÜbergabe(RowNo, 1, l_PurchCrMHeader."Pre-Assigned No.", true, false, '@');
                        ExcelÜbergabe(RowNo, 2, Format(l_PurchCrMHeader."Posting Date"), true, false, '');
                        ExcelÜbergabe(RowNo, 3, l_PurchCrMHeader."Buy-from Vendor Name", true, false, '@');
                        ExcelÜbergabe(RowNo, 4, l_PurchCrMHeader.Leistung, true, false, '@');
                        if (PurchCrMemoLine_temp."Direct Unit Cost" - PurchCrMemoLine_temp."Unit Cost (LCY)") <> 0 then
                            ExcelÜbergabe(RowNo, 5, Format((PurchCrMemoLine_temp."Direct Unit Cost" - PurchCrMemoLine_temp."Unit Cost (LCY)"), 0, '<Sign><Integer><Decimals>'), true, false, '');
                        if PurchCrMemoLine_temp."Unit Cost (LCY)" <> 0 then
                            ExcelÜbergabe(RowNo, 6, Format(PurchCrMemoLine_temp."Unit Cost (LCY)", 0, '<Sign><Integer><Decimals>'), true, false, '');
                        if (PurchCrMemoLine_temp.Amount) <> 0 then
                            ExcelÜbergabe(RowNo, 7, Format((PurchCrMemoLine_temp.Amount), 0, '<Sign><Integer><Decimals>'), true, false, '');
                        ExcelÜbergabe(RowNo, 8, l_PurchCrMHeader."Vendor Cr. Memo No.", true, false, '@');
                        ExcelÜbergabe(RowNo, 9, Format(l_PurchCrMHeader.Leistungsart), true, false, '@');
                    end;


                    if PurchCrMemoLine_temp."Direct Unit Cost" <> 0 then
                        drucken := true;

                    DrNummer := l_PurchCrMHeader."Pre-Assigned No.";
                    DrDatum := l_PurchCrMHeader."Posting Date";
                    DrName := l_PurchCrMHeader."Buy-from Vendor Name";
                    DrLeistung := l_PurchCrMHeader.Leistung;
                    DrBetrag := PurchCrMemoLine_temp."Direct Unit Cost";
                    DrVersand := PurchCrMemoLine_temp."Unit Cost (LCY)";
                    DrMWST := PurchCrMemoLine_temp.Amount;
                    DrRechnung := l_PurchCrMHeader."Vendor Cr. Memo No.";
                    if PurchCrMemoLine_temp.Leistungszeitraum = '' then
                        PurchCrMemoLine_temp.Leistungszeitraum := l_PurchCrMHeader.Leistungszeitraum;
                end;

                trigger OnPreDataItem()
                begin
                    //CurrReport.BREAK;

                    SetRange(Number, 1, PurchCrMemoLine_temp.Count);
                    if PurchCrMemoLine_temp.FindFirst then;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                Clear(SchiffRec);
                if SchiffRec.Get('SCHIFF', Job.Object) then;

                if Excel then begin
                    ExcelÜbergabe(3, 2, Job.FieldCaption("No."), true, false, '@');
                    ExcelÜbergabe(3, 3, Job."No.", true, false, '@');
                    ExcelÜbergabe(3, 5, 'Schiff', true, false, '@');
                    ExcelÜbergabe(3, 6, SchiffRec.Description, true, false, '@');

                    //Überschriften
                    ExcelÜbergabe(5, 1, 'Nr.', true, true, '@');
                    ExcelÜbergabe(5, 2, 'Datum', true, true, '@');
                    ExcelÜbergabe(5, 3, 'Eink. von Name', true, true, '@');
                    ExcelÜbergabe(5, 4, 'Leistung', true, true, '@');
                    ExcelÜbergabe(5, 5, 'Betrag', true, true, '@');
                    ExcelÜbergabe(5, 6, 'Versand', true, true, '@');
                    ExcelÜbergabe(5, 7, 'MwSt', true, true, '@');
                    ExcelÜbergabe(5, 8, 'Rechnung', true, true, '@');
                    ExcelÜbergabe(5, 9, 'Leistungsart', true, true, '@');

                    RowNo := 5;
                end;
            end;

            trigger OnPreDataItem()
            begin
                if Excel then begin
                    ExcelÜbergabe(1, 4, 'Kostenübersicht - Einkauf neu', true, true, '@');
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Excel; Excel)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Excelübergabe';
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
        Seit: label 'Seite';
        PurchLine: Record "Purchase Line";
        PurchLine_temp: Record "Purchase Line" temporary;
        PurchInvLine: Record "Purch. Inv. Line";
        PurchInvLine_temp: Record "Purch. Inv. Line" temporary;
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        PurchCrMemoLine_temp: Record "Purch. Cr. Memo Line" temporary;
        PurchHeader: Record "Purchase Header";
        PurchInvHeader: Record "Purch. Inv. Header";
        SchiffRec: Record "Multi Table";
        Excelpuffer: Record "Excel Buffer" temporary;
        Versand: Decimal;
        Excel: Boolean;
        RowNo: Integer;
        LetzteBelegnummer: Code[20];
        drucken: Boolean;
        DrNummer: Code[20];
        DrDatum: Date;
        DrName: Text[100];
        DrLeistung: Text[120];
        DrBetrag: Decimal;
        DrVersand: Decimal;
        DrMWST: Decimal;
        DrRechnung: Code[35];
        waehrungsfaktor: Decimal;
        MengeSicher: Decimal;
        Caption_Ueberschrift_HeaderLbl: label 'Kostenübersicht - Einkauf';
        Caption_Schiff_HeaderLbl: label 'Schiff';
        Caption_Versand_HeaderLbl: label 'Leistungszeitraum';
        Caption_Betrag_HeaderLbl: label 'Betrag';
        Caption_Leistung_HeaderLbl: label 'Leistung';
        Caption_EinkName_HeaderLbl: label 'Eink von Name';
        Caption_Date1_HeaderLbl: label 'Datum';
        Caption_Nr1_HeaderLbl: label 'Nr.';
        Caption_Rechnung_HeaderLbl: label 'Rechnung';
        Caption_Datum_HeaderLbl: label 'Druckdatum:';
        Caption_Page_HeaderLbl: label 'Page:';
        Caption_Leistungsart_HeaderLbl: label 'Leistungsart';
        Caption_Ueberschrift_BodyLbl: label 'Kostenübersicht - Einkauf';
        Caption_Schiff_BodyLbl: label 'Schiff';
        Caption_Versand_BodyLbl: label 'Leistungszeitraum';
        Caption_Betrag_BodyLbl: label 'Betrag';
        Caption_Leistung_BodyLbl: label 'Leistung';
        Caption_EinkName_BodyLbl: label 'Eink von Name';
        Caption_Date1_BodyLbl: label 'Datum';
        Caption_Nr1_BodyLbl: label 'Nr.';
        Caption_Rechnung_BodyLbl: label 'Rechnung';
        Caption_Datum_BodyLbl: label 'Druckdatum:';
        Caption_Page_BodyLbl: label 'Page:';
        Caption_Leistungsart_BodyLbl: label 'Leistungsart';
        Caption_Bestellung_PurchaseLineLbl: label 'Bestellungen';
        Caption_EKRechnung_PurchaseINVLineLbl: label 'EK-Rechnungen';
        Caption_EKGutschrift_PurchaseCRLineLbl: label 'EK-Gutschriften';
        FileMgt: Codeunit "File Management";
        ServerFileName: Text;
        Text002: label 'Update Workbook';
        ExcelFileExtensionTok: label '.xlsx', Locked = true;
        SheetName: Text[250];
        ClientFileName: Text;

    trigger OnPostReport()
    begin
        if Excel then begin
            Excelpuffer.CreateNewBook('Kostenübersicht - Einkauf');
            Excelpuffer.WriteSheet('Kostenübersicht - Einkauf', COMPANYNAME, UserId);
            Excelpuffer.CloseBook;
            Excelpuffer.SetFriendlyFilename(StrSubstNo('Kostenübersicht - Einkauf', CurrentDateTime, UserId));
            Excelpuffer.OpenExcel;
        end;
    end;

    procedure "ExcelÜbergabe"(Row: Integer; Column: Integer; Text: Text[250]; Fett: Boolean; Unter: Boolean; NumFormat: Text[30])
    begin
        if not Excel then
            exit;

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


Report 50051 "TT Order Barcode"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TT Order Barcode.rdlc';
    Caption = 'Order';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Buy-from Vendor No.", "No. Printed";
            RequestFilterHeading = 'Purchase Order';
            column(ReportForNavId_4458; 4458)
            {
            }
            column(Purchase_Header_Document_Type; "Document Type")
            {
            }
            column(Purchase_Header_No_; "No.")
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                column(ReportForNavId_5701; 5701)
                {
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    PrintOnlyIfDetail = true;
                    column(ReportForNavId_6455; 6455)
                    {
                    }
                    column(STRSUBSTNO_Text004_CopyText__________Purchase_Header___Job_No____________Purchase_Header___No__; StrSubstNo(Text004, CopyText) + ' ' + "Purchase Header"."Job No." + '/' + "Purchase Header"."No.")
                    {
                    }
                    column(BuyFromAddr_1_; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr_2_; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr_3_; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr_4_; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr_5_; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr_6_; BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr_7_; BuyFromAddr[7])
                    {
                    }
                    column(BuyFromAddr_8_; BuyFromAddr[8])
                    {
                    }
                    column(CompanyInfo_Address___________CompanyInfo__Post_Code__________CompanyInfo_City_______Germany_; CompanyInfo.Address + ' ╠ ' + CompanyInfo."Post Code" + ' ' + CompanyInfo.City + ' ╠ Germany')
                    {
                    }
                    column(CompanyInfo_Name; CompanyInfo.Name)
                    {
                    }
                    column(Purchase_Header___No________; '*' + "Purchase Header"."No." + '*')
                    {
                    }
                    column(Purchase_Header__Bestellername; "Purchase Header".Bestellername)
                    {
                    }
                    column(Purchase_Header___Expected_Receipt_Date_; "Purchase Header"."Expected Receipt Date")
                    {
                    }
                    column(Purchase_Header__BestellernameCaption; "Purchase Header".FieldCaption(Bestellername))
                    {
                    }
                    column(Purchase_Header___Expected_Receipt_Date_Caption; "Purchase Header".FieldCaption("Expected Receipt Date"))
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem("Purchase Line"; "Purchase Line")
                    {
                        DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                        DataItemLinkReference = "Purchase Header";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.");
                        column(ReportForNavId_6547; 6547)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break;
                        end;
                    }
                    dataitem(RoundLoop; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(ReportForNavId_7551; 7551)
                        {
                        }
                        column(Purchase_Line__Description_Control63; "Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line__Quantity; "Purchase Line".Quantity)
                        {
                        }
                        column(Purchase_Line___Unit_of_Measure_; "Purchase Line"."Unit of Measure")
                        {
                        }
                        column(pos; pos)
                        {
                        }
                        column(FORMAT_PurchLine__Line_No_________; '*' + Format(PurchLine."Line No.") + '*')
                        {
                        }
                        column(Purchase_Line___Description_2_; "Purchase Line"."Description 2")
                        {
                        }
                        column(Baugruppe______Purchase_Line__Baugruppe; 'Baugruppe: ' + "Purchase Line".Baugruppe)
                        {
                        }
                        column(Pos_______Purchase_Line__Pos; 'Pos: ' + "Purchase Line".Pos)
                        {
                        }
                        column(Purchase_Line__Description_Control63Caption; "Purchase Line".FieldCaption(Description))
                        {
                        }
                        column(Purchase_Line__QuantityCaption; Purchase_Line__QuantityCaptionLbl)
                        {
                        }
                        column(Purchase_Line___Unit_of_Measure_Caption; Purchase_Line___Unit_of_Measure_CaptionLbl)
                        {
                        }
                        column(Pos_Caption; Pos_CaptionLbl)
                        {
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }
                        column(VisibilityPurchLine; VisibilityPurchLine)
                        {
                        }
                        column(Item_Picture; Item.Picture)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then
                                PurchLine.Find('-')
                            else
                                PurchLine.Next;
                            "Purchase Line" := PurchLine;

                            if not "Purchase Header"."Prices Including VAT" and
                               (PurchLine."VAT Calculation Type" = PurchLine."vat calculation type"::"Full VAT")
                            then
                                PurchLine."Line Amount" := 0;

                            if (PurchLine.Type = PurchLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Purchase Line"."No." := '';

                            if ("Purchase Line".Type = "Purchase Line".Type::Item) and ("MwSt%" = 0) then
                                "MwSt%" := "Purchase Line"."VAT %";

                            if PurchLine.Type > 0 then begin
                                pos := IncStr(pos);
                            end;

                            if UnitofMeasureTranslation.Get("Purchase Line"."Unit of Measure", "Purchase Header"."Language Code") then
                                "Purchase Line"."Unit of Measure" := UnitofMeasureTranslation.Description;
                            /*
                            CLEAR(JobLineBudget);
                            IF JobLineBudget.GET("Purchase Line"."Job No.","Purchase Line"."Job Line Unique No.") THEN BEGIN
                              IF JobLineBudget.Baugruppe = '' THEN
                                IF JobLineBudget.GET("Purchase Line"."Job No.",JobLineBudget."Node No.") THEN;
                            END;
                            */

                            //G-ERP.KBS 2017-07-26 +
                            if PurchLine.Type > 0 then
                                VisibilityPurchLine := false //Zeile wird angezeigt
                            else
                                VisibilityPurchLine := true; //Zeile wird NICHT angezeigt
                            //CurrReport.SHOWOUTPUT(PurchLine.Type > 0);
                            //IF PurchLine.Type > 0 THEN
                            //  pos := INCSTR(pos);
                            if "Purchase Line"."Unit of Measure" = '' then
                                "Purchase Line".Quantity := 0;
                            //G-ERP.KBS 2017-07-26 -

                            //G-ERP.KBS 2017-08-15 +
                            Clear(Item);
                            if Item.Get("Purchase Line"."No.") then;
                            //G-ERP.KBS 2017-08-15 -

                        end;

                        trigger OnPostDataItem()
                        begin



                            PurchLine.DeleteAll;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := PurchLine.Find('+');
                            while MoreLines and (PurchLine.Description = '') and (PurchLine."Description 2" = '') and
                                  (PurchLine."No." = '') and (PurchLine.Quantity = 0) and
                                  (PurchLine.Amount = 0) do
                                MoreLines := PurchLine.Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break;
                            PurchLine.SetRange("Line No.", 0, PurchLine."Line No.");
                            PurchLine.SetFilter(Type, '%1..', PurchLine.Type::"G/L Account");
                            SetRange(Number, 1, PurchLine.Count);
                            CurrReport.CreateTotals(PurchLine."Line Amount", PurchLine."Inv. Discount Amount");
                            "MwSt%" := 0;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        pos := '000';
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    PrepmtPurchLine: Record "Purchase Line" temporary;
                begin
                    Clear(PurchLine);
                    Clear(PurchPost);
                    PurchLine.DeleteAll;
                    VATAmountLine.DeleteAll;
                    PurchPost.GetPurchLines("Purchase Header", PurchLine, 0);
                    PurchLine.CalcVATAmountLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    PurchLine.UpdateVATOnLines(0, "Purchase Header", PurchLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Purchase Header"."Currency Code", "Purchase Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    PrepmtInvBuf.DeleteAll;
                    PurchPostPrepmt.GetPurchLines("Purchase Header", 0, PrepmtPurchLine);
                    PurchPostPrepmt.CalcVATAmountLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    PurchPostPrepmt.UpdateVATOnLines("Purchase Header", PrepmtPurchLine, PrepmtVATAmountLine, 0);
                    PurchPostPrepmt.BuildInvLineBuffer("Purchase Header", PrepmtPurchLine, 0, PrepmtInvBuf);
                    PrepmtVATAmount := PrepmtVATAmountLine.GetTotalVATAmount;
                    PrepmtVATBaseAmount := PrepmtVATAmountLine.GetTotalVATBase;
                    PrepmtTotalAmountInclVAT := PrepmtVATAmountLine.GetTotalAmountInclVAT;

                    if Number > 1 then
                        CopyText := Text003;
                    CurrReport.PageNo := 1;
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);

                    if ISSERVICETIER then
                        OutputNo := 0;
                end;
            }

            trigger OnAfterGetRecord()
            var
                LandCode: Code[10];
                l_Contact: Record Contact;
            begin
                CurrReport.Language := Language_G.GetLanguageIdOrDefault("Language Code");

                CompanyInfo.Get;

                //13.11.07 AG+
                CompanyInfo.CalcFields(Picture, "Picture 1", "Picture 2");
                BLZText := 'BLZ';
                KTOText := 'Konto-Nr.: ';
                Datumtext := 'Datum';
                RepWerft := 'REPARATURWERFT';
                IhrZeichentext := 'Ihr Zeichen';
                if "Language Code" = 'ENU' then begin
                    Datumtext := 'Date';
                    RepWerft := 'REPAIRYARD';
                    IhrZeichentext := 'Your Reference';
                    BLZText := 'BCN';
                    KTOText := 'Account-No.: ';
                end;
                //13.11.07 AG-

                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                if "Purchaser Code" = '' then begin
                    SalesPurchPerson.Init;
                    SalesPurchPerson2.Init;
                    PurchaserText := '';
                end else begin
                    SalesPurchPerson.Get("Purchaser Code");
                    SalesPurchPerson2.Get("Purchaser Code");
                    PurchaserText := Text000;
                    PurchaserText2 := Text50000;
                    //15.11.07 AG+
                    Durchwahl := '';
                    if SalesPurchPerson.Durchwahlnummer <> '' then
                        Durchwahl := ' (-' + SalesPurchPerson.Durchwahlnummer + ')';
                    //    CompanyInfo."Phone No." := SalesPurchPerson."Phone No.";
                    if SalesPurchPerson."Fax No. TT" <> '' then
                        CompanyInfo."Fax No." := SalesPurchPerson."Fax No. TT";
                    if SalesPurchPerson."E-Mail" <> '' then
                        CompanyInfo."E-Mail" := SalesPurchPerson."E-Mail";
                    //15.11.07 AG-
                end;
                if Unterschriftscode <> '' then
                    SalesPurchPerson2.Get(Unterschriftscode);
                if "Unterschriftscode 2" <> '' then
                    SalesPurchPerson3.Get("Unterschriftscode 2");

                if "Your Reference" = '' then
                    ReferenceText := ''
                else
                    if "Language Code" = 'ENU' then
                        ReferenceText := 'Your letter / Date'
                    else
                        ReferenceText := 'Ihr Angebot / Datum';
                if CompanyInfo."VAT Registration No." = '' then
                    VATNoText := ''
                else
                    VATNoText := FieldCaption("VAT Registration No.");
                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText := StrSubstNo(Text001, GLSetup."LCY Code");
                    TotalInclVATText := StrSubstNo(Text002, GLSetup."LCY Code");
                    TotalExclVATText := StrSubstNo(Text006, GLSetup."LCY Code");
                end else begin
                    TotalText := StrSubstNo(Text001, "Currency Code");
                    TotalInclVATText := StrSubstNo(Text002, "Currency Code");
                    TotalExclVATText := StrSubstNo(Text006, "Currency Code");
                end;

                Kontaktname := "Purchase Header"."Buy-from Contact";
                "Purchase Header"."Buy-from Contact" := '';
                FormatAddr.PurchHeaderBuyFrom(BuyFromAddr, "Purchase Header");
                "Purchase Header"."Buy-from Contact" := Kontaktname;


                //Test Niels Anfang - Kontakt ohne Vorname sollte um Anrede ergänzt werden - neue Funktion in T5050
                //darf aber nur aufgerufen werden, wenn "Eink. von Kontakt" nicht manuell in der Bestellung überschrieben wurde
                if l_Contact.Get("Purchase Header"."Buy-from Contact No.") then begin
                    if l_Contact.Name = Kontaktname then begin
                        if "Language Code" = '' then
                            LandCode := 'DEU'
                        else
                            LandCode := "Language Code";
                        // 03.01.2012    Kontaktname := ContactRec.CalculateSalutationName("Purchase Header"."Buy-from Contact No.",LandCode,0);
                        if Kontaktname = '' then
                            Kontaktname := "Purchase Header"."Buy-from Contact";
                    end;
                end;
                //Test Niels Ende

                if ("Purchase Header"."Buy-from Vendor No." <> "Purchase Header"."Pay-to Vendor No.") then
                    FormatAddr.PurchHeaderPayTo(VendAddr, "Purchase Header");
                if "Payment Terms Code" = '' then
                    PaymentTerms.Init
                else begin
                    PaymentTerms.Get("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                end;
                if "Prepmt. Payment Terms Code" = '' then
                    PrepmtPaymentTerms.Init
                else begin
                    PrepmtPaymentTerms.Get("Prepmt. Payment Terms Code");
                    PrepmtPaymentTerms.TranslateDescription(PrepmtPaymentTerms, "Language Code");
                end;
                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init
                else begin
                    ShipmentMethod.Get("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                end;


                FormatAddr.PurchHeaderShipTo(ShipToAddr, "Purchase Header");

                //HZPMS-NA +
                //Wegen Druckmöglichkeit aus Bestellungsarchiv (Temporärer Datensatz in Purch. Header)
                //darf nicht nochmal archiviert werden. Belegnummer beginnt dann mit 'Archiv'
                if CopyStr("Purchase Header"."No.", 1, 6) = 'Archiv' then
                    ArchiveDocument := false;
                //HZPMS-NA -
                /*
                IF NOT CurrReport.PREVIEW THEN BEGIN
                  IF ArchiveDocument THEN
                    ArchiveManagement.StorePurchDocument("Purchase Header",LogInteraction);
                
                  IF LogInteraction THEN BEGIN
                    CALCFIELDS("No. of Archived Versions");
                    SegManagement.LogDocument(
                      13,"No.","Doc. No. Occurrence","No. of Archived Versions",DATABASE::Vendor,"Buy-from Vendor No.",
                      "Purchaser Code",'',"Posting Description",'');
                  END;
                END;
                */
                //HZPMS.AG+ 09.01.08
                if Fax then begin
                    if not Vendor.Get("Buy-from Vendor No.") then
                        Vendor.Init;
                    if ContactRec.Get("Buy-from Contact No.") then
                        if ContactRec.Type = ContactRec.Type::Person then
                            if ContactRec."Fax No." <> '' then
                                Vendor."Fax No." := ContactRec."Fax No.";
                    if Vendor."Fax No." <> '' then
                        if "Language Code" = 'ENU' then
                            FaxNr := 'FAX to:'
                        else
                            FaxNr := 'per Fax an:';
                end;
                Schiffstext := '';
                if AnzeigeSchiff then begin
                    if Job.Get("Job No.") then
                        if not Schiff.Get('SCHIFF', Job.Object) then
                            Schiff.Init
                        else
                            Schiffstext := 'Objekt: ' + Schiff.Abteilungsleiter;
                end;
                if Geschäftsbed then begin
                    if "Language Code" = 'ENU' then
                        AllGemein := 'attached '
                    else
                        AllGemein := 'beigefügten ';
                end;
                //HZPMS.AG- 09.01.08
                if Job.Get("Job No.") then begin
                    if Resource.Get(Job."Person Responsible") then begin
                        Durchwahl2 := '';
                        if Resource.Durchwahlnummer <> '' then
                            Durchwahl2 := ' (-' + Resource.Durchwahlnummer + ')';
                    end;
                end;
                if Wordübergabe then begin
                    CreateWordTopHeader1;
                    CreateWordTopHeader2;
                    CreateWordSender;
                    CreateWordAddress;
                    CreateWordHeader;
                    CreateWordBottomFooter1;
                    CreateWordBottomFooter2;
                    CreateWordGrussBody;
                end;

                if "Purchase Header"."Betriebsstätte Rotterdam" then begin
                    CompanyInfo."VAT Registration No." := 'NL823384573B01';
                    CompanyInfo."Registration No." := '823384573B01';
                end;
                CalcFields(Bestellername);

            end;

            trigger OnPostDataItem()
            begin

                if Wordübergabe then begin
                    Window.Close;
                end;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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

    trigger OnInitReport()
    begin
        GLSetup.Get;
    end;

    trigger OnPreReport()
    begin
        Unterschrift := true;
    end;

    var
        Text000: label 'Purchaser (com.):';
        Text001: label 'Total %1';
        Text002: label 'Total %1 Incl. VAT';
        Text003: label 'COPY';
        Text004: label 'Order-No.: %1';
        Text005: label 'Page %1';
        Text006: label 'Total %1 Excl. VAT';
        GLSetup: Record "General Ledger Setup";
        CompanyInfo: Record "Company Information";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PrepmtPaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        VATAmountLine: Record "VAT Amount Line" temporary;
        PrepmtVATAmountLine: Record "VAT Amount Line" temporary;
        PurchLine: Record "Purchase Line" temporary;
        PrepmtInvBuf: Record "Prepayment Inv. Line Buffer" temporary;
        RespCenter: Record "Responsibility Center";
        Language_G: Codeunit Language;
        CurrExchRate: Record "Currency Exchange Rate";
        Vendor: Record Vendor;
        Schiff: Record "Multi Table";
        PurchCountPrinted: Codeunit "Purch.Header-Printed";
        FormatAddr: Codeunit "Format Address";
        PurchPost: Codeunit "Purch.-Post";
        ArchiveManagement: Codeunit ArchiveManagement;
        SegManagement: Codeunit SegManagement;
        PurchPostPrepmt: Codeunit "Purchase-Post Prepayments";
        VendAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        BuyFromAddr: array[8] of Text[50];
        PurchaserText: Text[30];
        PurchaserText2: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalInclVATText: Text[50];
        TotalExclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text007: label 'VAT Amount Specification in ';
        Text008: label 'Local Currency';
        Text009: label 'Exchange rate: %1/%2';
        PrepmtVATAmount: Decimal;
        PrepmtVATBaseAmount: Decimal;
        PrepmtAmountInclVAT: Decimal;
        PrepmtTotalAmountInclVAT: Decimal;
        PrepmtLineAmount: Decimal;
        OutputNo: Integer;
        "******HZPMS**********": Integer;
        Job: Record Job;
        BLZText: Text[30];
        pos: Code[10];
        ContactRec: Record Contact;
        Schiffstext: Text[250];
        Text010: label 'To be shown in all correspondence and invoices';
        FaxNr: Text[100];
        SalesPurchPerson2: Record "Salesperson/Purchaser";
        SalesPurchPerson3: Record "Salesperson/Purchaser";
        Kontaktname: Text[50];
        "MwSt%": Decimal;
        Unterschrift: Boolean;
        Fax: Boolean;
        "Geschäftsbed": Boolean;
        Text011: label 'Our %1general purchase conditions apply exclusively';
        AllGemein: Text[30];
        AnzeigeSchiff: Boolean;
        "Wordübergabe": Boolean;
        IhrZeichentext: Text[30];
        Datumtext: Text[30];
        RepWerft: Text[15];
        i: Integer;
        r: Integer;
        Window: Dialog;
        FooterText1: label 'This company is a limited partnership,';
        FooterText2: label 'Register Court Oldenburg HRA 200812';
        FooterText3: label 'General Partner:';
        FooterText4: label 'Dassler Beteiligungs-GmbH';
        FooterText5: label 'Register Court Oldenburg HRB 130445';
        FooterText6: label 'Bankers';
        HeaderAn: label 'To:';
        HeaderSeite: label 'Page:';
        TextZwischensumme: label 'Subtotal:';
        TextRechnungsrabatt: label 'Invoice Discount';
        LiefAnAdresse: label 'Ship to Address';
        "ÜberschriftNummer": label 'No.';
        "ÜberschriftEinheit": label 'Unit';
        Text50000: label 'Purchaser (techn.):';
        Durchwahl: Text[30];
        Durchwahl2: Text[30];
        Resource: Record Resource;
        Text50001: label 'Receipted Date:';
        Text50002: label 'Baugruppe:';
        KTOText: Text[20];
        Text50003: label ' eintreffend';
        "Lieferadresse drucken": Boolean;
        PricesInclVATtxt: Text[30];
        UnitofMeasureTranslation: Record "Unit of Measure Translation";
        Purchase_Line__QuantityCaptionLbl: label 'Qty.';
        Purchase_Line___Unit_of_Measure_CaptionLbl: label 'Unit';
        Pos_CaptionLbl: label 'Pos.';
        VisibilityPurchLine: Boolean;
        Item: Record Item;


    procedure CreateWordTopHeader1()
    begin
    end;


    procedure CreateWordTopHeader2()
    begin
    end;


    procedure CreateWordBottomFooter1()
    begin
    end;


    procedure CreateWordBottomFooter2()
    begin
    end;


    procedure CreateWordSender()
    begin
    end;


    procedure CreateWordAddress()
    begin
    end;


    procedure CreateWordHeader()
    begin
    end;


    procedure CreateWordPostBody()
    begin
    end;


    procedure CreateWordGrussBody()
    begin
    end;


    procedure "AnzeigeSchiffÜbergeben"(P_AnzeigeSchiff: Boolean)
    begin
        AnzeigeSchiff := P_AnzeigeSchiff;
    end;
}


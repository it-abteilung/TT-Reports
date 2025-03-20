Report 50026 "TT Standard Sales - Quote TP"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TT Standard Sales - Quote TP.rdlc';
    WordLayout = './Layouts/TTStandardSalesQuoteTP.docx';
    Caption = 'Sales - Quote';
    PreviewMode = PrintLayout;
    WordMergeDataItem = Header;

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Quote';
            column(ShowDiscountColumn; ShowDiscountColumn) { } // Justin Bäcker wollte gerne die Rabattspalte verstecken, falls kein Rabatt vorhanden ist
            column(ExternalDocNo; "External Document No.")                //Vorher Job."External Document No."
            {
            }
            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
            }
            column(CompanyHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyEMail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyPicture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo__Picture_1_; CompanyInfo."Picture 1")
            {
            }
            column(CompanyInfo__Picture_2_; CompanyInfo."Picture 2")
            {
            }
            column(CompanyPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyPhoneNo_Lbl; CompanyInfoPhoneNoLbl)
            {
            }
            column(FaxNo; CompanyInfo."Fax No.")
            {
            }
            column(CompanyGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyGiroNo_Lbl; CompanyInfoGiroNoLbl)
            {
            }
            column(CompanyBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyBankName_Lbl; CompanyInfoBankNameLbl)
            {
            }
            column(CompanyBankBranchNo; CompanyInfo."Bank Branch No.")
            {
            }
            column(CompanyBankBranchNo_Lbl; CompanyInfo.FieldCaption("Bank Branch No."))
            {
            }
            column(CompanyBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyBankAccountNo_Lbl; CompanyInfoBankAccNoLbl)
            {
            }
            column(CompanyIBAN; CompanyInfo.Iban)
            {
            }
            column(CompanyIBAN_Lbl; CompanyInfo.FieldCaption(Iban))
            {
            }
            column(CompanySWIFT; CompanyInfo."SWIFT Code")
            {
            }
            column(CompanySWIFT_Lbl; CompanyInfo.FieldCaption("SWIFT Code"))
            {
            }
            column(CompanyLogoPosition; CompanyLogoPosition)
            {
            }
            column(CompanyRegistrationNumber; CompanyInfo.GetRegistrationNumber)
            {
            }
            column(CompanyRegistrationNumber_Lbl; CompanyInfo.GetRegistrationNumberLbl)
            {
            }
            column(CompanyVATRegNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CompanyVATRegNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
            }
            column(CompanyVATRegistrationNo; CompanyInfo.GetVATRegistrationNumber)
            {
            }
            column(CompanyVATRegistrationNo_Lbl; CompanyInfo.GetVATRegistrationNumberLbl)
            {
            }
            column(CompanyLegalOffice; CompanyInfo.GetLegalOffice)
            {
            }
            column(CompanyLegalOffice_Lbl; CompanyInfo.GetLegalOfficeLbl)
            {
            }
            column(CompanyCustomGiro; CompanyInfo.GetCustomGiro)
            {
            }
            column(CompanyCustomGiro_Lbl; CompanyInfo.GetCustomGiroLbl)
            {
            }
            column(CompanyLegalStatement; GetLegalStatement)
            {
            }
            column(FirstSign; FirstSign.Content)
            {
            }

            column(SecondSign; SecondSign.Content)
            {
            }
            column(CustomerAddress1; CustAddr[1])
            {
            }
            column(CustomerAddress2; CustAddr[2])
            {
            }
            column(CustomerAddress3; CustAddr[3])
            {
            }
            column(CustomerAddress4; CustAddr[4])
            {
            }
            column(CustomerAddress5; CustAddr[5])
            {
            }
            column(CustomerAddress6; CustAddr[6])
            {
            }
            column(CustomerAddress7; CustAddr[7])
            {
            }
            column(CustomerAddress8; CustAddr[8])
            {
            }
            column(CustomerPostalBarCode; FormatAddr.PostalBarCode(1))
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(YourReference__Lbl; FieldCaption("Your Reference"))
            {
            }
            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
            }
            column(ShipmentMethodDescription_Lbl; ShptMethodDescLbl)
            {
            }
            column(Shipment_Lbl; ShipmentLbl)
            {
            }
            column(ShowShippingAddress; ShowShippingAddr)
            {
            }
            column(ShipToAddress_Lbl; ShiptoAddrLbl)
            {
            }
            column(ShipToAddress1; ShipToAddr[1])
            {
            }
            column(ShipToAddress2; ShipToAddr[2])
            {
            }
            column(ShipToAddress3; ShipToAddr[3])
            {
            }
            column(ShipToAddress4; ShipToAddr[4])
            {
            }
            column(ShipToAddress5; ShipToAddr[5])
            {
            }
            column(ShipToAddress6; ShipToAddr[6])
            {
            }
            column(ShipToAddress7; ShipToAddr[7])
            {
            }
            column(ShipToAddress8; ShipToAddr[8])
            {
            }
            column(PaymentTermsDescription; PaymentTerms.Description)
            {
            }
            column(PaymentTermsDescription_Lbl; PaymentTermsDescLbl)
            {
            }
            column(PaymentMethodDescription; PaymentMethod.Description)
            {
            }
            column(PaymentMethodDescription_Lbl; PaymentMethodDescLbl)
            {
            }
            column(DocumentCopyText; StrSubstNo(DocumentCaption, CopyText))
            {
            }
            column(BilltoCustumerNo; "Bill-to Customer No.")
            {
            }
            column(BilltoCustomerNo_Lbl; FieldCaption("Bill-to Customer No."))
            {
            }
            column(DocumentDate; Format("Document Date", 0, 4))
            {
            }
            column(DocumentDate_Lbl; FieldCaption("Document Date"))
            {
            }
            column(DueDate; Format("Due Date", 0, 4))
            {
            }
            column(DueDate_Lbl; FieldCaption("Due Date"))
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(DocumentNo_Lbl; InvNoLbl)
            {
            }
            column(PricesIncludingVAT; "Prices Including VAT")
            {
            }
            column(PricesIncludingVAT_Lbl; FieldCaption("Prices Including VAT"))
            {
            }
            column(PricesIncludingVATYesNo; Format("Prices Including VAT"))
            {
            }
            column(SalesPerson_Lbl; SalespersonLbl)
            {
            }
            column(SalesPersonBlank_Lbl; SalesPersonText)
            {
            }
            column(SalesPersonName; SalespersonPurchaser.Name)
            {
            }
            column(SelltoCustomerNo; "Sell-to Customer No.")
            {
            }
            column(SelltoCustomerNo_Lbl; FieldCaption("Sell-to Customer No."))
            {
            }
            column(VATRegistrationNo; GetCustomerVATRegistrationNumber)
            {
            }
            column(VATRegistrationNo_Lbl; GetCustomerVATRegistrationNumberLbl)
            {
            }
            column(GlobalLocationNumber; GetCustomerGlobalLocationNumber)
            {
            }
            column(GlobalLocationNumber_Lbl; GetCustomerGlobalLocationNumberLbl)
            {
            }
            column(LegalEntityType; Cust.GetLegalEntityType)
            {
            }
            column(LegalEntityType_Lbl; Cust.GetLegalEntityTypeLbl)
            {
            }
            column(Copy_Lbl; CopyLbl)
            {
            }
            column(EMail_Lbl; EMailLbl)
            {
            }
            column(HomePage_Lbl; HomePageLbl)
            {
            }
            column(InvoiceDiscountBaseAmount_Lbl; InvDiscBaseAmtLbl)
            {
            }
            column(InvoiceDiscountAmount_Lbl; InvDiscountAmtLbl)
            {
            }
            column(LineAmountAfterInvoiceDiscount_Lbl; LineAmtAfterInvDiscLbl)
            {
            }
            column(LocalCurrency_Lbl; LocalCurrencyLbl)
            {
            }
            column(ExchangeRateAsText; ExchangeRateText)
            {
            }
            column(Page_Lbl; PageLbl)
            {
            }
            column(SalesInvoiceLineDiscount_Lbl; SalesInvLineDiscLbl)
            {
            }
            column(DocumentTitle_Lbl; SalesConfirmationLbl)
            {
            }
            column(ShowWorkDescription; ShowWorkDescription)
            {
            }
            column(Subtotal_Lbl; SubtotalLbl)
            {
            }
            column(Total_Lbl; TotalLbl)
            {
            }
            column(VATAmount_Lbl; VATAmtLbl)
            {
            }
            column(VATBase_Lbl; VATBaseLbl)
            {
            }
            column(VATAmountSpecification_Lbl; VATAmtSpecificationLbl)
            {
            }
            column(VATClauses_Lbl; VATClausesLbl)
            {
            }
            column(VATIdentifier_Lbl; VATIdentifierLbl)
            {
            }
            column(VATPercentage_Lbl; VATPercentageLbl)
            {
            }
            column(VATClause_Lbl; VATClause.TableCaption)
            {
            }
            column(STRSUBSTNO_Text004_CopyText___SalesHeader_JobNo; StrSubstNo(Text004, CopyText) + ' ' + "Job No." + ' / ' + "No.")
            {
            }
            column(KopfCaption1; KopfCaption[1])
            {
            }
            column(KopfCaption2; KopfCaption[2])
            {
            }
            column(KopfCaption3; KopfCaption[3])
            {
            }
            column(KopfCaption4; KopfCaption[4])
            {
            }
            column(KopfCaption5; KopfCaption[5])
            {
            }
            column(KopfCaption6; KopfCaption[6])
            {
            }
            column(KopfCaption7; KopfCaption[7])
            {
            }
            column(KopfCaption8; KopfCaption[8])
            {
            }
            column(Kopfdaten1; Kopfdaten[1])
            {
            }
            column(Kopfdaten2; Kopfdaten[2])
            {
            }
            column(Kopfdaten3; Kopfdaten[3])
            {
            }
            column(Kopfdaten4; Kopfdaten[4])
            {
            }
            column(Kopfdaten5; Kopfdaten[5])
            {
            }
            column(Kopfdaten6; Kopfdaten[6])
            {
            }
            column(Kopfdaten7; Kopfdaten[7])
            {
            }
            column(Kopfdaten8; Kopfdaten[8])
            {
            }
            column(ReferenceText; ReferenceText)
            {
            }
            column(AnredeCaption; AnredeCaption)
            {
            }
            column(AngebotKopfText; AngebotKopfText)
            {
            }
            column(KommanditgesellschaftCaption; KommanditgesellschaftCaption)
            {
            }
            column(RegistergerichtCaption; RegistergerichtCaption)
            {
            }
            column(PersHaftende; PersHaftende)
            {
            }
            column(TurboTechnikBeteiligungsCaption; TurboTechnikBeteiligungsCaption)
            {
            }
            column(Registergericht2Caption; Registergericht2Caption)
            {
            }
            column(CompanyInfo_Managing_Director; CompanyInfo.FieldCaption("Managing Director") + ': ' + CompanyInfo."Managing Director")
            {
            }
            column(BankverbindungenCaption; BankverbindungenCaption)
            {
            }
            column(Info_Bankname_1; KTOText + CompanyInfo."Bank Account No." + ' (' + BLZText + '  ' + CompanyInfo."Bank Branch No." + ')')
            {
            }
            column(Info_Bankname_2; 'SWIFT: ' + CompanyInfo."SWIFT Code" + ',  IBAN: ' + CompanyInfo.Iban)
            {
            }
            column(CompanyInfo_Bankname1; CompanyInfo."Bank Name 1")
            {
            }
            column(Info_Bankname1_1; KTOText + CompanyInfo."Bank Account No. 1" + ' (' + BLZText + '  ' + CompanyInfo."Bank Branch No. 1" + ')')
            {
            }
            column(Info_Bankname1_2; 'SWIFT: ' + CompanyInfo."SWIFT Code 1" + ',  IBAN: ' + CompanyInfo."IBAN 1")
            {
            }
            column(CompanyInfo_Bankname2; CompanyInfo."Bank Name 2")
            {
            }
            column(Info_Bankname2_1; KTOText + CompanyInfo."Bank Account No. 2" + ' (' + BLZText + '  ' + CompanyInfo."Bank Branch No. 2" + ')')
            {
            }
            column(Info_Bankname2_2; 'SWIFT: ' + CompanyInfo."SWIFT Code 2" + ',  IBAN: ' + CompanyInfo."IBAN 2")
            {
            }
            column(Unterschriftscode2; Header."Unterschriftscode 2")
            {
            }
            column(Caption_PersonInCharge; Caption_PersonInCharge)
            {
            }
            column(PersonInCharge; PersonInCharge)
            {
            }
            column(FaxCaption; FaxCaption)
            {
            }
            column(CurrencyCode; "Currency Code")
            {
            }

            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);
                column(ReportForNavId_1000000002; 1000000002)
                {
                }
                dataitem(Line; "Sales Line")
                {
                    DataItemLink = "Document No." = field("No.");
                    DataItemLinkReference = Header;
                    DataItemTableView = sorting("Document No.", "Line No.");
                    UseTemporary = true;
                    column(ReportForNavId_1570; 1570)
                    {
                    }
                    column(Line_Lfd; Line_Lfd)
                    {
                    }
                    column(LineNo_Line; "Line No.")
                    {
                    }
                    column(AmountExcludingVAT_Line; Amount)
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AmountExcludingVAT_Line_Lbl; FieldCaption(Amount))
                    {
                    }
                    column(AmountIncludingVAT_Line; "Amount Including VAT")
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AmountIncludingVAT_Line_Lbl; FieldCaption("Amount Including VAT"))
                    {
                        AutoFormatExpression = Header."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Description_Line; Description)
                    {
                    }
                    column(Description2_Line; Line."Description 2")
                    {
                    }
                    column(P_N_SalesLine_PartNo; 'P/N')
                    {
                    }
                    column(SalesLinePartNo; "Part No.")
                    {
                    }
                    column(Description_Line_Lbl; FieldCaption(Description))
                    {
                    }
                    column(LineDiscountPercent_LineCaption; LineDiscountCaption)
                    {
                    }
                    column(LineDiscountPercent_Line; "Line Discount %")
                    {
                    }
                    column(LineDiscountPercentText_Line; LineDiscountPctText)
                    {
                    }
                    column(LineAmount_Line; "Line Amount")
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmount_Line_Lbl; 'Amount')
                    {
                    }
                    column(ItemNo_Line; "No.")
                    {
                    }
                    column(ItemNo_Line_Lbl; FieldCaption("No."))
                    {
                    }
                    column(ShipmentDate_Line; Format(PostedShipmentDate))
                    {
                    }
                    column(ShipmentDate_Lbl; PostedShipmentDateLbl)
                    {
                    }
                    column(Quantity_Line; Quantity)
                    {
                    }
                    column(Quantity_Line_Lbl; FieldCaption(Quantity))
                    {
                    }
                    column(Type_Line; Format(Type))
                    {
                    }
                    column(UnitPrice; "Unit Price")
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 2;
                    }
                    column(UnitPrice_Lbl; 'Unit Price')
                    {
                    }
                    column(UnitOfMeasure; UnitOfMeasureTranslation)
                    {
                    }
                    column(UnitOfMeasure_Lbl; 'Unit')
                    {
                    }
                    column(VATIdentifier_Line; "VAT Identifier")
                    {
                    }
                    column(VATIdentifier_Line_Lbl; FieldCaption("VAT Identifier"))
                    {
                    }
                    column(VATPct_Line; "VAT %")
                    {
                    }
                    column(VATPct_Line_Lbl; FieldCaption("VAT %"))
                    {
                    }
                    column(TransHeaderAmount; TransHeaderAmount)
                    {
                        AutoFormatExpression = "Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalNetAmount; TotalAmount)
                    {
                        AutoFormatExpression = Header."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(Delivery_Line_Lbl; FieldCaption(Delivery))
                    {
                    }
                    column(Delivery_Line; Line.Delivery)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        UnitOfMeasureTrans: Record "Unit of Measure Translation";
                    begin
                        PostedShipmentDate := 0D;

                        if Type = Type::"G/L Account" then
                            "No." := '';

                        if "Line Discount %" = 0 then
                            LineDiscountPctText := ''
                        else begin
                            ShowDiscountColumn := true;
                            LineDiscountPctText := StrSubstNo('%1%', -ROUND("Line Discount %", 0.1));
                        end;

                        TransHeaderAmount += PrevLineAmount;
                        PrevLineAmount := "Line Amount";
                        TotalSubTotal += "Line Amount";
                        TotalInvDiscAmount -= "Inv. Discount Amount";
                        TotalAmount += Amount;
                        TotalAmountVAT += "Amount Including VAT" - Amount;
                        TotalAmountInclVAT += "Amount Including VAT";
                        TotalPaymentDiscOnVAT += -("Line Amount" - "Inv. Discount Amount" - "Amount Including VAT");

                        if FirstLineHasBeenOutput then
                            Clear(CompanyInfo.Picture);
                        FirstLineHasBeenOutput := true;

                        //-HF001
                        if (Line.Type = Line.Type::Item) or (Line.Type = Line.Type::Resource) then
                            //+HF001
                            Line_Lfd += 1; //G-ERP.KBS 2018-06-05

                        UnitOfMeasureTranslation := '';
                        if UnitOfMeasureTrans.Get("Unit of Measure", 'ENU') then
                            UnitOfMeasureTranslation := UnitOfMeasureTrans.Description
                        else
                            UnitOfMeasureTranslation := "Unit of Measure";
                    end;

                    trigger OnPreDataItem()
                    begin
                        MoreLines := Find('+');
                        while MoreLines and (Description = '') and ("No." = '') and (Quantity = 0) and (Amount = 0) do
                            MoreLines := Next(-1) <> 0;
                        if not MoreLines then
                            CurrReport.Break;
                        SetRange("Line No.", 0, "Line No.");
                        CurrReport.CreateTotals("Line Amount", Amount, "Amount Including VAT", "Inv. Discount Amount");
                        TransHeaderAmount := 0;
                        PrevLineAmount := 0;
                        FirstLineHasBeenOutput := false;
                        CompanyInfo.CalcFields(Picture);
                    end;
                }
                dataitem(WorkDescriptionLines; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = filter(1 .. 99999));
                    column(ReportForNavId_32; 32)
                    {
                    }
                    column(WorkDescriptionLineNumber; Number)
                    {
                    }
                    column(WorkDescriptionLine; WorkDescriptionLine)
                    {
                    }

                    trigger OnAfterGetRecord()
                    var
                        TypeHelper: Codeunit "Type Helper";
                    begin
                        if WorkDescriptionInstream.EOS then
                            CurrReport.Break();
                        WorkDescriptionLine := TypeHelper.ReadAsTextWithSeparator(WorkDescriptionInstream, TypeHelper.LFSeparator);
                    end;


                    trigger OnPostDataItem()
                    begin
                        Clear(WorkDescriptionInstream);
                    end;

                    trigger OnPreDataItem()
                    begin
                        if not ShowWorkDescription then
                            CurrReport.Break();
                        Header."Work Description".CreateInStream(WorkDescriptionInstream, TEXTENCODING::UTF8);
                    end;
                }
                dataitem(VATAmountLine; "VAT Amount Line")
                {
                    DataItemTableView = sorting("VAT Identifier", "VAT Calculation Type", "Tax Group Code", "Use Tax", Positive);
                    UseTemporary = true;
                    column(ReportForNavId_6558; 6558)
                    {
                    }
                    column(InvoiceDiscountAmount_VATAmountLine; "Invoice Discount Amount")
                    {
                        AutoFormatExpression = Header."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(InvoiceDiscountAmount_VATAmountLine_Lbl; FieldCaption("Invoice Discount Amount"))
                    {
                    }
                    column(InvoiceDiscountBaseAmount_VATAmountLine; "Inv. Disc. Base Amount")
                    {
                        AutoFormatExpression = Header."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(InvoiceDiscountBaseAmount_VATAmountLine_Lbl; FieldCaption("Inv. Disc. Base Amount"))
                    {
                    }
                    column(LineAmount_VatAmountLine; "Line Amount")
                    {
                        AutoFormatExpression = Header."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(LineAmount_VatAmountLine_Lbl; FieldCaption("Line Amount"))
                    {
                    }
                    column(VATAmount_VatAmountLine; "VAT Amount")
                    {
                        AutoFormatExpression = Header."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATAmount_VatAmountLine_Lbl; FieldCaption("VAT Amount"))
                    {
                    }
                    column(VATAmountLCY_VATAmountLine; VATAmountLCY)
                    {
                    }
                    column(VATAmountLCY_VATAmountLine_Lbl; VATAmountLCYLbl)
                    {
                    }
                    column(VATBase_VatAmountLine; "VAT Base")
                    {
                        AutoFormatExpression = Header."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(VATBase_VatAmountLine_Lbl; FieldCaption("VAT Base"))
                    {
                    }
                    column(VATBaseLCY_VATAmountLine; VATBaseLCY)
                    {
                    }
                    column(VATBaseLCY_VATAmountLine_Lbl; VATBaseLCYLbl)
                    {
                    }
                    column(VATIdentifier_VatAmountLine; "VAT Identifier")
                    {
                    }
                    column(VATIdentifier_VatAmountLine_Lbl; FieldCaption("VAT Identifier"))
                    {
                    }
                    column(VATPct_VatAmountLine; "VAT %")
                    {
                        DecimalPlaces = 0 : 5;
                    }
                    column(VATPct_VatAmountLine_Lbl; FieldCaption("VAT %"))
                    {
                    }
                    column(NoOfVATIdentifiers; Count)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        VATBaseLCY :=
                          GetBaseLCY(
                            Header."Posting Date", Header."Currency Code",
                            Header."Currency Factor");
                        VATAmountLCY :=
                          GetAmountLCY(
                            Header."Posting Date", Header."Currency Code",
                            Header."Currency Factor");

                        TotalVATBaseLCY += VATBaseLCY;
                        TotalVATAmountLCY += VATAmountLCY;
                    end;

                    trigger OnPreDataItem()
                    begin
                        CurrReport.CreateTotals(
                          "Line Amount", "Inv. Disc. Base Amount",
                          "Invoice Discount Amount", "VAT Base", "VAT Amount",
                          VATBaseLCY, VATAmountLCY);

                        TotalVATBaseLCY := 0;
                        TotalVATAmountLCY := 0;
                    end;
                }
                dataitem(ReportTotalsLine; "Report Totals Buffer")
                {
                    DataItemTableView = sorting("Line No.");
                    UseTemporary = true;
                    column(ReportForNavId_141; 141)
                    {
                    }
                    column(Description_ReportTotalsLine; Description)
                    {
                    }
                    column(Amount_ReportTotalsLine; Amount)
                    {
                    }
                    column(AmountFormatted_ReportTotalsLine; "Amount Formatted")
                    {
                    }
                    column(FontBold_ReportTotalsLine; "Font Bold")
                    {
                    }
                    column(FontUnderline_ReportTotalsLine; "Font Underline")
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        CreateReportTotalLines;
                    end;
                }
                dataitem(LetterText; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(ReportForNavId_209; 209)
                    {
                    }
                    column(GreetingText; GreetingLbl)
                    {
                    }
                    column(BodyText; BodyLbl)
                    {
                    }
                    column(ClosingText; ClosingLbl)
                    {
                    }
                    column(PmtDiscText; PmtDiscText)
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        PmtDiscText := '';
                        if Header."Payment Discount %" <> 0 then
                            PmtDiscText := StrSubstNo(PmtDiscTxt, Header."Pmt. Discount Date", Header."Payment Discount %");
                    end;
                }
                dataitem(Totals; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(ReportForNavId_99; 99)
                    {
                    }
                    column(TotalVATBaseLCY; TotalVATBaseLCY)
                    {
                    }
                    column(TotalAmountIncludingVAT; TotalAmountInclVAT)
                    {
                        AutoFormatExpression = Header."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalVATAmount; TotalAmountVAT)
                    {
                        AutoFormatExpression = Header."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalVATAmountLCY; TotalVATAmountLCY)
                    {
                    }
                    column(TotalInvoiceDiscountAmount; TotalInvDiscAmount)
                    {
                        AutoFormatExpression = Header."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalPaymentDiscountOnVAT; TotalPaymentDiscOnVAT)
                    {
                    }
                    column(TotalVATAmountText; VATAmountLine.VATAmountText)
                    {
                    }
                    column(TotalExcludingVATText; TotalExclVATText)
                    {
                    }
                    column(TotalIncludingVATText; TotalInclVATText)
                    {
                    }
                    column(TotalSubTotal; TotalSubTotal)
                    {
                        AutoFormatExpression = Header."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(TotalSubTotalMinusInvoiceDiscount; TotalSubTotal + TotalInvDiscAmount)
                    {
                    }
                    column(TotalText; TotalText)
                    {
                    }
                }
                dataitem(Total; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(ReportForNavId_1000000003; 1000000003)
                    {
                    }
                }
                dataitem(Total2; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(ReportForNavId_1000000004; 1000000004)
                    {
                    }
                }
                dataitem(Remarks; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(ReportForNavId_1000000005; 1000000005)
                    {
                    }
                    column(STRSUBSTNO_o_Price_is__; StrSubstNo('o Price is based on an exchange rate of 1 Euro = %1 %2 and will be adjusted in case of changes.', Header."Currency Factor", CurrExchRate."Currency Code"))
                    {
                    }
                    column(AngebotFussText; AngebotFussText)
                    {
                    }
                    column(Preistellung_t; Preistellung_t)
                    {
                    }
                    column(PaymentTerms_Description; PaymentTerms.Description)
                    {
                    }
                    column(STRSUBSTNO__; StrSubstNo('%1 DAYS', Header."Validity (DAYS)"))
                    {
                    }
                    column(ShipmentMethod_Description; ShipmentMethod.Description)
                    {
                    }
                }
                dataitem(Gruss; "Integer")
                {
                    DataItemTableView = sorting(Number) where(Number = const(1));
                    column(ReportForNavId_1000000006; 1000000006)
                    {
                    }
                    column(SalesPurchPerson2; SalesPurchPerson2."Job Title" + ' ' + SalesPurchPerson2.Name)
                    {
                    }
                    column(SalesPurchPerson3; SalesPurchPerson3."Job Title" + ' ' + SalesPurchPerson3.Name)
                    {
                    }
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "Sales-Post";
                begin
                    Clear(SalesLine);
                    Clear(SalesPost);
                    SalesLine.DeleteAll;
                    VATAmountLine.DeleteAll;
                    SalesPost.GetSalesLines(Header, SalesLine, 0);
                    SalesLine.CalcVATAmountLines(0, Header, SalesLine, VATAmountLine);
                    SalesLine.UpdateVATOnLines(0, Header, SalesLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount(Header."Currency Code", Header."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    if Number > 1 then
                        CopyText := Text003;
                    CurrReport.PageNo := 1;

                    Line_Lfd := 0//G-ERP.KBS 2018-06-05
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.Preview then
                        SalesCountPrinted.Run(Header);
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := Abs(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord()
            var
                CurrencyExchangeRate: Record "Currency Exchange Rate";
                ArchiveManagement: Codeunit ArchiveManagement;
                SalesPost: Codeunit "Sales-Post";
                "Sell-to Country": Text[50];
                Purchaser: Record "Salesperson/Purchaser";
                EmployeeSignStore: Record "Employee Sign Store";
                PurchaseLine: Record "Purchase Line";
            begin
                FirstLineHasBeenOutput := false;
                Clear(Line);
                Clear(SalesPost);
                VATAmountLine.DeleteAll;
                Line.DeleteAll;
                SalesPost.GetSalesLines(Header, Line, 0);
                Line.CalcVATAmountLines(0, Header, Line, VATAmountLine);
                Line.UpdateVATOnLines(0, Header, Line, VATAmountLine);

                if not CurrReport.Preview then
                    Codeunit.Run(Codeunit::"Sales-Printed", Header);

                "Language Code" := 'ENU';

                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");

                CalcFields("Work Description");
                ShowWorkDescription := "Work Description".Hasvalue;

                FormatAddr.GetCompanyAddr("Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
                FormatAddr.SalesHeaderBillTo(CustAddr, Header);
                ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, Header);
                //G-ERP.KBS 2017-08-05 +
                //21.11.07 AG+
                CompanyInfo.CalcFields(Picture, "Picture 1", "Picture 2");
                BLZText := 'BLZ';
                KTOText := 'Konto-Nr.: ';
                if "Language Code" = 'ENU' then begin
                    BLZText := 'BCN';
                    KTOText := 'Account-No.: ';
                end;
                //21.11.07 AG-

                if Salutation <> '' then
                    AnredeCaption := 'Dear ' + Salutation + ','
                else
                    AnredeCaption := AnredeCaptionEmpty;


                if "Salesperson Code" = '' then begin
                    SalespersonPurchaser.Init;
                    SalesPurchPerson2.Init;
                    SalesPersonText := '';

                end else begin
                    SalespersonPurchaser.Get("Salesperson Code");
                    SalesPurchPerson2.Get("Salesperson Code");
                    SalesPersonText := Text000;
                    //21.11.07 AG+
                    //CompanyInfo."Phone No." := SalesPurchPerson2."Phone No.";
                    //CompanyInfo."Fax No." := SalesPurchPerson2."Fax No.";
                    CompanyInfo."E-Mail" := SalesPurchPerson2."E-Mail";
                    //21.11.07 AG-
                end;
                if Unterschriftscode <> '' then
                    SalesPurchPerson2.Get(Unterschriftscode);
                if "Unterschriftscode 2" <> '' then
                    SalesPurchPerson3.Get("Unterschriftscode 2");
                //G-ERP.KBS 2017-11-06 +
                // IF "Your Reference" = '' THEN
                //  ReferenceText := ''
                // ELSE
                //G-ERP.KBS 2017-11-06 -
                ReferenceText := FieldCaption("Your Reference");
                if CompanyInfo."VAT Registration No." = '' then
                    VATNoText := ''
                else
                    VATNoText := FieldCaption("VAT Registration No.");
                if "Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText := StrSubstNo(Text001, GLSetup."LCY Code");
                    //  TotalText := STRSUBSTNO(Text001,'');
                    TotalInclVATText := StrSubstNo(Text002, GLSetup."LCY Code");
                    TotalExclVATText := StrSubstNo(Text006, GLSetup."LCY Code");
                end else begin
                    TotalText := StrSubstNo(Text001, "Currency Code");
                    TotalInclVATText := StrSubstNo(Text002, "Currency Code");
                    TotalExclVATText := StrSubstNo(Text006, "Currency Code");
                end;
                Header."Bill-to Contact" := Header."Sell-to Contact";
                Header."Ship-to Contact" := Header."Sell-to Contact";
                FormatAddr.SalesHeaderBillTo(CustAddr, Header);

                if "Payment Terms Code" = '' then
                    PaymentTerms.Init
                else begin
                    PaymentTerms.Get("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, Header."Language Code");
                end;
                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init
                else begin
                    ShipmentMethod.Get("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, Header."Language Code");
                end;

                if Country.Get(Header."Sell-to Country/Region Code") then
                    "Sell-to Country" := Country.Name;
                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, Header);
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                for i := 1 to ArrayLen(ShipToAddr) do
                    if (ShipToAddr[i] <> CustAddr[i]) and (ShipToAddr[i] <> '') and (ShipToAddr[i] <> "Sell-to Country") then
                        ShowShippingAddr := true;
                //G-ERP.KBS 2017-08-05 -

                if not Cust.Get("Bill-to Customer No.") then
                    Clear(Cust);

                if "Currency Code" <> '' then begin
                    CurrencyExchangeRate.FindCurrency("Posting Date", "Currency Code", 1);
                    CalculatedExchRate :=
                      ROUND(1 / "Currency Factor" * CurrencyExchangeRate."Exchange Rate Amount", 0.000001);
                    ExchangeRateText := StrSubstNo(ExchangeRateTxt, CalculatedExchRate, CurrencyExchangeRate."Exchange Rate Amount");
                end;

                FormatDocumentFields(Header);

                if not CurrReport.Preview and
                   (CurrReport.UseRequestPage and ArchiveDocument)
                then
                    ArchiveManagement.StoreSalesDocument(Header, LogInteraction);

                if LogInteraction and not CurrReport.Preview then begin
                    CalcFields("No. of Archived Versions");
                    if "Bill-to Contact No." <> '' then
                        SegManagement.LogDocument(
                          1, "No.", "Doc. No. Occurrence",
                          "No. of Archived Versions", Database::Contact, "Bill-to Contact No.",
                          "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                    else
                        SegManagement.LogDocument(
                          1, "No.", "Doc. No. Occurrence",
                          "No. of Archived Versions", Database::Customer, "Bill-to Customer No.",
                          "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                end;

                //G-ERP.KBS 2017-08-05 +
                Header.Mark(true);
                case Preisstellung of
                    Preisstellung::unpacked:
                        begin
                            if "Language Code" = 'ENU' then
                                Preistellung_t := 'net and true, unpacked'
                            else
                                Preistellung_t := 'netto, ohne Verpackung';
                        end;
                    Preisstellung::packed:
                        begin
                            if "Language Code" = 'ENU' then
                                Preistellung_t := 'net and true, packed'
                            else
                                Preistellung_t := 'netto, incl. Verpackung';
                        end;
                end;

                //G-ERP.FL 2012-03-13 +

                if Job.Get(Header."Job No.") then;
                if Ressource.Get(Job."Person Responsible") then begin
                    PersonInCharge := Ressource.Name;
                    Caption_PersonInCharge := Text_PersonInCharge;
                    if Ressource.Durchwahlnummer <> '' then
                        Phone := CopyStr(CompanyInfo."Phone No.", 1, (StrLen(CompanyInfo."Phone No.") - 1)) + Ressource.Durchwahlnummer;
                end
                else begin
                    Caption_PersonInCharge := '';
                end;

                if Phone = '' then
                    Phone := CompanyInfo."Phone No.";
                if Fax = '' then
                    Fax := CompanyInfo."Fax No.";
                if SalespersonPurchaser."Fax No. TT" <> '' then
                    Fax := SalespersonPurchaser."Fax No. TT";
                if SalespersonPurchaser."E-Mail" <> '' then
                    eMail := SalespersonPurchaser."E-Mail";

                y := 1;

                //Job.CALCFIELDS(Objektname);
                if Job.Objektname <> '' then begin
                    //Caption_Vessel := 'Vessel';
                    //varVessel := Job.Objektname;
                    KopfCaption[y] := 'Vessel';
                    Kopfdaten[y] := Job.Objektname;
                    y += 1;
                end;

                if Job."Parts for" <> '' then begin
                    //Caption_PartsFor := 'Parts for';
                    //varPartsFor := 'txt1';
                    KopfCaption[y] := 'Parts for';
                    Kopfdaten[y] := Job."Parts for";
                    y += 1;
                end;

                if Job.Maker <> '' then begin
                    //Caption_Maker := 'Maker';
                    //varMaker := 'txt2';
                    KopfCaption[y] := 'Maker';
                    Kopfdaten[y] := Job.Maker;
                    y += 1;
                end;

                if Job.Type <> '' then begin
                    //Caption_Type := 'Type';
                    //varType := 'txt3';
                    KopfCaption[y] := 'Type';
                    Kopfdaten[y] := Job.Type;
                    y += 1;
                end;

                if Multi.Get('SCHIFF', Job.Object) then begin
                    if Multi."LLoyds No." <> '' then begin
                        //Caption_IMO := 'IMO No.';
                        //varIMO := 'txt4';
                        KopfCaption[y] := 'IMO No.';
                        Kopfdaten[y] := Multi."LLoyds No.";
                        y += 1;
                    end;
                end;

                if Job."We Quote for" <> '' then begin
                    //Caption_WeQuoteFor := 'We quote for';
                    //varWeQuoteFor := 'txt5';
                    KopfCaption[y] := 'We quote for';
                    Kopfdaten[y] := Job."We Quote for";
                    y += 1;
                end;

                if Job."Serial Number" <> '' then begin
                    //Caption_SN := 'Serial Number';
                    //varSN := 'txt6';
                    KopfCaption[y] := 'Serial Number';
                    Kopfdaten[y] := Job."Serial Number";
                    y += 1;
                end;

                if Job.Specification <> '' then begin
                    //Caption_Spec := 'Specification';
                    //varSpec := 'txt7';
                    KopfCaption[y] := 'Specification';
                    Kopfdaten[y] := Job.Specification;
                end;

                AngebotKopfText := StrSubstNo(Text_AngebotAnschreiben1);
                AngebotKopfText += ' ' + StrSubstNo(Text_AngebotAnschreiben2, Multi.Description, Multi."LLoyds No.", CompanyInfo.Name,
                                                                             Job."Ship Owner", Job."Bareboat Charterer");
                AngebotKopfText += ' ' + StrSubstNo(Text_AngebotAnschreiben3, Job."Bareboat Charterer");

                AngebotFussText := StrSubstNo(Text_AngebotFuss1, Job.Objektname, Multi."LLoyds No.");
                AngebotFussText += StrSubstNo(Text_AngebotFuss2, Job."Ship Owner", Job."Bareboat Charterer", Header."Bill-to Name");

                if Header."Currency Code" <> '' then
                    CurrExchRate.FindCurrency(Header."Order Date", Header."Currency Code", 1);
                //G-ERP.FL 2012-03-13 -
                //G-ERP.KBS 2017-08-05 -

                TotalSubTotal := 0;
                TotalInvDiscAmount := 0;
                TotalAmount := 0;
                TotalAmountVAT := 0;
                TotalAmountInclVAT := 0;

                if "Status Approval 1" then begin
                    Purchaser.SetRange(Code, Unterschriftscode);
                    if Purchaser.FindFirst() then begin
                        EmployeeSignStore.SetRange("User Name", Purchaser."User ID");
                        if EmployeeSignStore.FindFirst() then
                            if FirstSign.Get(EmployeeSignStore.Signature.MediaId) then
                                FirstSign.CalcFields(Content);
                    end;
                end;
                Purchaser.Reset();
                if "Status Approval 2" then begin
                    EmployeeSignStore.Reset();
                    Purchaser.SetRange(Code, "Unterschriftscode 2");
                    if Purchaser.FindFirst() then begin
                        EmployeeSignStore.SetRange("User Name", Purchaser."User ID");
                        if EmployeeSignStore.FindFirst() then
                            if SecondSign.Get(EmployeeSignStore.Signature.MediaId) then
                                SecondSign.CalcFields(Content);
                    end;
                end;
            end;

            trigger OnPreDataItem()
            begin
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
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Anzahl Kopien';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Archive Document';
                        ToolTip = 'Specifies if the document is archived after you preview or print it.';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }

                }
            }
        }


        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction;
            LogInteractionEnable := LogInteraction;
            if SalesSetup."Archive Quotes" = SalesSetup."Archive Quotes"::Always then
                ArchiveDocument := true;
        end;
    }

    labels
    {
        DeliveryTimeCaption = 'o Delivery time:';
        AsStatedAboveCaption = 'as stated above, after receipt of your order (ready for shipment), subject to prior sale.';
        OurPricesAreCaption = 'o Our Prices are:';
        DeliveryTermsCaption = 'o Delivery terms:';
        QuotedPricesAreCaption = 'o Quoted prices are subject to revision in case of partial order';
        PaymentTermsCaption = 'o Payment terms:';
        ValidityCaption = 'o Validity:';
        RemarksCaption = 'Remarks:';
        TurboTechnikCaption = 'TURBO-TECHNIK';
        GmbHCaption = 'GmbH & Co. KG';
        Deliverytime = 'as stated above, after receipt of your order (ready for shipment), subject to prior sale.';
    }

    trigger OnInitReport()
    begin
        GLSetup.Get;
        CompanyInfo.Get;
        SalesSetup.Get;
        CompanyInfo.VerifyAndSetPaymentInfo;
    end;

    trigger OnPreReport()
    begin
        if Header.GetFilters = '' then
            Error(NoFilterSetErr);

        if not CurrReport.UseRequestPage then
            InitLogInteraction;

        CompanyLogoPosition := SalesSetup."Logo Position on Documents";
    end;

    var

        ShowDiscountColumn: Boolean;
        SalesConfirmationLbl: label 'Sales Quote';
        SalespersonLbl: label 'Sales person';
        CompanyInfoBankAccNoLbl: label 'Account No.';
        CompanyInfoBankNameLbl: label 'Bank';
        CompanyInfoGiroNoLbl: label 'Giro No.';
        CompanyInfoPhoneNoLbl: label 'Phone No.';
        CopyLbl: label 'Copy';
        EMailLbl: label 'Email';
        HomePageLbl: label 'Home Page';
        InvDiscBaseAmtLbl: label 'Invoice Discount Base Amount';
        InvDiscountAmtLbl: label 'Invoice Discount';
        InvNoLbl: label 'Quote No.';
        LineAmtAfterInvDiscLbl: label 'Payment Discount on VAT';
        LocalCurrencyLbl: label 'Local Currency';
        PageLbl: label 'Page';
        PaymentTermsDescLbl: label 'Payment Terms';
        PaymentMethodDescLbl: label 'Payment Method';
        PostedShipmentDateLbl: label 'Shipment Date';
        SalesInvLineDiscLbl: label 'Discount %';
        ShipmentLbl: label 'Shipment';
        ShiptoAddrLbl: label 'Ship-to Address';
        ShptMethodDescLbl: label 'Shipment Method';
        SubtotalLbl: label 'Subtotal';
        TotalLbl: label 'Total';
        VATAmtSpecificationLbl: label 'VAT Amount Specification';
        VATAmtLbl: label 'VAT Amount';
        VATAmountLCYLbl: label 'VAT Amount (LCY)';
        VATBaseLbl: label 'VAT Base';
        VATBaseLCYLbl: label 'VAT Base (LCY)';
        VATClausesLbl: label 'VAT Clause';
        VATIdentifierLbl: label 'VAT Identifier';
        VATPercentageLbl: label 'VAT %';
        WorkDescriptionInstream: InStream;
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        PaymentMethod: Record "Payment Method";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        Cust: Record Customer;
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        VATClause: Record "VAT Clause";
        FormatAddr: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        SegManagement: Codeunit SegManagement;
        PostedShipmentDate: Date;
        WorkDescriptionLine: Text;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        LineDiscountPctText: Text;
        MoreLines: Boolean;
        ShowWorkDescription: Boolean;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        TotalSubTotal: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalAmountVAT: Decimal;
        TotalInvDiscAmount: Decimal;
        TotalPaymentDiscOnVAT: Decimal;
        TransHeaderAmount: Decimal;
        [InDataSet]
        LogInteractionEnable: Boolean;
        CompanyLogoPosition: Integer;
        FirstLineHasBeenOutput: Boolean;
        CalculatedExchRate: Decimal;
        ExchangeRateText: Text;
        ExchangeRateTxt: label 'Exchange rate: %1/%2', Comment = '%1 and %2 are both amounts.';
        VATBaseLCY: Decimal;
        VATAmountLCY: Decimal;
        TotalVATBaseLCY: Decimal;
        TotalVATAmountLCY: Decimal;
        PrevLineAmount: Decimal;
        NoFilterSetErr: label 'You must specify one or more filters to avoid accidently printing all documents.';
        PmtDiscText: Text;
        GreetingLbl: label 'Hello';
        ClosingLbl: label 'Sincerely';
        PmtDiscTxt: label 'If we receive the payment before %1, you are eligible for a 2% payment discount.', Comment = '%1 = Discount Due Date %2 = value of Payment Discount % ';
        BodyLbl: label 'Thank you for your business. Your quote is attached to this message.';
        Text004: label 'Quotation';
        "*G-ERP*": Integer;
        BLZText: Text[30];
        SalesPurchPerson2: Record "Salesperson/Purchaser";
        Preistellung_t: Text[30];
        SalesPurchPerson3: Record "Salesperson/Purchaser";
        pos: Code[10];
        KTOText: Text[20];
        Job: Record Job;
        Ressource: Record Resource;
        PersonInCharge: Text[50];
        Caption_PersonInCharge: Text[50];
        AngebotKopfText: Text[1024];
        AngebotFussText: Text[1024];
        Phone: Text[30];
        Fax: Text[30];
        eMail: Text[50];
        Caption_Vessel: Text[50];
        Caption_PartsFor: Text[50];
        Caption_Maker: Text[50];
        Caption_Type: Text[50];
        Caption_IMO: Text[50];
        VarIMO: Text[50];
        Caption_WeQuoteFor: Text[50];
        Caption_SN: Text[50];
        Caption_Spec: Text[50];
        Caption_Validity: Text[50];
        Kopfdaten: array[20] of Text[50];
        KopfCaption: array[20] of Text[50];
        y: Integer;
        Multi: Record "Multi Table";
        Text000: label 'Contact';
        ReferenceText: Text[30];
        VATNoText: Text[30];
        Text001: label 'Total %1';
        Text002: label 'Total %1 Incl. VAT';
        Text006: label 'Total %1 Excl. VAT';
        Country: Record "Country/Region";
        i: Integer;
        Text_PersonInCharge: label 'Person in charge';
        Text_AngebotAnschreiben1: label 'Thank you for your inquiry. We are sending you our following/attached offer without obligation on the basis of our attached General Terms and Conditions.';
        Text_AngebotFuss1: label 'The contract regarding the repair of the ship %1, IMO-No. %2, shall be concluded between TURBO-TECHNIK GmbH & Co. KG';
        Text_AngebotFuss2: label ' and the ship owning company %1 and if applicable the bareboat charterer %2. We assume that you are authorized to conclude the contract as a proxy. In case we have any outstandig claims under this contract against the ship owning company and/or the bareboat charterer you %3, shall be liable as our co-debtor beside the ship owning company and the bareboat charterer.';
        CurrExchRate: Record "Currency Exchange Rate";
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        Text003: label 'COPY';
        SalesLine: Record "Sales Line" temporary;
        SalesSetup: Record "Sales & Receivables Setup";
        SalesCountPrinted: Codeunit "Sales-Printed";
        AnredeCaptionEmpty: label 'Dear Sir or Madam,';
        AnredeCaption: Text[100];
        KommanditgesellschaftCaption: label 'This company is a limited partnership,';
        RegistergerichtCaption: label 'Register Court Oldenburg HRA 200812';
        PersHaftende: label 'General Partner:';
        TurboTechnikBeteiligungsCaption: label 'Turbo-Technik Beteiligungs GmbH';
        Registergericht2Caption: label 'Register Court Oldenburg HRB 208134';
        BankverbindungenCaption: label 'Bank details:';
        FaxCaption: label 'Telefax';
        Text_AngebotAnschreiben2: label 'The contract regarding the repair of the ship %1, IMO-No. %2, shall be concluded between %3 and the ship owning company %4 and if applicable the bareboat charterer %5.';
        Text_AngebotAnschreiben3: label 'We assume that you are authorized to conclude the contract as a proxy. In case we have any outstanding claims under this contract against the ship owning company and/or the bareboat charterer you %1, shall be liable as our co-debtor beside the ship owning company and the bareboat charterer.';
        Line_Lfd: Integer;
        LineDiscountCaption: label 'Discount %';
        UnitOfMeasureTranslation: Text;
        FirstSign: Record "Tenant Media";
        SecondSign: Record "Tenant Media";

    local procedure InitLogInteraction()
    begin
        // LogInteraction := SegManagement.FindInteractTmplCode(1) <> ''; Wird nicht mehr unterstützt.
        LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Qte.") <> '';
    end;

    local procedure DocumentCaption(): Text[250]
    begin
        exit(SalesConfirmationLbl);
    end;


    procedure InitializeRequest(NewLogInteraction: Boolean)
    begin
        LogInteraction := NewLogInteraction;
    end;

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    begin
        with SalesHeader do begin
            FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetSalesPerson(SalespersonPurchaser, "Salesperson Code", SalesPersonText);
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetPaymentMethod(PaymentMethod, "Payment Method Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");
        end;
    end;

    local procedure CreateReportTotalLines()
    begin
        ReportTotalsLine.DeleteAll;
        if (TotalInvDiscAmount <> 0) or (TotalAmountVAT <> 0) then
            ReportTotalsLine.Add(SubtotalLbl, TotalSubTotal, true, false, false);
        if TotalInvDiscAmount <> 0 then begin
            ReportTotalsLine.Add(InvDiscountAmtLbl, TotalInvDiscAmount, false, false, false);
            if TotalAmountVAT <> 0 then
                ReportTotalsLine.Add(TotalExclVATText, TotalAmount, true, false, false);
        end;
        if TotalAmountVAT <> 0 then
            ReportTotalsLine.Add(VATAmountLine.VATAmountText, TotalAmountVAT, false, true, false);
    end;
}


#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50003 "TT Sales - Order"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TT Sales - Order.rdlc';
    Caption = 'Sales - Order Confirmation';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Order));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Quote';
            column(ReportForNavId_6640; 6640)
            {
            }
            column(Sales_Header_Document_Type; "Document Type")
            {
            }
            column(Sales_Header_No_; "No.")
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
                    column(ReportForNavId_6455; 6455)
                    {
                    }
                    column(Punkt2; Punkt2)
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(STRSUBSTNO_Text004_CopyText____________Sales_Header___Job_No__; StrSubstNo(Text004, CopyText) + ' ' + "Sales Header"."Job No.")
                    {
                    }
                    column(Phone; Phone)
                    {
                    }
                    column(Fax; Fax)
                    {
                    }
                    column(eMail; eMail)
                    {
                    }
                    column(CompanyInfo__Home_Page_; CompanyInfo."Home Page")
                    {
                    }
                    column(FORMAT__Sales_Header___Document_Date__0_4_; Format("Sales Header"."Document Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(Sales_Header___Your_Reference_; "Sales Header"."Your Reference")
                    {
                    }
                    column(CompanyInfo_Address___________CompanyInfo__Post_Code__________CompanyInfo_City_______Germany_; CompanyInfo.Address + ' ╠ ' + CompanyInfo."Post Code" + ' ' + CompanyInfo.City + ' ╠ Germany')
                    {
                    }
                    column(CompanyInfo_Name; CompanyInfo.Name)
                    {
                    }
                    column(CompanyInfo__Picture_1_; CompanyInfo."Picture 1")
                    {
                    }
                    column(CompanyInfo__Registration_No__; CompanyInfo."Registration No.")
                    {
                    }
                    column(CustAddr_8_; CustAddr[8])
                    {
                    }
                    column(CustAddr_7_; CustAddr[7])
                    {
                    }
                    column(CustAddr_6_; CustAddr[6])
                    {
                    }
                    column(CustAddr_5_; CustAddr[5])
                    {
                    }
                    column(CustAddr_4_; CustAddr[4])
                    {
                    }
                    column(CustAddr_3_; CustAddr[3])
                    {
                    }
                    column(CustAddr_2_; CustAddr[2])
                    {
                    }
                    column(CustAddr_1_; CustAddr[1])
                    {
                    }
                    column(AngebotKopfText; AngebotKopfText)
                    {
                    }
                    column(PersonInCharge; PersonInCharge)
                    {
                    }
                    column(Caption_PersonInCharge; Caption_PersonInCharge)
                    {
                    }
                    column(KopfCaption_5_; KopfCaption[5])
                    {
                    }
                    column(Kopfdaten_5_; Kopfdaten[5])
                    {
                    }
                    column(KopfCaption_1_; KopfCaption[1])
                    {
                    }
                    column(Kopfdaten_1_; Kopfdaten[1])
                    {
                    }
                    column(KopfCaption_6_; KopfCaption[6])
                    {
                    }
                    column(Kopfdaten_6_; Kopfdaten[6])
                    {
                    }
                    column(KopfCaption_2_; KopfCaption[2])
                    {
                    }
                    column(KopfCaption_3_; KopfCaption[3])
                    {
                    }
                    column(KopfCaption_4_; KopfCaption[4])
                    {
                    }
                    column(Kopfdaten_3_; Kopfdaten[3])
                    {
                    }
                    column(Kopfdaten_2_; Kopfdaten[2])
                    {
                    }
                    column(Kopfdaten_4_; Kopfdaten[4])
                    {
                    }
                    column(KopfCaption_7_; KopfCaption[7])
                    {
                    }
                    column(KopfCaption_8_; KopfCaption[8])
                    {
                    }
                    column(EmptyString; '')
                    {
                    }
                    column(Kopfdaten_7_; Kopfdaten[7])
                    {
                    }
                    column(Kopfdaten_8_; Kopfdaten[8])
                    {
                    }
                    column(EmptyString_Control1000000019; '')
                    {
                    }
                    column(AngebotFussText; AngebotFussText)
                    {
                    }
                    column(AngebotFussText1; AngebotFussText1)
                    {
                    }
                    column(AngebotKopfText1; AngebotKopfText1)
                    {
                    }
                    column(CompanyInfo__Picture_2_; CompanyInfo."Picture 2")
                    {
                    }
                    column(CompanyInfo_FIELDCAPTION__Managing_Director____________CompanyInfo__Managing_Director_; CompanyInfo.FieldCaption("Managing Director") + ': ' + CompanyInfo."Managing Director")
                    {
                    }
                    column(CompanyInfo__Bank_Name_2_; CompanyInfo."Bank Name 2")
                    {
                    }
                    column(CompanyInfo__Bank_Name_1_; CompanyInfo."Bank Name 1")
                    {
                    }
                    column(CompanyInfo__Bank_Name_; CompanyInfo."Bank Name")
                    {
                    }
                    column(SWIFT______CompanyInfo__SWIFT_Code_1________IBAN______CompanyInfo__IBAN_1_; 'SWIFT: ' + CompanyInfo."SWIFT Code 1" + ',  IBAN: ' + CompanyInfo."IBAN 1")
                    {
                    }
                    column(SWIFT______CompanyInfo__SWIFT_Code________IBAN______CompanyInfo_IBAN; 'SWIFT: ' + CompanyInfo."SWIFT Code" + ',  IBAN: ' + CompanyInfo.Iban)
                    {
                    }
                    column(SWIFT______CompanyInfo__SWIFT_Code_2________IBAN______CompanyInfo__IBAN_2_; 'SWIFT: ' + CompanyInfo."SWIFT Code 2" + ',  IBAN: ' + CompanyInfo."IBAN 2")
                    {
                    }
                    column(KTOText___CompanyInfo__Bank_Account_No_____________BLZText__________CompanyInfo__Bank_Branch_No________; KTOText + CompanyInfo."Bank Account No." + ' (' + BLZText + '  ' + CompanyInfo."Bank Branch No." + ')')
                    {
                    }
                    column(KTOText___CompanyInfo__Bank_Account_No__1____________BLZText__________CompanyInfo__Bank_Branch_No__1_______; KTOText + CompanyInfo."Bank Account No. 1" + ' (' + BLZText + '  ' + CompanyInfo."Bank Branch No. 1" + ')')
                    {
                    }
                    column(KTOText___CompanyInfo__Bank_Account_No__2____________BLZText__________CompanyInfo__Bank_Branch_No__2_______; KTOText + CompanyInfo."Bank Account No. 2" + ' (' + BLZText + '  ' + CompanyInfo."Bank Branch No. 2" + ')')
                    {
                    }
                    column(REPAIRYARDCaption; REPAIRYARDCaptionLbl)
                    {
                    }
                    column(PhoneCaption; PhoneCaptionLbl)
                    {
                    }
                    column(FaxCaption; FaxCaptionLbl)
                    {
                    }
                    column(eMailCaption; eMailCaptionLbl)
                    {
                    }
                    column(CompanyInfo__Home_Page_Caption; CompanyInfo__Home_Page_CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Registration_No__Caption; CompanyInfo__Registration_No__CaptionLbl)
                    {
                    }
                    column(FORMAT__Sales_Header___Document_Date__0_4_Caption; FORMAT__Sales_Header___Document_Date__0_4_CaptionLbl)
                    {
                    }
                    column(Dear_Sirs_Caption; Dear_Sirs_CaptionLbl)
                    {
                    }
                    column(V1_Caption; V1_CaptionLbl)
                    {
                    }
                    column(V2_Caption; V2_CaptionLbl)
                    {
                    }
                    column(Nature_and_extent_of_work_to_be_performed_us_Caption; Nature_and_extent_of_work_to_be_performed_us_CaptionLbl)
                    {
                    }
                    column(FORMAT__Sales_Header___Document_Date__0_4__Control1140053Caption; FORMAT__Sales_Header___Document_Date__0_4__Control1140053CaptionLbl)
                    {
                    }
                    column(PageCaption; PageCaptionLbl)
                    {
                    }
                    column(ToCaption; ToCaptionLbl)
                    {
                    }
                    column(This_company_is_a_limited_partnership_Caption; This_company_is_a_limited_partnership_CaptionLbl)
                    {
                    }
                    column(Register_Court_Oldenburg_HRA_200812Caption; Register_Court_Oldenburg_HRA_200812CaptionLbl)
                    {
                    }
                    column(General_Partner_Caption; General_Partner_CaptionLbl)
                    {
                    }
                    column(Turbo_Technik_Beteiligungs_GmbHCaption; Turbo_Technik_Beteiligungs_GmbHCaptionLbl)
                    {
                    }
                    column(Register_Court_Oldenburg_HRB_208134Caption; Register_Court_Oldenburg_HRB_208134CaptionLbl)
                    {
                    }
                    column(Bank_details_Caption; Bank_details_CaptionLbl)
                    {
                    }
                    column(Unterschriftscode2; "Sales Header"."Unterschriftscode 2")
                    {
                    }
                    column(PageLoop_Number; Number)
                    {
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = sorting("Document Type", "Document No.", "Line No.");
                        column(ReportForNavId_2844; 2844)
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
                        column(SalesHeader_PricesInclVAT; "Sales Header"."Prices Including VAT")
                        {
                        }
                        column(SalesHeader_VATBaseDiscountPerc; "Sales Header"."VAT Base Discount %")
                        {
                        }
                        column(SalesLine_Type; "Sales Line".Type)
                        {
                        }
                        column(SalesLine__Line_Amount_; SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine_Description; SalesLine.Description)
                        {
                        }
                        column(pos; pos)
                        {
                        }
                        column(Sales_Line__Description; "Sales Line".Description)
                        {
                        }
                        column(Sales_Line__Quantity; "Sales Line".Quantity)
                        {
                        }
                        column(Sales_Line___Unit_of_Measure_; "Sales Line"."Unit of Measure")
                        {
                        }
                        column(Sales_Line___Line_Amount_; "Sales Line"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line___Unit_Price_; "Sales Line"."Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(Sales_Line__Delivery; "Sales Line".Delivery)
                        {
                        }
                        column(SalesLine__Description_2_; SalesLine."Description 2")
                        {
                        }
                        column(P_N_____Sales_Line___Part_No__; 'P/N: ' + "Sales Line"."Part No.")
                        {
                        }
                        column(PartNo; "Sales Line"."Part No.")
                        {
                        }
                        column(SalesLine__Line_Amount__Control84; SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__Inv__Discount_Amount_; -SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(SalesLine__Line_Amount__Control61; SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(SalesLine__Line_Amount__SalesLine__Inv__Discount_Amount_; SalesLine."Line Amount" - SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATAmountText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Sales_Line__DescriptionCaption; "Sales Line".FieldCaption(Description))
                        {
                        }
                        column(posCaption; posCaptionLbl)
                        {
                        }
                        column(Qty_Caption; Qty_CaptionLbl)
                        {
                        }
                        column(UnitCaption; UnitCaptionLbl)
                        {
                        }
                        column(Price_UnitCaption; Price_UnitCaptionLbl)
                        {
                        }
                        column(Price_TotalCaption; Price_TotalCaptionLbl)
                        {
                        }
                        column(DeliveryCaption; DeliveryCaptionLbl)
                        {
                        }
                        column(ContinuedCaption; ContinuedCaptionLbl)
                        {
                        }
                        column(SalesLine__Inv__Discount_Amount_Caption; SalesLine__Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(RoundLoop_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        var
                            L_UnitofMeasureTranslation: Record "Unit of Measure Translation";
                        begin
                            if Number = 1 then
                                SalesLine.Find('-')
                            else
                                SalesLine.Next;
                            "Sales Line" := SalesLine;

                            if not "Sales Header"."Prices Including VAT" and
                               (SalesLine."VAT Calculation Type" = SalesLine."vat calculation type"::"Full VAT")
                            then
                                SalesLine."Line Amount" := 0;

                            if (SalesLine.Type = SalesLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Sales Line"."No." := '';

                            if L_UnitofMeasureTranslation.Get("Sales Line"."Unit of Measure", 'ENU') then
                                "Sales Line"."Unit of Measure" := L_UnitofMeasureTranslation.Description;

                            //G-ERP.KBS 2017-08-17 +
                            if SalesLine.Type > 0 then
                                pos := IncStr(pos);
                            //G-ERP.KBS 2017-08-17 -
                        end;

                        trigger OnPostDataItem()
                        begin
                            SalesLine.DeleteAll;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := SalesLine.Find('+');
                            while MoreLines and (SalesLine.Description = '') and (SalesLine."Description 2" = '') and
                                  (SalesLine."No." = '') and (SalesLine.Quantity = 0) and
                                  (SalesLine.Amount = 0)
                            do
                                MoreLines := SalesLine.Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break;
                            SalesLine.SetRange("Line No.", 0, SalesLine."Line No.");
                            SetRange(Number, 1, SalesLine.Count);
                            CurrReport.CreateTotals(SalesLine."Line Amount", SalesLine."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(ReportForNavId_6558; 6558)
                        {
                        }
                        column(VATAmountLine__VAT_Base_; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT_Amount_; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Line_Amount_; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount_; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__Invoice_Discount_Amount_; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT___; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Identifier_; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLine__VAT___Caption; VATAmountLine__VAT___CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Amount__Control69Caption; VATAmountLine__VAT_Amount__Control69CaptionLbl)
                        {
                        }
                        column(VAT_Amount_SpecificationCaption; VAT_Amount_SpecificationCaptionLbl)
                        {
                        }
                        column(VATAmountLine__Line_Amount__Control73Caption; VATAmountLine__Line_Amount__Control73CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Inv__Disc__Base_Amount__Control72Caption; VATAmountLine__Inv__Disc__Base_Amount__Control72CaptionLbl)
                        {
                        }
                        column(VATAmountLine__Invoice_Discount_Amount__Control71Caption; VATAmountLine__Invoice_Discount_Amount__Control71CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier_Caption; VATAmountLine__VAT_Identifier_CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Base_Caption; VATAmountLine__VAT_Base_CaptionLbl)
                        {
                        }
                        column(VATCounter_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break;

                            if VATAmount = 0 then
                                CurrReport.Break;
                            SetRange(Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(
                              VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount",
                              VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(ReportForNavId_2038; 2038)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine__VAT____Control154; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATAmountLine__VAT_Identifier__Control155; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VALVATAmountLCY_Control152Caption; VALVATAmountLCY_Control152CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control153Caption; VALVATBaseLCY_Control153CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT____Control154Caption; VATAmountLine__VAT____Control154CaptionLbl)
                        {
                        }
                        column(VATAmountLine__VAT_Identifier__Control155Caption; VATAmountLine__VAT_Identifier__Control155CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCYCaption; VALVATBaseLCYCaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control157Caption; VALVATBaseLCY_Control157CaptionLbl)
                        {
                        }
                        column(VALVATBaseLCY_Control160Caption; VALVATBaseLCY_Control160CaptionLbl)
                        {
                        }
                        column(VATCounterLCY_Number; Number)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            /*
                            VATAmountLine.GetLine(Number);
                            
                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                               "Sales Header"."Order Date","Sales Header"."Currency Code",
                                               VATAmountLine."VAT Base","Sales Header"."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                                 "Sales Header"."Order Date","Sales Header"."Currency Code",
                                                 VATAmountLine."VAT Amount","Sales Header"."Currency Factor"));
                            */

                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break;

                            /*
                            IF (NOT GLSetup."Print VAT specification in LCY") OR
                               ("Sales Header"."Currency Code"  = '') OR
                               (VATAmountLine.GetTotalVATAmount = 0) THEN
                              CurrReport.BREAK;
                            
                            SETRANGE(Number,1,VATAmountLine.COUNT);
                            CurrReport.CREATETOTALS(VALVATBaseLCY,VALVATAmountLCY);
                            
                            IF GLSetup."LCY Code" = '' THEN
                              VALSpecLCYHeader := Text008 + Text009
                            ELSE
                              VALSpecLCYHeader := Text008 + FORMAT(GLSetup."LCY Code");
                            
                            CurrExchRate.FindCurrency("Sales Header"."Order Date","Sales Header"."Currency Code",1);
                            VALExchRate := STRSUBSTNO(Text010,CurrExchRate."Relational Exch. Rate Amount",CurrExchRate."Exchange Rate Amount");
                            */

                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));
                        column(ReportForNavId_3476; 3476)
                        {
                        }
                        column(PaymentTerms_Description; PaymentTerms.Description)
                        {
                        }
                        column(Preistellung_t; Preistellung_t)
                        {
                        }
                        column(Sales_Header___Place_of_delivery_; "Sales Header"."Place of delivery")
                        {
                        }
                        column(Sales_Header___Date_of_delivery_; "Sales Header"."Date of delivery")
                        {
                        }
                        column(PaymentTerms_DescriptionCaption; PaymentTerms_DescriptionCaptionLbl)
                        {
                        }
                        column(We_thank_you_for_your_confidence_and_assure_you_to_execute_this_order_most_carefully_Caption; We_thank_you_for_your_confidence_and_assure_you_to_execute_this_order_most_carefully_CaptionLbl)
                        {
                        }
                        column(Prices_Caption; Prices_CaptionLbl)
                        {
                        }
                        column(Place_of_delivery_Caption; Place_of_delivery_CaptionLbl)
                        {
                        }
                        column(Approx__date_of_delivery_Caption; Approx__date_of_delivery_CaptionLbl)
                        {
                        }
                        column(Yours_faithfully_Caption; Yours_faithfully_CaptionLbl)
                        {
                        }
                        column(Total_Number; Number)
                        {
                        }
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));
                        column(ReportForNavId_3363; 3363)
                        {
                        }
                        column(Sales_Header___Sell_to_Customer_No__; "Sales Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr_1_; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr_2_; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr_3_; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr_4_; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr_5_; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr_6_; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr_7_; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr_8_; ShipToAddr[8])
                        {
                        }
                        column(Ship_to_AddressCaption; Ship_to_AddressCaptionLbl)
                        {
                        }
                        column(Sales_Header___Sell_to_Customer_No__Caption; "Sales Header".FieldCaption("Sell-to Customer No."))
                        {
                        }
                        column(Total2_Number; Number)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            //IF NOT ShowShippingAddr THEN
                            CurrReport.Break;
                        end;
                    }
                    dataitem(Remarks; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        MaxIteration = 1;
                        column(ReportForNavId_8304; 8304)
                        {
                        }
                    }
                    dataitem(Gruss; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));
                        column(ReportForNavId_5216; 5216)
                        {
                        }
                        column(SalesPurchPerson2__Job_Title__________SalesPurchPerson2_Name; SalesPurchPerson2."Job Title" + ' ' + SalesPurchPerson2.Name)
                        {
                        }
                        column(SalesPurchPerson3__Job_Title__________SalesPurchPerson3_Name; SalesPurchPerson3."Job Title" + ' ' + SalesPurchPerson3.Name)
                        {
                        }
                        column(Gruss_Number; Number)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if "Sales Header"."Unterschriftscode 2" <> '' then
                                CurrReport.Break;
                        end;
                    }

                    trigger OnAfterGetRecord()
                    begin
                        pos := '000';
                    end;
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "Sales-Post";
                begin
                    Clear(SalesLine);
                    Clear(SalesPost);
                    SalesLine.DeleteAll;
                    VATAmountLine.DeleteAll;
                    SalesPost.GetSalesLines("Sales Header", SalesLine, 0);
                    SalesLine.CalcVATAmountLines(0, "Sales Header", SalesLine, VATAmountLine);
                    SalesLine.UpdateVATOnLines(0, "Sales Header", SalesLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount;
                    VATBaseAmount := VATAmountLine.GetTotalVATBase;
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT;

                    if Number > 1 then
                        CopyText := Text003;
                    CurrReport.PageNo := 1;
                end;

                trigger OnPostDataItem()
                begin
                    if not CurrReport.Preview then
                        SalesCountPrinted.Run("Sales Header");
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
                "Sell-to Country": Text[50];
            begin
                "Language Code" := 'ENU';
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");

                if RespCenter.Get("Responsibility Center") then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No." := RespCenter."Phone No.";
                    CompanyInfo."Fax No." := RespCenter."Fax No.";
                end else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);

                //21.11.07 AG+
                CompanyInfo.CalcFields(Picture, "Picture 1", "Picture 2");
                BLZText := 'BLZ';
                KTOText := 'Konto-Nr.: ';
                if "Language Code" = 'ENU' then begin
                    BLZText := 'BCN';
                    KTOText := 'Account-No.: ';
                end;
                //21.11.07 AG-

                if "Salesperson Code" = '' then begin
                    SalesPurchPerson.Init;
                    SalesPurchPerson2.Init;
                    SalesPersonText := '';

                end else begin
                    SalesPurchPerson.Get("Salesperson Code");
                    SalesPurchPerson2.Get("Salesperson Code");
                    SalesPersonText := Text000;
                    //21.11.07 AG+
                    //CompanyInfo."Phone No." := SalesPurchPerson."Phone No.";
                    //CompanyInfo."Fax No." := SalesPurchPerson."Fax No.";
                    //CompanyInfo."E-Mail" := SalesPurchPerson."E-Mail";
                    //21.11.07 AG-
                end;
                if Unterschriftscode <> '' then
                    SalesPurchPerson2.Get(Unterschriftscode);
                if "Unterschriftscode 2" <> '' then
                    SalesPurchPerson3.Get("Unterschriftscode 2");
                if "Your Reference" = '' then
                    ReferenceText := ''
                else
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
                "Sales Header"."Bill-to Contact" := "Sales Header"."Sell-to Contact";
                "Sales Header"."Ship-to Contact" := "Sales Header"."Sell-to Contact";
                FormatAddr.SalesHeaderBillTo(CustAddr, "Sales Header");

                if "Payment Terms Code" = '' then
                    PaymentTerms.Init
                else begin
                    PaymentTerms.Get("Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms, "Sales Header"."Language Code");
                end;
                if "Shipment Method Code" = '' then
                    ShipmentMethod.Init
                else begin
                    ShipmentMethod.Get("Shipment Method Code");
                    ShipmentMethod.TranslateDescription(ShipmentMethod, "Sales Header"."Language Code");
                end;

                if Country.Get("Sales Header"."Sell-to Country/Region Code") then
                    "Sell-to Country" := Country.Name;
                FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, "Sales Header");
                ShowShippingAddr := "Sell-to Customer No." <> "Bill-to Customer No.";
                for i := 1 to ArrayLen(ShipToAddr) do
                    if (ShipToAddr[i] <> CustAddr[i]) and (ShipToAddr[i] <> '') and (ShipToAddr[i] <> "Sell-to Country") then
                        ShowShippingAddr := true;

                if not CurrReport.Preview then begin
                    if ArchiveDocument then
                        ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);

                    if LogInteraction then begin
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
                end;
                "Sales Header".Mark(true);
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

                if Job.Get("Sales Header"."Job No.") then;
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
                if SalesPurchPerson."Fax No. TT" <> '' then
                    Fax := SalesPurchPerson."Fax No. TT";
                if SalesPurchPerson."E-Mail" <> '' then
                    eMail := SalesPurchPerson."E-Mail";

                y := 1;

                //IF Job."Auftragseingang erfolgte am" <> 0D THEN BEGIN
                KopfCaption[y] := 'Your Order dated:';
                Kopfdaten[y] := Format(Job."Auftragseingang erfolgte am");
                y += 1;
                //END;

                //IF Job."Your Order No." <> '' THEN BEGIN
                KopfCaption[y] := 'Your Order No.:';
                Kopfdaten[y] := Job."Your Order No.";
                y += 1;
                //END;

                //IF Job.Objektname <> '' THEN BEGIN
                KopfCaption[y] := 'Vessel:';
                Kopfdaten[y] := Job.Objektname;
                y += 2;
                //END;

                //IF Job."No." <> '' THEN BEGIN
                KopfCaption[y] := 'Our Order No.:';
                Kopfdaten[y] := Job."No.";
                y += 1;
                //END;

                //IF Job.Reparaturleiter <> '' THEN BEGIN
                KopfCaption[y] := 'Technical Handling:';
                Kopfdaten[y] := Job.Reparaturleiter;
                y += 1;
                //END;

                //IF Job."Person Responsible" <> '' THEN BEGIN
                KopfCaption[y] := 'Commercial Handling:';
                Kopfdaten[y] := Job."Person Responsible";
                y += 1;
                //END;
                if Multi.Get('SCHIFF', Job.Object) then
                    if Multi."LLoyds No." <> '' then
                        VarIMO := Multi."LLoyds No.";

                /*
                IF Multi.GET('SCHIFF', Job.Object) THEN BEGIN
                  IF Multi."LLoyds No." <> '' THEN BEGIN
                    //Caption_IMO := 'IMO No.';
                    //varIMO := 'txt4';
                    KopfCaption[y] := 'IMO No.';
                    Kopfdaten[y] := Multi."LLoyds No.";
                    y += 1;
                  END;
                END;
                
                IF Job."We Quote for" <> '' THEN BEGIN
                  //Caption_WeQuoteFor := 'We quote for';
                  //varWeQuoteFor := 'txt5';
                  KopfCaption[y] := 'We quote for';
                  Kopfdaten[y] := Job."We Quote for";
                  y += 1;
                END;
                
                IF Job."Serial Number" <> '' THEN BEGIN
                  //Caption_SN := 'Serial Number';
                  //varSN := 'txt6';
                  KopfCaption[y] := 'Serial Number';
                  Kopfdaten[y] := Job."Serial Number";
                  y += 1;
                END;
                
                IF Job.Specification <> '' THEN BEGIN
                  //Caption_Spec := 'Specification';
                  //varSpec := 'txt7';
                  KopfCaption[y] := 'Specification';
                  Kopfdaten[y] := Job.Specification;
                END;
                */
                //IF not Multi.GET('SCHIFF', Job.Object) THEN
                //  multi.init;

                AngebotKopfText := StrSubstNo(Text_AuftragAnschreiben2, Format(Job."Auftragseingang erfolgte am"),
                                                                       Job."Auftragseingang erfolgte");

                AngebotFussText := StrSubstNo(Text_AngebotFuss1);
                AngebotFussText1 := StrSubstNo(Text_AngebotFuss2, Job.Objektname, VarIMO);
                AngebotFussText1 += StrSubstNo(Text_AngebotFuss3, Job."Ship Owner", Job."Bareboat Charterer", "Sales Header"."Bill-to Name");
                AngebotKopfText1 := StrSubstNo(Text_AuftragAnschreiben3, Job.Maker,
                                                                       Job.Type,
                                                                       Job."Parts for",
                                                                       Job.Planungsprojektnummer);

                if "Sales Header"."Currency Code" <> '' then
                    CurrExchRate.FindCurrency("Sales Header"."Order Date", "Sales Header"."Currency Code", 1);
                //G-ERP.FL 2012-03-13 -


                //STRSUBSTNO('o Price is based on an echange rate of 1 Euro
                // = %1 %2 and will be adjusted in case of changes.', CurrExchRate."Exchange Rate Amount", CurrExchRate."Currency Code")

            end;

            trigger OnPreDataItem()
            begin
                NoOfRecords := Count;
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
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Internal Information';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Archive Document';
                        Enabled = ArchiveDocumentEnable;

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;

                        trigger OnValidate()
                        begin
                            if LogInteraction then
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    field(ArchiveDocument2; Punkt2)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Archive Document';

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
            ArchiveDocumentEnable := true;
        end;

        trigger OnOpenPage()
        begin
            ArchiveDocument := ArchiveManagement.SalesDocArchiveGranule;
            LogInteraction := SegManagement.FindInteractionTemplateCode("Interaction Log Entry Document Type"::"Sales Qte.") <> '';

            ArchiveDocumentEnable := ArchiveDocument;
            LogInteractionEnable := LogInteraction;

            Punkt2 := true;
        end;
    }

    labels
    {
        TurboTechnikCaption = 'TURBO-TECHNIK';
        GmbHCaption = 'GmbH & Co. KG';
    }

    trigger OnInitReport()
    begin
        GLSetup.Get;
        CompanyInfo.Get;
        SalesSetup.Get;

        case SalesSetup."Logo Position on Documents" of
            SalesSetup."logo position on documents"::"No Logo":
                ;
            SalesSetup."logo position on documents"::Left:
                begin
                    CompanyInfo.CalcFields(Picture);
                end;
            SalesSetup."logo position on documents"::Center:
                begin
                    CompanyInfo1.Get;
                    CompanyInfo1.CalcFields(Picture);
                end;
            SalesSetup."logo position on documents"::Right:
                begin
                    CompanyInfo2.Get;
                    CompanyInfo2.CalcFields(Picture);
                end;
        end;
    end;

    var
        Text000: label 'Contact';
        Text001: label 'Total %1';
        Text002: label 'Total %1 Incl. VAT';
        Text003: label 'COPY';
        Text004: label 'ACKNOWLEDGEMENT OF ORDER';
        Text005: label 'Page %1';
        Text006: label 'Total %1 Excl. VAT';
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        SalesLine: Record "Sales Line" temporary;
        RespCenter: Record "Responsibility Center";
        Language: Codeunit Language;
        Country: Record "Country/Region";
        CurrExchRate: Record "Currency Exchange Rate";
        SalesCountPrinted: Codeunit "Sales-Printed";
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit SegManagement;
        ArchiveManagement: Codeunit ArchiveManagement;
        CustAddr: array[8] of Text[50];
        ShipToAddr: array[8] of Text[50];
        CompanyAddr: array[8] of Text[50];
        SalesPersonText: Text[30];
        VATNoText: Text[30];
        ReferenceText: Text[30];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        i: Integer;
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
        Text007: label 'Do you want to create a follow-up to-do?';
        NoOfRecords: Integer;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text008: label 'VAT Amount Specification in ';
        Text009: label 'Local Currency';
        Text010: label 'Exchange rate: %1/%2';
        Text50000: label 'we refer to your inquiry of';
        Text50001: label 'and have pleasure in quoting hereunder, on the base';
        Text50002: label 'of our General Terms and Conditions (Shiprepairs) as follows:';
        "*******HZPMS***********": Integer;
        BLZText: Text[30];
        SalesPurchPerson2: Record "Salesperson/Purchaser";
        Preistellung_t: Text[30];
        SalesPurchPerson3: Record "Salesperson/Purchaser";
        pos: Code[10];
        KTOText: Text[20];
        Text_PersonInCharge: label 'Person in charge';
        "####G-ERP####": Integer;
        Job: Record Job;
        Ressource: Record Resource;
        PersonInCharge: Text[50];
        Text_AuftragAnschreiben1: label 'Dear Sirs,';
        Text_AuftragAnschreiben2: label 'We hereby confirm to accept your order of %1 given by %2 subject to following conditions:';
        Caption_PersonInCharge: Text[50];
        AngebotKopfText: Text[1024];
        Text_AuftragAnschreiben3: label 'Supply of spare parts for %1 %2 %3 shaft seal as per our offer %4.';
        Text_AngebotFuss1: label 'Our attached General Terms and Conditions (Ship repairs) from part of the contract.';
        Text_AngebotFuss2: label 'The contract regarding the repair of the ship %1, IMO-No. %2, shall be concluded between TURBO-TECHNIK Reparatur-Werft GmbH & Co. KG';
        Text_AngebotFuss3: label ' and the ship owning company %1 and if applicable the bareboat charterer %2. We assume thar you are authorized to conclude the contract as a proxy. In case we have any outstandig claims under this contract against the ship owning company and/or the bareboat charterer you %3, shall be liable as our co-debtor beside the ship owning company and the bareboat charterer.';
        AngebotKopfText1: Text[1024];
        AngebotFussText: Text[1024];
        AngebotFussText1: Text[1024];
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
        Punkt2: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        REPAIRYARDCaptionLbl: label 'REPAIRYARD';
        PhoneCaptionLbl: label 'Telephone';
        FaxCaptionLbl: label 'Telefax';
        eMailCaptionLbl: label 'E-Mail';
        CompanyInfo__Home_Page_CaptionLbl: label 'Internet';
        CompanyInfo__Registration_No__CaptionLbl: label 'Registration No.';
        FORMAT__Sales_Header___Document_Date__0_4_CaptionLbl: label 'Date';
        Dear_Sirs_CaptionLbl: label 'Dear Sirs,';
        V1_CaptionLbl: label '1.';
        V2_CaptionLbl: label '2.';
        Nature_and_extent_of_work_to_be_performed_us_CaptionLbl: label 'Nature and extent of work to be performed us:';
        Nature_and_extent_of_work_to_be_performed_us_Caption_Control1000000028Lbl: label 'Nature and extent of work to be performed us:';
        FORMAT__Sales_Header___Document_Date__0_4__Control1140053CaptionLbl: label 'Date';
        PageCaptionLbl: label 'Page';
        ToCaptionLbl: label 'To';
        This_company_is_a_limited_partnership_CaptionLbl: label 'This company is a limited partnership,';
        Register_Court_Oldenburg_HRA_200812CaptionLbl: label 'Register Court Oldenburg HRA 200812';
        General_Partner_CaptionLbl: label 'General Partner:';
        Turbo_Technik_Beteiligungs_GmbHCaptionLbl: label 'Turbo-Technik Beteiligungs GmbH';
        Register_Court_Oldenburg_HRB_208134CaptionLbl: label 'Register Court Oldenburg HRB 208134';
        Bank_details_CaptionLbl: label 'Bank details:';
        Header_DimensionsCaptionLbl: label 'Header Dimensions';
        posCaptionLbl: label 'Item No.';
        Qty_CaptionLbl: label 'Qty.';
        UnitCaptionLbl: label 'Unit';
        Price_UnitCaptionLbl: label 'Price/Unit';
        Price_TotalCaptionLbl: label 'Price/Total';
        DeliveryCaptionLbl: label 'Delivery';
        ContinuedCaptionLbl: label 'Continued';
        ContinuedCaption_Control83Lbl: label 'Continued';
        SalesLine__Inv__Discount_Amount_CaptionLbl: label 'Inv. Discount Amount';
        SubtotalCaptionLbl: label 'Subtotal';
        VATDiscountAmountCaptionLbl: label 'Payment Discount on VAT';
        Line_DimensionsCaptionLbl: label 'Line Dimensions';
        VATAmountLine__VAT___CaptionLbl: label 'VAT %';
        VATAmountLine__VAT_Base__Control70CaptionLbl: label 'VAT Base';
        VATAmountLine__VAT_Amount__Control69CaptionLbl: label 'VAT Amount';
        VAT_Amount_SpecificationCaptionLbl: label 'VAT Amount Specification';
        VATAmountLine__Line_Amount__Control73CaptionLbl: label 'Line Amount';
        VATAmountLine__Inv__Disc__Base_Amount__Control72CaptionLbl: label 'Inv. Disc. Base Amount';
        VATAmountLine__Invoice_Discount_Amount__Control71CaptionLbl: label 'Invoice Discount Amount';
        VATAmountLine__VAT_Identifier_CaptionLbl: label 'VAT Identifier';
        VATAmountLine__VAT_Base_CaptionLbl: label 'Continued';
        VATAmountLine__VAT_Base__Control110CaptionLbl: label 'Continued';
        VATAmountLine__VAT_Base__Control114CaptionLbl: label 'Total';
        VALVATAmountLCY_Control152CaptionLbl: label 'VAT Amount';
        VALVATBaseLCY_Control153CaptionLbl: label 'VAT Base';
        VATAmountLine__VAT____Control154CaptionLbl: label 'VAT %';
        VATAmountLine__VAT_Identifier__Control155CaptionLbl: label 'VAT Identifier';
        VALVATBaseLCYCaptionLbl: label 'Continued';
        VALVATBaseLCY_Control157CaptionLbl: label 'Continued';
        VALVATBaseLCY_Control160CaptionLbl: label 'Total';
        PaymentTerms_DescriptionCaptionLbl: label 'Payment Terms';
        We_thank_you_for_your_confidence_and_assure_you_to_execute_this_order_most_carefully_CaptionLbl: label 'We thank you for your confidence and assure you to execute this order most carefully.';
        Prices_CaptionLbl: label 'Prices:';
        Place_of_delivery_CaptionLbl: label 'Place of delivery:';
        Approx__date_of_delivery_CaptionLbl: label 'Approx. date of delivery:';
        Yours_faithfully_CaptionLbl: label 'Yours faithfully,';
        Ship_to_AddressCaptionLbl: label 'Ship-to Address';
}


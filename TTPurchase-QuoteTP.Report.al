#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50028 "TT Purchase - Quote TP"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/TT Purchase - Quote TP.rdlc';
    Caption = 'Quote';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(Quote));
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
                    column(ReportForNavId_6455; 6455)
                    {
                    }
                    column(CompanyInfo_Picture; CompanyInfo.Picture)
                    {
                    }
                    column(STRSUBSTNO_Text004_CopyText__________Purchase_Header___Job_No____________Purchase_Header___No__; StrSubstNo(Text004, CopyText) + ' ' + "Purchase Header"."Job No." + '/' + "Purchase Header"."No.")
                    {
                    }
                    column(CompanyInfo__Phone_No__; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfo__Fax_No__; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfo__E_Mail_; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfo__Home_Page_; CompanyInfo."Home Page")
                    {
                    }
                    column(FORMAT__Purchase_Header___Document_Date__0_4_; Format("Purchase Header"."Document Date", 0, 4))
                    {
                    }
                    column(VATNoText; VATNoText)
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No__; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(PurchaserText; PurchaserText)
                    {
                    }
                    column(SalesPurchPerson_Name___Durchwahl; SalesPurchPerson.Name + Durchwahl)
                    {
                    }
                    column(ReferenceText; ReferenceText)
                    {
                    }
                    column(Purchase_Header___Your_Reference_; PersonCharge_Lbl)
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
                    column(CompanyInfo__Picture_1_; CompanyInfo."Picture 1")
                    {
                    }
                    column(CompanyInfo__Registration_No__; CompanyInfo."Registration No.")
                    {
                    }
                    column(FaxNr; FaxNr)
                    {
                    }
                    column(Schiffstext; Schiffstext)
                    {
                    }
                    column(Kontaktname; Kontaktname)
                    {
                    }
                    column(Vendor__Fax_No__; Vendor."Fax No.")
                    {
                    }
                    column(PurchaserText2; PurchaserText2)
                    {
                    }
                    column(Resource_Name___Durchwahl2; Resource.Name)
                    {
                    }
                    column(Betrieb_Rotterdam; "Purchase Header"."Betriebsstätte Rotterdam")
                    {
                    }
                    column(Purchase_Header_Unterschriftscode; "Purchase Header".Unterschriftscode)
                    {
                    }
                    column(Purchase_Header_Unterschrift; Unterschrift)
                    {
                    }
                    column(SalesPurchPerson3__Job_Title__________SalesPurchPerson3_Name; SalesPurchPerson3."Job Title" + ' ' + SalesPurchPerson3.Name)
                    {
                    }
                    column(Purchase_Header_Unterschriftscode2; "Purchase Header"."Unterschriftscode 2")
                    {
                    }
                    column(SalesPurchPerson2__Job_Title__________SalesPurchPerson2_Name; SalesPurchPerson2."Job Title" + ' ' + SalesPurchPerson2.Name)
                    {
                    }
                    column(AnzeigeSchiff; AnzeigeSchiff)
                    {
                    }
                    column(STRSUBSTNO_Text004_CopyText__________Purchase_Header___Job_No____________Purchase_Header___No___Control1140069; StrSubstNo(Text004, CopyText) + ' ' + "Purchase Header"."Job No." + '/' + "Purchase Header"."No.")
                    {
                    }
                    column(CompanyInfo__Phone_No___Control1140076; CompanyInfo."Phone No.")
                    {
                    }
                    column(CompanyInfo__Fax_No___Control1140079; CompanyInfo."Fax No.")
                    {
                    }
                    column(CompanyInfo__E_Mail__Control1140083; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfo__Home_Page__Control1140085; CompanyInfo."Home Page")
                    {
                    }
                    column(FORMAT__Purchase_Header___Document_Date__0_4__Control1140086; Format("Purchase Header"."Document Date", 0, 4))
                    {
                    }
                    column(PurchaserText_Control1140089; PurchaserText)
                    {
                    }
                    column(SalesPurchPerson_Name___Durchwahl_Control1140090; SalesPurchPerson.Name + Durchwahl)
                    {
                    }
                    column(ReferenceText_Control1140091; ReferenceText)
                    {
                    }
                    column(Purchase_Header___Your_Reference__Control1140092; "Purchase Header"."Your Reference")
                    {
                    }
                    column(BuyFromAddr_1__Control1140093; BuyFromAddr[1])
                    {
                    }
                    column(BuyFromAddr_2__Control1140094; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr_3__Control1140095; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr_4__Control1140096; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr_5__Control1140097; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr_6__Control1140098; BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr_7__Control1140099; BuyFromAddr[7])
                    {
                    }
                    column(BuyFromAddr_8__Control1140100; BuyFromAddr[8])
                    {
                    }
                    column(CompanyInfo_Address___________CompanyInfo__Post_Code__________CompanyInfo_City_______Germany__Control1140101; CompanyInfo.Address + ' ╠ ' + CompanyInfo."Post Code" + ' ' + CompanyInfo.City + ' ╠ Germany')
                    {
                    }
                    column(CompanyInfo_Name_Control1140102; CompanyInfo.Name)
                    {
                    }
                    column(CompanyInfo__Picture_1__Control1140103; CompanyInfo."Picture 1")
                    {
                    }
                    column(FaxNr_Control1140107; FaxNr)
                    {
                    }
                    column(Schiffstext_Control1140108; Schiffstext)
                    {
                    }
                    column(Kontaktname_Control1140111; Kontaktname)
                    {
                    }
                    column(Vendor__Fax_No___Control1140112; Vendor."Fax No.")
                    {
                    }
                    column(PurchaserText2_Control1140113; PurchaserText2)
                    {
                    }
                    column(Resource_Name___Durchwahl2_Control1140114; Resource.Name)
                    {
                    }
                    column("Purchase_Header__FIELDCAPTION__Betriebsstätte_Rotterdam__"; "Purchase Header".FieldCaption("Betriebsstätte Rotterdam"))
                    {
                    }
                    column(VATNoText_Control1140053; VATNoText)
                    {
                    }
                    column(CompanyInfo__VAT_Registration_No___Control1140105; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(CompanyInfo__Registration_No___Control1140119; CompanyInfo."Registration No.")
                    {
                    }
                    column(BuyFromAddr_6__Control1140026; BuyFromAddr[6])
                    {
                    }
                    column(BuyFromAddr_5__Control1140027; BuyFromAddr[5])
                    {
                    }
                    column(BuyFromAddr_4__Control1140028; BuyFromAddr[4])
                    {
                    }
                    column(BuyFromAddr_3__Control1140029; BuyFromAddr[3])
                    {
                    }
                    column(BuyFromAddr_2__Control1140030; BuyFromAddr[2])
                    {
                    }
                    column(BuyFromAddr_1__Control1140031; BuyFromAddr[1])
                    {
                    }
                    column(FORMAT__Purchase_Header___Document_Date__0_4__Control1140033; Format("Purchase Header"."Document Date", 0, 4))
                    {
                    }
                    column(CurrReport_PAGENO; CurrReport.PageNo)
                    {
                    }
                    column(STRSUBSTNO_Text004_CopyText__________Purchase_Header___Job_No____________Purchase_Header___No___Control1140046; StrSubstNo(Text004, CopyText) + ' ' + "Purchase Header"."Job No." + '/' + "Purchase Header"."No.")
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
                    column(REPARATUR_WERFTCaption; REPARATUR_WERFTCaptionLbl)
                    {
                    }
                    column(CompanyInfo__Phone_No__Caption; CompanyInfo__Phone_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Fax_No__Caption; CompanyInfo__Fax_No__CaptionLbl)
                    {
                    }
                    column(CompanyInfo__E_Mail_Caption; CompanyInfo__E_Mail_CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Home_Page_Caption; CompanyInfo__Home_Page_CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Registration_No__Caption; CompanyInfo__Registration_No__CaptionLbl)
                    {
                    }
                    column(FORMAT__Purchase_Header___Document_Date__0_4_Caption; FORMAT__Purchase_Header___Document_Date__0_4_CaptionLbl)
                    {
                    }
                    column(KontaktnameCaption; KontaktnameCaptionLbl)
                    {
                    }
                    column(Ansprache; AnspracheLbl)
                    {
                    }
                    column(Ansprache2; AnspracheLbl2)
                    {
                    }
                    column(CompanyInfo__Phone_No___Control1140076Caption; CompanyInfo__Phone_No___Control1140076CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Fax_No___Control1140079Caption; CompanyInfo__Fax_No___Control1140079CaptionLbl)
                    {
                    }
                    column(CompanyInfo__E_Mail__Control1140083Caption; CompanyInfo__E_Mail__Control1140083CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Home_Page__Control1140085Caption; CompanyInfo__Home_Page__Control1140085CaptionLbl)
                    {
                    }
                    column(FORMAT__Purchase_Header___Document_Date__0_4__Control1140086Caption; FORMAT__Purchase_Header___Document_Date__0_4__Control1140086CaptionLbl)
                    {
                    }
                    column(Kontaktname_Control1140111Caption; Kontaktname_Control1140111CaptionLbl)
                    {
                    }
                    column(CompanyInfo__Registration_No___Control1140119Caption; CompanyInfo__Registration_No___Control1140119CaptionLbl)
                    {
                    }
                    column(FORMAT__Purchase_Header___Document_Date__0_4__Control1140033Caption; FORMAT__Purchase_Header___Document_Date__0_4__Control1140033CaptionLbl)
                    {
                    }
                    column(SeiteCaption; SeiteCaptionLbl)
                    {
                    }
                    column(Die_Gesellschaft_ist_eine_Kommanditgesellschaft_Caption; Die_Gesellschaft_ist_eine_Kommanditgesellschaft_CaptionLbl)
                    {
                    }
                    column(Registergericht_Oldenburg_HRA_200812Caption; Registergericht_Oldenburg_HRA_200812CaptionLbl)
                    {
                    }
                    column(Pers__haftende_Gesellschafterin_Caption; Pers__haftende_Gesellschafterin_CaptionLbl)
                    {
                    }
                    column(Dassler_Beteiligungs_GmbHCaption; Dassler_Beteiligungs_GmbHCaptionLbl)
                    {
                    }
                    column(Registergericht_Oldenburg_HRB_130445Caption; Registergericht_Oldenburg_HRB_130445CaptionLbl)
                    {
                    }
                    column(Bankverbindungen_Caption; Bankverbindungen_CaptionLbl)
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
                        column(PurchLine__Line_Amount_; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(Purchase_Line__Description; "Purchase Line".Description)
                        {
                        }
                        column(Purchase_Line__Type; Format("Purchase Line".Type, 0, 2))
                        {
                        }
                        column(Purchase_Line___Line_No__; "Purchase Line"."Line No.")
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
                        column(KredArtikel_Caption; KredArtikel_Caption)
                        {
                        }
                        column(Request_Date_; Format(PurchLine."Requested Receipt Date", 0, 4))
                        {
                        }
                        column(Purchase_Line___Description_2_; "Purchase Line"."Description 2")
                        {
                        }
                        column(Purchase_Line___Vendor_Item_No__; "Purchase Line"."Vendor Item No.")
                        {
                        }
                        column(PurchLine__Line_Amount__Control77; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Inv__Discount_Amount_; -PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Line"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Line_Amount__Control109; PurchLine."Line Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount_; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmountLine_VATAmountText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount____VATAmount; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount" + VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(PurchLine__Line_Amount__PurchLine__Inv__Discount_Amount__Control147; PurchLine."Line Amount" - PurchLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmountLine_VATAmountText_Control1140047; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText_Control1140048; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText_Control1140049; TotalInclVATText)
                        {
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmount_Control1140051; VATAmount)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Purchase Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(STRSUBSTNO_Text011_AllGemein_; StrSubstNo(Text011, AllGemein))
                        {
                        }
                        column(BITTE_BEACHTEN_____BITTE_BEACHTEN____Caption; BITTE_BEACHTEN_____BITTE_BEACHTEN____CaptionLbl)
                        {
                        }
                        column(Steuerfreie_innergemeinschaftliche_Lieferung_nach_Paragraph_6a_UStGCaption; Steuerfreie_innergemeinschaftliche_Lieferung_nach_Paragraph_6a_UStGCaptionLbl)
                        {
                        }
                        column(Ware_wird_in_die_Niederlande_verbrachtCaption; Ware_wird_in_die_Niederlande_verbrachtCaptionLbl)
                        {
                        }
                        column("Bitte_vermerken_Sie_unbedingt_in_der_Rechnungsanschrift___Betriebsstätte_Rotterdam__Caption"; Bitte_vermerken_Sie_unbedingt_in_der_Rechnungsanschrift___Betriebsstätte_Rotterdam__CaptionLbl)
                        {
                        }
                        column("sowie_in_der_Rechnung_unsere_niederländische_USt_Identnr__NL823384573B01Caption"; sowie_in_der_Rechnung_unsere_niederländische_USt_Identnr__NL823384573B01CaptionLbl)
                        {
                        }
                        column("Rechnungen_ohne_diese_Angaben_können_nicht_akzeptiert_werdenCaption"; Rechnungen_ohne_diese_Angaben_können_nicht_akzeptiert_werdenCaptionLbl)
                        {
                        }
                        column(Purchase_Line___Vendor_Item_No__Caption; Purchase_Line___Vendor_Item_No__CaptionLbl)
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
                        column(Benoetigt_Caption; Benoetigt_CaptionLbl)
                        {
                        }
                        column("ÜbertragCaption"; ÜbertragCaptionLbl)
                        {
                        }
                        column(EHCaption; EHCaptionLbl)
                        {
                        }
                        column(MengeCaption; MengeCaptionLbl)
                        {
                        }
                        column(BeschreibungCaption; BeschreibungCaptionLbl)
                        {
                        }
                        column(Nr_Caption; Nr_CaptionLbl)
                        {
                        }
                        column(Pos_Caption_Control1140044; Pos_Caption_Control1140044Lbl)
                        {
                        }
                        column("ÜbertragCaption_Control76"; ÜbertragCaption_Control76Lbl)
                        {
                        }
                        column(PurchLine__Inv__Discount_Amount_Caption; PurchLine__Inv__Discount_Amount_CaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(RoundLoop_Number; Number)
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
                            /*
                            CLEAR(JobLineBudget);
                            IF JobLineBudget.GET("Purchase Line"."Job No.","Purchase Line"."Job Line Unique No.") THEN BEGIN
                              IF JobLineBudget.Baugruppe = '' THEN
                                IF JobLineBudget.GET("Purchase Line"."Job No.",JobLineBudget."Node No.") THEN;
                            END;
                            */

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
                            SetRange(Number, 1, PurchLine.Count);
                            CurrReport.CreateTotals(PurchLine."Line Amount", PurchLine."Inv. Discount Amount");
                            "MwSt%" := 0;
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(ReportForNavId_6558; 6558)
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

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);

                            VALVATBaseLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                               "Purchase Header"."Posting Date", "Purchase Header"."Currency Code",
                                               VATAmountLine."VAT Base", "Purchase Header"."Currency Factor"));
                            VALVATAmountLCY := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(
                                                 "Purchase Header"."Posting Date", "Purchase Header"."Currency Code",
                                                 VATAmountLine."VAT Amount", "Purchase Header"."Currency Factor"));
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break;

                            if (not GLSetup."Print VAT specification in LCY") or
                               ("Purchase Header"."Currency Code" = '') or
                               (VATAmountLine.GetTotalVATAmount = 0) then
                                CurrReport.Break;

                            SetRange(Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(VALVATBaseLCY, VALVATAmountLCY);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text007 + Text008
                            else
                                VALSpecLCYHeader := Text007 + Format(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Purchase Header"."Posting Date", "Purchase Header"."Currency Code", 1);
                            VALExchRate := StrSubstNo(Text009, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));
                        column(ReportForNavId_3476; 3476)
                        {
                        }
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));
                        column(ReportForNavId_3363; 3363)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break;

                            if "Purchase Header"."Buy-from Vendor No." = "Purchase Header"."Pay-to Vendor No." then
                                CurrReport.Break;
                        end;
                    }
                    dataitem(Total3; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));
                        column(ReportForNavId_8272; 8272)
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
                        column(Total3_Number; Number)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if ("Purchase Header"."Sell-to Customer No." = '') and (ShipToAddr[1] = '') then
                                CurrReport.Break;
                        end;
                    }
                    dataitem(PrepmtLoop; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = filter(1 ..));
                        column(ReportForNavId_1849; 1849)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not PrepmtInvBuf.Find('-') then
                                    CurrReport.Break;
                            end else
                                if PrepmtInvBuf.Next = 0 then
                                    CurrReport.Break;

                            if "Purchase Header"."Prices Including VAT" then
                                PrepmtLineAmount := PrepmtInvBuf."Amount Incl. VAT"
                            else
                                PrepmtLineAmount := PrepmtInvBuf.Amount;
                        end;

                        trigger OnPreDataItem()
                        begin
                            CurrReport.CreateTotals(
                              PrepmtInvBuf.Amount, PrepmtInvBuf."Amount Incl. VAT",
                              PrepmtVATAmountLine."Line Amount", PrepmtVATAmountLine."VAT Base",
                              PrepmtVATAmountLine."VAT Amount",
                              PrepmtLineAmount);
                        end;
                    }
                    dataitem(PrepmtVATCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        column(ReportForNavId_3388; 3388)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            PrepmtVATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            SetRange(Number, 1, PrepmtVATAmountLine.Count);
                        end;
                    }
                    dataitem(PrepmtTotal; "Integer")
                    {
                        DataItemTableView = sorting(Number) where(Number = const(1));
                        column(ReportForNavId_7808; 7808)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if not PrepmtInvBuf.Find('-') then
                                CurrReport.Break;
                        end;
                    }
                    dataitem(Gruss; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        MaxIteration = 1;
                        column(ReportForNavId_5216; 5216)
                        {
                        }
                        column(xyz; SalesPurchPerson2."Job Title" + ' ' + SalesPurchPerson2.Name)
                        {
                        }
                        column(TURBO_TECHNIK_; 'TURBO-TECHNIK')
                        {
                        }
                        column(GmbH___Co__KG_; 'GmbH & Co. KG')
                        {
                        }
                        column(Gruss_Number; Number)
                        {
                        }

                        trigger OnPreDataItem()
                        begin

                            if ("Purchase Header"."Unterschriftscode 2" <> '') or (not Unterschrift) then
                                CurrReport.Break;
                        end;
                    }
                    dataitem(Gruss2; "Integer")
                    {
                        DataItemTableView = sorting(Number);
                        MaxIteration = 1;
                        column(ReportForNavId_1679; 1679)
                        {
                        }
                        column(SalesPurchPerson2__Job_Title__________SalesPurchPerson2_Name_Control1140054; SalesPurchPerson2."Job Title" + ' ' + SalesPurchPerson2.Name)
                        {
                        }
                        column(TURBO_TECHNIK__Control1140058; 'TURBO-TECHNIK')
                        {
                        }
                        column(xyz2; SalesPurchPerson3."Job Title" + ' ' + SalesPurchPerson3.Name)
                        {
                        }
                        column(GmbH___Co__KG__Control1000000001; 'GmbH & Co. KG')
                        {
                        }
                        column(GmbH___Co__KG__Control1000000002; 'GmbH & Co. KG')
                        {
                        }
                        column(TURBO_TECHNIK__Control1000000004; 'TURBO-TECHNIK')
                        {
                        }
                        column(Gruss2_Number; Number)
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if ("Purchase Header"."Unterschriftscode 2" = '') or (not Unterschrift) then
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
                end;
            }

            trigger OnAfterGetRecord()
            var
                LandCode: Code[10];
                l_Contact: Record Contact;
            begin
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                CurrReport.Language := Language.GetLanguageIdOrDefault('ENU');

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
                        CompanyInfo."Phone No." := SalesPurchPerson."Phone No.";
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
                            Schiffstext := 'Objekt: ' + Schiff.Description;
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
                        //  PersonInCharge := Ressource.Name;
                        //  Caption_PersonInCharge := Text_PersonInCharge;
                        if Resource.Durchwahlnummer <> '' then
                            CompanyInfo."Phone No." := CopyStr(CompanyInfo."Phone No.", 1,
                            (StrLen(CompanyInfo."Phone No.") - 1)) + Resource.Durchwahlnummer;
                    end
                    else begin
                        //    Caption_PersonInCharge := '';
                    end;
                end;

                y := 1;

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

                /*
                IF Job."We Quote for" <> '' THEN BEGIN
                  //Caption_WeQuoteFor := 'We quote for';
                  //varWeQuoteFor := 'txt5';
                  KopfCaption[y] := 'We quote for';
                  Kopfdaten[y] := Job."We Quote for";
                  y += 1;
                END;
                */
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
                    field(ArchiveDocument2; Fax)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Fax-No.';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field("Lieferadresse drucken"; "Lieferadresse drucken")
                    {
                        ApplicationArea = Basic;
                    }
                    field(ArchiveDocument3; Unterschrift)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Unterschrift';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field(ArchiveDocument4; Geschäftsbed)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Geschäftsbedigungen anhängig';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field(ArchiveDocument5; AnzeigeSchiff)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Anzeige Schiff';
                    }
                    field("Wordübergabe"; Wordübergabe)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print to Word';
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
            ArchiveDocument := ArchiveManagement.PurchaseDocArchiveGranule;
            LogInteraction := SegManagement.FindInteractTmplCode(13) <> '';

            ArchiveDocumentEnable := ArchiveDocument;
            LogInteractionEnable := LogInteraction;

            Unterschrift := true;
            Fax := true;
            Geschäftsbed := false;
            AnzeigeSchiff := false;
            Wordübergabe := false;
        end;
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
        Text004: label 'Enquiry %1';
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
        Language: codeunit Language;
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
        Kopfdaten: array[20] of Text[50];
        KopfCaption: array[20] of Text[50];
        KTOText: Text[20];
        Text50003: label ' eintreffend';
        "Lieferadresse drucken": Boolean;
        PricesInclVATtxt: Text[30];
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        REPARATUR_WERFTCaptionLbl: label 'REPAIRYARD';
        CompanyInfo__Phone_No__CaptionLbl: label 'Telephone';
        CompanyInfo__Fax_No__CaptionLbl: label 'Telefax';
        CompanyInfo__E_Mail_CaptionLbl: label 'E-Mail';
        CompanyInfo__Home_Page_CaptionLbl: label 'Internet';
        CompanyInfo__Registration_No__CaptionLbl: label 'Registration No.';
        FORMAT__Purchase_Header___Document_Date__0_4_CaptionLbl: label 'Date';
        KontaktnameCaptionLbl: label 'Your Reference';
        AnspracheLbl: label 'Dear Sirs,';
        AnspracheLbl2: label 'please offer for the below specified spare parts.';
        CompanyInfo__Phone_No___Control1140076CaptionLbl: label 'Telephone';
        CompanyInfo__Fax_No___Control1140079CaptionLbl: label 'Telefax';
        CompanyInfo__E_Mail__Control1140083CaptionLbl: label 'E-Mail';
        CompanyInfo__Home_Page__Control1140085CaptionLbl: label 'Internet';
        FORMAT__Purchase_Header___Document_Date__0_4__Control1140086CaptionLbl: label 'Date';
        Kontaktname_Control1140111CaptionLbl: label 'Your Reference';
        CompanyInfo__Registration_No___Control1140119CaptionLbl: label 'Registration No.';
        FORMAT__Purchase_Header___Document_Date__0_4__Control1140033CaptionLbl: label 'Date';
        SeiteCaptionLbl: label 'Page';
        Die_Gesellschaft_ist_eine_Kommanditgesellschaft_CaptionLbl: label 'This company is a limited partnership,';
        Registergericht_Oldenburg_HRA_200812CaptionLbl: label 'Register Court Oldenburg HRA 200812';
        Pers__haftende_Gesellschafterin_CaptionLbl: label 'General Partner:';
        Dassler_Beteiligungs_GmbHCaptionLbl: label 'Turbo-Technik Beteiligungs GmbH';
        Registergericht_Oldenburg_HRB_130445CaptionLbl: label 'Register Court Oldenburg HRB 208134';
        Bankverbindungen_CaptionLbl: label 'Bank details:';
        KopfdimensionenCaptionLbl: label 'Header Dimensions';
        BITTE_BEACHTEN_____BITTE_BEACHTEN____CaptionLbl: label 'Description';
        Steuerfreie_innergemeinschaftliche_Lieferung_nach_Paragraph_6a_UStGCaptionLbl: label 'Description';
        Ware_wird_in_die_Niederlande_verbrachtCaptionLbl: label 'Description';
        "Bitte_vermerken_Sie_unbedingt_in_der_Rechnungsanschrift___Betriebsstätte_Rotterdam__CaptionLbl": label 'Description';
        "sowie_in_der_Rechnung_unsere_niederländische_USt_Identnr__NL823384573B01CaptionLbl": label 'Description';
        "Rechnungen_ohne_diese_Angaben_können_nicht_akzeptiert_werdenCaptionLbl": label 'Description';
        Purchase_Line___Vendor_Item_No__CaptionLbl: label 'Your Item No.';
        Purchase_Line__QuantityCaptionLbl: label 'Qty.';
        Purchase_Line___Unit_of_Measure_CaptionLbl: label 'Unit';
        Pos_CaptionLbl: label 'Item';
        Benoetigt_CaptionLbl: label 'Needed to';
        "ÜbertragCaptionLbl": label 'Continued';
        EHCaptionLbl: label 'Unit';
        MengeCaptionLbl: label 'Qty.';
        BeschreibungCaptionLbl: label 'Description';
        Nr_CaptionLbl: label 'Your Item No.';
        Pos_Caption_Control1140044Lbl: label 'Item';
        "ÜbertragCaption_Control76Lbl": label 'Continued';
        PurchLine__Inv__Discount_Amount_CaptionLbl: label 'Inv. Discount Amount';
        SubtotalCaptionLbl: label 'Subtotal';
        Ship_to_AddressCaptionLbl: label 'Ship-to Address';
        y: Integer;
        Multi: Record "Multi Table";
        KredArtikel_Caption: label 'P/N';
        PersonCharge_Lbl: label 'Person in charge';


    procedure "AnzeigeSchiffÜbergeben"(P_AnzeigeSchiff: Boolean)
    begin
        AnzeigeSchiff := P_AnzeigeSchiff;
    end;
}


#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50004 "MwSt Anpassung"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Sales Line";"Sales Line")
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "VAT Prod. Posting Group" = 'VAT19' then begin
                  "VAT Prod. Posting Group" := 'VAT16';

                  VATPostingSetup.Get("VAT Bus. Posting Group","VAT Prod. Posting Group");
                  "VAT Difference" := 0;

                  //GetSalesHeader;
                  "VAT %" := VATPostingSetup."VAT %";
                  "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
                  "VAT Identifier" := VATPostingSetup."VAT Identifier";
                  "VAT Clause Code" := VATPostingSetup."VAT Clause Code";
                  case "VAT Calculation Type" of
                    "vat calculation type"::"Reverse Charge VAT",
                    "vat calculation type"::"Sales Tax":
                      "VAT %" := 0;
                    "vat calculation type"::"Full VAT":
                      begin
                        TestField(Type,Type::"G/L Account");
                        TestField("No.",VATPostingSetup.GetSalesAccount(false));
                      end;
                  end;
                  Modify;
                end;
                if "VAT Prod. Posting Group" = 'VAT7' then begin
                  "VAT Prod. Posting Group" := 'VAT5';

                  VATPostingSetup.Get("VAT Bus. Posting Group","VAT Prod. Posting Group");
                  "VAT Difference" := 0;

                  //GetSalesHeader;
                  "VAT %" := VATPostingSetup."VAT %";
                  "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
                  "VAT Identifier" := VATPostingSetup."VAT Identifier";
                  "VAT Clause Code" := VATPostingSetup."VAT Clause Code";
                  case "VAT Calculation Type" of
                    "vat calculation type"::"Reverse Charge VAT",
                    "vat calculation type"::"Sales Tax":
                      "VAT %" := 0;
                    "vat calculation type"::"Full VAT":
                      begin
                        TestField(Type,Type::"G/L Account");
                        TestField("No.",VATPostingSetup.GetSalesAccount(false));
                      end;
                  end;
                  Modify;
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Document Type","Sales Line"."document type"::Order);
                //SETRANGE("Document No.",'20224644');
                SetFilter("Outstanding Qty. (Base)",'<>%1',0);
            end;
        }
        dataitem("Purchase Line";"Purchase Line")
        {
            column(ReportForNavId_1000000001; 1000000001)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "VAT Prod. Posting Group" = 'VAT19' then begin
                  "VAT Prod. Posting Group" := 'VAT16';

                  VATPostingSetup.Get("VAT Bus. Posting Group","VAT Prod. Posting Group");
                  "VAT Difference" := 0;
                  "VAT %" := VATPostingSetup."VAT %";
                  "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
                  "VAT Identifier" := VATPostingSetup."VAT Identifier";
                  case "VAT Calculation Type" of
                    "vat calculation type"::"Reverse Charge VAT",
                    "vat calculation type"::"Sales Tax":
                      "VAT %" := 0;
                    "vat calculation type"::"Full VAT":
                      begin
                        TestField(Type,Type::"G/L Account");
                        TestField("No.",VATPostingSetup.GetPurchAccount(false));
                      end;
                  end;

                  Modify;
                end;
                if "VAT Prod. Posting Group" = 'VAT7' then begin
                  "VAT Prod. Posting Group" := 'VAT5';

                  VATPostingSetup.Get("VAT Bus. Posting Group","VAT Prod. Posting Group");
                  "VAT Difference" := 0;
                  "VAT %" := VATPostingSetup."VAT %";
                  "VAT Calculation Type" := VATPostingSetup."VAT Calculation Type";
                  "VAT Identifier" := VATPostingSetup."VAT Identifier";
                  case "VAT Calculation Type" of
                    "vat calculation type"::"Reverse Charge VAT",
                    "vat calculation type"::"Sales Tax":
                      "VAT %" := 0;
                    "vat calculation type"::"Full VAT":
                      begin
                        TestField(Type,Type::"G/L Account");
                        TestField("No.",VATPostingSetup.GetPurchAccount(false));
                      end;
                  end;

                  Modify;
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Document Type","document type"::Order);
                //SETRANGE("Document No.",'20612071');
                SetFilter("Outstanding Qty. (Base)",'<>%1',0);
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

    trigger OnPostReport()
    begin
        Message('Fertig');
    end;

    var
        VATPostingSetup: Record "VAT Posting Setup";
}


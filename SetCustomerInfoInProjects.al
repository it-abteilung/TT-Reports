Report 50150 "Set Customer Info In Projects"
{
    Caption = 'Debitordaten in Projekten';
    ProcessingOnly = true;
    UsageCategory = Tasks;
    ApplicationArea = All;

    dataset
    {
        dataitem(Job; Job)
        {
            trigger OnAfterGetRecord()
            begin
                if "Sell-to Customer No." = '' then begin
                    "Sell-to Customer No." := "Bill-to Customer No.";
                    "Sell-to Customer Name" := "Bill-to Name";
                    "Sell-to Customer Name 2" := "Bill-to Name 2";
                    "Sell-to Address" := "Bill-to Address";
                    "Sell-to Address 2" := "Bill-to Address 2";
                    "Sell-to City" := "Bill-to City";
                    "Sell-to Post Code" := "Bill-to Post Code";
                    "Sell-to Country/Region Code" := "Bill-to Country/Region Code";
                    "Sell-to Contact" := "Bill-to Contact";
                    "Sell-to Contact No." := "Bill-to Contact No.";
                    Modify(false);
                end;
            end;
        }
    }
}
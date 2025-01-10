reportextension 50000 JobRegister extends "Job Register"
{

    RDLCLayout = './Layouts/JobRegister.rdlc';

    dataset
    {
        addlast("Job Ledger Entry")
        {
            dataitem("Ext"; "Job Ledger Entry")
            {
                DataItemLinkReference = "Job Ledger Entry";
                DataItemLink = "Document No." = Field("Document No."), "No." = field("No.");

                column(TotalPrice; "Total Price") { }
                column(Total_Price__LCY_; "Total Price (LCY)") { }
                column(Total_Cost; "Total Cost") { }
                column(Total_Cost__LCY_; "Total Cost (LCY)") { }
                column(Direct_Unit_Cost__LCY_; "Direct Unit Cost (LCY)") { }
                column(Description; Description) { }
                column(Description_2; "Description 2") { }
                column(Description_3; "Description 3") { }

                trigger OnAfterGetRecord()
                var
                    Item: Record Item;
                begin
                    Description := '';
                    "Description 2" := '';
                    "Description 3" := '';
                    if Item.Get("Job Ledger Entry"."No.") then begin
                        Description := Item.Description;
                        "Description 2" := Item."Description 2";
                        "Description 3" := Item."Description 3";
                    end;
                end;
                // dataitem(Item; Item)
                // {
                //     DataItemLinkReference = "Job Ledger Entry";
                //     DataItemLink = "No." = Field("No.");

                //     column(Description; Description) { }
                //     column(Description_2; "Description 2") { }
                //     column(Description_3; "Description 3") { }
                //     column(Unit_Cost; "Unit Cost") { }
                //     column(LineValue; LineValue) { }

                // }
            }
        }
    }
    var
        LineValue: Decimal;
        Description: Text;
        "Description 2": Text;
        "Description 3": Text;
}
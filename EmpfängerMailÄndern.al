report 59555 SetMailAddress
{
    UsageCategory = Administration;
    ApplicationArea = all;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            DataItemTableView = where("Document Type" = const(order),
                                        "No." = const('027972'));

            dataitem("Purchase Line"; "Purchase Line")
            {

                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemLinkReference = "Purchase Header";

                trigger OnAfterGetRecord()
                begin
                    Delete(false);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                PurchHeader.get("Purchase Header"."Document Type", "Purchase Header"."No.");
            end;
        }
    }
    trigger OnPostReport()
    begin
        PurchHeader.Delete(false);
    end;

    var
        PurchHeader: Record "Purchase Header";
}
report 50155 "Set Leistungsart"
{
    ProcessingOnly = true;
    Caption = 'Leistungsart setzen (Echtstart)';
    UsageCategory = Administration;
    ApplicationArea = All;
    Permissions = tabledata "Purch. Inv. Line" = RIMD, tabledata "Purch. Cr. Memo Line" = RIMD;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            dataitem("Purch. Inv. Line"; "Purch. Inv. Line")
            {
                DataItemLink = "Document No." = field("No.");

                trigger OnAfterGetRecord()
                begin
                    if (Leistungsart = Leistungsart::" ") or ("Job No." = '') then begin
                        Leistungsart := "Purch. Inv. Header".Leistungsart;
                        Leistungszeitraum := "Purch. Inv. Header".Leistungszeitraum;
                        "Job No." := "Purch. Inv. Header"."Job No.";
                        Modify();
                    end;
                end;
            }
        }
        dataitem("Purch. Cr. Memo Hdr."; "Purch. Cr. Memo Hdr.")
        {
            dataitem("Purch. Cr. Memo Line"; "Purch. Cr. Memo Line")
            {
                DataItemLink = "Document No." = field("No.");

                trigger OnAfterGetRecord()
                begin
                    if (Leistungsart = Leistungsart::" ") or ("Job No." = '') then begin
                        Leistungsart := "Purch. Cr. Memo Hdr.".Leistungsart;
                        Leistungszeitraum := "Purch. Cr. Memo Hdr.".Leistungszeitraum;
                        "Job No." := "Purch. Cr. Memo Hdr."."Job No.";
                        Modify();
                    end;
                end;
            }
        }
    }
}
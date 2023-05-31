#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50049 "Einkaufszeile Barcode"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Einkaufszeile Barcode.rdlc';

    dataset
    {
        dataitem("Purchase Line";"Purchase Line")
        {
            DataItemTableView = sorting("Document Type","Document No.","Line No.");
            column(ReportForNavId_6547; 6547)
            {
            }
            column(Purchase_Line_Document_Type;"Document Type")
            {
            }
            column(Purchase_Line_Document_No_;"Document No.")
            {
            }
            column(Purchase_Line_Line_No_;"Line No.")
            {
            }
            dataitem("Integer";"Integer")
            {
                DataItemTableView = sorting(Number);
                column(ReportForNavId_5444; 5444)
                {
                }
                dataitem("Purchase Line_Druck";"Purchase Line")
                {
                    DataItemLink = "Document Type"=field("Document Type"),"Document No."=field("Document No."),"Line No."=field("Line No.");
                    DataItemLinkReference = "Purchase Line";
                    DataItemTableView = sorting("Document Type","Document No.","Line No.");
                    column(ReportForNavId_1463; 1463)
                    {
                    }
                    column(Purchase_Line___Job_No__;"Purchase Line"."Job No.")
                    {
                    }
                    column(Auftragsnr___;'Auftragsnr.:')
                    {
                    }
                    column(JobRec_Objektname;JobRec.Objektname)
                    {
                    }
                    column(Objekt__;'Objekt:')
                    {
                    }
                    column(Purchase_Line__Baugruppe____________Purchase_Line__Pos;"Purchase Line".Baugruppe + ' / ' + "Purchase Line".Pos)
                    {
                    }
                    column(Bgr____Pos___;'Bgr. / Pos.:')
                    {
                    }
                    column(Purchase_Line__Description;"Purchase Line".Description)
                    {
                    }
                    column(Beschreibung__;'Beschreibung:')
                    {
                    }
                    column(Purchase_Line___Description_2_;"Purchase Line"."Description 2")
                    {
                    }
                    column(ItemRec__Description_3_;ItemRec."Description 3")
                    {
                    }
                    column(Purchase_Line_Druck_Document_Type;"Document Type")
                    {
                    }
                    column(Purchase_Line_Druck_Document_No_;"Document No.")
                    {
                    }
                    column(Purchase_Line_Druck_Line_No_;"Line No.")
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        Barcode := '*' + "Purchase Line"."Job No." + '#' + "Purchase Line"."No." + '*';
                        BarcodeText := 'Auftragsnr.: ' + "Purchase Line"."Job No.";
                        BarcodeText2 := 'Artikelnr.: ' + "Purchase Line"."No.";

                        if not ItemRec.Get("No.") then
                          ItemRec.Init;
                        if not JobRec.Get("Job No.") then
                          JobRec.Init;
                        //JobRec.calcfields(Objektname);
                    end;
                }

                trigger OnPreDataItem()
                begin
                    SetRange(Number,1,AnzEtiketten);
                end;
            }

            trigger OnPreDataItem()
            begin
                SetRange("Document Type","document type"::Order);
                SetRange("Document No.",Belegnr);
                SetRange("Line No.",Zeilennr);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(AnzEtiketten;AnzEtiketten)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Anzahl Etiketten';
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

    trigger OnInitReport()
    begin
        //AnzEtiketten := 1;
    end;

    var
        InventorySetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Barcode: Text[30];
        BarcodeText: Text[30];
        BarcodeText2: Text[30];
        Seriennr: Code[20];
        Dummy: Code[20];
        AnzEtiketten: Integer;
        ItemRec: Record Item;
        JobRec: Record Job;
        Belegnr: Code[20];
        Zeilennr: Integer;


    procedure "WerteÜbergeben"(PBelegnr: Code[20];PZeilennr: Integer;PAnzEtiketten: Integer)
    begin
        Belegnr := PBelegnr;
        Zeilennr := PZeilennr;
        AnzEtiketten := PAnzEtiketten;
    end;
}


#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50054 CreateItemDummys
{
    Caption = 'Create dummy items';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Integer";"Integer")
        {
            DataItemTableView = sorting(Number) order(ascending);
            column(ReportForNavId_100000000; 100000000)
            {
            }

            trigger OnAfterGetRecord()
            var
                item: Record Item;
            begin
                Clear(item);

                item."No." := '';
                item."No. Series" := NoSeries;
                NoSeriesManagement.SetSeries(item."No.");
                item.Insert(true);

                item.Description := 'Dummy';
                item."Gen. Prod. Posting Group" := ProdPostingGroup;
                item."VAT Prod. Posting Group" := VatProdPostingGroup;
                item."Base Unit of Measure" := BaseUnit;
                item."Purch. Unit of Measure" := PurchaseBaseUnit;
                item."Sales Unit of Measure" := SalesBaseUnit;
                item.Modify(true);

                counter += 1;
                Window.Update(1, item."No.");
                Window.Update(2, (counter * Factor) DIV 1);
            end;

            trigger OnPreDataItem()
            begin
                Integer.SetRange(Number,1,NumberOfItems);

                if Count > 0 then
                    Factor := 9999 / Count;
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
                    Caption = 'Optionen';
                    field(NumberOfItems;NumberOfItems)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Anzahl der Artikel';
                    }
                    field(NoSeries;NoSeries)
                    {
                        ApplicationArea = Basic;
                        CaptionClass = Item_g.FIELDCAPTION("No. Series");
                        Editable = false;

                        trigger OnAssistEdit()
                        var
                            oldNoSeries: Code[10];
                        begin
                            if NoSeriesManagement.SelectSeries(InventorySetup."Item Nos.",oldNoSeries,NoSeries) then;
                        end;
                    }
                    field(ProdPostingGroup;ProdPostingGroup)
                    {
                        ApplicationArea = Basic;
                        CaptionClass = Item_g.FIELDCAPTION("Gen. Prod. Posting Group");
                        TableRelation = "Gen. Product Posting Group";
                    }
                    field(VatProdPostingGroup;VatProdPostingGroup)
                    {
                        ApplicationArea = Basic;
                        CaptionClass = Item_g.FIELDCAPTION("VAT Prod. Posting Group");
                        TableRelation = "VAT Product Posting Group";
                    }
                    field(BaseUnit;BaseUnit)
                    {
                        ApplicationArea = Basic;
                        CaptionClass = Item_g.FIELDCAPTION("Base Unit of Measure");
                        TableRelation = "Unit of Measure";
                    }
                    field(SalesBaseUnit;SalesBaseUnit)
                    {
                        ApplicationArea = Basic;
                        CaptionClass = Item_g.FIELDCAPTION("Sales Unit of Measure");
                        TableRelation = "Unit of Measure";
                    }
                    field(PurchaseBaseUnit;PurchaseBaseUnit)
                    {
                        ApplicationArea = Basic;
                        CaptionClass = Item_g.FIELDCAPTION("Purch. Unit of Measure");
                        TableRelation = "Unit of Measure";
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
        InventorySetup.Get();
        InventorySetup.TestField("Item Nos.");
    end;

    trigger OnPostReport()
    begin
        Window.Close();
    end;

    trigger OnPreReport()
    var
        item: Record Item;
    begin
        if NumberOfItems < 1 then
          Error(ERR_NoOfLoops);

        if NoSeries = '' then
          Error(ERR_Field,item.FieldCaption("No. Series"));

        if ProdPostingGroup = '' then
          Error(ERR_Field,item.FieldCaption("Gen. Prod. Posting Group"));

        if VatProdPostingGroup = '' then
          Error(ERR_Field,item.FieldCaption("VAT Prod. Posting Group"));

        if BaseUnit = '' then
          Error(ERR_Field,item.FieldCaption("Base Unit of Measure"));

        if SalesBaseUnit = '' then
          Error(ERR_Field,item.FieldCaption("Sales Unit of Measure"));

        if PurchaseBaseUnit = '' then
          Error(ERR_Field,item.FieldCaption("Purch. Unit of Measure"));


        Window.Open('Artikel anlegen #1###### @2@@@@@@@@');
    end;

    var
        InventorySetup: Record "Inventory Setup";
        Item_g: Record Item;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        NumberOfItems: Integer;
        NoSeries: Code[10];
        ProdPostingGroup: Code[10];
        VatProdPostingGroup: Code[10];
        BaseUnit: Code[10];
        SalesBaseUnit: Code[10];
        PurchaseBaseUnit: Code[10];
        ERR_Field: label 'The value for %1 must contain a value.';
        ERR_NoOfLoops: label 'The number of items to be created must be greater than 1.';
        Window: Dialog;
        Factor: Decimal;
        counter: Decimal;
}


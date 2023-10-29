report 50073 "Package Tree List"
{
    DefaultLayout = RDLC;
    Caption = 'Verlgeich_Pakete_mit _Werkzeuganforderungen';
    RDLCLayout = './Layouts/Package_Tree_List.rdlc';

    dataset
    {
        dataitem("Info"; Integer)
        {
            DataItemTableView = SORTING(Number) where(Number = const(1));
            column(TmpCompanyInformation; TmpCompanyInformation.Picture)
            {
            }
            column(JobNo; JobNo)
            {
            }
            column(MainBin; MainBin)
            {
            }
            column(Frombin; FromBin)
            {
            }
            column(ToBin; ToBin)
            {
            }
            trigger OnPreDataItem()
            begin
                Integer.SetRange(Number, 1, 1);
            end;
        }

        dataitem("Integer"; "Integer")
        {
            DataItemTableView = SORTING(Number);

            column(EntryNo_PackageTreeTemp; PackageTreeTemp."Entry No.")
            {
            }
            column(Indentation_PackageTreeTemp; PackageTreeTemp.Indentation)
            {
            }
            column(ItemNo_PackageTreeTemp; PackageTreeTemp."Item No.")
            {
            }
            column(ItemDescription_PackageTreeTemp; PackageTreeTemp."Item Description")
            {
            }
            column(Bin_PackageTreeTemp; PackageTreeTemp.Bin)
            {
            }
            column(PostingDate_PackageTreeTemp; PackageTreeTemp."Posting Date")
            {
            }
            column(PackedQuantity_PackageTreeTemp; PackageTreeTemp."Packed Quantity")
            {
            }
            column(RequestedQuantity_PackageTreeTemp; PackageTreeTemp."Requested Quantity")
            {
            }
            column(DeltaQuantity_PackageTreeTemp; PackageTreeTemp."Delta Quantity")
            {
            }
            column(PackageList_PackageTreeTemp; PackageTreeTemp."Package List")
            {
            }
            column(OnToolRequest_PackageTreeTemp; PackageTreeTemp."On Tool Request")
            {
            }

            trigger OnPreDataItem()
            begin
                PackageTreeTemp.Reset();
                Integer.SetRange(Number, 1, PackageTreeTemp.Count());
            end;

            trigger OnAfterGetRecord()
            begin
                if Integer.Number = 1 then
                    PackageTreeTemp.Find('-')
                else
                    PackageTreeTemp.Next();

                PackageTreeTemp."Delta Quantity" := PackageTreeTemp."Packed Quantity" - PackageTreeTemp."Requested Quantity";

            end;
        }
    }
    requestpage
    {

        layout
        {
            area(Content)
            {
                group(General)
                {
                    Caption = 'Filter';
                    field(JobNo; JobNo)
                    {
                        ApplicationArea = all;
                        Caption = 'Projekt-Nr.';
                    }
                    field(BinFilter; BinFilter)
                    {
                        ApplicationArea = all;
                        Caption = 'Pakete';
                    }
                }
            }
        }

        actions
        {
        }

    }

    var
        PackageTreeTemp: Record "Package Tree Temp";
        StyleExprDelta: Text;
        DeltaQuantitiy: Decimal;
        WerkzeugKopf_G: Record Werkzeuganforderungskopf;
        WerkzeugZeile_G: Record Werkzeuganforderungzeile;
        BinFilter: Text;
        HideValues: Boolean;
        StyleExpr: Text;
        JobNo: Code[20];
        JobMap: List of [Dictionary of [Code[20], Integer]];
        TmpCompanyInformation: Record "Company Information";

        MainBin: Text;
        FromBin: Text;
        ToBin: Text;

    trigger OnPreReport()
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        Job: Record Job;
        Bin: Record Bin;
        EntryNoCounter: Integer;
        SaveEntryNoCounter: Integer;
        IndQty0: Integer;
        IndQty1: Integer;
        IndQty2: Integer;
        WerkzeugKopf_L: Record Werkzeuganforderungskopf;
        WerkzeugZeile_L: Record Werkzeuganforderungzeile;
        WarehouseEntry: Record "Warehouse Entry";

        ReqQty: Decimal;

        Item: Record Item;
        ItemDesc: Text;
        ItemKey: Code[20];
        ItemDict: Dictionary of [Code[20], Decimal];
        BinKey: Code[20];
        BinDict: Dictionary of [Code[20], Decimal];

        JobDict: Dictionary of [Code[20], Integer];
        JobKey: Code[20];
        TextBuilderList: TextBuilder;

        BinItemList: List of [Code[20]];

    begin
        EntryNoCounter := 0;

        // GET WerkzeugKopf
        WerkzeugKopf_L.Reset();
        if JobNo <> '' then begin
            WerkzeugKopf_L.SetRange("Projekt Nr", JobNo);
        end else begin
            FOREACH JobDict IN JobMap do
                foreach JobKey in JobDict.Keys() do
                    if WerkzeugKopf_L.Get(JobKey, JobDict.Get(JobKey)) then
                        WerkzeugKopf_L.Mark(true);
            WerkzeugKopf_L.MarkedOnly(true);
        end;
        // GET ~ END
        if WerkzeugKopf_L.FindSet() then begin
            // GET WerkzeugZeilen
            WerkzeugZeile_L.Reset();
            WerkzeugZeile_L.ClearMarks();
            repeat
                WerkzeugZeile_L.SetRange("Projekt Nr", WerkzeugKopf_L."Projekt Nr");
                WerkzeugZeile_L.SetRange("Lfd Nr", WerkzeugKopf_L."Lfd Nr");
                if WerkzeugZeile_L.FindSet() then begin
                    repeat
                        WerkzeugZeile_L.Mark(true);
                    until WerkzeugZeile_L.Next() = 0;
                end;
            until WerkzeugKopf_L.Next() = 0;
            WerkzeugZeile_L.SetRange("Projekt Nr");
            WerkzeugZeile_L.SetRange("Lfd Nr");
            WerkzeugZeile_L.MarkedOnly(true);
            WerkzeugZeile_L.SetCurrentKey("Beschreibung");
            WerkzeugZeile_L.SetAscending("Beschreibung", true);
            // GET ~ END
            if WerkzeugZeile_L.FindSet() then begin
                WerkzeugZeile_G.Copy(WerkzeugZeile_L);
                ItemDict := createDictEmpty();
                // FIND WerkzeugZeile Quantity
                repeat
                    if ItemDict.ContainsKey(WerkzeugZeile_L."Artikel Nr") then
                        ItemDict.Set(WerkzeugZeile_L."Artikel Nr", ItemDict.Get(WerkzeugZeile_L."Artikel Nr") + WerkzeugZeile_L.Menge)
                    else
                        ItemDict.Add(WerkzeugZeile_L."Artikel Nr", WerkzeugZeile_L.Menge);
                until WerkzeugZeile_L.Next() = 0;
                // FIND ~ END
                foreach ItemKey in ItemDict.Keys() do begin
                    EntryNoCounter += 1;
                    SaveEntryNoCounter := EntryNoCounter;

                    Item.Reset();
                    ItemDesc := '';
                    if Item.Get(ItemKey) then
                        ItemDesc := Item.Description;

                    PackageTreeTemp.Init();
                    PackageTreeTemp."Entry No." := EntryNoCounter;
                    PackageTreeTemp.Indentation := 0;
                    PackageTreeTemp."Item No." := ItemKey;
                    PackageTreeTemp."Item Description" := ItemDesc;
                    PackageTreeTemp."Requested Quantity" := ItemDict.Get(Itemkey);
                    PackageTreeTemp."On Tool Request" := true;
                    PackageTreeTemp.Insert(true);


                    // FIND Bin Quantity
                    WarehouseEntry.Reset();
                    WarehouseEntry.SetFilter("Bin Code", BinFilter);
                    WarehouseEntry.SetRange("Item No.", ItemKey);

                    ReqQty := 0;
                    TextBuilderList.Clear();
                    if WarehouseEntry.FindSet() then begin
                        BinDict := createDictEmpty();
                        repeat
                            if BinDict.ContainsKey(WarehouseEntry."Bin Code") then
                                BinDict.Set(WarehouseEntry."Bin Code", BinDict.Get(WarehouseEntry."Bin Code") + WarehouseEntry.Quantity)
                            else
                                BinDict.Add(WarehouseEntry."Bin Code", WarehouseEntry.Quantity)
                        until WarehouseEntry.Next() = 0;

                        foreach BinKey in BinDict.Keys() do begin
                            if BinDict.Get(BinKey) > 0 then begin

                                EntryNoCounter += 1;
                                PackageTreeTemp.Init();
                                PackageTreeTemp."Entry No." := EntryNoCounter;
                                PackageTreeTemp.Indentation := 1;
                                PackageTreeTemp."Item No." := ItemKey;
                                PackageTreeTemp."Item Description" := ItemDesc;
                                PackageTreeTemp."Packed Quantity" := BinDict.Get(BinKey);
                                PackageTreeTemp.Bin := BinKey;
                                PackageTreeTemp."On Tool Request" := true;
                                PackageTreeTemp.Insert(true);

                                ReqQty += BinDict.Get(BinKey);

                                if TextBuilderList.Length > 0 then
                                    TextBuilderList.Append(';');
                                TextBuilderList.Append(BinKey + ';' + Format(BinDict.Get(BinKey)));
                            end;
                        end;
                    end;

                    if PackageTreeTemp.Get(SaveEntryNoCounter) then begin
                        PackageTreeTemp."Packed Quantity" := ReqQty;
                        PackageTreeTemp."Package List" := TextBuilderList.ToText();
                        PackageTreeTemp.Modify();
                    end;
                end;

                WarehouseEntry.Reset();
                WarehouseEntry.SetFilter("Bin Code", BinFilter);
                WarehouseEntry.SetCurrentKey(Description);
                WarehouseEntry.SetAscending(Description, true);
                if WarehouseEntry.FindSet() then
                    repeat
                        if NOT BinItemList.Contains(WarehouseEntry."Item No.") then
                            BinItemList.Add(WarehouseEntry."Item No.");
                    until WarehouseEntry.Next() = 0;

                foreach ItemKey in BinItemList do begin
                    if NOT ItemDict.ContainsKey(ItemKey) then begin
                        EntryNoCounter += 1;
                        SaveEntryNoCounter := EntryNoCounter;
                        Item.Reset();
                        ItemDesc := '';
                        if Item.Get(ItemKey) then
                            ItemDesc := Item.Description;

                        PackageTreeTemp.Init();
                        PackageTreeTemp."Entry No." := EntryNoCounter;
                        PackageTreeTemp.Indentation := 0;
                        PackageTreeTemp."Item No." := ItemKey;
                        PackageTreeTemp."Item Description" := ItemDesc;
                        PackageTreeTemp."Requested Quantity" := 0;
                        PackageTreeTemp."On Tool Request" := false;
                        PackageTreeTemp.Insert(true);

                        WarehouseEntry.Reset();
                        WarehouseEntry.SetFilter("Bin Code", BinFilter);
                        WarehouseEntry.SetRange("Item No.", ItemKey);

                        ReqQty := 0;
                        TextBuilderList.Clear();
                        if WarehouseEntry.FindSet() then begin
                            BinDict := createDictEmpty();
                            repeat
                                if BinDict.ContainsKey(WarehouseEntry."Bin Code") then
                                    BinDict.Set(WarehouseEntry."Bin Code", BinDict.Get(WarehouseEntry."Bin Code") + WarehouseEntry.Quantity)
                                else
                                    BinDict.Add(WarehouseEntry."Bin Code", WarehouseEntry.Quantity)
                            until WarehouseEntry.Next() = 0;

                            foreach BinKey in BinDict.Keys() do begin
                                if BinDict.Get(BinKey) > 0 then begin

                                    EntryNoCounter += 1;
                                    PackageTreeTemp.Init();
                                    PackageTreeTemp."Entry No." := EntryNoCounter;
                                    PackageTreeTemp.Indentation := 1;
                                    PackageTreeTemp."Item No." := ItemKey;
                                    PackageTreeTemp."Item Description" := ItemDesc;
                                    PackageTreeTemp."Packed Quantity" := BinDict.Get(BinKey);
                                    PackageTreeTemp.Bin := BinKey;
                                    PackageTreeTemp."On Tool Request" := false;
                                    PackageTreeTemp.Insert(true);

                                    ReqQty += BinDict.Get(BinKey);

                                    if TextBuilderList.Length > 0 then
                                        TextBuilderList.Append(';');
                                    TextBuilderList.Append(BinKey + ';' + Format(BinDict.Get(BinKey)));
                                end;
                            end;
                        end;

                        if PackageTreeTemp.Get(SaveEntryNoCounter) then begin
                            PackageTreeTemp."Packed Quantity" := ReqQty;
                            PackageTreeTemp."Package List" := TextBuilderList.ToText();
                            PackageTreeTemp.Modify();
                        end;

                    end;
                end;
            end;
        end;
        TmpCompanyInformation.Get();
        TmpCompanyInformation.CalcFields(Picture);

        FindBins();
    end;

    local procedure FindBins()
    var
        Index: Integer;
        ListText: List of [Text];
    begin
        if BinFilter <> '' then begin
            if BinFilter.Contains('|') then begin
                ListText := BinFilter.Split('|');
                MainBin := ListText.Get(1);
                if ListText.Get(2).Contains('..') then begin
                    ListText := ListText.Get(2).Split('..');
                end;
            end;

            if ListText.Count = 0 then begin
                ListText := BinFilter.Split('..');
                MainBin := Binfilter.Substring(1, BinFilter.IndexOf('-P'));
            end;

            FromBin := ListText.Get(1);
            ToBin := ListText.Get(2);
        end;
    end;

    local procedure createDictEmpty() Result: Dictionary of [Code[20], Decimal]
    begin
        exit(Result);
    end;

    procedure SetBinFilter(BinFilter_L: Text)
    begin
        BinFilter := BinFilter_L;
    end;

    procedure SetJobMap(JobMap_L: List of [Dictionary of [Code[20], Integer]])
    begin
        JobMap := JobMap_L;
    end;

    procedure SetJobNo(JobNo_L: Code[20])
    begin
        JobNo := JobNo_L;
    end;
}


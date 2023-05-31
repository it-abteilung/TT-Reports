Report 50041 CreateTransferOrder
{
    Caption = 'Erstelle Umlagerungsauftrag';
    ProcessingOnly = true;

    dataset
    {
        dataitem(WarehouseEntry; "Warehouse Entry")
        {
            DataItemTableView = sorting("Item No.", "Bin Code", "Location Code", "Variant Code", "Unit of Measure Code", "Lot No.", "Serial No.", "Entry Type", Dedicated) order(ascending);
            column(ReportForNavId_100000000; 100000000)
            {
            }

            trigger OnAfterGetRecord()
            var
                TransferLine_l: Record "Transfer Line";
                Item_l: Record Item;
            begin
                SetRange("Item No.", "Item No.");
                FindLast();
                WarehouseEntry.CalcSums(Quantity);
                SetRange("Item No.");

                if WarehouseEntry.Quantity > 0 then begin

                    // Erstellung Umlagerungsauftragszeilen
                    TransferLine_l.SetRange("Document No.", TransferHeader_g."No.");
                    TransferLine_l.SetRange("Item No.", WarehouseEntry."Item No.");
                    TransferLine_l.SetRange("Unit of Measure", WarehouseEntry."Unit of Measure Code");
                    if not TransferLine_l.FindSet() then begin
                        TransferLine_l.Validate("Document No.", TransferHeader_g."No.");
                        TransferLine_l.Validate("Line No.", LineNo_g);
                        TransferLine_l.Validate("Item No.", WarehouseEntry."Item No.");
                        TransferLine_l.Validate(Quantity, WarehouseEntry.Quantity);
                        TransferLine_l.Validate("Unit of Measure", WarehouseEntry."Unit of Measure Code");
                        TransferLine_l.Validate("Qty. to Ship", WarehouseEntry.Quantity);
                        // G-ERP.AG 2021-05-17  TransferLine_l.VALIDATE("Transfer-from Bin Code",FromBinCode_g);
                        TransferLine_l.Validate("Transfer-from Bin Code", 'WA');      // G-ERP.AG 2021-05-17
                        TransferLine_l.Validate("Transfer-To Bin Code", ToBinCode_g);
                        TransferLine_l.Insert(true);
                        LineNo_g += 10000;
                    end else begin
                        TransferLine_l.Validate(Quantity, TransferLine_l.Quantity + WarehouseEntry.Quantity);
                        TransferLine_l.Modify(true);
                    end;
                end;

                // IF Item_l.GET(TransferLine_l."Item No.") THEN
                //  IF Item_l."Item Tracking Code" <> '' THEN BEGIN
                //    CreateReservationEntry(0,TransferLine_l,WarehouseEntry,FromLocation_g);
                //    CreateReservationEntry(1,TransferLine_l,WarehouseEntry,ToLocation_g);
                //  END;
            end;

            trigger OnPostDataItem()
            var
                warehouseShipmentHeader: Record "Warehouse Shipment Header";
                warehouseShipmentLine: Record "Warehouse Shipment Line";
                warehouseActivityLine: Record "Warehouse Activity Line";
                GetSourceDocOutbound_l: Codeunit "Get Source Doc. Outbound";
                ReleaseWhseShipment: Codeunit "Whse.-Shipment Release";
            begin
                // Umlag. Auftrag Freigeben
                if ReleaseTransferOrder_g then
                    Codeunit.Run(Codeunit::"Release Transfer Document", TransferHeader_g);

                // Warenausgang erstellen
                if CreateOutbondTransferOrder_g then begin
                    GetSourceDocOutbound_l.CreateFromOutbndTransferOrderHideDialog(TransferHeader_g);
                    // Kommissionierung erstellen
                    Clear(warehouseShipmentLine);
                    warehouseShipmentLine.SetRange("Source Type", 5741);
                    warehouseShipmentLine.SetRange("Source Subtype", 0);
                    warehouseShipmentLine.SetRange("Source No.", TransferHeader_g."No.");
                    if warehouseShipmentLine.FindFirst then begin
                        Clear(warehouseShipmentHeader);
                        warehouseShipmentHeader.Get(warehouseShipmentLine."No.");
                        if warehouseShipmentHeader.Status = warehouseShipmentHeader.Status::Open then
                            ReleaseWhseShipment.Release(warehouseShipmentHeader);
                        CreatePickDoc(warehouseShipmentLine, warehouseShipmentHeader);
                        Clear(warehouseActivityLine);
                        warehouseActivityLine.SetRange("Activity Type", warehouseActivityLine."activity type"::Pick);
                        warehouseActivityLine.SetRange("Whse. Document Type", warehouseActivityLine."whse. document type"::Shipment);
                        warehouseActivityLine.SetRange("Whse. Document No.", warehouseShipmentHeader."No.");
                        warehouseActivityLine.SetRange("Action Type", warehouseActivityLine."action type"::Take);
                        if warehouseActivityLine.FindSet then
                            repeat
                                if (warehouseActivityLine."Bin Code" = '') then begin
                                    warehouseActivityLine.Validate("Bin Code", FromBinCode_g);
                                    warehouseActivityLine.Modify;
                                end;
                            until warehouseActivityLine.Next = 0;
                    end;
                end;
            end;

            trigger OnPreDataItem()
            var
                FromBin_l: Record Bin;
                ToBin_l: Record Bin;
            begin
                // Überprüfung ob es den Von Lagerplatz gibt
                if not FromBin_l.Get(FromLocation_g, FromBinCode_g) then
                    Error(ERR_BinCode, FromBinCode_g);

                // Überprüfung ob es den Zu Lagerplatz gibt
                if not ToBin_l.Get(ToLocation_g, ToBinCode_g) then
                    Error(ERR_BinCode, ToBinCode_g);

                //Filter auf Lagerort und -Platz
                WarehouseEntry.SetRange("Location Code", FromLocation_g);
                WarehouseEntry.SetRange("Bin Code", FromBinCode_g);

                // Erstellung Umlagerungsauftrag
                TransferHeader_g."No." := '';
                TransferHeader_g.Insert(true);

                TransferHeader_g.Validate("Job No", ToBinCode_g);
                TransferHeader_g.Validate("Shipment Date", WorkDate);
                TransferHeader_g.Validate("Transfer-from Code", FromLocation_g);
                TransferHeader_g.Validate("In-Transit Code", InventorySetup_g."Transit Location");
                TransferHeader_g.Validate("Transfer-to Code", ToLocation_g);
                TransferHeader_g.Validate("Assigned User ID", UserId);
                TransferHeader_g.Modify(true);

                LineNo_g := 10000;
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
                    field("From Location"; FromLocation_g)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Von Lagerort';
                        TableRelation = Location;
                    }
                    field("From Bin Code"; FromBinCode_g)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Von Lagerplatz';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Bin_l: Record Bin;
                        begin
                            Bin_l.SetRange("Location Code", FromLocation_g);
                            if Page.RunModal(0, Bin_l) = Action::LookupOK then
                                FromBinCode_g := Bin_l.Code;
                        end;
                    }
                    field("To Location"; ToLocation_g)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Zu Lagerort';
                        TableRelation = Location;
                    }
                    field("To Bin Code"; ToBinCode_g)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Zu Lagerplatz';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Bin_l: Record Bin;
                        begin
                            Bin_l.SetRange("Location Code", ToLocation_g);
                            if Page.RunModal(0, Bin_l) = Action::LookupOK then
                                ToBinCode_g := Bin_l.Code;
                        end;
                    }
                    field("Release Transfer Order"; ReleaseTransferOrder_g)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Automatisch freigeben';

                        trigger OnValidate()
                        begin
                            if not ReleaseTransferOrder_g then
                                CreateOutbondTransferOrder_g := false;
                        end;
                    }
                    field("Create Outbond"; CreateOutbondTransferOrder_g)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Warenausgang erstellen';
                        Enabled = ReleaseTransferOrder_g;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            // Lagereinrichtung überprüfen
            InventorySetup_g.Get();
            InventorySetup_g.TestField("Picking Location");
            InventorySetup_g.TestField("Transit Location");
            InventorySetup_g.TestField("Project Location");

            FromLocation_g := InventorySetup_g."Picking Location";
            ToLocation_g := InventorySetup_g."Project Location";

            ReleaseTransferOrder_g := true;
            CreateOutbondTransferOrder_g := true;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    var
        Werkzeuganforderungskopf_l: Record Werkzeuganforderungskopf;
        Werkzeuganforderungzeile_l: Record Werkzeuganforderungzeile;
        LineNo: Integer;
    begin
    end;

    var
        JobNo_g: Code[20];
        ERR_BinCode: label 'There is no storage space for the project. \\Please check whether the project %1  is commissioned.';
        InventorySetup_g: Record "Inventory Setup";
        TransferHeader_g: Record "Transfer Header";
        LineNo_g: Integer;
        FromLocation_g: Code[20];
        ToLocation_g: Code[20];
        FromBinCode_g: Code[20];
        ToBinCode_g: Code[20];
        [InDataSet]
        ReleaseTransferOrder_g: Boolean;
        [InDataSet]
        CreateOutbondTransferOrder_g: Boolean;

    local procedure CreateReservationEntry(_Type: Integer; _TransferLine: Record "Transfer Line"; _WarehouseEntry: Record "Warehouse Entry"; _LocationCode: Code[20])
    var
        ReservationEntry_l: Record "Reservation Entry";
        EntryNo_l: Integer;
    begin
        EntryNo_l := 1;
        Clear(ReservationEntry_l);
        ReservationEntry_l.SetCurrentkey("Entry No.", Positive);
        if ReservationEntry_l.FindLast() then
            EntryNo_l := ReservationEntry_l."Entry No." + 1;

        Clear(ReservationEntry_l);
        ReservationEntry_l.Init();
        ReservationEntry_l.Validate("Entry No.", EntryNo_l);
        ReservationEntry_l.Validate("Creation Date", Today);
        ReservationEntry_l.Validate("Created By", UserId);
        ReservationEntry_l.Validate("Reservation Status", ReservationEntry_l."reservation status"::Surplus);
        ReservationEntry_l.Validate("Source Type", 5741);
        ReservationEntry_l.Validate("Source ID", _TransferLine."Document No.");
        ReservationEntry_l.Validate("Source Batch Name", '');
        ReservationEntry_l.Validate("Source Ref. No.", _TransferLine."Line No.");
        ReservationEntry_l.Validate("Location Code", _LocationCode);
        ReservationEntry_l.Validate("Item No.", _TransferLine."Item No.");

        case _Type of
            0:
                begin
                    ReservationEntry_l.Validate("Source Subtype", 0);
                    ReservationEntry_l.Validate(Positive, false);
                    ReservationEntry_l.Validate("Shipment Date", Today);
                end;
            1:
                begin
                    ReservationEntry_l.Validate("Source Subtype", 1);
                    ReservationEntry_l.Validate(Positive, true);
                    ReservationEntry_l.Validate("Expected Receipt Date", Today);
                end;
        end;

        if _WarehouseEntry."Lot No." <> '' then begin
            ReservationEntry_l.Validate("Lot No.", _WarehouseEntry."Lot No.");
            ReservationEntry_l.Validate("Item Tracking", ReservationEntry_l."item tracking"::"Lot No.");
        end;

        if _WarehouseEntry."Serial No." <> '' then begin
            ReservationEntry_l.Validate("Item Tracking", ReservationEntry_l."item tracking"::"Serial No.");
            ReservationEntry_l.Validate("Serial No.", _WarehouseEntry."Serial No.");
        end;

        case _Type of
            0:
                ReservationEntry_l.Validate("Quantity (Base)", (_TransferLine."Quantity (Base)" * -1));
            1:
                ReservationEntry_l.Validate("Quantity (Base)", (_TransferLine."Quantity (Base)"));
        end;

        ReservationEntry_l.Insert(true);
    end;


    procedure CreatePickDoc(var WhseShptLine: Record "Warehouse Shipment Line"; WhseShptHeader2: Record "Warehouse Shipment Header")
    var
        CreatePickFromWhseShpt: Report "Whse.-Shipment - Create Pick";
    begin
        WhseShptHeader2.TestField(Status, WhseShptHeader2.Status::Released);
        WhseShptLine.SetFilter(Quantity, '>0');
        WhseShptLine.SetRange("Completely Picked", false);
        if WhseShptLine.Find('-') then begin
            CreatePickFromWhseShpt.SetWhseShipmentLine(WhseShptLine, WhseShptHeader2);
            CreatePickFromWhseShpt.SetHideValidationDialog(true);
            CreatePickFromWhseShpt.UseRequestPage(false);
            // CreatePickFromWhseShpt.SetJobNo(WhseShptHeader2."Job No");      //G-ERP.RS 2019-07-08 Anfrage#233369
            // CreatePickFromWhseShpt.SetRessource(WhseShptHeader2.Ressource); //G-ERP.RS 2019-08-15 Anfrage#233369
            CreatePickFromWhseShpt.RunModal;
            CreatePickFromWhseShpt.GetResultMessage;
            Clear(CreatePickFromWhseShpt);
        end;
    end;
}


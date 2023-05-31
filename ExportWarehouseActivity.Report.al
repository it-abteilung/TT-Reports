// Report 50025 "Export Warehouse Activity"
// {
//     Caption = 'Shipping Documents';
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem("Posted Whse. Shipment Line";"Posted Whse. Shipment Line")
//         {
//             DataItemTableView = sorting("No.","Line No.") order(ascending);
//             column(ReportForNavId_100000003; 100000003)
//             {
//             }
//             dataitem("Registered Whse. Activity Line";"Registered Whse. Activity Line")
//             {
//                 DataItemLink = "Item No."=field("Item No.");
//                 DataItemTableView = sorting("Activity Type","No.","Line No.") order(ascending);
//                 column(ReportForNavId_100000001; 100000001)
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 var
//                     Item_l: Record Item;
//                     ItemTranslation_l: Record "Item Translation";
//                     TransportContainer_l: Record 50050;
//                     WarehouseShipmentHeader_l: Record "Warehouse Shipment Header";
//                     RegisteredWhseActivityHdr_l: Record "Registered Whse. Activity Hdr.";
//                 begin
//                     RegisteredWhseActivityHdr_l.Get("Activity Type","No.");
//                     if (Job_g <> '') and (RegisteredWhseActivityHdr_l."Job No" <> Job_g) then
//                       CurrReport.Break();

//                     SetRange("Item No.","Item No.");
//                     FindLast();
//                     SetRange("Item No.");

//                     if Item_l.Get("Item No.") then;
//                     if ItemTranslation_l.Get("Item No.","Variant Code",'ENU') then;
//                     if TransportContainer_l.Get("Transport Container Code") then;
//                     // IF ("Whse. Document Type" = "Whse. Document Type"::Shipment) AND
//                     //   (WarehouseShipmentHeader_l.GET("Whse. Document No.")) THEN
//                     //  dddd

//                     // "Posted Whse. Shipment Line".

//                     EnterCell( RowNo_g,  1, Format(Quantity), '', true, false, false);
//                     EnterCell( RowNo_g,  2, "Unit of Measure Code", '', true, false, false);
//                     EnterCell( RowNo_g,  3, Item_l.Description, '', true, false, false);
//                     EnterCell( RowNo_g,  4, Item_l."Description 2", '', true, false, false);
//                     EnterCell( RowNo_g,  5, "Serial No.", '', true, false, false);
//                     EnterCell( RowNo_g,  6, '', '', true, false, false);
//                     EnterCell( RowNo_g,  7, '', '', true, false, false);
//                     EnterCell( RowNo_g,  8, ItemTranslation_l.Description, '', true, false, false);
//                     EnterCell( RowNo_g,  9, Item_l."Tariff No.", '', true, false, false);
//                     EnterCell( RowNo_g, 10, Item_l."Country/Region Purchased Code", '', true, false, false);
//                     EnterCell( RowNo_g, 11, Format(Item_l."Net Weight"), '', true, false, false);
//                     EnterCell( RowNo_g, 12, Format(Quantity * Item_l."Net Weight"), '', true, false, false);
//                     EnterCell( RowNo_g, 13, Format(Item_l."Unit Cost"), '', true, false, false);
//                     EnterCell( RowNo_g, 14, Format(Item_l."Unit Cost" * Quantity), '', true, false, false);
//                     EnterCell( RowNo_g, 15, "Item No.", '', true, false, false);
//                     EnterCell( RowNo_g, 16, "Transport Container Code", '', true, false, false);
//                     RowNo_g += 1;
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     SetRange("Whse. Document Type","whse. document type"::Shipment);
//                     SetRange("Whse. Document No.","Posted Whse. Shipment Line"."Whse. Shipment No.");
//                 end;
//             }

//             trigger OnPreDataItem()
//             begin
//                 //"Posted Whse. Shipment Line".SETRANGE("Location Code",InventorySetup_g."Project Location");
//                 //"Posted Whse. Shipment Line".SETRANGE("Bin Code",Job_g);
//                 if Shippentdate_g <> 0D then
//                   "Posted Whse. Shipment Line".SetRange("Shipment Date",Shippentdate_g);
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//             area(content)
//             {
//                 group(Control100000001)
//                 {
//                     field(Job;Job_g)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Projekt';
//                         TableRelation = Job;
//                     }
//                     field(Shippentdate;Shippentdate_g)
//                     {
//                         ApplicationArea = Basic;
//                         Caption = 'Warenausgangsdatum';
//                     }
//                 }
//             }
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPostReport()
//     begin
//         ExcelBuffer_Tmp_g.CreateBookAndOpenExcel('','Versandpapiere','Versandpapiere',COMPANYNAME,UserId);
//     end;

//     trigger OnPreReport()
//     begin
//         InventorySetup_g.Get();
//         ExcelBuffer_Tmp_g.DeleteAll();
//         RowNo_g := 2;

//         EnterCell( 1,  1, 'Menge', '', true, false, false);
//         EnterCell( 1,  2, 'Einheit', '', true, false, false);
//         EnterCell( 1,  3, 'Beschreibung', '', true, false, false);
//         EnterCell( 1,  4, 'Beschreibung 2', '', true, false, false);
//         EnterCell( 1,  5, 'Seriennummer', '', true, false, false);
//         EnterCell( 1,  6, '', '', true, false, false);
//         EnterCell( 1,  7, '', '', true, false, false);
//         EnterCell( 1,  8, 'Description', '', true, false, false);
//         EnterCell( 1,  9, 'Zollpos', '', true, false, false);
//         EnterCell( 1, 10, 'Herkunftsland', '', true, false, false);
//         EnterCell( 1, 11, 'Nettogewicht', '', true, false, false);
//         EnterCell( 1, 12, 'Gewicht', '', true, false, false);
//         EnterCell( 1, 13, 'EK-Preis', '', true, false, false);
//         EnterCell( 1, 14, 'Preis', '', true, false, false);
//         EnterCell( 1, 15, 'Artikelnummer', '', true, false, false);
//         EnterCell( 1, 16, 'Transportbehälter', '', true, false, false);
//     end;

//     var
//         ExcelBuffer_Tmp_g: Record "Excel Buffer" temporary;
//         InventorySetup_g: Record "Inventory Setup";
//         Job_g: Code[20];
//         Shippentdate_g: Date;
//         RowNo_g: Integer;

//     local procedure EnterCell(_RowNo: Integer;_ColumnNo: Integer;_CellValue: Text[250];_CellFormula: Text[250];_Bold: Boolean;_Italic: Boolean;_UnderLine: Boolean)
//     begin
//         ExcelBuffer_Tmp_g.Init;
//         ExcelBuffer_Tmp_g.Validate("Row No.",_RowNo);
//         ExcelBuffer_Tmp_g.Validate("Column No.",_ColumnNo);
//         ExcelBuffer_Tmp_g."Cell Value as Text" := _CellValue;
//         ExcelBuffer_Tmp_g.Formula := _CellFormula;
//         ExcelBuffer_Tmp_g.Bold := _Bold;
//         ExcelBuffer_Tmp_g.Italic := _Italic;
//         ExcelBuffer_Tmp_g.Underline := _UnderLine;
//         ExcelBuffer_Tmp_g.Insert;
//     end;
// }


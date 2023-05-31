// Report 50053 "Import Bestellung from Excel"
// {
//     ProcessingOnly = true;

//     dataset
//     {
//         dataitem("Purchase Header";"Purchase Header")
//         {
//             trigger OnAfterGetRecord()
//             begin
//                 ExcelBuf.OpenBook(ServerFileName,SheetName);
//                 ExcelBuf.ReadSheet;
//                 //ReadExcelSheet;
//                 AnalyzeData;
//             end;
//         }
//     }

//     requestpage
//     {

//         layout
//         {
//         }

//         actions
//         {
//         }
//     }

//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin
//         if ServerFileName = '' then
//           ServerFileName := FileMgt.UploadFile(Text006,ExcelFileExtensionTok);
//         if ServerFileName = '' then
//           Error('Fehler!');

//         ExcelBuf.LockTable;
//         if SheetName = '' then
//           SheetName := ExcelBuf.SelectSheetsName(ServerFileName);
//     end;

//     var
//         ExcelBuf: Record "Excel Buffer" temporary;
//         PurchaseLine: Record "Purchase Line";
//         FileName: Text[250];
//         UploadedFileName: Text[1024];
//         SheetName: Text[250];
//         ImportOption: Option "Replace entries","Add entries";
//         Window: Dialog;
//         TotalRecNo: Integer;
//         RecNo: Integer;
//         Hilfswert: Decimal;
//         Einlesen: Boolean;
//         i: Integer;
//         LetzteNr: Integer;
//         ZeileEinlesen: Boolean;
//         Baugr: Code[20];
//         PosNr: Code[20];
//         Artnr: Code[10];
//         Meng: Decimal;
//         Beschr: Text[50];
//         Beschr2: Text[50];
//         Einh: Code[10];
//         PosCode: Code[10];
//         EPreis: Decimal;
//         KredArtikelnr: Text[30];
//         ZeilRabatt: Decimal;
//         Text000: label 'You must specify a budget name to import to.';
//         Text001: label 'Do you want to create %1 %2.';
//         Text002: label '%1 %2 is blocked. You cannot import entries.';
//         Text003: label 'Are you sure you want to %1 for %2 %3.';
//         Text004: label '%1 table has been successfully updated with %2 entries.';
//         Text005: label 'Imported from Excel ';
//         Text006: label 'Import Excel File';
//         Text007: label 'Analyzing Data...\\';
//         Text008: label 'You cannot specify more than 8 dimensions in your Excel worksheet.';
//         Text009: label 'G/L ACCOUNT NO';
//         Text010: label 'G/L Account No.';
//         Text011: label 'The text G/L Account No. can only be specified once in the Excel worksheet.';
//         Text012: label 'The dimensions specified by worksheet must be placed in the lines before the table.';
//         Text013: label 'Dimension ';
//         Text014: label 'Date';
//         Text015: label 'Dimension 1';
//         Text016: label 'Dimension 2';
//         Text017: label 'Dimension 3';
//         Text018: label 'Dimension 4';
//         Text019: label 'Dimension 5';
//         Text020: label 'Dimension 6';
//         Text021: label 'Dimension 7';
//         Text022: label 'Dimension 8';
//         Text023: label 'You cannot import the same information twice.\';
//         Text024: label 'The combination G/L Account No. - Dimensions - Date must be unique.';
//         Text025: label 'G/L Accounts have not been found in the Excel worksheet.';
//         Text026: label 'Dates have not been recognized in the Excel worksheet.';
//         Text027: label 'Replace entries,Add entries';
//         Text028: label 'A filter has been used on the %1 when the budget was exported. When a filter on a dimension has been used, a column with the same dimension must be present in the worksheet imported. The column in the worksheet must specify the dimension value codes the program should use when importing the budget.';
//         ServerFileName: Text;
//         FileMgt: Codeunit "File Management";
//         ExcelFileExtensionTok: label '.xlsx', Locked=true;

//     local procedure ReadExcelSheet()
//     begin
//         if ISSERVICETIER then
//           if UploadedFileName = '' then
//             UploadFile
//           else
//             FileName := UploadedFileName;

//         ExcelBuf.OpenBook(FileName,SheetName);
//         ExcelBuf.ReadSheet;
//     end;

//     local procedure AnalyzeData()
//     begin
//         Window.Open(
//           Text007 +
//           '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
//         Window.Update(1,0);
//         TotalRecNo := ExcelBuf.Count;
//         RecNo := 0;

//         if ExcelBuf.Find('-') then begin
//           Einlesen := false;
//           i := 0;
//           repeat
//             RecNo := RecNo + 1;
//             Window.Update(1,ROUND(RecNo / TotalRecNo * 10000,1));
//             if ExcelBuf."Row No." > 1 then begin
//               if (ExcelBuf."Column No." = 1) then
//                 Artnr := ExcelBuf."Cell Value as Text";
//               if (ExcelBuf."Column No." = 2) then
//                 Beschr := ExcelBuf."Cell Value as Text";
//               if (ExcelBuf."Column No." = 3) then
//                 Beschr2 := ExcelBuf."Cell Value as Text";
//               if (ExcelBuf."Column No." = 4) then
//                 KredArtikelnr := ExcelBuf."Cell Value as Text";
//               if (ExcelBuf."Column No." = 5) then
//                 Evaluate(Meng,ExcelBuf."Cell Value as Text");
//               if (ExcelBuf."Column No." = 6) then
//                 Einh := ExcelBuf."Cell Value as Text";
//               if (ExcelBuf."Column No." = 7) then
//                 Evaluate(EPreis,ExcelBuf."Cell Value as Text");
//               if (ExcelBuf."Column No." = 8) then
//                 Evaluate(ZeilRabatt,ExcelBuf."Cell Value as Text");
//               if (ExcelBuf."Column No." = 9) then
//                 Baugr := ExcelBuf."Cell Value as Text";
//               if (ExcelBuf."Column No." = 10) then begin
//                 PosCode := ExcelBuf."Cell Value as Text";
//                 i += 10000;
//                 Clear(PurchaseLine);
//                 PurchaseLine.Validate("Document Type","Purchase Header"."Document Type");
//                 PurchaseLine.Validate("Document No.","Purchase Header"."No.");
//                 PurchaseLine.Validate("Line No.",i);
//                 PurchaseLine.Validate(Type,PurchaseLine.Type::Item);
//                 PurchaseLine.Validate("No.",Artnr);
//                 if Beschr <> '' then
//                   PurchaseLine.Validate(PurchaseLine.Description,Beschr);
//                 if Beschr2 <> '' then
//                   PurchaseLine.Validate(PurchaseLine."Description 2",Beschr2);
//                 if KredArtikelnr <> '' then
//                   PurchaseLine."Vendor Item No." := KredArtikelnr;
//                 PurchaseLine.Validate(Quantity,Meng);
//                 PurchaseLine.Validate("Unit of Measure",Einh);
//                 PurchaseLine.Validate(Pos,PosCode);
//                 PurchaseLine.Validate(Baugruppe,Baugr);
//                 PurchaseLine.Validate("Direct Unit Cost",EPreis);
//                 if ZeilRabatt <>0 then
//                   PurchaseLine.Validate("Line Discount %",ZeilRabatt);
//                 PurchaseLine.Insert(true);
//                 Baugr := '';
//                 Artnr := '';
//                 Meng := 0;
//                 Beschr := '';
//                 Beschr2 := '';
//                 KredArtikelnr := '';
//                 Einh := '';
//                 PosCode := '';
//                 EPreis := 0;
//                 ZeilRabatt := 0;
//               end;
//             end;
//           until ExcelBuf.Next = 0;
//         end;

//         Window.Close;
//     end;

//     local procedure FormatData(TextToFormat: Text[250]): Text[250]
//     var
//         FormatInteger: Integer;
//         FormatDecimal: Decimal;
//         FormatDate: Date;
//     begin
//         case true of
//           Evaluate(FormatInteger,TextToFormat):
//             exit(Format(FormatInteger));
//           Evaluate(FormatDecimal,TextToFormat):
//             exit(Format(FormatDecimal));
//           Evaluate(FormatDate,TextToFormat):
//             exit(Format(FormatDate));
//           else
//             exit(TextToFormat);
//         end;
//     end;


//     procedure UploadFile()
//     var
//         CommonDialogMgt: Codeunit UnknownCodeunit412;
//     begin
//         //UploadedFileName := CommonDialogMgt.OpenFile(Text006,'',2,'',0);
//         FileName := UploadedFileName;
//     end;

//     local procedure FileNameOnAfterValidate()
//     begin
//         UploadFile;
//     end;
// }


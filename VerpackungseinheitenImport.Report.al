// Report 50040 "Verpackungseinheiten Import"
// {
//     ProcessingOnly = true;

//     dataset
//     {
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
//     // 
//     }

//     trigger OnPreReport()
//     begin
//         if ServerFileName = '' then
//           ServerFileName := FileMgt.UploadFile(Text001,ExcelFileExtensionTok);
//         if ServerFileName = '' then
//           Error('Fehler!');

//         ExcelBuf.LockTable;
//         if SheetName = '' then
//           SheetName := ExcelBuf.SelectSheetsName(ServerFileName);


//         ExcelBuf.OpenBook(ServerFileName,SheetName);
//         ExcelBuf.ReadSheet;
//         //ReadExcelSheet;
//         AnalyzeData;
//     end;

//     var
//         ExcelBuf: Record "Excel Buffer" temporary;
//         Item: Record Item;
//         ItemUnitofMeasure: Record "Item Unit of Measure";
//         FileMgt: Codeunit "File Management";
//         RowNo: Integer;
//         ServerFileName: Text;
//         FileName: Text[250];
//         UploadedFileName: Text[1024];
//         SheetName: Text[250];
//         Text001: label 'Import Excel File';
//         ExcelFileExtensionTok: label '.xlsx', Locked=true;
//         ItemNo: Code[20];
//         QuantityEvaluated: Decimal;

//     local procedure ReadExcelSheet()
//     begin
//         if ISSERVICETIER then
//           if UploadedFileName = '' then
//             UploadFile
//           else
//             FileName := UploadedFileName;

//         ExcelBuf.OpenBook(FileName,SheetName);
//         ExcelBuf.ReadSheet;
//         Message('Fertig!');
//     end;

//     local procedure AnalyzeData()
//     begin

//         ExcelBuf.SetFilter("Row No.",'%1..',2);
//         if ExcelBuf.Find('-') then begin
//           repeat
//             if (ExcelBuf."Column No." = 1) and (ExcelBuf."Cell Value as Text" <> '') then begin //Artikel-Nr.
//               ItemNo := ExcelBuf."Cell Value as Text";
//             end;
//             if (ExcelBuf."Column No." = 3)  and (ExcelBuf."Cell Value as Text" <> '') then begin //Basiseinheitencode
//               Item.Get(ItemNo);
//               Item."Base Unit of Measure" := ExcelBuf."Cell Value as Text";
//               Item.Validate("Base Unit of Measure");                          // G-ERP.RS 2020-02-14 Anfrage#234878
//               Item."Purch. Unit of Measure" := ExcelBuf."Cell Value as Text"; // G-ERP.RS 2020-02-14 Anfrage#234878
//               Item."Sales Unit of Measure" := ExcelBuf."Cell Value as Text";  // G-ERP.RS 2020-02-14 Anfrage#234878
//               Item.Modify;
//             end;
//             if (ExcelBuf."Column No." = 4)  and (ExcelBuf."Cell Value as Text" <> '') then begin //Menge (Basiseinheitencode)
//               if not ItemUnitofMeasure.Get(ItemNo, Item."Base Unit of Measure") then begin
//                 ItemUnitofMeasure."Item No." := ItemNo;
//                 ItemUnitofMeasure.Code :=  Item."Base Unit of Measure";
//                 ItemUnitofMeasure.Insert;
//               end;
//               Evaluate(QuantityEvaluated, ExcelBuf."Cell Value as Text");
//               ItemUnitofMeasure.Validate("Qty. per Unit of Measure", QuantityEvaluated);
//               ItemUnitofMeasure.Modify;
//             end;
//             if (ExcelBuf."Column No." = 5)  and (ExcelBuf."Cell Value as Text" <> '') then begin //Einheit 1
//               if not ItemUnitofMeasure.Get(ItemNo, ExcelBuf."Cell Value as Text") then begin
//                 ItemUnitofMeasure."Item No." := ItemNo;
//                 ItemUnitofMeasure.Code :=  ExcelBuf."Cell Value as Text";
//                 ItemUnitofMeasure.Insert;
//               end;
//             end;
//             if (ExcelBuf."Column No." = 6)  and (ExcelBuf."Cell Value as Text" <> '') then begin //Menge (Einheit 1)
//               Evaluate(QuantityEvaluated, ExcelBuf."Cell Value as Text");
//               ItemUnitofMeasure.Validate("Qty. per Unit of Measure", QuantityEvaluated);
//               ItemUnitofMeasure.Modify;
//             end;
//             if (ExcelBuf."Column No." = 7)  and (ExcelBuf."Cell Value as Text" <> '') then begin //Einheit 2
//               if not ItemUnitofMeasure.Get(ItemNo, ExcelBuf."Cell Value as Text") then begin
//                 ItemUnitofMeasure."Item No." := ItemNo;
//                 ItemUnitofMeasure.Code :=  ExcelBuf."Cell Value as Text";
//                 ItemUnitofMeasure.Insert;
//               end;
//             end;
//             if (ExcelBuf."Column No." = 8)  and (ExcelBuf."Cell Value as Text" <> '') then begin //Menge (Einheit 2)
//               Evaluate(QuantityEvaluated, ExcelBuf."Cell Value as Text");
//               ItemUnitofMeasure.Validate("Qty. per Unit of Measure", QuantityEvaluated);
//               ItemUnitofMeasure.Modify;
//             end;
//           until ExcelBuf.Next = 0;
//         end;
//     end;


//     procedure UploadFile()
//     var
//         CommonDialogMgt: Codeunit UnknownCodeunit412;
//     begin
//         //UploadedFileName := CommonDialogMgt.OpenFile(Text006,'',2,'',0);
//         FileName := UploadedFileName;
//     end;
// }


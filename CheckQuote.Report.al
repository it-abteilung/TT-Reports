#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50071 CheckQuote
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/CheckQuote.rdlc';

    dataset
    {
        dataitem(PurchaseHeader1;"Purchase Header")
        {
            DataItemTableView = sorting("Document Type","No.") order(ascending);
            RequestFilterFields = Serienanfragennr;
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(PurchaseHeader_DocumentType;"Document Type")
            {
            }
            column(PurchaseHeader_No;"No.")
            {
            }
            column(PurchaseHeader_Serienanfragennr;Serienanfragennr)
            {
            }

            trigger OnAfterGetRecord()
            var
                l_PurchaseHeader: Record "Purchase Header";
                l_ModTreeNo: Boolean;
                l_QuoteFound: Boolean;
                l_PurchaseNo: Code[20];
            begin
                //Nicht wenn die Anfragenummer und Serienanfragenummer gleich sind.
                if ("No." = Serienanfragennr) and (TreeNo = 1) then
                  CurrReport.Skip();


                //Wenn die Anfrage TreeNo korrigiert werden sollen.
                if g_Modify then begin

                  //Wenn die Anfragenummer die erste in der Serienanfrage ist.
                  //Dann soll wenn die TreeNo 2 ist, auf 1 umgeändert werden.
                  Clear(l_PurchaseHeader);
                  l_PurchaseHeader.SetCurrentkey("Document Type","No.");
                  l_PurchaseHeader.SetRange("Document Type","document type"::Quote);
                  l_PurchaseHeader.SetRange(Serienanfragennr,Serienanfragennr);
                  if l_PurchaseHeader.FindFirst() then
                    if ("No." = l_PurchaseHeader."No.") and (TreeNo = 2) then begin
                      TreeNo := 1;
                      Modify(false);
                    end;
                end;


                //Wenn die TreeNo 2 ist dann wird geskipt
                if (TreeNo = 2) then
                  CurrReport.Skip();


                //Wenn die Anfragenummer die erste in der Serienanfrage ist.
                //Dann soll geskipt werden.
                Clear(l_PurchaseHeader);
                l_PurchaseHeader.SetCurrentkey("Document Type","No.");
                l_PurchaseHeader.SetRange("Document Type","document type"::Quote);
                l_PurchaseHeader.SetRange(Serienanfragennr,Serienanfragennr);
                if l_PurchaseHeader.FindFirst() then
                  if "No." = l_PurchaseHeader."No." then
                    CurrReport.Skip();


                //Wenn die Anfrage TreeNo korrigiert werden sollen.
                if g_Modify then begin

                  //Wenn Serienanfragenummer als Anfragenummer vorhanden ist
                  if l_PurchaseHeader.Get("document type"::Quote,Serienanfragennr) then begin
                    l_ModTreeNo := true;
                  end else begin
                    //Erste Anfragenummer finden mit der Serienanfragenummer
                    Clear(l_PurchaseHeader);
                    l_PurchaseHeader.SetCurrentkey("Document Type","No.");
                    l_PurchaseHeader.SetRange("Document Type","document type"::Quote);
                    l_PurchaseHeader.SetRange(Serienanfragennr,Serienanfragennr);
                    if l_PurchaseHeader.FindFirst() then begin
                      l_PurchaseNo := l_PurchaseHeader."No.";
                      l_QuoteFound := true;
                    end;
                  end;


                  //Wenn eine Anfragenummer gefunden wurde, wenn die Anfragenummer nicht die Serienanfragenummer ist.
                  if (not l_ModTreeNo) and (l_QuoteFound) and (l_PurchaseNo <> "No.") then
                    l_ModTreeNo := true;


                  //Wenn das Modify Flag true ist.
                  if l_ModTreeNo then begin
                    TreeNo := 2;
                    Modify(false);
                    CurrReport.Skip();
                  end;
                end;
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Document Type","document type"::Quote);
                if GetFilter(Serienanfragennr) = '' then
                  SetFilter(Serienanfragennr,'<>%1','');
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Optionen';
                    field(Modify;g_Modify)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Anpassen';
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

    var
        g_Modify: Boolean;
}


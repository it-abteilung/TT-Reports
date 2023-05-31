#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50070 "Update Purchase Header"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purchase Header";"Purchase Header")
        {
            DataItemTableView = sorting("Document Type","No.") order(ascending);
            RequestFilterFields = "No.";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            var
                PurchaseLine: Record "Purchase Line";
            begin
                "Status Purchase" := "status purchase"::" ";

                Clear(PurchaseLine);
                PurchaseLine.SetRange(PurchaseLine."Document Type","Document Type");
                PurchaseLine.SetRange(PurchaseLine."Document No.","No.");
                PurchaseLine.SetRange(Type,PurchaseLine.Type::Item);
                PurchaseLine.CalcSums(Quantity,"Quantity Received","Quantity Invoiced");
                if PurchaseLine.Quantity > 0 then begin

                  //Geliefert
                  if PurchaseLine."Quantity Received" > 0 then
                    if PurchaseLine.Quantity = PurchaseLine."Quantity Received" then
                      "Status Purchase" := "status purchase"::delivered
                    else
                      "Status Purchase" := "status purchase"::"partly delivered";

                  //Faktura
                  if PurchaseLine."Quantity Invoiced" > 0 then
                    if PurchaseLine.Quantity = PurchaseLine."Quantity Invoiced" then
                      "Status Purchase" := "status purchase"::invoiced
                    else
                      "Status Purchase" := "status purchase"::"partly invoiced";

                  //MESSAGE('Bestellung %1 Menge %2 Geliefert %3 Berechnet %4 Status %5',"No.",PurchaseLine.Quantity,
                  //                                                                           PurchaseLine."Quantity Received",
                  //                                                                           PurchaseLine."Quantity Invoiced",
                  //                                                                           "Status Purchase");

                  Modify();

                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Fertig');
            end;

            trigger OnPreDataItem()
            begin
                SetRange("Purchase Header"."Document Type","Purchase Header"."document type"::Order);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}


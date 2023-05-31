#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50042 UpdateItemNumberseries
{
    Caption = 'Update article number series';
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item;Item)
        {
            DataItemTableView = sorting("No.") order(ascending);
            RequestFilterFields = "No.";
            column(ReportForNavId_100000000; 100000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                case ItemTrackingCode_g.Code of
                  'SNALLE'     : Item."Serial Nos." := NoSeries_g.Code;
                  'CHARGEALLE' : Item."Lot Nos."    := NoSeries_g.Code;
                else
                  Error(ERR_01,ItemTrackingCode_g.Code);
                end;
                Item.Modify();
            end;

            trigger OnPreDataItem()
            begin
                Item.SetRange("Item Tracking Code",ItemTrackingCode_g.Code);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Control100000001)
                {
                    field("Item Tracking Code";ItemTrackingCode_g.Code)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Artikelverfolgungscode';
                        TableRelation = "Item Tracking Code" where (Code=filter('SNALLE'));
                    }
                    field("No Series";NoSeries_g.Code)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Nummernserie';
                        TableRelation = "No. Series";
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
        ItemTrackingCode_g: Record "Item Tracking Code";
        NoSeries_g: Record "No. Series";
        ERR_01: label 'The item tracking code %1 is not supported by this report';
}


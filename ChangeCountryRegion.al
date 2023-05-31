report 65000 ChangeCountryRegion
{
    ApplicationArea = All;
    Caption = 'Länder/Region Alpha3 Anpassung';
    UsageCategory = Administration;
    UseRequestPage = true;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = where("Country/Region Code" = const('DE'));

            trigger OnAfterGetRecord()
            begin
                Customer."Country/Region Code" := 'DEU';
                Customer.Modify(false);
            end;
        }
        dataitem(Customer2; Customer)
        {
            DataItemTableView = where("Country/Region Code" = const('US'));

            trigger OnAfterGetRecord()
            begin
                Customer2."Country/Region Code" := 'USA';
                Customer2.Modify(false);
            end;
        }
        dataitem(Customer3; Customer)
        {
            DataItemTableView = where("Country/Region Code" = const('IT'));

            trigger OnAfterGetRecord()
            begin
                Customer3."Country/Region Code" := 'ITA';
                Customer3.Modify(false);
            end;
        }
        dataitem(Customer4; Customer)
        {
            DataItemTableView = where("Country/Region Code" = const('CY'));

            trigger OnAfterGetRecord()
            begin
                Customer4."Country/Region Code" := 'CYP';
                Customer4.Modify(false);
            end;
        }
        dataitem(Customer5; Customer)
        {
            DataItemTableView = where("Country/Region Code" = const('AE'));

            trigger OnAfterGetRecord()
            begin
                Customer5."Country/Region Code" := 'ARE';
                Customer5.Modify(false);
            end;
        }
        dataitem(Customer6; Customer)
        {
            DataItemTableView = where("Country/Region Code" = const('DK'));

            trigger OnAfterGetRecord()
            begin
                Customer6."Country/Region Code" := 'DNK';
                Customer6.Modify(false);
            end;
        }
    }
}

#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50061 ContactBusinessRelationDebKred
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/ContactBusinessRelationDebKred.rdlc';
    Caption = 'Debitoren und Kreditoren ohne Kontakt';

    dataset
    {
        dataitem(Customer;Customer)
        {
            DataItemTableView = sorting("No.") order(ascending);
            RequestFilterFields = "No.";
            column(ReportForNavId_100000001; 100000001)
            {
            }
            column(Caption_Customer;Customer.TableCaption)
            {
            }
            column(Customer_NoCaption;Customer.FieldCaption("No."))
            {
            }
            column(Customer_NameCaption;Customer.FieldCaption(Name))
            {
            }
            column(Customer_No;Customer."No.")
            {
            }
            column(Customer_Name;Customer.Name)
            {
            }

            trigger OnAfterGetRecord()
            var
                ContactBusinessRelation_l: Record "Contact Business Relation";
                Contact_l: Record Contact;
            begin
                ContactBusinessRelation_l.SetRange("Business Relation Code",'DEB');
                ContactBusinessRelation_l.SetRange("No.",Customer."No.");
                if ContactBusinessRelation_l.FindSet() then begin
                  if Contact_l.Get(ContactBusinessRelation_l."Contact No.") then
                    if Contact_l.Name <> '' then
                      CurrReport.Skip();
                end; // Wenn keine Geschäftsbeziehung gefunden anzeigen
            end;
        }
        dataitem(Vendor;Vendor)
        {
            DataItemTableView = sorting("No.") order(ascending);
            RequestFilterFields = "No.";
            column(ReportForNavId_100000000; 100000000)
            {
            }
            column(Caption_Vendor;Vendor.TableCaption)
            {
            }
            column(Vendor_NoCaption;Vendor.FieldCaption("No."))
            {
            }
            column(Vendor_NameCaption;Vendor.FieldCaption(Name))
            {
            }
            column(Vendor_No;Vendor."No.")
            {
            }
            column(Vendor_Name;Vendor.Name)
            {
            }

            trigger OnAfterGetRecord()
            var
                ContactBusinessRelation_l: Record "Contact Business Relation";
                Contact_l: Record Contact;
            begin
                ContactBusinessRelation_l.SetRange("Business Relation Code",'KRED');
                ContactBusinessRelation_l.SetRange("No.",Vendor."No.");
                if ContactBusinessRelation_l.FindSet() then begin
                  if Contact_l.Get(ContactBusinessRelation_l."Contact No.") then
                    if Contact_l.Name <> '' then
                      CurrReport.Skip();
                end; // Wenn keine Geschäftsbeziehung gefunden anzeigen
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


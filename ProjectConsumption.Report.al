#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50027 "Project Consumption"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Project Consumption.rdlc';
    Caption = 'Projekt Verbrauch';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(SingelRowData;"Integer")
        {
            DataItemTableView = sorting(Number) order(ascending) where(Number=const(1));
            MaxIteration = 1;
            column(ReportForNavId_100000001; 100000001)
            {
            }
            column(ReportHeadLine;"Project Consumption".TableCaption)
            {
            }
            column(CompanyName;COMPANYNAME)
            {
            }
            column(Site_Caption;Site_Caption)
            {
            }
            column(Job_Caption;Job_Caption)
            {
            }
            column(Item_Caption;Item_Caption)
            {
            }
            column(Description_Caption;Description_Caption)
            {
            }
            column(Description2_Caption;Description2_Caption)
            {
            }
            column(SerialNo_Caption;SerialNo_Caption)
            {
            }
            column(LotNo_Caption;LotNo_Caption)
            {
            }
            column(Quantity_Caption;Quantity_Caption)
            {
            }
            column(ItemTTType_Caption;ItemTTType_Caption)
            {
            }
            column(LastDirectCost_Caption;LastDirectCost_Caption)
            {
            }
            column(UnitPrice_Caption;UnitPrice_Caption)
            {
            }
            column(SellingPriceProject_Caption;SellingPriceProject_Caption)
            {
            }
            column(Employee_Caption;Employee_Caption)
            {
            }
            column(EmployeeNo_Caption;EmployeeNo_Caption)
            {
            }
            column(ProjectConsumption_GetFilters;"Project Consumption".GetFilters())
            {
            }
        }
        dataitem("Project Consumption";"Project Consumption")
        {
            DataItemTableView = sorting("Job No.","Entry No.") order(ascending);
            RequestFilterFields = "Job No.";
            column(ReportForNavId_100000000; 100000000)
            {
            }
            column(JobNo_ProjectConsumption;"Project Consumption"."Job No.")
            {
            }
            column(ItemNo_ProjectConsumption;"Project Consumption"."Item No.")
            {
            }
            column(ItemDescription_ProjectConsumption;"Project Consumption"."Item Description")
            {
            }
            column(ItemDescription2_ProjectConsumption;"Project Consumption"."Item Description 2")
            {
            }
            column(SerialNo_ProjectConsumption;"Project Consumption"."Serial No.")
            {
            }
            column(LotNo_ProjectConsumption;"Project Consumption"."Lot No.")
            {
            }
            column(Quantity_ProjectConsumption;"Project Consumption".Quantity)
            {
            }
            column(ItemTTType_ProjectConsumption;"Project Consumption"."Item TT Type")
            {
            }
            column(LastDirectCost_ProjectConsumption;"Project Consumption"."Last Direct Cost")
            {
            }
            column(UnitPrice_ProjectConsumption;"Project Consumption"."Unit Price")
            {
            }
            column(SellingPriceProject_ProjectConsumption;"Project Consumption"."Selling Price Project")
            {
            }
            column(Employee_ProjectConsumption;"Project Consumption".Employee)
            {
            }
            column(EmployeeNo_ProjectConsumption;"Project Consumption"."Employee No.")
            {
            }
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

    var
        Site_Caption: label 'Site {0} of {1}';
        Job_Caption: label 'Job No.';
        Item_Caption: label 'Item No.';
        Description_Caption: label 'Description';
        Description2_Caption: label 'Description 2';
        SerialNo_Caption: label 'Serial No.';
        LotNo_Caption: label 'Lot No.';
        Quantity_Caption: label 'Quantity';
        ItemTTType_Caption: label 'Art';
        LastDirectCost_Caption: label 'Last Direct Cost';
        UnitPrice_Caption: label 'Change Selling Price';
        SellingPriceProject_Caption: label 'Selling Price Project';
        Employee_Caption: label 'Employee';
        EmployeeNo_Caption: label 'Employee No.';
}


Report 50036 "Artikel Barcode"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Artikel Barcode.rdlc';

    dataset
    {
        dataitem(Item; Item)
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(No_Item; Item."No.")
            {
            }
            column(Description_Item; Item.Description)
            {
            }
            column(Description2_Item; Item."Description 2")
            {
            }
            column(Barcode; '*' + Item."No." + '*')
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
}


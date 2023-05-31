#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50058 "Artikel-Seriennr_Auswertung"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Artikel-Seriennr_Auswertung.rdlc';

    dataset
    {
        dataitem("Artikel-Seriennr";"Artikel-Seriennr")
        {
            DataItemTableView = sorting("Item No.","Serial No.");
            RequestFilterFields = "Item No.";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(ItemNo_ArtikelSeriennr;"Artikel-Seriennr"."Item No.")
            {
                IncludeCaption = true;
            }
            column(SerialNo_ArtikelSeriennr;"Artikel-Seriennr"."Serial No.")
            {
                IncludeCaption = true;
            }
            column(SerialNoDescription_ArtikelSeriennr;"Artikel-Seriennr"."Serial No. Description")
            {
                IncludeCaption = true;
            }
            column(SerialNoDescription2_ArtikelSeriennr;"Artikel-Seriennr"."Serial No. Description 2")
            {
                IncludeCaption = true;
            }
            column(Description_ArtikelSeriennr;"Artikel-Seriennr".Description)
            {
                IncludeCaption = true;
            }
            column(Description2_ArtikelSeriennr;"Artikel-Seriennr"."Description 2")
            {
                IncludeCaption = true;
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
        ReportCaption = 'Item-Serial No. Evaluation';
        PageCaption = 'Page {0} of {1}';
        DateCaption = 'Date:';
    }
}


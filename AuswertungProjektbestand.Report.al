#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50059 "Auswertung Projektbestand"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Auswertung Projektbestand.rdlc';

    dataset
    {
        dataitem(Ausstattung_Posten;Ausstattung_Posten)
        {
            DataItemTableView = sorting("Lfd Nr") where(Offen=filter(true));
            RequestFilterFields = "Projekt Nr";
            column(ReportForNavId_1000000000; 1000000000)
            {
            }
            column(ProjektNr_AusstattungPosten;Ausstattung_Posten."Projekt Nr")
            {
            }
            column(MitarbeiterNr_AusstattungPosten;Ausstattung_Posten."Mitarbeiter Nr")
            {
                IncludeCaption = true;
            }
            column(ArtikelNr_AusstattungPosten;Ausstattung_Posten."Artikel Nr")
            {
                IncludeCaption = true;
            }
            column(Beschreibung_AusstattungPosten;Ausstattung_Posten.Beschreibung)
            {
                IncludeCaption = true;
            }
            column(Beschreibung2_AusstattungPosten;Ausstattung_Posten."Beschreibung 2")
            {
                IncludeCaption = true;
            }
            column(Restmenge_AusstattungPosten;Ausstattung_Posten.Restmenge)
            {
                IncludeCaption = true;
            }
            dataitem(Job;Job)
            {
                DataItemLink = "No."=field("Projekt Nr");
                DataItemTableView = sorting("No.");
                column(ReportForNavId_1000000007; 1000000007)
                {
                }
                column(Description_Job;Job.Description)
                {
                }
                column(Description2_Job;Job."Description 2")
                {
                }
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
        ReportCaption = 'Auswertung Projektbestand';
        PageCaption = 'Page {0} of {1}';
        DateCaption = 'Date:';
    }
}


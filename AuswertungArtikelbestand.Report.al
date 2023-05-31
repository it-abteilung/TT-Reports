#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50060 "Auswertung Artikelbestand"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Auswertung Artikelbestand.rdlc';

    dataset
    {
        dataitem(Item;Item)
        {
            RequestFilterFields = "No.";
            column(ReportForNavId_1000000010; 1000000010)
            {
            }
            column(No_Item;Item."No.")
            {
                IncludeCaption = true;
            }
            column(Description_Item;Item.Description)
            {
                IncludeCaption = true;
            }
            column(Description2_Item;Item."Description 2")
            {
                IncludeCaption = true;
            }
            column(AnzahlGeraete;AnzahlGeraete)
            {
            }
            dataitem(Ausstattung_Posten;Ausstattung_Posten)
            {
                DataItemLink = "Artikel Nr"=field("No.");
                DataItemTableView = where(Offen=filter(true));
                column(ReportForNavId_1000000000; 1000000000)
                {
                }
                column(ProjektNr_AusstattungPosten;Ausstattung_Posten."Projekt Nr")
                {
                    IncludeCaption = true;
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
                column(Seriennummer_AusstattungPosten;Ausstattung_Posten.Seriennummer)
                {
                    IncludeCaption = true;
                }
                column(Restmenge_AusstattungPosten;Ausstattung_Posten.Restmenge)
                {
                    IncludeCaption = true;
                }
                column(MitarbeiterName_AusstattungPosten;Ausstattung_Posten."Mitarbeiter Name")
                {
                    IncludeCaption = true;
                }
            }

            trigger OnAfterGetRecord()
            begin
                Clear(ArtikelSeriennr);
                ArtikelSeriennr.SetRange("Item No.", "No.");
                AnzahlGeraete := ArtikelSeriennr.Count;
            end;
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
        AnzahlGeraeteCaption = 'Anzahl Geräte:';
        AnzahlProjektCaption = 'Anzahl Projekt:';
        ReportCaption = 'Evaluation Equipment Entry';
        PageCaption = 'Page {0} of {1}';
        DateCaption = 'Date:';
    }

    var
        ArtikelSeriennr: Record "Artikel-Seriennr";
        AnzahlGeraete: Integer;
}


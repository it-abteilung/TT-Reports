Report 50044 "Projekt Packliste"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Projekt Packliste.rdlc';

    dataset
    {
        dataitem("Projekt Packliste"; "Projekt Packliste")
        {
            DataItemTableView = sorting("Projektnr.", "Zeilennr.");
            column(Projektnr_ProjektPackliste; "Projekt Packliste"."Projektnr.")
            {
                IncludeCaption = true;
            }
            column(Projektnummer_Barcode; '*' + "Projektnr." + '*')
            {
            }
            column(Artikelnr_ProjektPackliste; "Projekt Packliste"."Artikelnr.")
            {
                IncludeCaption = true;
            }
            column(Artikelnr_Barcode; '*' + "Artikelnr." + '*')
            {
            }
            column(Menge_ProjektPackliste; "Projekt Packliste".Menge)
            {
                IncludeCaption = true;
            }
            column(Beschreibung_ProjektPackliste; "Projekt Packliste".Beschreibung)
            {
                IncludeCaption = true;
            }
            column(Beschreibung2_ProjektPackliste; "Projekt Packliste"."Beschreibung 2")
            {
            }
            column(Reparaturleiter_ProjektPackliste; "Projekt Packliste".Reparaturleiter)
            {
            }
            column(ReparaturleiterName_ProjektPackliste; "Projekt Packliste"."Reparaturleiter Name")
            {
            }
            column(Description_JobRec; JobRec.Description)
            {
            }

            trigger OnAfterGetRecord()
            begin
                JobRec.Get("Projekt Packliste"."Projektnr.");
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

    var
        JobRec: Record Job;
}


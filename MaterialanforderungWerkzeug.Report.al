Report 50065 "Materialanforderung Werkzeug"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Materialanforderung Werkzeug.rdlc';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem(SingleRowDataItem; "Integer")
        {
            DataItemTableView = sorting(Number) where(Number = const(1));
            column(Picture_CompanyInformation; CompanyInformation.Picture)
            {
            }

            trigger OnAfterGetRecord()
            begin
                CompanyInformation.CalcFields(Picture);
            end;
        }
        dataitem(Materialanforderungskopf; Materialanforderungskopf)
        {
            DataItemTableView = sorting("Projekt Nr", "Lfd Nr") order(ascending);
            RequestFilterFields = "Projekt Nr", "Lfd Nr";
            RequestFilterHeading = 'Materialanforderung Filter';
            column(Kopf_ProjektNr; Materialanforderungskopf."Projekt Nr")
            {
            }
            column(Kopf_LfdNr; Materialanforderungskopf."Lfd Nr")
            {
            }
            column(Kopf_Stichwort; Materialanforderungskopf.Stichwort)
            {
            }
            dataitem(Materialanforderungzeile; Materialanforderungzeile)
            {
                DataItemLink = "Projekt Nr" = field("Projekt Nr"), "Lfd Nr" = field("Lfd Nr");
                DataItemLinkReference = Materialanforderungskopf;
                DataItemTableView = sorting("Projekt Nr", "Lfd Nr", "Zeilen Nr") order(ascending) where(Abgehakt = const(false));
                column(ProjektNr_Materialanforderung; Materialanforderungzeile."Projekt Nr")
                {
                }
                column(ArtikelNr_Materialanforderung; Materialanforderungzeile."Artikel Nr")
                {
                }
                column(Beschreibung_Materialanforderung; Materialanforderungzeile.Beschreibung)
                {
                }
                column(Beschreibung2_Materialanforderung; Materialanforderungzeile."Beschreibung 2")
                {
                }
                column(Menge_Materialanforderung; Materialanforderungzeile.Menge)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Barcode; '*' + Materialanforderungzeile."Artikel Nr" + '*')
                {
                }
                dataitem(Job; Job)
                {
                    DataItemLink = "No." = field("Projekt Nr");
                    DataItemTableView = sorting("No.");
                    column(Reparaturort_Job; Job.Reparaturort)
                    {
                    }
                    column(Objektname_Job; Job.Objektname)
                    {
                    }
                    column(Reparaturleiter_Job; Job.Reparaturleiter)
                    {
                    }
                    column(StartingDate_Job; Job."Starting Date")
                    {
                    }
                    column(EndingDate_Job; Job."Ending Date")
                    {
                    }
                }
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
        HeaderCaption = 'Anforderungsliste für';
        Header2Caption = 'Geräte / Kleingeräte / Werkzeuge';
        ArbeitsanweisungUeberschriftCaption = 'Arbeitsanweisung!';
        Arbeitsanweisung1Caption = 'Der Aussteller ist für die vollständige Auflistung aller für die Durchführung dieses Auftrages erforderlichen';
        Arbeitsanweisung2Caption = 'Geräte / Kleingeräte / Werkzeuge verantwortlich. Jede einzelne Position ist vor dem Verpacken durch den';
        Arbeitsanweisung3Caption = 'verpackenden Mitarbeiter auf Vollzähligkeit und Funktionstüchtigkeit zu überprüfen. Dieses ist durch seine';
        Arbeitsanweisung4Caption = 'Unterschrift zu bestätigen.';
        Arbeitsanweisung5Caption = 'Nach dem Packen erhalten jeweils eine Kopie: KE / TL / KA / Aussteller.';
        PageCaption = 'Seite {0} von {1}';
        AuftragsnummerCaption = 'Auftragsnummer';
        ReparaturleiterCaption = 'Reparaturleiter';
        SchiffCaption = 'Schiff';
        Liegeplatz_ReparaturortCaption = 'Liegeplatz / Reparaturort';
        ReparaturbeginnCaption = 'Reparaturbeginn';
        FertigstellungCaption = 'Fertigstellung';
        Abholung_TransportCaption = 'Abholung/Transport:';
        TransportmittelCaption = 'Transportmittel:';
        WeitertransportCaption = 'Weitertransport:';
        VerpackungCaption = 'Verpackung:';
        amCaption = 'am:';
        durchCaption = 'durch:';
        vonCaption = 'von:';
        nachCaption = 'nach:';
        LKWCaption = '[ ] LKW';
        SeefrachtCaption = '[ ] Seefracht';
        LuftfrachtCaption = '[ ] Luftfracht';
        QuadratCaption = '[ ]';
        KisteCaption = '[ ] Kiste';
        VerschlagCaption = '[ ] Verschlag';
        ContainerCaption = '[ ] Container';
        unvepacktCaption = '[ ] unverpackt';
        AnzahlCaption = 'Anzahl';
        GenaueBezeichnungCaption = 'Genaue Bezeichnung';
        gepacktCaption = 'gepackt';
        ErstellerCaption = 'Ersteller';
        DatumUnterschriftCaption = 'Datum, Unterschrift';
        BarcodeCaption = 'Barcode';
    }

    var
        CompanyInformation: Record "Company Information";
}


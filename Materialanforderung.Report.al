Report 50030 Materialanforderung
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Materialanforderung.rdlc';

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
        dataitem(Materialanforderungzeile; Materialanforderungzeile)
        {
            DataItemTableView = where(Abgehakt = const(false));
            RequestFilterFields = "Projekt Nr";
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
            }
            column(lfdnr_Materialanforderung; Materialanforderungzeile."Lfd Nr")
            {
            }
            column(Einheit_Materialanforderung; Materialanforderungzeile.Einheit)
            {
            }
            column(Liefertermin_Materialanforderung; Materialanforderungzeile.Liefertermin)
            {
            }
            column(Zusatzanforderung_Materialanforderung; Materialanforderungzeile."zusätzliche Anforderungen")
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
                column(CustomerNo_Job; Job."Bill-to Customer No.")
                {
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
        lblZusatzanforderung = 'zusätzliche Anforderungen';
        lblLiefertermin = 'Liefertermin';
        lblDescription1 = 'Beschreibung 1';
        lblDescription2 = 'Beschreibung 2';
    }

    var
        CompanyInformation: Record "Company Information";
}


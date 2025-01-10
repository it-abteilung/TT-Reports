Report 50066 "Werkzeuganforderung Werkzeug"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Werkzeuganforderung Werkzeug.rdlc';
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
        dataitem(Werkzeuganforderungskopf; Werkzeuganforderungskopf)
        {
            DataItemTableView = sorting("Projekt Nr", "Lfd Nr") order(ascending);
            RequestFilterFields = "Projekt Nr", "Lfd Nr";
            RequestFilterHeading = 'Materialanforderung Filter';
            column(Kopf_ProjektNr; "Projekt Nr")
            {
            }
            column(Kopf_LfdNr; "Lfd Nr")
            {
            }
            column(Kopf_Stichwort; Stichwort)
            {
            }
            column(Kopf_Reparaturort; Reparaturort)
            {
            }
            column(Kopf_Objektname; Schiff)
            {
            }
            column(Kopf_Reparaturleiter; RessourceReparaturleiter.Name)
            {
            }
            column(Kopf_StartingDate; Reparaturbeginn)
            {
            }
            column(Kopf_EndingDate; Reparaturende)
            {
            }
            column(Kopf_Fertigstellung; Fertigstellung)
            {
            }
            column(Kopf_AbholungAm; "Abholung am")
            {
            }
            column(Kopf_AbholungDurch; RessourceAbholung.Name)
            {
            }
            column("Kopf_SchweißzusätzeAm"; "Freigabe Schweißzusätze am")
            {
            }
            column("Kopf_SchweißzusätzeDurch"; "RessourceSchweißzusaetzeDurch".Name)
            {
            }
            column(Kopf_TransportLKW; "Transport LKW")
            {
            }
            column(Kopf_TransportSeefracht; "Transport Seefracht")
            {
            }
            column(Kopf_TransportLuftfracht; "Transport Luftfracht")
            {
            }
            column(Kopf_TransportSonstig; "Transport Sonstig")
            {
            }
            column(Kopf_TransportSonstigText; "Transport Sonstig Text")
            {
            }
            column(SortItems; SortItems)
            {
            }
            column(OrderBy; format(OrderBy, 0, 2))
            {
            }
            dataitem(Werkzeuganforderungzeile; Werkzeuganforderungzeile)
            {
                DataItemLink = "Projekt Nr" = field("Projekt Nr"), "Lfd Nr" = field("Lfd Nr");
                DataItemLinkReference = Werkzeuganforderungskopf;
                DataItemTableView = sorting("Projekt Nr", "Lfd Nr", "Zeilen Nr") order(ascending) where(Abgehakt = const(false));
                column(Zeilen_ProjektNr; "Projekt Nr")
                {
                }
                column(Zeilen_ArtikelNr; "Artikel Nr")
                {
                }
                column(Zeilen_ZeilenNr; "Zeilen Nr")
                {
                }
                column(Zeilen_Beschreibung; Beschreibung)
                {
                }
                column(Zeilen_Beschreibung2; "Beschreibung 2")
                {
                }
                column(Zeilen_Menge; Menge)
                {
                    DecimalPlaces = 0 : 0;
                }
                column(Zeilen_Einheit; Einheit)
                {
                }
                column(Zeilen_Barcode; '%90' + "Artikel Nr")
                {
                }
                column(Barcode_Artikel; ArtikelBarcode)
                {
                }
                column(Item_ArtikelKategorie; Item_g."Item Category Code")
                {
                }
                column(BinCode1; BinCode[1])
                {
                }
                column(BinCode2; BinCode[2])
                {
                }
                column(BinCode3; BinCode[3])
                {
                }
                column(Delta; Delta)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    begin
                        BarcodeFontProvider := Enum::"Barcode Font Provider 2D"::IDAutomation2D;
                        BarcodeSymbology := Enum::"Barcode Symbology 2D"::"Data Matrix";
                        BarcodeString := Werkzeuganforderungzeile."Artikel Nr";
                        ArtikelBarcode := BarcodeFontProvider.EncodeFont(BarcodeString, BarcodeSymbology);
                    end;

                    //G-ERP.RS 2021-03-31 + 01
                    Clear(Item_g);
                    if Item_g.Get("Artikel Nr") then;
                    //G-ERP.RS 2021-03-31 - 01

                    // AC01 B
                    CLEAR(BinCode);
                    CLEAR(BinQty);
                    BinContent.SETCURRENTKEY("Location Code", "Item No.", "Variant Code", "Warehouse Class Code", Fixed, "Bin Ranking");
                    BinContent.SETRANGE("Location Code", 'WHV');
                    BinContent.SETRANGE("Item No.", "Artikel Nr");
                    BinContent.SETFILTER("Bin Code", 'C*');
                    BinContent.SETFILTER("Quantity (Base)", '<>%1', 0);
                    IF BinContent.FINDSET THEN BEGIN
                        FOR i := 1 TO 3 DO BEGIN
                            IF i > 1 THEN BEGIN
                                IF (BinContent."Bin Code" <> BinCode[1]) AND (BinContent."Bin Code" <> BinCode[2]) THEN BEGIN
                                    BinCode[i] := BinContent."Bin Code";
                                    BinQty[i] := BinContent.CalcQtyBase;
                                END;
                            END ELSE BEGIN
                                BinCode[i] := BinContent."Bin Code";
                                BinQty[i] := BinContent.CalcQtyBase;
                            END;
                            BinContent.NEXT;
                        END;

                        BinCodeSave := '';
                        IF (BinQty[2] > BinQty[1]) AND (BinQty[2] > BinQty[3]) THEN BEGIN
                            BinCodeSave := BinCode[1];
                            BinCode[1] := BinCode[2];
                            BinCode[2] := BinCodeSave;
                        END ELSE BEGIN
                            IF (BinQty[3] > BinQty[1]) AND (BinQty[3] > BinQty[2]) THEN BEGIN
                                BinCodeSave := BinCode[1];
                                BinCode[1] := BinCode[3];
                                BinCode[3] := BinCodeSave;
                            END;
                        END;
                    END;
                end;
                // AC01 E
            }

            trigger OnAfterGetRecord()
            begin
                if RessourceReparaturleiter.Get(Werkzeuganforderungskopf.Reparaturleiter) then;
                if "RessourceSchweißzusaetzeDurch".Get(Werkzeuganforderungskopf."Freigabe Schweißzusätze durch") then;
                if RessourceAbholung.Get(Werkzeuganforderungskopf."Abholung durch") then;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(Orderby; OrderBy)
                    {
                        ApplicationArea = All;
                        Caption = 'Order By';
                        OptionCaption = 'Bin Content,Line No.,Description';
                    }
                }
            }
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
        StichwortCaption = 'Stichwort';
        SchiffCaption = 'Schiff/Objekt';
        Liegeplatz_ReparaturortCaption = 'Liegeplatz / Reparaturort';
        ReparaturbeginnCaption = 'Reparaturbeginn';
        ReparaturendeCaption = 'Reparaturende';
        FertigstellungCaption = 'Fertigstellung Werkzeuge Lager';
        FreigabeSchweißzusätzeCaption = 'Freigabe Schweißzusätze:';
        Abholung_TransportCaption = 'Abholung/Transport:';
        TransportmittelCaption = 'Transportmittel:';
        WeitertransportCaption = 'Weitertransport:';
        VerpackungCaption = 'Verpackung:';
        amCaption = 'am:';
        durchCaption = 'durch:';
        vonCaption = 'von:';
        nachCaption = 'nach:';
        LKWCaption = '[ ] LKW';
        LKWXCaption = '[X] LKW';
        SeefrachtCaption = '[ ] Seefracht';
        SeefrachtXCaption = '[X] Seefracht';
        LuftfrachtCaption = '[ ] Luftfracht';
        LuftfrachtXCaption = '[X] Luftfracht';
        QuadratCaption = '[ ]';
        QuadratXCaption = '[X]';
        KisteCaption = '[ ] Kiste';
        VerschlagCaption = '[ ] Verschlag';
        ContainerCaption = '[ ] Container';
        unvepacktCaption = '[ ] unverpackt';
        AnzahlCaption = 'Anzahl';
        EinheitCaption = 'Einheit';
        GenaueBezeichnungCaption = 'Genaue Bezeichnung';
        gepacktCaption = 'gepackt';
        ErstellerCaption = 'Ersteller';
        DatumUnterschriftCaption = 'Datum, Unterschrift';
        BarcodeCaption = 'Barcode';
        BinCodeCaption = 'Lagerplätze';
        DeltaCaption = 'Unterdeckung';
    }

    var
        CompanyInformation: Record "Company Information";
        RessourceAbholung: Record Resource;
        RessourceReparaturleiter: Record Resource;
        "RessourceSchweißzusaetzeDurch": Record Resource;
        Item_g: Record Item;
        BarcodeString: Text;
        BarcodeSymbology: Enum "Barcode Symbology 2D";
        BarcodeFontProvider: Interface "Barcode Font Provider 2D";
        ArtikelBarcode: Text;
        SortItems: Boolean;
        SortBins: Boolean;
        BinContent: Record "Bin Content";
        i: Integer;
        BinCode: array[3] of Code[20];
        BinQty: array[3] of Decimal;
        BinCodeSave: Code[20];
        OrderBy: Option "Bin Content","Line No.","Description";

}


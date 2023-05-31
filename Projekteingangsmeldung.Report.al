#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50012 Projekteingangsmeldung
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Projekteingangsmeldung.rdlc';

    dataset
    {
        dataitem(Job;Job)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.";
            column(ReportForNavId_8019; 8019)
            {
            }
            column(CompanyInfo_Picture;CompanyInfo.Picture)
            {
            }
            column(Object_________ObjectRec_Description;Object + ' ' + ObjectRec.Description)
            {
            }
            column(Job__No__;"No.")
            {
            }
            column(ObjectRec_Type;ObjectRec.Type)
            {
            }
            column(ObjectRec_Class;ObjectRec.Class)
            {
            }
            column(CustAddr_6_;CustAddr[6])
            {
            }
            column(CustAddr_5_;CustAddr[5])
            {
            }
            column(CustAddr_4_;CustAddr[4])
            {
            }
            column(CustAddr_3_;CustAddr[3])
            {
            }
            column(CustAddr_2_;CustAddr[2])
            {
            }
            column(CustAddr_1_;CustAddr[1])
            {
            }
            column(CustomerRec__Phone_No__;CustomerRec."Phone No.")
            {
            }
            column(CustomerRec__Fax_No__;CustomerRec."Fax No.")
            {
            }
            column(CustomerRec__E_Mail_;CustomerRec."E-Mail")
            {
            }
            column(ContactRec__E_Mail_;ContactRec."E-Mail")
            {
            }
            column(Kontaktname;Kontaktname)
            {
            }
            column(ContactRec__Phone_No__;ContactRec."Phone No.")
            {
            }
            column(ContactRec__Fax_No__;ContactRec."Fax No.")
            {
            }
            column(ContactRec__Mobile_Phone_No__;ContactRec."Mobile Phone No.")
            {
            }
            column(Job__Anfrage_von_;"Anfrage von")
            {
            }
            column(Job__Anfrage_am_;"Anfrage am")
            {
            }
            column(Job__Anfrage_per_;"Anfrage per")
            {
            }
            column(Job__Angebotsabgabe_bis_;"Angebotsabgabe bis")
            {
            }
            column(Job__Angebotsabgabe_durch_;"Angebotsabgabe durch")
            {
            }
            column(Job__External_Document_No__;"External Document No.")
            {
            }
            column(PaymentTerms_Description;PaymentTerms.Description)
            {
            }
            column("Job__Anfrage_über_";"Anfrage über")
            {
            }
            column(Agenturadresse_2_;Agenturadresse[2])
            {
            }
            column(Agenturadresse_3_;Agenturadresse[3])
            {
            }
            column(Agenturadresse_4_;Agenturadresse[4])
            {
            }
            column(Agenturadresse_5_;Agenturadresse[5])
            {
            }
            column(Agenturadresse_6_;Agenturadresse[6])
            {
            }
            column(ContactRecAgentur__Fax_No__;ContactRecAgentur."Fax No.")
            {
            }
            column(ContactRecAgentur__E_Mail_;ContactRecAgentur."E-Mail")
            {
            }
            column(Job__Agenturperson_Name_;"Agenturperson Name")
            {
            }
            column(Agenturadresse_1_;Agenturadresse[1])
            {
            }
            column(ContactRecAgentur__Phone_No__;ContactRecAgentur."Phone No.")
            {
            }
            column(AgenturdatenDrucken;AgenturdatenDrucken)
            {
            }
            column(FORMAT__Starting_Date_____________FORMAT__Ending_Date__;Format("Starting Date") + ' - ' + Format("Ending Date"))
            {
            }
            column(Job_Reparaturort;Reparaturort)
            {
            }
            column(VerfasserName;VerfasserName)
            {
            }
            column(ProjekteingangsmeldungCaption;ProjekteingangsmeldungCaptionLbl)
            {
            }
            column(REPARATUR_WERFTCaption;REPARATUR_WERFTCaptionLbl)
            {
            }
            column(Schiff___Objekt_Caption;Schiff___Objekt_CaptionLbl)
            {
            }
            column(Projekt_Nr__Caption;Projekt_Nr__CaptionLbl)
            {
            }
            column(Typ_Caption;Typ_CaptionLbl)
            {
            }
            column(Klasse_Caption;Klasse_CaptionLbl)
            {
            }
            column(Kunde_Caption;Kunde_CaptionLbl)
            {
            }
            column(Tel__Nr__Caption;Tel__Nr__CaptionLbl)
            {
            }
            column(Fax_Nr__Caption;Fax_Nr__CaptionLbl)
            {
            }
            column(eMail_Caption;eMail_CaptionLbl)
            {
            }
            column(Ansprechpartner_Caption;Ansprechpartner_CaptionLbl)
            {
            }
            column(Tel__Nr__Caption_Control1140031;Tel__Nr__Caption_Control1140031Lbl)
            {
            }
            column(Fax_Nr__Caption_Control1140033;Fax_Nr__Caption_Control1140033Lbl)
            {
            }
            column(eMail_Caption_Control1140034;eMail_Caption_Control1140034Lbl)
            {
            }
            column(Mobil_Nr__Caption;Mobil_Nr__CaptionLbl)
            {
            }
            column(Anfrage_von_Caption;Anfrage_von_CaptionLbl)
            {
            }
            column(am_Caption;am_CaptionLbl)
            {
            }
            column(per_Caption;per_CaptionLbl)
            {
            }
            column(Angebotsabgabe_bis_Caption;Angebotsabgabe_bis_CaptionLbl)
            {
            }
            column(durch_Caption;durch_CaptionLbl)
            {
            }
            column("Anfrage_über__Gegenstand_Beschreibung_Arbeitsbezeichnung_Leistungsumfang__Caption";Anfrage_über__Gegenstand_Beschreibung_Arbeitsbezeichnung_Leistungsumfang__CaptionLbl)
            {
            }
            column(Externe_Belegnr__Caption;Externe_Belegnr__CaptionLbl)
            {
            }
            column(Kunde_Kontaktdaten_Caption;Kunde_Kontaktdaten_CaptionLbl)
            {
            }
            column(Ansprechpartner_Kontaktdaten_Caption;Ansprechpartner_Kontaktdaten_CaptionLbl)
            {
            }
            column(Zahlungsbedingungen_Caption;Zahlungsbedingungen_CaptionLbl)
            {
            }
            column(Besonders_zu_beachten_Caption_0815;Besonders_zu_beachten_Caption_0815Lbl)
            {
            }
            column(Fax_Nr__Caption_Control1140069;Fax_Nr__Caption_Control1140069Lbl)
            {
            }
            column(eMail_Caption_Control1140070;eMail_Caption_Control1140070Lbl)
            {
            }
            column(Person_Caption;Person_CaptionLbl)
            {
            }
            column(Agentur_Caption;Agentur_CaptionLbl)
            {
            }
            column(Tel__Caption;Tel__CaptionLbl)
            {
            }
            column(Zeitraum_Caption;Zeitraum_CaptionLbl)
            {
            }
            column(Reparaturort_Caption;Reparaturort_CaptionLbl)
            {
            }
            column(Verfasser_Caption;Verfasser_CaptionLbl)
            {
            }
            column(Anfrageueber1;"Projekt-Notizen"."Anfrage über1")
            {
            }
            column(Anfrageueber2;"Projekt-Notizen"."Anfrage über2")
            {
            }
            column(Anfrageueber3;"Projekt-Notizen"."Anfrage über3")
            {
            }
            column(Besonders_zu_beachten_Caption;Besonders_zu_beachten_CaptionLbl)
            {
            }
            column(Zubeachten1;"Projekt-Notizen"."Zu beachten1")
            {
            }
            column(Zubeachten2;"Projekt-Notizen"."Zu beachten2")
            {
            }
            column(Zubeachten3;"Projekt-Notizen"."Zu beachten3")
            {
            }
            column(Job_CreationDate;Job."Creation Date")
            {
            }

            trigger OnAfterGetRecord()
            var
                LandCode: Code[10];
                l_Contact: Record Contact;
                i: Integer;
            begin
                Clear("Projekt-Notizen");
                if "Projekt-Notizen".Get("No.") then;
                
                Clear(ObjectRec);
                if ObjectRec.Get('SCHIFF',Object) then;
                
                Clear(PaymentTerms);
                Clear(CustomerRec);
                if CustomerRec.Get("Bill-to Customer No.") then begin
                  if CustomerRec."Payment Terms Code" = '' then
                    PaymentTerms.Init
                  else begin
                    PaymentTerms.Get(CustomerRec."Payment Terms Code");
                    PaymentTerms.TranslateDescription(PaymentTerms,"Language Code");
                  end;
                end;
                /*
                CLEAR(SalesInvoiceHeader);
                CALCFIELDS("Sell-to Customer Name","Sell-to Customer Name 2","Sell-to Address",
                           "Sell-to Address 2","Sell-to City","Sell-to Post Code");
                SalesInvoiceHeader."Bill-to Name" := "Sell-to Customer Name";
                SalesInvoiceHeader."Bill-to Name 2" := "Sell-to Customer Name 2";
                SalesInvoiceHeader."Bill-to Address" := "Sell-to Address";
                SalesInvoiceHeader."Bill-to Address 2" := "Sell-to Address 2";
                SalesInvoiceHeader."Bill-to City" := "Sell-to City";
                SalesInvoiceHeader."Bill-to Post Code" := "Sell-to Post Code";
                */
                Clear(SalesInvoiceHeader);
                SalesInvoiceHeader."Bill-to Name" := "Bill-to Name";
                SalesInvoiceHeader."Bill-to Name 2" := "Bill-to Name 2";
                SalesInvoiceHeader."Bill-to Address" := "Bill-to Address";
                SalesInvoiceHeader."Bill-to Address 2" := "Bill-to Address 2";
                SalesInvoiceHeader."Bill-to City" := "Bill-to City";
                SalesInvoiceHeader."Bill-to Post Code" := "Bill-to Post Code";
                FormatAddr.SalesInvBillTo(CustAddr,SalesInvoiceHeader);
                
                Clear(ContactRec);
                //IF ContactRec.GET("Contact Person No.") THEN;
                if ContactRec.Get(Job."Bill-to Contact No.") then;
                
                Clear(ResourceRec);
                if ResourceRec.Get(Job.Verfasser) then
                  VerfasserName := ResourceRec.Name
                else
                  VerfasserName := '';
                
                //Ergänzung Übernahme des Anredecodes für Job."Contact Person Name"
                Job.CalcFields("Contact Person Name");
                Kontaktname := Job."Contact Person Name";
                if l_Contact.Get(Job."Contact Person No.") then begin
                  if l_Contact.Name = Kontaktname then begin
                    if "Language Code" = '' then
                      LandCode := 'DEU'
                    else
                      LandCode := "Language Code";
                    //Kontaktname := ContactRec.CalculateSalutationName(Job."Contact Person No.",LandCode,0);
                    if Kontaktname = '' then
                      Kontaktname := Job."Contact Person Name";
                  end;
                end;
                Kontaktname := Job."Bill-to Contact";
                //Agentur soll mit vollständiger Adresse angedruckt werden
                AgenturdatenDrucken := false;
                Clear(Agenturadresse);
                if Job.Agentur <> '' then begin
                  if ContactRecAgentur.Get(Job.Agentur) then begin
                    AgenturdatenDrucken := true;
                    Agenturadresse[1] := ContactRecAgentur.Name;
                    i := 2;
                    if ContactRecAgentur."Name 2" <> '' then begin
                      Agenturadresse[i] := ContactRecAgentur."Name 2";
                      i += 1;
                    end;
                    Agenturadresse[i] := ContactRecAgentur.Address;
                    i += 1;
                    if ContactRecAgentur."Address 2" <> '' then begin
                      Agenturadresse[i] := ContactRecAgentur."Address 2";
                      i += 1;
                    end;
                    Agenturadresse[i] := ContactRecAgentur."Post Code" + ' ' + ContactRecAgentur.City;
                    i += 1;
                //03.01.2012    ContactRecAgentur.CALCFIELDS(ContactRecAgentur.Ländername);
                //03.01.2012    Agenturadresse[i] := ContactRecAgentur.Ländername;
                  end;
                end;

            end;

            trigger OnPreDataItem()
            begin
                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture,"Picture 1","Picture 2");
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
        ErstelltAmCaption = 'Erstellt am:';
    }

    var
        ObjectRec: Record "Multi Table";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        CustomerRec: Record Customer;
        ContactRec: Record Contact;
        CompanyInfo: Record "Company Information";
        FormatAddr: Codeunit "Format Address";
        CustAddr: array [8] of Text[50];
        Beschr: Text[152];
        ResourceRec: Record Resource;
        VerfasserName: Text[50];
        Kontaktname: Text[50];
        ContactRecAgentur: Record Contact;
        AgenturdatenDrucken: Boolean;
        PaymentTerms: Record "Payment Terms";
        Agenturadresse: array [6] of Text[80];
        IStream: InStream;
        IStream2: InStream;
        HTML_Text: array [10] of Text[1024];
        HTML_Text2: array [10] of Text[1024];
        HTML: BigText;
        HTML2: BigText;
        i: Integer;
        ProjekteingangsmeldungCaptionLbl: label 'Projekteingangsmeldung';
        REPARATUR_WERFTCaptionLbl: label 'REPAIRYARD';
        Schiff___Objekt_CaptionLbl: label 'Schiff / Objekt:';
        Projekt_Nr__CaptionLbl: label 'Projekt-Nr.:';
        Typ_CaptionLbl: label 'Typ:';
        Klasse_CaptionLbl: label 'Klasse:';
        Kunde_CaptionLbl: label 'Kunde:';
        Tel__Nr__CaptionLbl: label 'Tel.-Nr.:';
        Fax_Nr__CaptionLbl: label 'Fax-Nr.:';
        eMail_CaptionLbl: label 'eMail:';
        Ansprechpartner_CaptionLbl: label 'Ansprechpartner:';
        Tel__Nr__Caption_Control1140031Lbl: label 'Tel.-Nr.:';
        Fax_Nr__Caption_Control1140033Lbl: label 'Fax-Nr.:';
        eMail_Caption_Control1140034Lbl: label 'eMail:';
        Mobil_Nr__CaptionLbl: label 'Mobil-Nr.:';
        Anfrage_von_CaptionLbl: label 'Anfrage von:';
        am_CaptionLbl: label 'am:';
        per_CaptionLbl: label 'per:';
        Angebotsabgabe_bis_CaptionLbl: label 'Angebotsabgabe bis:';
        durch_CaptionLbl: label 'durch:';
        "Anfrage_über__Gegenstand_Beschreibung_Arbeitsbezeichnung_Leistungsumfang__CaptionLbl": label 'Anfrage über (Gegenstand/Beschreibung/Arbeitsbezeichnung/Leistungsumfang):';
        Externe_Belegnr__CaptionLbl: label 'Externe Belegnr.:';
        Kunde_Kontaktdaten_CaptionLbl: label 'Kunde-Kontaktdaten:';
        Ansprechpartner_Kontaktdaten_CaptionLbl: label 'Ansprechpartner-Kontaktdaten:';
        Zahlungsbedingungen_CaptionLbl: label 'Zahlungsbedingungen:';
        Besonders_zu_beachten_Caption_0815Lbl: label 'Besonders zu beachten:';
        Fax_Nr__Caption_Control1140069Lbl: label 'Fax-Nr.:';
        eMail_Caption_Control1140070Lbl: label 'eMail:';
        Person_CaptionLbl: label 'Person:';
        Agentur_CaptionLbl: label 'Agentur:';
        Tel__CaptionLbl: label 'Tel.:';
        Zeitraum_CaptionLbl: label 'Zeitraum:';
        Reparaturort_CaptionLbl: label 'Reparaturort:';
        Verfasser_CaptionLbl: label 'Person Author';
        Besonders_zu_beachten_CaptionLbl: label 'Besonders zu beachten:';
        "Projekt-Notizen": Record "Projekt-Notizen";


    procedure ohneHTML(var inText: Text[1024];Suchwort: Text[250])
    begin
        if StrPos(inText, Suchwort) <> 0 then
          begin
            repeat
              inText := DelStr(inText, StrPos(inText, Suchwort), StrLen(Suchwort));
            until StrPos(inText, Suchwort) = 0;
          end;
    end;
}


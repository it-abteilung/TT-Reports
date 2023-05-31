#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50052 "Austattungsposten füllen"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Ausstattung_Posten;Ausstattung_Posten)
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if Ausstattung_Posten.Buchungsdatum = 0DT then begin
                  Ausstattung_Posten.Buchungsdatum := CreateDatetime(20170815D, 150000T);
                  Ausstattung_Posten.Modify;
                end;
            end;

            trigger OnPostDataItem()
            begin
                Message('Abgeschlossen');
            end;

            trigger OnPreDataItem()
            begin
                Ausstattung_Posten.SetRange(Buchungsdatum, 0DT);
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
}


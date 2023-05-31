#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50050 "Korrektur Seriennr"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Ausstattung_Posten;Ausstattung_Posten)
        {
            DataItemTableView = sorting("Artikel Nr",Seriennummer);
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(Ausstattung_PostenRec);
                Ausstattung_PostenRec.SetRange("Artikel Nr",Ausstattung_Posten."Artikel Nr");
                Ausstattung_PostenRec.SetRange(Seriennummer,Ausstattung_Posten.Seriennummer);
                Ausstattung_PostenRec.SetRange(Offen,true);
                if Ausstattung_PostenRec.Count > 1 then begin
                  Ausstattung_PostenRec.FindFirst;
                  Ausstattung_PostenRec.Next;
                  LfdNrBuchen += 1;
                  Ausstattung_PostenRecneu := Ausstattung_Posten;
                  Ausstattung_PostenRecneu."Lfd Nr" := LfdNrBuchen;
                  Ausstattung_PostenRecneu.Offen := false;
                  Ausstattung_PostenRecneu.Postenart := 'RÜCKGABE';
                  Ausstattung_PostenRecneu.Menge := -Ausstattung_Posten.Menge;
                  Ausstattung_PostenRecneu.Restmenge := 0;
                  Ausstattung_PostenRecneu.Buchungsdatum := Ausstattung_PostenRec.Buchungsdatum;
                  Ausstattung_PostenRecneu.Insert;
                  Ausstattung_Posten.Restmenge := 0;
                  Ausstattung_Posten.Offen := false;
                  Ausstattung_Posten.Modify;
                end;
            end;

            trigger OnPreDataItem()
            begin
                //Ausstattung_Posten.SETRANGE("Artikel Nr",'400097');
                Ausstattung_Posten.SetFilter(Seriennummer,'<> %1','');
                //Ausstattung_Posten.SETRANGE(Seriennummer,'0002');

                Ausstattung_Posten.SetRange(Offen,true);
                Clear(Ausstattung_PostenRec);
                if Ausstattung_PostenRec.FindLast then
                  LfdNrBuchen := Ausstattung_PostenRec."Lfd Nr"
                else
                  LfdNrBuchen := 0;
                Clear(Ausstattung_PostenRec);
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
        Ausstattung_PostenRec: Record Ausstattung_Posten;
        Ausstattung_PostenRecneu: Record Ausstattung_Posten;
        LfdNrBuchen: Integer;
}


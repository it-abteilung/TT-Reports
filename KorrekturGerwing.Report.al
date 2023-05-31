#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50020 "Korrektur Gerwing"
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
                if Offen and (Restmenge < 0) then begin
                  Restmenge := 0;
                  Offen := false;
                  Modify;
                end;
                if Offen then begin
                  Clear(AusstattungPosten2);
                  AusstattungPosten2.SetRange("Artikel Nr","Artikel Nr");
                  AusstattungPosten2.SetRange(Seriennummer,Seriennummer);
                  AusstattungPosten2.SetRange(Offen,true);
                  if AusstattungPosten2.FindLast then begin
                    if AusstattungPosten2."Lfd Nr" <> "Lfd Nr" then begin
                      Restmenge := 0;
                      Offen := false;
                      Modify;
                    end;
                  end;
                end;
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
        AusstattungPosten2: Record Ausstattung_Posten;
}


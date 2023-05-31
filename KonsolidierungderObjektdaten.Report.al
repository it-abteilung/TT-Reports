#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50021 "Konsolidierung der Objektdaten"
{
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Nummernwahl)
                {
                    field("Alte Nr.";AlteNr)
                    {
                        ApplicationArea = Basic;
                        TableRelation = "Multi Table".Code where (Kennzeichen=const('SCHIFF'));
                    }
                    field("Neue Nr.";NeueNr)
                    {
                        ApplicationArea = Basic;
                        TableRelation = "Multi Table".Code where (Kennzeichen=const('SCHIFF'));
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        if AlteNr = '' then
          Error('Bitte alte Nr. eingeben');
        if NeueNr = '' then
          Error('Bitte neue Nr. eingeben');

        Objekt.Get('SCHIFF', AlteNr);
        Objekt2.Get('SCHIFF', NeueNr);

        Job.SetRange(Object, AlteNr);
        if Job.FindSet then
          repeat
            Job.Validate(Object, NeueNr);
            Job.Modify;
          until Job.Next = 0;

        Objekt.Delete;
    end;

    var
        Objekt: Record "Multi Table";
        Objekt2: Record "Multi Table";
        Job: Record Job;
        AlteNr: Code[20];
        NeueNr: Code[20];
}


report 60001 "Change Job Status"
{
    Caption = 'Job Status ändern (Echtstart)';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Job; Job)
        {
            DataItemTableView = where(Status = const(Invoiced));
            trigger OnAfterGetRecord()
            begin
                if Status = Status::Invoiced then begin
                    Status := Status::Planning;
                    Modify();
                end;
            end;
        }
    }
}
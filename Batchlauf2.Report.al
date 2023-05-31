#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50011 "Batchlauf 2"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Resource;Resource)
        {
            column(ReportForNavId_1000000000; 1000000000)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if (StrLen("No.") = 5) and ((CopyStr("No.",1,1) = '2') or (CopyStr("No.",1,1) = '3')) then begin
                  EmployeeRec."No." := "No.";
                  EmployeeRec."Last Name" := Name;
                  EmployeeRec."Search Name" := "Search Name";
                  EmployeeRec.Address := Address;
                  EmployeeRec."Address 2" := "Address 2";
                  EmployeeRec.City := City;
                  EmployeeRec."Post Code" := "Post Code";
                  EmployeeRec.Extension := Durchwahlnummer;
                  EmployeeRec."E-Mail" := "E-Mail";

                  if not EmployeeRec.Insert(true) then
                    EmployeeRec.Modify(true);
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
        EmployeeRec: Record Employee;
}


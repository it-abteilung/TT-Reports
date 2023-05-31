#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0206, AA0218, AA0228, AL0424, AW0006 // ForNAV settings
Report 50057 "Artikelbilder einlesen"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {

            trigger OnAfterGetRecord()
            begin
                // if Exists('\\W2012R2-NAV17\c$\Migration NAV 2017\Echtdaten\Artikelbilder\' + Format(Item."No.") + '.jpg') then begin
                //   Item.Picture.ImportFile('\\W2012R2-NAV17\c$\Migration NAV 2017\Echtdaten\Artikelbilder\' + Format(Item."No.") + '.jpg', 'Item Picture');
                //   Item.Modify;
                // end;
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


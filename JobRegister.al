reportextension 50000 JobRegister extends "Job Register"
{

    RDLCLayout = './Layouts/JobRegister.rdlc';

    dataset
    {

        addlast("Job Ledger Entry")
        {
            dataitem(Item; Item)
            {

                DataItemLinkReference = "Job Ledger Entry";
                DataItemLink = "No." = Field("No.");

                column(Description; Description) { }
                column(Description_2; "Description 2") { }
                column(Description_3; "Description 3") { }
            }
        }
    }
}
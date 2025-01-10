reportextension 50024 "PhysInvtRecording" extends "Phys. Invt. Recording"
{
    RDLCLayout = './Layouts/PhysInvtRecordingTT.rdlc';

    dataset
    {
        add("Phys. Invt. Record Line")
        {
            column(Description_2; "Description 2")
            {
            }
        }
    }
}
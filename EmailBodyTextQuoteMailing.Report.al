report 50147 "Email Body Text PurchQuote"
{
    DefaultLayout = Word;
    WordLayout = './Layouts/EmailBodyTextPurchQuote.docx';
    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            column(Purchaser_Code; CompInfo.Name)
            {
            }
            column(Durchwahl; Durchwahl)
            {
            }
            trigger OnAfterGetRecord()
            var
                Purchaser: Record "Salesperson/Purchaser";
            begin
                if Purchaser.Get("Purchase Header"."Purchaser Code") then begin
                    Durchwahl := Purchaser.Durchwahlnummer;
                    Purchaser_Code := Purchaser.Name;
                end;
                CompInfo.Get();
            end;
        }
    }
    var
        Durchwahl: Text;
        Purchaser_Code: Text;
        CompInfo: Record "Company Information";
}
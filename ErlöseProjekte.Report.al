Report 50023 "Erlöse Projekte"
{
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Job; Job)
        {
            RequestFilterFields = "No.", "Object";

            trigger OnAfterGetRecord()
            var
                JobLedgerEntry: Record "Job Ledger Entry";
                JobType_l: Record "Job Type";
                Job_l: Record Job;
                LiquidityPlanning_l: Record "Liquidity Planning";
                PurchaseHeader_l: Record "Purchase Header";
                PurchInvHeader_l: Record "Purch. Inv. Header";
                PurchCrMemoHdr_l: Record "Purch. Cr. Memo Hdr.";
                JobDiscount_l: Decimal;
                JobSum_l: Decimal;
                JobSumDiscount_l: Decimal;

                PurchaseHeaderExt: Record "Purchase Header";
                PurchInvHeaderExtTemp: Record "Purch. Inv. Header";
                PurchInvHeaderExt: Record "Purch. Inv. Header" temporary;
                PurchInvLineExt: Record "Purch. Inv. Line";
                PurchCrMemoHdrExt: Record "Purch. Cr. Memo Hdr.";
                PurchCrMemoHdrExtTemp: Record "Purch. Cr. Memo Hdr." temporary;
                PurchCrMemoLineExt: Record "Purch. Cr. Memo Line";
                QuoteCounter: Integer;
                OrderCounter: Integer;
                InvoiceCounter: Integer;
                CreditCounter: Integer;
            begin
                CalcFields("EK Material Ist", "EK Fremdlieferung Ist", "EK Fremdleistung Ist", "Lagermaterial Ist", "EK Transporte Ist",
                           "EK Hotelkosten Ist", "EK Flugkosten Ist", "EK Auslöse Ist", "EK Fremdlieferung Ist Gut", "EK Fremdleistung Ist Gut",
                           "EK Transporte Ist Gut", "EK Hotelkosten Ist Gut", "EK Flugkosten Ist Gut", "EK Auslöse Ist Gut",
                           "Arbeitsstd. Gesamt Ist"); //G-ERP.RS 2019-05-21 Anfrage#232823


                Clear(JobPlanningLine);
                JobPlanningLine.SetCurrentkey("Job No.", Type);
                case SumProject of
                    true:
                        JobPlanningLine.SetFilter("Job No.", '%1', "No." + '*');
                    false:
                        JobPlanningLine.SetRange("Job No.", "No.");
                end;
                JobPlanningLine.SetRange(Type, JobPlanningLine.Type::Resource);
                JobPlanningLine.CalcSums(Quantity);
                JobPlanningLine.SetRange(Type);
                JobPlanningLine.CalcSums(Lohnkosten, Materialkosten, Fremdarbeitenkosten, "EK-Lohnkosten",
                                         "EK-Materialkosten", "EK-Fremdarbeitenkosten", "EK-Transport",  //G-ERP.RS 2019-05-21 Anfrage#232823
                                         "EK-Fremdlieferungkosten",                                   //G-ERP.RS 2019-08-19 Anfrage#233661
                                         "EK-Hotelkosten", "EK-Reisekosten");                          //G-ERP.RS 2019-09-09 Anfrage#233661

                //GesamtSOLL := JobPlanningLine.Lohnkosten                                          //G-ERP.RS 2019-09-09 Anfrage#233661
                GesamtSOLL := JobPlanningLine."EK-Transport"                                        //G-ERP.RS 2019-09-09 Anfrage#233661
                            + JobPlanningLine."EK-Materialkosten"                                   //G-ERP.RS 2019-10-15
                            + JobPlanningLine.Lohnkosten                                            //G-ERP.RS 2019-10-15
                            + JobPlanningLine."EK-Fremdarbeitenkosten"
                            + JobPlanningLine."EK-Fremdlieferungkosten"
                            + JobPlanningLine."EK-Reisekosten"
                            + JobPlanningLine."EK-Hotelkosten";                                     //G-ERP.RS 2019-09-09 Anfrage#233661

                // G-ERP.RS 2020-02-26 +++

                JobPlanningLine.CalcSums(Fremdlieferungskosten, Transportkosten, Hotelkosten, Flugkosten, Auslöse);
                JobSum_l := JobPlanningLine.Lohnkosten
                          + JobPlanningLine.Materialkosten
                          + JobPlanningLine.Fremdarbeitenkosten
                          + JobPlanningLine.Fremdlieferungskosten
                          + JobPlanningLine.Transportkosten
                          + JobPlanningLine.Hotelkosten
                          + JobPlanningLine.Flugkosten
                          + JobPlanningLine.Auslöse;


                JobDiscount_l := 0;
                case SumProject of
                    true:
                        Job_l.SetFilter("No.", '%1', "No." + '*');
                    false:
                        Job_l.SetRange("No.", "No.");
                end;
                if Job_l.FindSet() then begin
                    repeat
                        JobDiscount_l += Job_l."Nachlass in Euro";
                    until (Job_l.Next() = 0);
                end;
                // G-ERP.RS 2020-02-26 ---

                JobSumDiscount_l := JobSum_l - JobDiscount_l;

                GesamtIST := 0;                                                                    //G-ERP.RS 2019-08-15 Anfrage#233661
                LagegrmaterialIst := 0;
                Clear(JobLedgerEntry);
                case SumProject of
                    true:
                        JobLedgerEntry.SetFilter("Job No.", '%1', "No." + '*');
                    false:
                        JobLedgerEntry.SetRange("Job No.", "No.");
                end;
                JobLedgerEntry.SetRange(Type, JobLedgerEntry.Type::Resource);
                JobLedgerEntry.SetFilter("No.", '<>9*');
                JobLedgerEntry.CalcSums(Quantity);
                ArbeitsstdGesamtIst := JobLedgerEntry.Quantity;

                JobLedgerEntry.SetFilter("No.", '9*');                   //XXX
                JobLedgerEntry.CalcSums(Quantity);                      //XXX
                ArbeitsstdGesamtIstFremd_g := JobLedgerEntry.Quantity;  //XXX

                JobLedgerEntry.SetRange("No.");
                JobLedgerEntry.SetRange(Type);
                //JobLedgerEntry.SETRANGE("Source Code",'');                                        //G-ERP.RS 2019-08-12 Anfrage#233374
                JobLedgerEntry.SetFilter("Source Code", '%1|%2', '', 'PROJBUCHBL');                    //G-ERP.RS 2019-08-12
                //JobLedgerEntry.CALCSUMS("Total Cost (LCY)");                                      //G-ERP.RS 2019-08-15 Anfrage#233661
                //JobLedgerEntry.CALCSUMS("Total Cost (LCY)","Direct Unit Cost (LCY)",Quantity);      //G-ERP.RS 2019-08-15 Anfrage#233661
                //LagegrmaterialIst := JobLedgerEntry."Total Cost (LCY)";
                //LagegrmaterialIst := JobLedgerEntry."Direct Unit Cost (LCY)" * JobLedgerEntry.Quantity;
                if JobLedgerEntry.FindSet() then
                    repeat
                        if (JobLedgerEntry."Direct Unit Cost (LCY)" <> 0) and
                           (JobLedgerEntry.Quantity <> 0) then
                            LagegrmaterialIst += JobLedgerEntry."Direct Unit Cost (LCY)"
                                               * JobLedgerEntry.Quantity;

                    until (JobLedgerEntry.Next() = 0);
                //GesamtIST += LagegrmaterialIst;                                                     //G-ERP.RS 2019-08-15 Anfrage#233661

                //Arbeitsstunden_EIGEN +++
                Clear(JobPlanningLine2);
                JobPlanningLine2.SetCurrentkey("Job No.", Type);
                case SumProject of
                    true:
                        JobPlanningLine2.SetFilter("Job No.", '%1', "No." + '*');
                    false:
                        JobPlanningLine2.SetRange("Job No.", "No.");
                end;
                JobPlanningLine2.SetRange(Type, JobPlanningLine2.Type::Resource);
                JobPlanningLine2.SetRange("No.", '1');
                JobPlanningLine2.CalcSums(Lohnkosten, Quantity);

                Lohnkosten_IST := 0;
                Clear(JobLedgerEntry);
                JobLedgerEntry.SetCurrentkey("Job No.", "Entry Type", Type, "No.");
                case SumProject of
                    true:
                        JobLedgerEntry.SetFilter("Job No.", '%1', "No." + '*');
                    false:
                        JobLedgerEntry.SetRange("Job No.", "No.");
                end;
                JobLedgerEntry.SetRange(Type, JobLedgerEntry.Type::Resource);
                JobLedgerEntry.SetFilter("No.", '2*|3*');
                JobLedgerEntry.CalcSums(Quantity);
                Arbeitsstunden_EIGEN := JobLedgerEntry.Quantity;
                if JobPlanningLine2.Quantity <> 0 then
                    Lohnkosten_IST := JobLedgerEntry.Quantity * JobPlanningLine2.Lohnkosten / JobPlanningLine2.Quantity;
                //Arbeitsstunden_EIGEN ---


                Fremdlief := 0;
                Fremdleist := 0;
                TranspLeist := 0;
                PersonalIst := 0;   //G-ERP.RS 2019-08-15 Anfrage#233661
                HotelIst := 0;        //G-ERP.RS 2019-09-11 Anfrage#233661
                ReisekostenIst := 0;  //G-ERP.RS 2019-09-11 Anfrage#233661
                "AuslöseLeist" := 0;
                Clear(PurchInvLine);
                case SumProject of
                    true:
                        PurchInvLine.SetFilter("Job No.", '%1', "No." + '*');
                    false:
                        PurchInvLine.SetRange("Job No.", "No.");
                end;
                if PurchInvLine.FindSet then
                    repeat
                        waehrungsfaktor := 1;
                        if l_PurchInvHeader.Get(PurchInvLine."Document No.") then
                            waehrungsfaktor := l_PurchInvHeader."Currency Factor";
                        if waehrungsfaktor = 0 then
                            waehrungsfaktor := 1;

                        if PurchInvLine.Amount <> 0 then begin
                            if PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Fremdlieferung then
                                Fremdlief += (PurchInvLine.Amount / waehrungsfaktor);
                            if (PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Fremdleistung) or
                               //         (PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Transport) OR    //G-ERP.RS 2019-05-21 Anfrage#232823
                               //         (PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Reisekosten) OR
                               //         (PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Auslöse) OR
                               //         (PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Personal) OR
                               //         (PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Hotelkosten) OR
                               (PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::" ") then
                                Fremdleist += (PurchInvLine.Amount / waehrungsfaktor);
                            if PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Transport then
                                TranspLeist += (PurchInvLine.Amount / waehrungsfaktor);
                            if PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Auslöse then        //G-ERP.RS 2019-08-15 Anfrage#233661
                                AuslöseLeist += (PurchInvLine.Amount / waehrungsfaktor);                    //G-ERP.RS 2019-08-15 Anfrage#233661
                            if PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Personal then       //G-ERP.RS 2019-08-15 Anfrage#233661
                                PersonalIst += (PurchInvLine.Amount / waehrungsfaktor);                     //G-ERP.RS 2019-08-15 Anfrage#233661
                            if PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Hotelkosten then    //G-ERP.RS 2019-09-11 Anfrage#233661
                                HotelIst += (PurchInvLine.Amount / waehrungsfaktor);                        //G-ERP.RS 2019-09-11 Anfrage#233661
                            if PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Flugkosten then    //G-ERP.RS 2019-09-11 Anfrage#233661
                                ReisekostenIst += (PurchInvLine.Amount / waehrungsfaktor);                  //G-ERP.RS 2019-09-11 Anfrage#233661
                        end;
                    until PurchInvLine.Next = 0;

                // G-ERP.AG 2021-05-12+
                Clear(PurchInvHeader_l);
                case SumProject of
                    true:
                        PurchInvHeader_l.SetFilter("Job No.", '%1', "No." + '*');
                    false:
                        PurchInvHeader_l.SetRange("Job No.", "No.");
                end;
                if PurchInvHeader_l.FindSet then
                    repeat
                        Clear(PurchInvLine);
                        PurchInvLine.SetRange("Document No.", PurchInvHeader_l."No.");
                        if PurchInvLine.FindSet then
                            repeat
                                if PurchInvLine."Job No." = 'LV' then begin
                                    waehrungsfaktor := 1;
                                    if l_PurchInvHeader.Get(PurchInvLine."Document No.") then
                                        waehrungsfaktor := l_PurchInvHeader."Currency Factor";
                                    if waehrungsfaktor = 0 then
                                        waehrungsfaktor := 1;

                                    if PurchInvLine.Amount <> 0 then begin
                                        if PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Fremdlieferung then
                                            Fremdlief += (PurchInvLine.Amount / waehrungsfaktor);
                                        if (PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Fremdleistung) or
                                           //         (PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Transport) OR    //G-ERP.RS 2019-05-21 Anfrage#232823
                                           //         (PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Reisekosten) OR
                                           //         (PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Auslöse) OR
                                           //         (PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Personal) OR
                                           //         (PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Hotelkosten) OR
                                           (PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::" ") then
                                            Fremdleist += (PurchInvLine.Amount / waehrungsfaktor);
                                        if PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Transport then
                                            TranspLeist += (PurchInvLine.Amount / waehrungsfaktor);
                                        if PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Auslöse then        //G-ERP.RS 2019-08-15 Anfrage#233661
                                            AuslöseLeist += (PurchInvLine.Amount / waehrungsfaktor);                    //G-ERP.RS 2019-08-15 Anfrage#233661
                                        if PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Personal then       //G-ERP.RS 2019-08-15 Anfrage#233661
                                            PersonalIst += (PurchInvLine.Amount / waehrungsfaktor);                     //G-ERP.RS 2019-08-15 Anfrage#233661
                                        if PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Hotelkosten then    //G-ERP.RS 2019-09-11 Anfrage#233661
                                            HotelIst += (PurchInvLine.Amount / waehrungsfaktor);                        //G-ERP.RS 2019-09-11 Anfrage#233661
                                        if PurchInvLine.Leistungsart = PurchInvLine.Leistungsart::Flugkosten then    //G-ERP.RS 2019-09-11 Anfrage#233661
                                            ReisekostenIst += (PurchInvLine.Amount / waehrungsfaktor);                  //G-ERP.RS 2019-09-11 Anfrage#233661
                                    end;
                                end;
                            until PurchInvLine.Next = 0;
                    until PurchInvHeader_l.Next = 0;
                // G-ERP.AG 2021-05-12-

                Clear(PurchCrMemoLine);
                case SumProject of
                    true:
                        PurchCrMemoLine.SetFilter("Job No.", '%1', "No." + '*');
                    false:
                        PurchCrMemoLine.SetRange("Job No.", "No.");
                end;
                if PurchCrMemoLine.FindSet then
                    repeat
                        waehrungsfaktor := 1;
                        if l_PurchCrMemoHdr.Get(PurchCrMemoLine."Document No.") then
                            waehrungsfaktor := l_PurchCrMemoHdr."Currency Factor";
                        if waehrungsfaktor = 0 then
                            waehrungsfaktor := 1;

                        if PurchCrMemoLine.Amount <> 0 then begin
                            if PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Fremdlieferung then
                                Fremdlief -= (PurchCrMemoLine.Amount / waehrungsfaktor);
                            if (PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Fremdleistung) or
                               //         (PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Transport) OR   //G-ERP.RS 2019-05-21 Anfrage#232823
                               //         (PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Reisekosten) OR
                               //         (PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Auslöse) OR
                               //         (PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Personal) OR
                               //         (PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Hotelkosten) OR
                               (PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::" ") then
                                Fremdleist -= (PurchCrMemoLine.Amount / waehrungsfaktor);
                            if PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Transport then
                                TranspLeist -= (PurchCrMemoLine.Amount / waehrungsfaktor);
                            if PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Auslöse then       //G-ERP.RS 2019-08-15 Anfrage#233661
                                AuslöseLeist -= (PurchCrMemoLine.Amount / waehrungsfaktor);                      //G-ERP.RS 2019-08-15 Anfrage#233661
                            if PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Personal then      //G-ERP.RS 2019-08-15 Anfrage#233661
                                PersonalIst -= (PurchCrMemoLine.Amount / waehrungsfaktor);                       //G-ERP.RS 2019-08-15 Anfrage#233661
                            if PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Hotelkosten then   //G-ERP.RS 2019-09-11 Anfrage#233661
                                HotelIst -= (PurchCrMemoLine.Amount / waehrungsfaktor);                          //G-ERP.RS 2019-09-11 Anfrage#233661
                            if PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Flugkosten then   //G-ERP.RS 2019-09-11 Anfrage#233661
                                ReisekostenIst -= (PurchCrMemoLine.Amount / waehrungsfaktor);                    //G-ERP.RS 2019-09-11 Anfrage#233661
                        end;
                    until PurchCrMemoLine.Next = 0;

                // G-ERP.AG 2021-05-12+
                Clear(PurchCrMemoHdr_l);
                case SumProject of
                    true:
                        PurchCrMemoHdr_l.SetFilter("Job No.", '%1', "No." + '*');
                    false:
                        PurchCrMemoHdr_l.SetRange("Job No.", "No.");
                end;
                if PurchCrMemoHdr_l.FindSet then
                    repeat
                        Clear(PurchCrMemoLine);
                        PurchCrMemoLine.SetRange("Document No.", PurchCrMemoHdr_l."No.");
                        if PurchCrMemoLine.FindSet then
                            repeat
                                if PurchCrMemoLine."Job No." = 'LV' then begin
                                    waehrungsfaktor := 1;
                                    if l_PurchCrMemoHdr.Get(PurchCrMemoLine."Document No.") then
                                        waehrungsfaktor := l_PurchCrMemoHdr."Currency Factor";
                                    if waehrungsfaktor = 0 then
                                        waehrungsfaktor := 1;

                                    if PurchCrMemoLine.Amount <> 0 then begin
                                        if PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Fremdlieferung then
                                            Fremdlief -= (PurchCrMemoLine.Amount / waehrungsfaktor);
                                        if (PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Fremdleistung) or
                                           //         (PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Transport) OR   //G-ERP.RS 2019-05-21 Anfrage#232823
                                           //         (PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Reisekosten) OR
                                           //         (PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Auslöse) OR
                                           //         (PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Personal) OR
                                           //         (PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Hotelkosten) OR
                                           (PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::" ") then
                                            Fremdleist -= (PurchCrMemoLine.Amount / waehrungsfaktor);
                                        if PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Transport then
                                            TranspLeist -= (PurchCrMemoLine.Amount / waehrungsfaktor);
                                        if PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Auslöse then       //G-ERP.RS 2019-08-15 Anfrage#233661
                                            AuslöseLeist -= (PurchCrMemoLine.Amount / waehrungsfaktor);                      //G-ERP.RS 2019-08-15 Anfrage#233661
                                        if PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Personal then      //G-ERP.RS 2019-08-15 Anfrage#233661
                                            PersonalIst -= (PurchCrMemoLine.Amount / waehrungsfaktor);                       //G-ERP.RS 2019-08-15 Anfrage#233661
                                        if PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Hotelkosten then   //G-ERP.RS 2019-09-11 Anfrage#233661
                                            HotelIst -= (PurchCrMemoLine.Amount / waehrungsfaktor);                          //G-ERP.RS 2019-09-11 Anfrage#233661
                                        if PurchCrMemoLine.Leistungsart = PurchCrMemoLine.Leistungsart::Flugkosten then   //G-ERP.RS 2019-09-11 Anfrage#233661
                                            ReisekostenIst -= (PurchCrMemoLine.Amount / waehrungsfaktor);                    //G-ERP.RS 2019-09-11 Anfrage#233661
                                    end;
                                end;
                            until PurchCrMemoLine.Next = 0;
                    until PurchCrMemoHdr_l.Next = 0;
                // G-ERP.AG 2021-05-12-


                Clear(PurchaseLine);
                PurchaseLine.SetRange("Document Type", PurchaseLine."document type"::Order);
                case SumProject of
                    true:
                        PurchaseLine.SetFilter("Job No.", '%1', "No." + '*');
                    false:
                        PurchaseLine.SetRange("Job No.", "No.");
                end;
                if PurchaseLine.FindSet then
                    repeat
                        waehrungsfaktor := 1;
                        if PurchaseHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.") then
                            waehrungsfaktor := PurchaseHeader."Currency Factor";
                        if waehrungsfaktor = 0 then
                            waehrungsfaktor := 1;

                        //G-ERP.RS 2019-05-21 +++ Anfrage#232823
                        if PurchaseLine."Qty. to Invoice" <> PurchaseLine.Quantity then
                            PurchaseLine."Qty. to Invoice" := PurchaseLine.Quantity - PurchaseLine."Quantity Invoiced";
                        PurchaseLine."Outstanding Amount" := ((PurchaseLine."Qty. to Invoice") * PurchaseLine."Direct Unit Cost");
                        //G-ERP.RS 2019-05-21 --- Anfrage#232823

                        if PurchaseLine."Outstanding Amount" <> 0 then begin                            //G-ERP.RS 2019-09-11 Anfrage#233661
                            if PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Fremdlieferung then
                                Fremdlief += (PurchaseLine."Outstanding Amount" / waehrungsfaktor);         //G-ERP.RS 2019-09-11 Anfrage#233661
                            if (PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Fremdleistung) or
                               //         (PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Transport) OR    //G-ERP.RS 2019-05-21 Anfrage#232823
                               //         (PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Reisekosten) OR
                               //         (PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Auslöse) OR
                               //         (PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Personal) OR
                               //         (PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Hotelkosten) OR
                               (PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::" ") then
                                //Fremdleist += (PurchaseLine.Amount / waehrungsfaktor);                    //G-ERP.RS 2019-05-21 Anfrage#232823
                                Fremdleist += (PurchaseLine."Outstanding Amount" / waehrungsfaktor);
                            if PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Transport then      //G-ERP.RS 2019-05-21 Anfrage#232823
                                TranspLeist += (PurchaseLine."Outstanding Amount" / waehrungsfaktor);       //G-ERP.RS 2019-05-21 Anfrage#232823
                            if PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Auslöse then        //G-ERP.RS 2019-05-21 Anfrage#232823
                                AuslöseLeist += (PurchaseLine."Outstanding Amount" / waehrungsfaktor);      //G-ERP.RS 2019-05-21 Anfrage#232823
                            if PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Personal then       //G-ERP.RS 2019-08-15 Anfrage#233661
                                PersonalIst += (PurchaseLine."Outstanding Amount" / waehrungsfaktor);       //G-ERP.RS 2019-08-15 Anfrage#233661
                            if PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Hotelkosten then    //G-ERP.RS 2019-09-11 Anfrage#233661
                                HotelIst += (PurchaseLine."Outstanding Amount" / waehrungsfaktor);          //G-ERP.RS 2019-09-11 Anfrage#233661
                            if PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Flugkosten then    //G-ERP.RS 2019-09-11 Anfrage#233661
                                ReisekostenIst += (PurchaseLine."Outstanding Amount" / waehrungsfaktor);    //G-ERP.RS 2019-09-11 Anfrage#233661
                        end;
                    until PurchaseLine.Next = 0;

                // G-ERP.AG 2021-05-12+
                Clear(PurchaseHeader_l);
                case SumProject of
                    true:
                        PurchaseHeader_l.SetFilter("Job No.", '%1', "No." + '*');
                    false:
                        PurchaseHeader_l.SetRange("Job No.", "No.");
                end;
                if PurchaseHeader_l.FindSet then
                    repeat
                        Clear(PurchaseLine);
                        PurchaseLine.SetRange("Document Type", PurchaseLine."document type"::Order);
                        PurchaseLine.SetRange("Document No.", PurchaseHeader_l."No.");
                        if PurchaseLine.FindSet then
                            repeat
                                if PurchaseLine."Job No." = 'LV' then begin
                                    waehrungsfaktor := 1;
                                    if PurchaseHeader.Get(PurchaseLine."Document Type", PurchaseLine."Document No.") then
                                        waehrungsfaktor := PurchaseHeader."Currency Factor";
                                    if waehrungsfaktor = 0 then
                                        waehrungsfaktor := 1;

                                    //G-ERP.RS 2019-05-21 +++ Anfrage#232823
                                    if PurchaseLine."Qty. to Invoice" <> PurchaseLine.Quantity then
                                        PurchaseLine."Qty. to Invoice" := PurchaseLine.Quantity - PurchaseLine."Quantity Invoiced";
                                    PurchaseLine."Outstanding Amount" := ((PurchaseLine."Qty. to Invoice") * PurchaseLine."Direct Unit Cost");
                                    //G-ERP.RS 2019-05-21 --- Anfrage#232823

                                    if PurchaseLine."Outstanding Amount" <> 0 then begin                            //G-ERP.RS 2019-09-11 Anfrage#233661
                                        if PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Fremdlieferung then
                                            Fremdlief += (PurchaseLine."Outstanding Amount" / waehrungsfaktor);         //G-ERP.RS 2019-09-11 Anfrage#233661
                                        if (PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Fremdleistung) or
                                           //         (PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Transport) OR    //G-ERP.RS 2019-05-21 Anfrage#232823
                                           //         (PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Reisekosten) OR
                                           //         (PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Auslöse) OR
                                           //         (PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Personal) OR
                                           //         (PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Hotelkosten) OR
                                           (PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::" ") then
                                            //Fremdleist += (PurchaseLine.Amount / waehrungsfaktor);                    //G-ERP.RS 2019-05-21 Anfrage#232823
                                            Fremdleist += (PurchaseLine."Outstanding Amount" / waehrungsfaktor);
                                        if PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Transport then      //G-ERP.RS 2019-05-21 Anfrage#232823
                                            TranspLeist += (PurchaseLine."Outstanding Amount" / waehrungsfaktor);       //G-ERP.RS 2019-05-21 Anfrage#232823
                                        if PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Auslöse then        //G-ERP.RS 2019-05-21 Anfrage#232823
                                            AuslöseLeist += (PurchaseLine."Outstanding Amount" / waehrungsfaktor);      //G-ERP.RS 2019-05-21 Anfrage#232823
                                        if PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Personal then       //G-ERP.RS 2019-08-15 Anfrage#233661
                                            PersonalIst += (PurchaseLine."Outstanding Amount" / waehrungsfaktor);       //G-ERP.RS 2019-08-15 Anfrage#233661
                                        if PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Hotelkosten then    //G-ERP.RS 2019-09-11 Anfrage#233661
                                            HotelIst += (PurchaseLine."Outstanding Amount" / waehrungsfaktor);          //G-ERP.RS 2019-09-11 Anfrage#233661
                                        if PurchaseLine.Leistungsart = PurchaseLine.Leistungsart::Flugkosten then    //G-ERP.RS 2019-09-11 Anfrage#233661
                                            ReisekostenIst += (PurchaseLine."Outstanding Amount" / waehrungsfaktor);    //G-ERP.RS 2019-09-11 Anfrage#233661
                                    end;
                                end;
                            until PurchaseLine.Next = 0;
                    until PurchaseHeader_l.Next = 0;
                // G-ERP.AG 2021-05-12-


                GesamtIST += Lohnkosten_IST
                           + PersonalIst
                           + LagegrmaterialIst
                           + Fremdlief
                           + Fremdleist
                           + TranspLeist
                           + HotelIst
                           + ReisekostenIst
                           + AuslöseLeist     //G-ERP.RS 2019-08-15 Anfrage#233661
                           + (JobSumDiscount_l / 101.5 * 1.5);             // G-ERP.AG 2020-05-10


                //G-ERP.RS 2019-10-08 +++
                JobType_g := '';
                if JobType_l.Get(Job."Job Type") then
                    JobType_g := JobType_l.Description;
                //G-ERP.RS 2019-10-08 ---

                // G-ERP.AG 2021-05-12+
                Clear(LiquidityPlanning_l);
                LiquidityPlanning_l.SetRange("Job No.", "No.");
                LiquidityPlanning_l.SetFilter("Invoice No.", '<>%1', '');
                if LiquidityPlanning_l.FindFirst then
                    LiquidityPlanning_l.CalcSums(Amount);
                // G-ERP.AG 2021-05-12-

                QuoteCounter := 0;
                PurchaseHeaderExt.SetRange("Document Type", PurchaseHeaderExt."document type"::Quote);
                case SumProject of
                    true:
                        PurchaseHeaderExt.SetFilter("Job No.", '%1', "No." + '*');
                    false:
                        PurchaseHeaderExt.SetRange("Job No.", "No.");
                end;
                QuoteCounter := PurchaseHeaderExt.Count();

                OrderCounter := 0;
                PurchaseHeaderExt.SetRange("Document Type", PurchaseHeaderExt."document type"::Order);
                case SumProject of
                    true:
                        PurchaseHeaderExt.SetFilter("Job No.", '%1', "No." + '*');
                    false:
                        PurchaseHeaderExt.SetRange("Job No.", "No.");
                end;
                OrderCounter := PurchaseHeaderExt.Count();

                InvoiceCounter := 0;
                case SumProject of
                    true:
                        PurchInvLineExt.SetFilter("Job No.", '%1', "No." + '*');
                    false:
                        PurchInvLineExt.SetRange("Job No.", "No.");
                end;
                if PurchInvLineExt.FindSet then
                    repeat
                        if PurchaseHeaderExt.Get(PurchInvLineExt."Document No.") then begin
                            PurchInvHeaderExtTemp := PurchInvHeaderExt;
                            if PurchInvHeaderExtTemp.Insert then;
                        end;
                    until PurchInvLineExt.Next = 0;
                case SumProject of
                    true:
                        PurchInvHeaderExtTemp.SetFilter("Job No.", '%1', "No." + '*');
                    false:
                        PurchInvHeaderExtTemp.SetRange("Job No.", "No.");
                end;
                InvoiceCounter := PurchInvHeaderExtTemp.Count();

                CreditCounter := 0;
                case SumProject of
                    true:
                        PurchCrMemoLineExt.SetFilter("Job No.", '%1', "No." + '*');
                    false:
                        PurchCrMemoLineExt.SetRange("Job No.", "No.");
                end;
                if PurchCrMemoLineExt.FindSet then
                    repeat
                        if PurchCrMemoHdrExt.Get(PurchCrMemoLineExt."Document No.") then begin
                            PurchCrMemoHdrExtTemp := PurchCrMemoHdrExt;
                            if PurchCrMemoHdrExtTemp.Insert then;
                        end;
                    until PurchCrMemoLineExt.Next = 0;
                CreditCounter := PurchCrMemoHdrExtTemp.Count();


                // CLEAR(JobPlanningLine);
                // JobPlanningLine.SETRANGE("Job No.", "No.");
                // JobPlanningLine.CALCSUMS(Quantity, Lohnkosten, Materialkosten, Fremdarbeitenkosten, Fremdlieferungskosten, Transportkosten, Hotelkosten, Flugkosten, Auslöse);

                // TempExcelBuffer.NewRow();
                RowNo += 1;
                // A
                ExcelUebergabe(RowNo, 1, Job."No.", false, false, '@');
                // TempExcelBuffer.AddColumn(Job."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                // B
                ExcelUebergabe(RowNo, 2, Job.Objektname, false, false, '@');
                // TempExcelBuffer.AddColumn(Job.Objektname, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                // C
                ExcelUebergabe(RowNo, 3, Job.Description, false, false, '@');
                // TempExcelBuffer.AddColumn(Job.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                // D
                ExcelUebergabe(RowNo, 4, format(JobPlanningLine."EK-Materialkosten"), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(JobPlanningLine."EK-Materialkosten", false, '', false, false, false, '#.##0,00 €;[Rot]-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // E
                ExcelUebergabe(RowNo, 5, format(LagegrmaterialIst), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(LagegrmaterialIst, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // F
                ExcelUebergabeFormula(RowNo, 6, '=D' + Format(RowNo) + '-E' + Format(RowNo), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(JobPlanningLine."EK-Materialkosten" - LagegrmaterialIst, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // G
                ExcelUebergabe(RowNo, 7, Format(JobPlanningLine."EK-Fremdlieferungkosten"), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(JobPlanningLine."EK-Fremdlieferungkosten", false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // H
                ExcelUebergabe(RowNo, 8, Format(Fremdlief), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(Fremdlief, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // I
                ExcelUebergabeFormula(RowNo, 9, '=G' + Format(RowNo) + '-H' + Format(RowNo), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(JobPlanningLine."EK-Fremdlieferungkosten" - Fremdlief, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // J
                ExcelUebergabe(RowNo, 10, Format(JobPlanningLine."EK-Fremdarbeitenkosten"), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(JobPlanningLine."EK-Fremdarbeitenkosten", false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // K
                ExcelUebergabe(RowNo, 11, Format(Fremdleist), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(Fremdleist, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // L
                ExcelUebergabeFormula(RowNo, 12, '=J' + Format(RowNo) + '-K' + Format(RowNo), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(JobPlanningLine."EK-Fremdarbeitenkosten" - Fremdleist, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // M
                ExcelUebergabe(RowNo, 13, Format(JobPlanningLine."EK-Transport"), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(JobPlanningLine."EK-Transport", false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // N
                ExcelUebergabe(RowNo, 14, format(TranspLeist), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(TranspLeist, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // O
                ExcelUebergabeFormula(RowNo, 15, '=M' + Format(RowNo) + '-N' + Format(RowNo), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(JobPlanningLine."EK-Transport" - TranspLeist, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // 03.2024 CN - start
                //P Hotel Soll
                ExcelUebergabe(RowNo, 16, Format(JobPlanningLine."EK-Hotelkosten"), false, false, '#,##0.00');
                //Q Hotel Ist
                ExcelUebergabe(RowNo, 17, format(HotelIst), false, false, '#,##0.00');
                //R Hotel Diff
                ExcelUebergabeFormula(RowNo, 18, '=P' + Format(RowNo) + '-Q' + Format(RowNo), false, false, '#,##0.00');
                //S Reise Soll
                ExcelUebergabe(RowNo, 19, Format(JobPlanningLine."EK-Reisekosten"), false, false, '#,##0.00');
                //T Reise Ist
                ExcelUebergabe(RowNo, 20, format(ReisekostenIst), false, false, '#,##0.00');
                //U Reise Diff
                ExcelUebergabeFormula(RowNo, 21, '=S' + Format(RowNo) + '-T' + Format(RowNo), false, false, '#,##0.00');
                //V Auslöse Soll
                ExcelUebergabe(RowNo, 22, Format(JobPlanningLine."EK-Auslöse"), false, false, '#,##0.00');
                //W Auslöse Ist
                ExcelUebergabe(RowNo, 23, format("AuslöseLeist"), false, false, '#,##0.00');
                //X Auslöse Diff
                ExcelUebergabeFormula(RowNo, 24, '=U' + Format(RowNo) + '-V' + Format(RowNo), false, false, '#,##0.00');
                // 03.2024 CN - ende
                // Y
                ExcelUebergabe(RowNo, 25, Format(JobSumDiscount_l / 101.5 * 1.5), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(JobSumDiscount_l / 101.5 * 1.5, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Z
                ExcelUebergabe(RowNo, 26, Format(JobPlanningLine.Quantity), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(JobPlanningLine.Quantity, false, '', false, false, false, '#.##0,00_ ;-#.##0,00 ', TempExcelBuffer."Cell Type"::Number);
                // AA
                ExcelUebergabe(RowNo, 27, Format(JobPlanningLine.Lohnkosten), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(JobPlanningLine.Lohnkosten, false, '', false, false, false, '#.##0,00_ ;-#.##0,00 ', TempExcelBuffer."Cell Type"::Number);
                // AB
                ExcelUebergabe(RowNo, 28, Format(ArbeitsstdGesamtIst), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(ArbeitsstdGesamtIst, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                // AC
                ExcelUebergabe(RowNo, 29, Format(ArbeitsstdGesamtIstFremd_g), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(ArbeitsstdGesamtIstFremd_g, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                // AD
                ExcelUebergabe(RowNo, 30, Format(Lohnkosten_IST), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(Lohnkosten_IST, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // AE
                ExcelUebergabe(RowNo, 31, Format(PersonalIst), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(PersonalIst, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // AF
                ExcelUebergabeFormula(RowNo, 32, '=Z' + Format(RowNo) + '-AB' + Format(RowNo) + '-AC' + Format(RowNo), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(JobPlanningLine.Quantity - ArbeitsstdGesamtIst - ArbeitsstdGesamtIstFremd_g, false, '#.##0,00_ ;-#.##0,00 ', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // AG
                ExcelUebergabeFormula(RowNo, 33, '=AA' + Format(RowNo) + '-AD' + Format(RowNo) + '-AE' + Format(RowNo), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(JobPlanningLine.Lohnkosten - Lohnkosten_IST - PersonalIst, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // AH
                ExcelUebergabe(RowNo, 34, Format(GesamtSOLL), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(GesamtSOLL, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // AI
                ExcelUebergabe(RowNo, 35, Format(GesamtIST), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(GesamtIST, false, '', false, false, false, '#.##0,00_ ;-#.##0,00 ', TempExcelBuffer."Cell Type"::Number);
                // AJ
                ExcelUebergabeFormula(RowNo, 36, '=AH' + Format(RowNo) + '-AI' + Format(RowNo), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(GesamtSOLL - GesamtIST, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // AK
                ExcelUebergabe(RowNo, 37, Format(JobSumDiscount_l), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(JobSumDiscount_l, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // AL
                ExcelUebergabe(RowNo, 38, Format(LiquidityPlanning_l.Amount), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(LiquidityPlanning_l.Amount, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // AM
                ExcelUebergabeFormula(RowNo, 39, '=AK' + Format(RowNo) + '-AL' + Format(RowNo), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(JobSumDiscount_l - LiquidityPlanning_l.Amount, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // AN
                ExcelUebergabeFormula(RowNo, 40, '=AK' + Format(RowNo) + '-AI' + Format(RowNo), false, false, '#,##0.00');
                // TempExcelBuffer.AddColumn(JobSumDiscount_l - GesamtIST, false, '', false, false, false, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // AO
                ExcelUebergabe(RowNo, 41, Format(Job.Status), false, false, '@');
                // TempExcelBuffer.AddColumn(Job.Status, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                // AP
                ExcelUebergabe(RowNo, 42, Format(JobType_g), false, false, '@');
                // TempExcelBuffer.AddColumn(JobType_g, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                // 03.2024 CN - start
                // AQ
                ExcelUebergabe(RowNo, 43, Format(QuoteCounter), false, false, '@');
                // AR     
                ExcelUebergabe(RowNo, 44, Format(OrderCounter), false, false, '@');
                // AS
                ExcelUebergabe(RowNo, 45, Format(InvoiceCounter), false, false, '@');
                // AT
                ExcelUebergabe(RowNo, 46, Format(CreditCounter), false, false, '@');
                // AU
                ExcelUebergabe(RowNo, 47, Format(JobPlanningLine.Materialkosten), false, false, '@');
                // AV
                ExcelUebergabe(RowNo, 48, Format(JobPlanningLine.Fremdarbeitenkosten), false, false, '@');
                // AW
                ExcelUebergabe(RowNo, 49, Format(JobPlanningLine.Fremdlieferungskosten), false, false, '@');
                // 03.2024 CN - ende
            end;

            trigger OnPreDataItem()
            begin
                TempExcelBuffer.Reset();
                TempExcelBuffer.DeleteAll();
                //schreiben Überschrift
                // A
                ExcelUebergabe(RowNo, ColumnHeader, 'Auftrag', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Auftrag', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // B
                ExcelUebergabe(RowNo, ColumnHeader, 'Objekt', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Objekt', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // C
                ExcelUebergabe(RowNo, ColumnHeader, 'Beschreibung', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Beschreibung', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // D
                ExcelUebergabe(RowNo, ColumnHeader, 'Lagermaterial SOLL', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Lagermaterial SOLL', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // E
                ExcelUebergabe(RowNo, ColumnHeader, 'Lagermaterial IST', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Lagermaterial IST', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // F
                ExcelUebergabe(RowNo, ColumnHeader, 'Differenz', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Differenz', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // G
                ExcelUebergabe(RowNo, ColumnHeader, 'FremdLieferung SOLL', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('FremdLieferung SOLL', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // H
                ExcelUebergabe(RowNo, ColumnHeader, 'FremdLieferung IST', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('FremdLieferung IST', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // I
                ExcelUebergabe(RowNo, ColumnHeader, 'Differenz', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Differenz', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // J
                ExcelUebergabe(RowNo, ColumnHeader, 'Fremdleistung SOLL', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Fremdleistung SOLL', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // K
                ExcelUebergabe(RowNo, ColumnHeader, 'Fremdleistung IST', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Fremdleistung IST', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // L
                ExcelUebergabe(RowNo, ColumnHeader, 'Differenz', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Differenz', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // M
                ExcelUebergabe(RowNo, ColumnHeader, 'Transport SOLL', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Transport SOLL', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // N
                ExcelUebergabe(RowNo, ColumnHeader, 'Transport IST', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Transport IST', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // O
                ExcelUebergabe(RowNo, ColumnHeader, 'Differenz', true, true, '@');
                ColumnHeader += 1;


                // P 
                ExcelUebergabe(RowNo, ColumnHeader, 'Hotel SOLL', true, true, '@');
                ColumnHeader += 1;
                // Q
                ExcelUebergabe(RowNo, ColumnHeader, 'Hotel IST', true, true, '@');
                ColumnHeader += 1;
                // R
                ExcelUebergabe(RowNo, ColumnHeader, 'Differenz', true, true, '@');
                ColumnHeader += 1;
                // S
                ExcelUebergabe(RowNo, ColumnHeader, 'Reise SOLL', true, true, '@');
                ColumnHeader += 1;
                // T
                ExcelUebergabe(RowNo, ColumnHeader, 'Reise IST', true, true, '@');
                ColumnHeader += 1;
                // U
                ExcelUebergabe(RowNo, ColumnHeader, 'Differenz', true, true, '@');
                ColumnHeader += 1;
                // V
                ExcelUebergabe(RowNo, ColumnHeader, 'Auslöse SOLL', true, true, '@');
                ColumnHeader += 1;
                // W
                ExcelUebergabe(RowNo, ColumnHeader, 'Auslöse IST', true, true, '@');
                ColumnHeader += 1;
                // X
                ExcelUebergabe(RowNo, ColumnHeader, 'Differenz', true, true, '@');
                ColumnHeader += 1;


                // Y
                ExcelUebergabe(RowNo, ColumnHeader, '1,5% Versich.', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('1,5% Versich.', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // Z
                ExcelUebergabe(RowNo, ColumnHeader, 'Stunden SOLL', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Stunden SOLL', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AA
                ExcelUebergabe(RowNo, ColumnHeader, 'Lohnkosten SOLL', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Lohnkosten SOLL', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AB
                ExcelUebergabe(RowNo, ColumnHeader, 'Arbeitsstunden Eigen IST', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Arbeitsstunden Eigen IST', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AC
                ExcelUebergabe(RowNo, ColumnHeader, 'Arbeitsstunden Fremd IST', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Arbeitsstunden Fremd IST', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AD
                ExcelUebergabe(RowNo, ColumnHeader, 'Lohnkosten Eigen IST', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Lohnkosten Eigen IST', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AE
                ExcelUebergabe(RowNo, ColumnHeader, 'Lohnkosten Fremd IST', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Lohnkosten Fremd IST', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AF
                ExcelUebergabe(RowNo, ColumnHeader, 'Differenz Stunden', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Differenz Stunden', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AG
                ExcelUebergabe(RowNo, ColumnHeader, 'Differenz Lohnkosten', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Differenz Lohnkosten', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AH
                ExcelUebergabe(RowNo, ColumnHeader, 'Kosten SOLL', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Kosten SOLL', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AI
                ExcelUebergabe(RowNo, ColumnHeader, 'Kosten IST', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Kosten IST', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AJ
                ExcelUebergabe(RowNo, ColumnHeader, 'Differenz', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Differenz', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AK
                ExcelUebergabe(RowNo, ColumnHeader, 'Angebotssumme', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Angebotssumme', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AL
                ExcelUebergabe(RowNo, ColumnHeader, 'Abgerechnet', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Abgerechnet', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AM
                ExcelUebergabe(RowNo, ColumnHeader, 'offene Summe', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('offene Summe', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AN
                ExcelUebergabe(RowNo, ColumnHeader, 'Überschuss/Unterdeckung', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Überschuss/Unterdeckung', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AO
                ExcelUebergabe(RowNo, ColumnHeader, 'Status', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Status', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AP
                ExcelUebergabe(RowNo, ColumnHeader, 'Projekttyp', true, true, '@');
                ColumnHeader += 1;
                // TempExcelBuffer.AddColumn('Projekttyp', false, '', true, false, true, '', TempExcelBuffer."Cell Type"::Text);
                // AQ
                ExcelUebergabe(RowNo, ColumnHeader, 'EK-Anfragen', true, true, '@');
                ColumnHeader += 1;
                // AR     
                ExcelUebergabe(RowNo, ColumnHeader, 'EK-Bestellungen', true, true, '@');
                // AS
                ColumnHeader += 1;
                ExcelUebergabe(RowNo, ColumnHeader, 'EK-Rechnungen', true, true, '@');
                // AT
                ColumnHeader += 1;
                ExcelUebergabe(RowNo, ColumnHeader, 'EK-Gutschriften', true, true, '@');
                ColumnHeader += 1;
                // AU
                ExcelUebergabe(RowNo, ColumnHeader, 'Verkaufspreis Materialkosten', true, true, '@');
                ColumnHeader += 1;
                // AV
                ExcelUebergabe(RowNo, ColumnHeader, 'Verkaufspreis Fremdleistung', true, true, '@');
                ColumnHeader += 1;
                // AW
                ExcelUebergabe(RowNo, ColumnHeader, 'Verkaufspreis Fremdlieferung', true, true, '@');
                ColumnHeader += 1;
            end;

            trigger OnPostDataItem()
            begin
                RowNo += 1;
                // Summe A
                // TempExcelBuffer.AddColumn('', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe B
                // TempExcelBuffer.AddColumn('', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe C
                // TempExcelBuffer.AddColumn('', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe D
                ExcelUebergabeFormula(RowNo, 4, '=SUM(D2:D' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('SUMME(D2:D' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', true, '', true, false, true, '', TempExcelBuffer."Cell Type"::Number);
                // Summe E
                ExcelUebergabeFormula(RowNo, 5, '=SUM(E2:E' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('SUMME(E2:E' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', true, '', true, false, true, '', TempExcelBuffer."Cell Type"::Number);
                // Summe F
                ExcelUebergabeFormula(RowNo, 6, '=SUM(F2:F' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('SUMME(F2:F' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', true, '', true, false, true, '', TempExcelBuffer."Cell Type"::Number);
                // Summe G
                ExcelUebergabeFormula(RowNo, 7, '=SUM(G2:G' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(G2:G' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe H
                ExcelUebergabeFormula(RowNo, 8, '=SUM(H2:H' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(H2:H' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe I
                ExcelUebergabeFormula(RowNo, 9, '=SUM(I2:I' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(I2:I' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe J
                ExcelUebergabeFormula(RowNo, 10, '=SUM(J2:J' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(J2:J' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe K
                ExcelUebergabeFormula(RowNo, 11, '=SUM(K2:K' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(K2:K' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe L
                ExcelUebergabeFormula(RowNo, 12, '=SUM(L2:L' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(L2:L' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe M
                ExcelUebergabeFormula(RowNo, 13, '=SUM(M2:M' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(M2:M' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe N
                ExcelUebergabeFormula(RowNo, 14, '=SUM(N2:N' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(N2:N' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe O
                ExcelUebergabeFormula(RowNo, 15, '=SUM(O2:O' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(O2:O' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);


                // Summe P 
                ExcelUebergabeFormula(RowNo, 16, '=SUM(P2:P' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                ColumnHeader += 1;
                // Summe Q
                ExcelUebergabeFormula(RowNo, 17, '=SUM(Q2:Q' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                ColumnHeader += 1;
                // Summe R
                ExcelUebergabeFormula(RowNo, 18, '=SUM(R2:R' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                ColumnHeader += 1;
                // Summe S
                ExcelUebergabeFormula(RowNo, 19, '=SUM(S2:S' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                ColumnHeader += 1;
                // Summe T
                ExcelUebergabeFormula(RowNo, 20, '=SUM(T2:T' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                ColumnHeader += 1;
                // Summe U
                ExcelUebergabeFormula(RowNo, 21, '=SUM(U2:U' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                ColumnHeader += 1;
                // Summe V
                ExcelUebergabeFormula(RowNo, 22, '=SUM(V2:V' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                ColumnHeader += 1;
                // Summe W
                ExcelUebergabeFormula(RowNo, 23, '=SUM(W2:W' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                ColumnHeader += 1;
                // Summe X
                ExcelUebergabeFormula(RowNo, 24, '=SUM(X2:X' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                ColumnHeader += 1;


                // Summe Y
                ExcelUebergabeFormula(RowNo, 25, '=SUM(Y2:Y' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(P2:P' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe Z
                ExcelUebergabeFormula(RowNo, 26, '=SUM(Z2:Z' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(Q2:Q' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00_ ;-#.##0,00 ', TempExcelBuffer."Cell Type"::Number);
                // Summe AA
                ExcelUebergabeFormula(RowNo, 27, '=SUM(AA2:AA' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(R2:R' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00_ ;-#.##0,00 ', TempExcelBuffer."Cell Type"::Number);
                // Summe AB
                // ExcelUebergabeFormula(RowNo, 19, '=SUM(S2:S' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe AC
                // ExcelUebergabeFormula(RowNo, 20, '=SUM(D2:D' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe AD
                ExcelUebergabeFormula(RowNo, 30, '=SUM(AD2:AD' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(U2:U' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe AE
                ExcelUebergabeFormula(RowNo, 31, '=SUM(AE2:AE' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(V2:V' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe AF
                ExcelUebergabeFormula(RowNo, 32, '=SUM(AF2:AF' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(W2:W' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00_ ;-#.##0,00 ', TempExcelBuffer."Cell Type"::Number);
                // Summe AG
                ExcelUebergabeFormula(RowNo, 33, '=SUM(AG2:AG' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(X2:X' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe AH
                ExcelUebergabeFormula(RowNo, 34, '=SUM(AH2:AH' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(Y2:Y' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe AI
                ExcelUebergabeFormula(RowNo, 35, '=SUM(AI2:AI' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(Z2:Z' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00_ ;-#.##0,00 ', TempExcelBuffer."Cell Type"::Number);
                // Summe AJ
                ExcelUebergabeFormula(RowNo, 36, '=SUM(AJ2:AJ' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(AA2:A' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe AK
                ExcelUebergabeFormula(RowNo, 37, '=SUM(AK2:AK' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(AB2:AB' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe AL
                ExcelUebergabeFormula(RowNo, 38, '=SUM(AL2:AL' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(AC2:AC' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe AM
                ExcelUebergabeFormula(RowNo, 39, '=SUM(AM2:AM' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(AD2:AD' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // Summe AN
                ExcelUebergabeFormula(RowNo, 40, '=SUM(AN2:AN' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // TempExcelBuffer.AddColumn('=SUMME(AE2:AE' + FORMAT(TempExcelBuffer."Row No." - 1) + ')', false, '', true, false, true, '#.##0,00 €;-#.##0,00 €', TempExcelBuffer."Cell Type"::Number);
                // AQ
                // AR
                // AS
                // AT
                // AU
                ExcelUebergabeFormula(RowNo, 47, '=SUM(AU2:AU' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // AV
                ExcelUebergabeFormula(RowNo, 48, '=SUM(AV2:AV' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
                // AW
                ExcelUebergabeFormula(RowNo, 49, '=SUM(AW2:AW' + Format(RowNo - 1) + ')', true, false, '#,##0.00');
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

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

    trigger OnInitReport()
    begin
        ColumnHeader := 1;
        RowNo := 1;
    end;

    trigger OnPostReport()
    begin
        TempExcelBuffer.CreateNewBook('Erlöse Projekte');
        TempExcelBuffer.WriteSheet('Erlöse', CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo('Erlöse', CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();
    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        ColumnHeader: Integer;
        JobPlanningLine: Record "Job Planning Line";
        JobPlanningLine2: Record "Job Planning Line";
        PurchaseLine: Record "Purchase Line";
        PurchInvLine: Record "Purch. Inv. Line";
        PurchCrMemoLine: Record "Purch. Cr. Memo Line";
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchCrMemoHdr_temp: Record "Purch. Cr. Memo Hdr." temporary;
        l_PurchInvHeader: Record "Purch. Inv. Header";
        l_PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        PurchaseHeader: Record "Purchase Header";
        FileMgt: Codeunit "File Management";
        ServerFileName: Text;
        SheetName: Text[250];
        "Zähler": Integer;
        Fremdlief: Decimal;
        Fremdleist: Decimal;
        TranspLeist: Decimal;
        waehrungsfaktor: Decimal;
        Lohnkosten_IST: Decimal;
        PersonalIst: Decimal;
        Arbeitsstunden_EIGEN: Decimal;
        Arbeitsstunden_FREMD: Decimal;
        LagegrmaterialIst: Decimal;
        ArbeitsstdGesamtIst: Decimal;
        ArbeitsstdGesamtIstFremd_g: Decimal;
        "AuslöseLeist": Decimal;
        HotelIst: Decimal;
        ReisekostenIst: Decimal;
        GesamtSOLL: Decimal;
        GesamtIST: Decimal;
        RowNo: Integer;
        Text002: label 'Update Workbook';
        ExcelFileExtensionTok: label '.xlsx', Locked = true;
        JobType_g: Text[50];

    procedure ExcelUebergabe(Row: Integer; Column: Integer; Text: Text[250]; Fett: Boolean; Unter: Boolean; NumFormat: Text[30])
    begin
        Clear(TempExcelBuffer);
        TempExcelBuffer.Validate("Row No.", Row);
        TempExcelBuffer.Validate("Column No.", Column);
        TempExcelBuffer."Cell Value as Text" := Text;
        TempExcelBuffer.Bold := Fett;
        TempExcelBuffer.Underline := Unter;
        TempExcelBuffer.NumberFormat := NumFormat;
        TempExcelBuffer.Insert;
    end;


    procedure ExcelUebergabeFormula(Row: Integer; Column: Integer; Text: Text[250]; Fett: Boolean; Unter: Boolean; NumFormat: Text[30])
    begin
        Clear(TempExcelBuffer);
        TempExcelBuffer.Validate("Row No.", Row);
        TempExcelBuffer.Validate("Column No.", Column);
        TempExcelBuffer."Cell Value as Text" := '';
        TempExcelBuffer.SetFormula(Text);
        TempExcelBuffer.Bold := Fett;
        TempExcelBuffer.Underline := Unter;
        TempExcelBuffer.NumberFormat := NumFormat;
        TempExcelBuffer.Insert;
    end;

}


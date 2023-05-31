XmlPort 50020 ImportIndividualFields
{
    Direction = Import;
    Format = VariableText;
    FieldSeparator = ';';
    RecordSeparator = '<NewLine>';
    DefaultFieldsValidation = false;
    Permissions = TableData "Job Planning Line" = RIMD;
    TextEncoding = UTF8;
    UseRequestPage = false;

    schema
    {
        textelement(root)
        {
            tableelement(JobPlanningLine; "Job Planning Line")
            {
                XmlName = 'JobPlanningLine';
                AutoUpdate = true;
                fieldelement(LineNo; JobPlanningLine."Line No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(JobNo; JobPlanningLine."Job No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(PlanningDate; JobPlanningLine."Planning Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(DocumentNo; JobPlanningLine."Document No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Type; JobPlanningLine."Type")
                {
                    MinOccurs = Zero;
                }
                fieldelement(No; JobPlanningLine."No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Description; JobPlanningLine.Description)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Quantity; JobPlanningLine.Quantity)
                {
                    MinOccurs = Zero;
                }
                fieldelement(DirectUnitCostLCY; JobPlanningLine."Direct Unit Cost (LCY)")
                {
                    MinOccurs = Zero;
                }
                fieldelement(UnitCostLCY; JobPlanningLine."Unit Cost (LCY)")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TotalCostLCY; JobPlanningLine."Total Cost (LCY)")
                {
                    MinOccurs = Zero;
                }
                fieldelement(UnitPriceLCY; JobPlanningLine."Unit Price (LCY)")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TotalPriceLCY; JobPlanningLine."Total Price (LCY)")
                {
                    MinOccurs = Zero;
                }
                fieldelement(ResourceGroupNo; JobPlanningLine."Resource Group No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(UnitofMeasureCode; JobPlanningLine."Unit of Measure Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(LocationCode; JobPlanningLine."Location Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(LastDateModified; JobPlanningLine."Last Date Modified")
                {
                    MinOccurs = Zero;
                }
                fieldelement(UserID; JobPlanningLine."User ID")
                {
                    MinOccurs = Zero;
                }
                fieldelement(WorkTypeCode; JobPlanningLine."Work Type Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(CustomerPriceGroup; JobPlanningLine."Customer Price Group")
                {
                    MinOccurs = Zero;
                }
                fieldelement(CountryRegionCode; JobPlanningLine."Country/Region Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(GenBusPostingGroup; JobPlanningLine."Gen. Bus. Posting Group")
                {
                    MinOccurs = Zero;
                }
                fieldelement(GenProdPostingGroup; JobPlanningLine."Gen. Prod. Posting Group")
                {
                    MinOccurs = Zero;
                }
                fieldelement(DocumentDate; JobPlanningLine."Document Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(LineAmountLCY; JobPlanningLine."Line Amount (LCY)")
                {
                    MinOccurs = Zero;
                }
                fieldelement(UnitCost; JobPlanningLine."Unit Cost")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TotalCost; JobPlanningLine."Total Cost")
                {
                    MinOccurs = Zero;
                }
                fieldelement(UnitPrice; JobPlanningLine."Unit Price")
                {
                    MinOccurs = Zero;
                }
                fieldelement(TotalPrice; JobPlanningLine."Total Price")
                {
                    MinOccurs = Zero;
                }
                fieldelement(LineAmount; JobPlanningLine."Line Amount")
                {
                    MinOccurs = Zero;
                }
                fieldelement(LineDiscountAmount; JobPlanningLine."Line Discount Amount")
                {
                    MinOccurs = Zero;
                }
                fieldelement(LineDiscountAmountLCY; JobPlanningLine."Line Discount Amount (LCY)")
                {
                    MinOccurs = Zero;
                }
                fieldelement(CostFactor; JobPlanningLine."Cost Factor")
                {
                    MinOccurs = Zero;
                }
                fieldelement(SerialNo; JobPlanningLine."Serial No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(LotNo; JobPlanningLine."Lot No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(LineDiscount; JobPlanningLine."Line Discount %")
                {
                    MinOccurs = Zero;
                }
                fieldelement(LineType; JobPlanningLine."Line Type")
                {
                    MinOccurs = Zero;
                }
                fieldelement(CurrencyCode; JobPlanningLine."Currency Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(CurrencyDate; JobPlanningLine."Currency Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(CurrencyFactor; JobPlanningLine."Currency Factor")
                {
                    MinOccurs = Zero;
                }
                fieldelement(ScheduleLine; JobPlanningLine."Schedule Line")
                {
                    MinOccurs = Zero;
                }
                fieldelement(ContractLine; JobPlanningLine."Contract Line")
                {
                    MinOccurs = Zero;
                }
                fieldelement(JobContractEntryNo; JobPlanningLine."Job Contract Entry No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(VATUnitPrice; JobPlanningLine."VAT Unit Price")
                {
                    MinOccurs = Zero;
                }
                fieldelement(VATLineDiscountAmount; JobPlanningLine."VAT Line Discount Amount")
                {
                    MinOccurs = Zero;
                }
                fieldelement(VATLineAmount; JobPlanningLine."VAT Line Amount")
                {
                    MinOccurs = Zero;
                }
                fieldelement(VAT; JobPlanningLine."VAT %")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Description2; JobPlanningLine."Description 2")
                {
                    MinOccurs = Zero;
                }
                fieldelement(JobLedgerEntryNo; JobPlanningLine."Job Ledger Entry No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Status; JobPlanningLine.Status)
                {
                    MinOccurs = Zero;
                }
                fieldelement(LedgerEntryType; JobPlanningLine."Ledger Entry Type")
                {
                    MinOccurs = Zero;
                }
                fieldelement(LedgerEntryNo; JobPlanningLine."Ledger Entry No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(SystemCreatedEntry; JobPlanningLine."System-Created Entry")
                {
                    MinOccurs = Zero;
                }
                fieldelement(UsageLink; JobPlanningLine."Usage Link")
                {
                    MinOccurs = Zero;
                }
                fieldelement(RemainingQty; JobPlanningLine."Remaining Qty.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(RemainingQtyBase; JobPlanningLine."Remaining Qty. (Base)")
                {
                    MinOccurs = Zero;
                }
                fieldelement(RemainingTotalCost; JobPlanningLine."Remaining Total Cost")
                {
                    MinOccurs = Zero;
                }
                fieldelement(RemainingTotalCostLCY; JobPlanningLine."Remaining Total Cost (LCY)")
                {
                    MinOccurs = Zero;
                }
                fieldelement(RemainingLineAmount; JobPlanningLine."Remaining Line Amount")
                {
                    MinOccurs = Zero;
                }
                fieldelement(RemainingLineAmountLCY; JobPlanningLine."Remaining Line Amount (LCY)")
                {
                    MinOccurs = Zero;
                }
                fieldelement(QtyPosted; JobPlanningLine."Qty. Posted")
                {
                    MinOccurs = Zero;
                }
                fieldelement(QtytoTransfertoJournal; JobPlanningLine."Qty. to Transfer to Journal")
                {
                    MinOccurs = Zero;
                }
                fieldelement(PostedTotalCost; JobPlanningLine."Posted Total Cost")
                {
                    MinOccurs = Zero;
                }
                fieldelement(PostedTotalCostLCY; JobPlanningLine."Posted Total Cost (LCY)")
                {
                    MinOccurs = Zero;
                }
                fieldelement(PostedLineAmount; JobPlanningLine."Posted Line Amount")
                {
                    MinOccurs = Zero;
                }
                fieldelement(PostedLineAmountLCY; JobPlanningLine."Posted Line Amount (LCY)")
                {
                    MinOccurs = Zero;
                }
                fieldelement(QtyTransferredtoInvoice; JobPlanningLine."Qty. Transferred to Invoice")
                {
                    MinOccurs = Zero;
                }
                fieldelement(QtytoTransfertoInvoice; JobPlanningLine."Qty. to Transfer to Invoice")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Reserve; JobPlanningLine.Reserve)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Planned; JobPlanningLine.Planned)
                {
                    MinOccurs = Zero;
                }
                fieldelement(VariantCode; JobPlanningLine."Variant Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(BinCode; JobPlanningLine."Bin Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(QtyperUnitofMeasure; JobPlanningLine."Qty. per Unit of Measure")
                {
                    MinOccurs = Zero;
                }
                fieldelement(QuantityBase; JobPlanningLine."Quantity (Base)")
                {
                    MinOccurs = Zero;
                }
                fieldelement(RequestedDeliveryDate; JobPlanningLine."Requested Delivery Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(PromisedDeliveryDate; JobPlanningLine."Promised Delivery Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(PlannedDeliveryDate; JobPlanningLine."Planned Delivery Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(ServiceOrderNo; JobPlanningLine."Service Order No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(VendorItemNo; JobPlanningLine."Vendor Item No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Delivery; JobPlanningLine.Delivery)
                {
                    MinOccurs = Zero;
                }
                fieldelement(StckpreisEUR; JobPlanningLine."Stückpreis EUR")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Einkaufsrabatt; JobPlanningLine."Einkaufsrabatt %")
                {
                    MinOccurs = Zero;
                }
                fieldelement(EinkaufsrabattEUR; JobPlanningLine."Einkaufsrabatt EUR")
                {
                    MinOccurs = Zero;
                }
                fieldelement(EinkaufsrabattWhrung; JobPlanningLine."Einkaufsrabatt Währung")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Aufschlag; JobPlanningLine."Aufschlag %")
                {
                    MinOccurs = Zero;
                }
                fieldelement(AufschlagEUR; JobPlanningLine."Aufschlag EUR")
                {
                    MinOccurs = Zero;
                }
                fieldelement(AufschlagWhrung; JobPlanningLine."Aufschlag Währung")
                {
                    MinOccurs = Zero;
                }
                fieldelement(StckpreisinWhrungscode; JobPlanningLine."Stückpreis in Währungscode")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Whrungscode; JobPlanningLine."Währungscode")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Whrungskurs; JobPlanningLine."Währungskurs")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Baugruppe; JobPlanningLine.Baugruppe)
                {
                    MinOccurs = Zero;
                }
                fieldelement(BaugruppeTree; JobPlanningLine."Baugruppe Tree")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Lohnkosten; JobPlanningLine.Lohnkosten)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Materialkosten; JobPlanningLine.Materialkosten)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Fremdarbeitenkosten; JobPlanningLine.Fremdarbeitenkosten)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Fremdlieferungskosten; JobPlanningLine.Fremdlieferungskosten)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Transportkosten; JobPlanningLine.Transportkosten)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Hotelkosten; JobPlanningLine.Hotelkosten)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Flugkosten; JobPlanningLine.Flugkosten)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Auslse; JobPlanningLine."Auslöse")
                {
                    MinOccurs = Zero;
                }
                fieldelement(EKLohnkosten; JobPlanningLine."EK-Lohnkosten")
                {
                    MinOccurs = Zero;
                }
                fieldelement(EKMaterialkosten; JobPlanningLine."EK-Materialkosten")
                {
                    MinOccurs = Zero;
                }
                fieldelement(EKFremdarbeitenkosten; JobPlanningLine."EK-Fremdarbeitenkosten")
                {
                    MinOccurs = Zero;
                }
                fieldelement(EKFremdlieferungkosten; JobPlanningLine."EK-Fremdlieferungkosten")
                {
                    MinOccurs = Zero;
                }
                fieldelement(AttachedtoLineNo; JobPlanningLine."Attached to Line No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Pos; JobPlanningLine.Pos)
                {
                    MinOccurs = Zero;
                }
                fieldelement(EKTransport; JobPlanningLine."EK-Transport")
                {
                    MinOccurs = Zero;
                }
                fieldelement(EKHotelkosten; JobPlanningLine."EK-Hotelkosten")
                {
                    MinOccurs = Zero;
                }
                fieldelement(EKReisekosten; JobPlanningLine."EK-Reisekosten")
                {
                    MinOccurs = Zero;
                }
                fieldelement(EKAuslse; JobPlanningLine."EK-Auslöse")
                {
                    MinOccurs = Zero;
                }
                fieldelement(AnzeigeLohnkosten; JobPlanningLine."Anzeige Lohnkosten")
                {
                    MinOccurs = Zero;
                }
                fieldelement(AnzeigeMaterialkosten; JobPlanningLine."Anzeige Materialkosten")
                {
                    MinOccurs = Zero;
                }
                fieldelement(AnzeigeFremdarbeitenkosten; JobPlanningLine."Anzeige Fremdarbeitenkosten")
                {
                    MinOccurs = Zero;
                }
                fieldelement(AnzeigeMenge; JobPlanningLine."Anzeige Menge")
                {
                    MinOccurs = Zero;
                }
                fieldelement(AnzeigeFremdlieferungskosten; JobPlanningLine."Anzeige Fremdlieferungskosten")
                {
                    MinOccurs = Zero;
                }
            }
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
}


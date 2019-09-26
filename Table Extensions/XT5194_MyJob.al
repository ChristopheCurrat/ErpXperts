tableextension 50003 ErpX_MyJob extends "My Job"
{
    fields
    {
        field(50000; "ErpX_Qty. to Invoice"; Decimal)
        {
            Caption = 'Qty. to Invoice';
            FieldClass = FlowField;
            CalcFormula = Sum ("Job Planning Line"."Qty. to Invoice" WHERE ("Job No."=FIELD("Job No.")));
            DecimalPlaces = 0:5;
            Description = 'SP00';
            Editable = false;
         }
    }
}
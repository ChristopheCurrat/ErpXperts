codeunit 50000 ErpXperts
{
    // version SP03, SP04, SP07

    trigger OnRun();
    begin
    end;

    [EventSubscriber(ObjectType::Table, 951, 'OnAfterValidateEvent', 'Job Task No.', false, false)]
    local procedure TableTimeSheetLineOnAfterValidateTaskNo(var Rec: Record "Time Sheet Line"; var xRec: Record "Time Sheet Line"; CurrFieldNo: Integer);
    var
        _JobTask: Record "Job Task";
    begin
        // ERPX/ChC/SP07 -
        if _JobTask.Get(Rec."Job No.", Rec."Job Task No.") then
            _JobTask.TestField(ErpX_Blocked, false);
        // ERPX/ChC/SP07 +
    end;

    [EventSubscriber(ObjectType::Table, 1003, 'OnAfterInsertEvent', '', false, false)]
    local procedure TableJobPlanningLineOnAfterInsertEvent(var Rec: Record "Job Planning Line"; RunTrigger: Boolean);
    var
        _JobTask: Record "Job Task";
    begin
        // ERPX/ChC/SP07 -
        if _JobTask.Get(Rec."Job No.", Rec."Job Task No.") then
            _JobTask.TestField(ErpX_Blocked, false);
        // ERPX/ChC/SP07 +
    end;

    [EventSubscriber(ObjectType::Table, 169, 'OnAfterInsertEvent', '', false, false)]
    local procedure TableJobLedgerEntryOnAfterInsertEvent(var Rec: Record "Job Ledger Entry"; RunTrigger: Boolean);
    var
        _JobTask: Record "Job Task";
    begin
        // ERPX/ChC/SP07 -
        if _JobTask.Get(Rec."Job No.", Rec."Job Task No.") then
            _JobTask.TestField(ErpX_Blocked, false);
        // ERPX/ChC/SP07 +
    end;

    [EventSubscriber(ObjectType::Codeunit, 1002, 'OnBeforeInsertSalesLine', '', false, false)]
    local procedure OnBeforeInsertSalesLine(var SalesLine: Record "Sales Line"; var SalesHeader: Record "Sales Header"; Job: Record Job; JobPlanningLine: Record "Job Planning Line")
    var
        _TempBlob: Record TempBlob;
        _Text001Lbl: Label 'Job: %1, %2 ';
    begin
        // ERPX/ChC/SP03 -
        SalesLine.Validate("Shipment Date", JobPlanningLine."Planning Date");
        if not SalesHeader."Work Description".HasValue() then begin
            _TempBlob.WriteAsText(STRSUBSTNO(_Text001Lbl, Job."No.", Job.Description), TEXTENCODING::Windows);
            SalesHeader."Work Description" := _TempBlob.Blob;
            SalesHeader.Modify();
        end;
        // ERPX/ChC/SP03 +
    end;

    [EventSubscriber(ObjectType::Codeunit, 1002, 'OnBeforeCreateSalesInvoiceLines', '', false, false)]
    local procedure OnBeforeCreateSalesInvoiceLines(var JobPlanningLine: Record "Job Planning Line"; InvoiceNo: Code[20]; NewInvoice: Boolean; PostingDate: Date; CreditMemo: Boolean)
    begin
        // ERPX/ChC/SP03 -
        JobPlanningLine.SetCurrentKey("Job No.", "Job Task No.", "Schedule Line", "Planning Date");
        // ERPX/ChC/SP03 +
    end;

    [EventSubscriber(ObjectType::Table, 951, 'OnAfterValidateEvent', 'Work Type Code', false, false)]
    local procedure TableTimeSheetLineOnAfterValidateEvent(var Rec: Record "Time Sheet Line"; var xRec: Record "Time Sheet Line"; CurrFieldNo: Integer);
    begin
        // ERPX/ChC/SP02 -
        if Rec."Work Type Code" = 'HDEPL' then
            Rec.Validate(Chargeable, false);
        // ERPX/ChC/SP02 +
    end;

    [EventSubscriber(ObjectType::Codeunit, 1001, 'OnAfterJobPlanningLineModify', '', false, false)]
    local procedure CreateNewPlanningPeriod(var JobPlanningLine: Record "Job Planning Line");
    var
        _JobPlanningLine2: Record "Job Planning Line";
        _LineNo: Integer;
        _Text001Lbl: Label 'A new Job Planning Line\%1, %2\has been created.';
    begin
        // ERPX/ChC/SP04 -
        with JobPlanningLine do
            if FORMAT("ErpX_Invoice Period") <> '' then begin
                _JobPlanningLine2.SetRange("Job No.", "Job No.");
                _JobPlanningLine2.SetRange("Job Task No.", "Job Task No.");
                if _JobPlanningLine2.FindLast() then
                    _LineNo := _JobPlanningLine2."Line No." + 10000;

                _JobPlanningLine2.Init();
                ;
                _JobPlanningLine2.Validate("Job No.", "Job No.");
                _JobPlanningLine2.Validate("Job Task No.", "Job Task No.");
                _JobPlanningLine2.Validate("Line No.", _LineNo);
                _JobPlanningLine2.Validate("Line Type", "Line Type");
                _JobPlanningLine2.Validate("Planning Date", CALCDATE("ErpX_Invoice Period", "Planning Date"));
                _JobPlanningLine2.Validate("ErpX_Invoice Period", "ErpX_Invoice Period");
                _JobPlanningLine2.Validate("Document No.", "Document No.");
                _JobPlanningLine2.Validate(Type, Type);
                _JobPlanningLine2.Validate("No.", "No.");
                _JobPlanningLine2.Validate(Description, Description);
                _JobPlanningLine2.Validate(Quantity, Quantity);
                _JobPlanningLine2.Validate("Direct Unit Cost (LCY)", "Direct Unit Cost (LCY)");
                _JobPlanningLine2.Validate("Unit Cost (LCY)", "Unit Cost (LCY)");
                _JobPlanningLine2.Validate("Unit Price (LCY)", "Unit Price (LCY)");
                _JobPlanningLine2.INSERT(true);

                Message(_Text001Lbl, JobPlanningLine."Planning Date", JobPlanningLine.Description);
            end;
        // ERPX/ChC/SP04 +
    end;

    [EventSubscriber(ObjectType::Codeunit, 9520, 'OnBeforeCheckValidEmailAddress', '', false, false)]
    local procedure OnBeforeCheckValidEmailAddress(Recipients: Text; var IsHandled: Boolean)
    begin
        // ERPX/ChC/SP00 - allow multiple emails
        IsHandled := TRUE;
        // ERPX/ChC/SP00 +
    end;

    //Job No.,Planning Date,Document No.

}
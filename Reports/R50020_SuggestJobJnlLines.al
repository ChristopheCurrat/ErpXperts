report 50020 "ErpX_Suggest Job Jnl. Lines"
{
    Caption = 'Suggest Job Jnl. Lines';
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(StartingDate; StartingDate)
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the date from which the report or batch job processes information.';
                    }
                    field(EndingDate; EndingDate)
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Ending Date';
                        ToolTip = 'Specifies the date to which the report or batch job processes information.';
                    }
                    field(ResourceNoFilter; ResourceNoFilter)
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Resource No. Filter';
                        TableRelation = Resource;
                        ToolTip = 'Specifies the resource number that the batch job will suggest job lines for.';
                    }
                    field(JobNoFilter; JobNoFilter)
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Job No. Filter';
                        TableRelation = Job;
                        ToolTip = 'Specifies a filter for the job numbers that will be included in the report.';
                    }
                    field(JobTaskNoFilter; JobTaskNoFilter)
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Job Task No. Filter';
                        ToolTip = 'Specifies a filter for the job task numbers that will be included in the report.';

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            JobTask: Record "Job Task";
                        begin
                            JobTask.FILTERGROUP(2);
                            if JobNoFilter <> '' then
                                JobTask.SetFilter("Job No.", JobNoFilter);
                            JobTask.FILTERGROUP(0);
                            if PAGE.RUNMODAL(PAGE::"Job Task List", JobTask) = ACTION::LookupOK then
                                JobTask.TestField("Job Task Type", JobTask."Job Task Type"::Posting);
                            JobTaskNoFilter := JobTask."Job Task No.";
                        end;
                    }
                    // ERPX/ChC/SP02 -
                    field(ProjectManagerFilter; ProjectManagerFilter)
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Project Manager Filter';
                        TableRelation = "User Setup";
                    }
                    field(TravelingExpenses; TravelingExpenses)
                    {
                        ApplicationArea = Jobs;
                        Caption = 'Travelling expenses';
                    }
                    // ERPX/ChC/SP02 +
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    var
        // ERPX/ChC/SP02 -
        _JobJnlLine: Record "Job Journal Line";
        // ERPX/ChC/SP02 +
        NoSeriesMgt: Codeunit NoSeriesManagement;
        TimeSheetMgt: Codeunit "Time Sheet Management";
        NextDocNo: Code[20];
        LineNo: Integer;
        QtyToPost: Decimal;
    begin
        DateFilter := TimeSheetMgt.GetDateFilter(StartingDate, EndingDate);
        FillTimeSheetLineBuffer();

        if TempTimeSheetLine.FindFirst() then begin
            JobJnlLine.LockTable();
            JobJnlTemplate.Get(JobJnlLine."Journal Template Name");
            JobJnlBatch.Get(JobJnlLine."Journal Template Name", JobJnlLine."Journal Batch Name");
            if JobJnlBatch."No. Series" = '' then
                NextDocNo := ''
            else
                NextDocNo := NoSeriesMgt.GetNextNo(JobJnlBatch."No. Series", TempTimeSheetLine."Time Sheet Starting Date", false);

            JobJnlLine.SetRange("Journal Template Name", JobJnlLine."Journal Template Name");
            JobJnlLine.SetRange("Journal Batch Name", JobJnlLine."Journal Batch Name");
            if JobJnlLine.FindLast() then;
            LineNo := JobJnlLine."Line No.";

            repeat
                TimeSheetHeader.Get(TempTimeSheetLine."Time Sheet No.");
                TimeSheetDetail.SetRange("Time Sheet No.", TempTimeSheetLine."Time Sheet No.");
                TimeSheetDetail.SetRange("Time Sheet Line No.", TempTimeSheetLine."Line No.");
                if DateFilter <> '' then
                    TimeSheetDetail.SetFilter(Date, DateFilter);
                TimeSheetDetail.SetFilter(Quantity, '<>0');
                TimeSheetDetail.SetRange(Posted, false);
                if TimeSheetDetail.FindFirst() then
                    repeat
                        QtyToPost := TimeSheetDetail.GetMaxQtyToPost();
                        if QtyToPost <> 0 then begin
                            JobJnlLine.Init();
                            LineNo := LineNo + 10000;
                            JobJnlLine."Line No." := LineNo;
                            JobJnlLine."Time Sheet No." := TimeSheetDetail."Time Sheet No.";
                            JobJnlLine."Time Sheet Line No." := TimeSheetDetail."Time Sheet Line No.";
                            JobJnlLine."Time Sheet Date" := TimeSheetDetail.Date;
                            JobJnlLine.Validate("Job No.", TimeSheetDetail."Job No.");
                            JobJnlLine."Source Code" := JobJnlTemplate."Source Code";
                            if TimeSheetDetail."Job Task No." <> '' then
                                JobJnlLine.Validate("Job Task No.", TimeSheetDetail."Job Task No.");
                            JobJnlLine.Validate(Type, JobJnlLine.Type::Resource);
                            JobJnlLine.Validate("No.", TimeSheetHeader."Resource No.");
                            if TempTimeSheetLine."Work Type Code" <> '' then
                                JobJnlLine.Validate("Work Type Code", TempTimeSheetLine."Work Type Code");
                            JobJnlLine.Validate("Posting Date", TimeSheetDetail.Date);
                            JobJnlLine."Document No." := NextDocNo;
                            NextDocNo := INCSTR(NextDocNo);
                            JobJnlLine."Posting No. Series" := JobJnlBatch."Posting No. Series";
                            JobJnlLine.Description := TempTimeSheetLine.Description;
                            JobJnlLine.Validate(Quantity, QtyToPost);
                            JobJnlLine.Validate(Chargeable, TempTimeSheetLine.Chargeable);
                            JobJnlLine."Reason Code" := JobJnlBatch."Reason Code";
                            OnAfterTransferTimeSheetDetailToJobJnlLine(JobJnlLine, JobJnlTemplate, TempTimeSheetLine, TimeSheetDetail);
                            JobJnlLine.Insert();

                            // ERPX/ChC/SP02 - Travel Expenses
                            if TravelingExpenses and (JobJnlLine."Work Type Code" = 'HDEPL') then begin
                                LineNo := LineNo + 10000;
                                _JobJnlLine.Init();
                                _JobJnlLine.Validate("Journal Template Name", JobJnlLine."Journal Template Name");
                                _JobJnlLine.Validate("Journal Batch Name", JobJnlLine."Journal Batch Name");
                                _JobJnlLine.Validate("Line Type", _JobJnlLine."Line Type"::Billable);
                                _JobJnlLine.Validate("Line No.", LineNo);
                                _JobJnlLine.Validate("Job No.", JobJnlLine."Job No.");
                                _JobJnlLine.Validate("Job Task No.", JobJnlLine."Job Task No.");
                                _JobJnlLine.Validate("Posting Date", JobJnlLine."Posting Date");
                                _JobJnlLine.Validate("Document No.", NextDocNo);
                                NextDocNo := INCSTR(NextDocNo);
                                _JobJnlLine.Validate(Type, _JobJnlLine.Type::Item);
                                _JobJnlLine.Validate("No.", 'DEPL-FORFA');
                                _JobJnlLine.Validate(Quantity, 1);
                                _JobJnlLine.Validate(Chargeable, TRUE);
                                _JobJnlLine.Insert();
                            end;
                            // ERPX/ChC/SP02 +

                        end;
                    until TimeSheetDetail.Next() = 0;
            until TempTimeSheetLine.Next() = 0;
        end;
    end;

    var
        JobJnlLine: Record "Job Journal Line";
        JobJnlBatch: Record "Job Journal Batch";
        JobJnlTemplate: Record "Job Journal Template";
        TimeSheetHeader: Record "Time Sheet Header";
        TimeSheetLine: Record "Time Sheet Line";
        TempTimeSheetLine: Record "Time Sheet Line" temporary;
        TimeSheetDetail: Record "Time Sheet Detail";
        ResourceNoFilter: Code[1024];
        JobNoFilter: Code[1024];
        JobTaskNoFilter: Code[1024];
        StartingDate: Date;
        EndingDate: Date;
        DateFilter: Text[30];
        // ERPX/ChC/SP02 -
        TravelingExpenses: Boolean;
        ProjectManagerFilter: Text[50];
        // ERPX/ChC/SP02 +

    [Scope('Personalization')]
    procedure SetJobJnlLine(NewJobJnlLine: Record "Job Journal Line")
    begin
        JobJnlLine := NewJobJnlLine;
    end;

    [Scope('Personalization')]
    procedure InitParameters(NewJobJnlLine: Record "Job Journal Line"; NewResourceNoFilter: Code[1024]; NewJobNoFilter: Code[1024]; NewJobTaskNoFilter: Code[1024]; NewStartingDate: Date; NewEndingDate: Date)
    begin
        JobJnlLine := NewJobJnlLine;
        ResourceNoFilter := NewResourceNoFilter;
        JobNoFilter := NewJobNoFilter;
        JobTaskNoFilter := NewJobTaskNoFilter;
        StartingDate := NewStartingDate;
        EndingDate := NewEndingDate;
    end;

    local procedure FillTimeSheetLineBuffer()
    var
        // ERPX/ChC/SP02 -
        _Job: Record Job;
        // ERPX/ChC/SP02 +
        SkipLine: Boolean;
    begin
        if ResourceNoFilter <> '' then
            TimeSheetHeader.SetFilter("Resource No.", ResourceNoFilter);
        if DateFilter <> '' then begin
            TimeSheetHeader.SetFilter("Starting Date", DateFilter);
            TimeSheetHeader.SetFilter("Starting Date", '..%1', TimeSheetHeader.GETRANGEMAX("Starting Date"));
            TimeSheetHeader.SetFilter("Ending Date", DateFilter);
            TimeSheetHeader.SetFilter("Ending Date", '%1..', TimeSheetHeader.GETRANGEMIN("Ending Date"));
        end;

        if TimeSheetHeader.FindSet() then
            repeat
                TimeSheetLine.SetRange("Time Sheet No.", TimeSheetHeader."No.");
                TimeSheetLine.SetRange(Type, TimeSheetLine.Type::Job);
                TimeSheetLine.SetRange(Status, TimeSheetLine.Status::Approved);
                if JobNoFilter <> '' then
                    TimeSheetLine.SetFilter("Job No.", JobNoFilter);
                if JobTaskNoFilter <> '' then
                    TimeSheetLine.SetFilter("Job Task No.", JobTaskNoFilter);
                TimeSheetLine.SetRange(Posted, false);
                if TimeSheetLine.FindSet() then
                    repeat
                        TempTimeSheetLine := TimeSheetLine;
                        OnBeforeInsertTempTimeSheetLine(JobJnlLine, TimeSheetHeader, TempTimeSheetLine, SkipLine);

                        // ERPX/ChC/SP02 - Project Manager Filter
                        if (ProjectManagerFilter = '') or (_Job."Project Manager" = ProjectManagerFilter) then
                            SkipLine := (ProjectManagerFilter <> '') and (_Job."Project Manager" <> ProjectManagerFilter);
                        // ERPX/ChC/SP02 +

                        if NOT SkipLine then
                            TempTimeSheetLine.Insert();
                    until TimeSheetLine.Next() = 0;
            until TimeSheetHeader.Next() = 0;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertTempTimeSheetLine(JobJournalLine: Record "Job Journal Line"; TimeSheetHeader: Record "Time Sheet Header"; var TempTimeSheetLine: Record "Time Sheet Line" temporary; var SkipLine: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterTransferTimeSheetDetailToJobJnlLine(var JobJournalLine: Record "Job Journal Line"; JobJournalTemplate: Record "Job Journal Template"; var TempTimeSheetLine: Record "Time Sheet Line" temporary; TimeSheetDetail: Record "Time Sheet Detail")
    begin
    end;
}


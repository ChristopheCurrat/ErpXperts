report 50019 "ErpX_Make Sales Quote"
{
    DefaultLayout = Word;
    WordLayout = './Make Sales Quote.docx';
    Caption = 'Make Sales Quote';
    ProcessingOnly = true;
    Description = 'SP05';
    dataset
    {
        dataitem(Job; Job)
        {
            DataItemTableView = SORTING ("No.");
            MaxIteration = 1;
            dataitem("Job Task"; "Job Task")
            {
                DataItemLink = "Job No." = FIELD ("No.");
                DataItemTableView = SORTING ("Job No.", "Job Task No.");
                dataitem("Job Planning Line"; "Job Planning Line")
                {
                    DataItemLink = "Job No." = FIELD ("Job No."), "Job Task No." = FIELD ("Job Task No.");
                    DataItemTableView = SORTING ("Job No.", "Job Task No.", "Line No.");

                    trigger OnAfterGetRecord();
                    begin
                        InitSalesLine();

                        case Type of
                            Type::Resource:
                                SalesLine.VALIDATE(Type, SalesLine.Type::Resource);
                            Type::Item:
                                SalesLine.VALIDATE(Type, SalesLine.Type::Item);
                            Type::"G/L Account":
                                SalesLine.VALIDATE(Type, SalesLine.Type::"G/L Account");
                            Type::Text:
                                SalesLine.VALIDATE(Type, 0);
                        end;
                        SalesLine.VALIDATE("No.", "No.");
                        SalesLine.VALIDATE(Description, Description);
                        if Type <> Type::Text then begin
                            SalesLine.VALIDATE(Quantity, Quantity);
                            SalesLine.VALIDATE("Unit of Measure Code", "Unit of Measure Code");
                            SalesLine.VALIDATE("Unit Price", "Unit Price");
                        end;
                        SalesLine.Modify(TRUE);
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    InitSalesLine();

                    SalesLine.VALIDATE(Type, SalesLine.Type::Title);
                    SalesLine.VALIDATE(Description, Description);
                    SalesLine.MODIFY(TRUE);
                end;

                trigger OnPreDataItem();
                begin
                    SETRANGE("Job No.", JobFilter);
                    SETFILTER("Job Task No.", JobTaskFilter);
                end;
            }

            trigger OnAfterGetRecord();
            var
                _Text001Lbl: Label 'Job: %1, %2 ';
            begin
                SalesHeader."Document Type" := SalesHeader."Document Type"::Quote;
                SalesHeader.INSERT(TRUE);

                SalesHeader.VALIDATE("Sell-to Customer No.", "Bill-to Customer No.");
                SalesHeader.SetWorkDescription(STRSUBSTNO(_Text001Lbl, "No.", Description));
                SalesHeader.MODIFY(TRUE);
            end;

             trigger OnPreDataItem();
            begin
                SETRANGE("No.", JobFilter);
            end;
        }
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
                    field(JobFilter; JobFilter)
                    {
                        Caption = 'Job Filter';
                        TableRelation = Job;
                        ApplicationArea = Jobs;

                        trigger OnValidate();
                        begin
                            JobTaskFilter := '';
                        end;
                    }
                    field(JobTaskFilter; JobTaskFilter)
                    {
                        Caption = 'Job Task Filter';
                        TableRelation = "Job Task"."Job Task No.";
                        ApplicationArea = Jobs;

                        trigger OnLookup(Text: Text): Boolean;
                        var
                            _JobTask: Record "Job Task";
                        begin
                            _JobTask.SETRANGE("Job No.", JobFilter);
                            IF PAGE.RUNMODAL(0, _JobTask) = ACTION::LookupOK THEN
                                JobTaskFilter := _JobTask."Job Task No.";
                        end;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        JobNoLbl = 'Job No.';
        JobDescriptionLbl = 'Description';
    }

    trigger OnPostReport();
    var
        Text001Lbl: Label 'The quote %1 has been created from Joib no. %2.\Do you want to edit the new quote?';
    begin
        Commit();
        if Confirm(StrSubstNo(Text001Lbl, SalesHeader."No.", Job."No."), TRUE) then
          PAGE.RUNMODAL(PAGE::"Sales Quote", SalesHeader);
    end;

    local procedure InitSalesLine();
    begin
        LineNo += 10000;
        WITH SalesLine DO BEGIN
            "Document Type" := SalesHeader."Document Type";
            "Document No." := SalesHeader."No.";
            "Line No." := LineNo;
            VALIDATE("Sell-to Customer No.", SalesHeader."Sell-to Customer No.");
            VALIDATE("Job No.", "Job Task"."Job No.");
            VALIDATE("Job Task No.", "Job Task"."Job Task No.");
            INSERT(TRUE);
        END;
    end;

    procedure SetJobNo(_JobNo: Code[20]);
    begin
        JobFilter := _JobNo;
        JobTaskFilter := '';
    end;

    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
        JobFilter: Code[20];
        JobTaskFilter: Code[20];


}


pageextension 50011 "ErpX_Cash Receipt Journal" extends "Cash Receipt Journal"
{
    Description = 'X031';

    actions
    {
        addafter(Approvals)
        {
            action(ImportBankCamt054)
            {
                ApplicationArea = Basic,Suite;
                Caption = '&Import CAMT054';
                Ellipsis = true;
                Image = XMLFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Import a file for transaction payments that was made from your bank account and apply the payments to the entry. The file name must end in .csv, .txt, asc, or .xml.';

                trigger OnAction()
                begin
                    // ERPX/ChC/ X031 -
                    ImportCamt054();
                    // ERPX/ChC/ X031 +
                end;
            }
        }
    }

    procedure ImportCamt054()
    var
        _BankAccReconciliation: Record "Bank Acc. Reconciliation";
        _BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";
        _GenJournalLine: Record "Gen. Journal Line";
        _GenJournalLine2: Record "Gen. Journal Line";
        _GenJournalBatch: Record "Gen. Journal Batch";
        _CustLedgerEntry: Record "Cust. Ledger Entry";
        _GeneralLedgerSetup: Record "General Ledger Setup";
        _ESRSetup: Record "ESR Setup";
        _NoSeriesMgt: Codeunit "NoSeriesManagement";
        Text011Lbl: Label 'Import cancelled.';
        Text020Lbl: Label 'ESR payment, inv ';
        //Text021Lbl: Label 'ESR correction debit ';
        //Text022Lbl: Label 'ESR correction ';
        _NoRecords: Integer;
        _TotalAmt: Decimal;
        _FirstPostingDate: Date;
        _MultiplePostingDates: Boolean;
        Text025Lbl: Label 'ESR payment ';
        //Text026Lbl: Label 'Checksum error on import.\\The number of payments or the sum of amounts does not match the checksum record.\\Total records read    : %1\Total of checksum     : %2\Total amounts read    : %3\Total of checksum     : %4.', Comment='All parameters are numbers.';
        Text036Lbl: Label '%1 payments of %2 were successfully imported.', Comment='Parameters 1 and 2 - numbers.';
        _DocumentNo: Code[20];
    begin
        // ERPX/ChC/ X031 -
        // One or multiple ESR banks
        if _ESRSetup.Count() = 1 then
          _ESRSetup.FindFirst()
        else
          if PAGE.RUNMODAL(PAGE::"ESR Setup List", _ESRSetup) = ACTION::LookupCancel then
            ERROR(Text011Lbl);
        
        _BankAccReconciliation.Init();;
        _BankAccReconciliation."Statement Type" := _BankAccReconciliation."Statement Type"::"Payment Application";
        _BankAccReconciliation."Bank Account No." := _ESRSetup."Bal. Account No.";
        _BankAccReconciliation."Statement No." := 'ESR';
        if _BankAccReconciliation.Insert() then;
        
        _BankAccReconciliationLine.SetRange("Statement Type", _BankAccReconciliation."Statement Type");
        _BankAccReconciliationLine.SetRange("Bank Account No.", _BankAccReconciliation."Bank Account No.");
        _BankAccReconciliationLine.SetRange("Statement No.", _BankAccReconciliation."Statement No.");
        _BankAccReconciliationLine.DeleteAll();
        
        _BankAccReconciliation.ImportBankStatement();
        
        _GenJournalBatch.GET("Journal Template Name", "Journal Batch Name");
        _DocumentNo := _NoSeriesMgt.GetNextNo(_GenJournalBatch."No. Series", WorkDate(), false);
        
        with _GenJournalLine do begin
          if _BankAccReconciliationLine.FindSet() then
            repeat
              Init();
              "Journal Template Name" := Rec."Journal Template Name";
              "Journal Batch Name" := Rec."Journal Batch Name";
              "Line No." := _BankAccReconciliationLine."Statement Line No.";
        
              "Posting Date" := _BankAccReconciliationLine."Transaction Date";
              "Account Type" := _GenJournalLine."Account Type"::Customer;
              "Document Type" := _GenJournalLine."Document Type"::Payment;
              "Document No." := _DocumentNo;
        
              // Currency
              _GeneralLedgerSetup.Get();
              if _GeneralLedgerSetup."LCY Code" <> GetDataExch(_BankAccReconciliationLine, 11) then
                Validate("Currency Code", GetDataExch(_BankAccReconciliationLine, 11));
        
        
              // Fetch customer based on invoice no.
              _CustLedgerEntry.SETCURRENTKEY("Document No.");
              _CustLedgerEntry.SetRange("Document Type", _CustLedgerEntry."Document Type"::Invoice);
              _CustLedgerEntry.SetRange("Document No.", TrimInvoiceNo(COPYSTR(GetDataExch(_BankAccReconciliationLine, 29), 19, 8)));
              if _CustLedgerEntry.FindFirst() then begin
                Validate("Account No.", _CustLedgerEntry."Customer No.");
                if "Currency Code" <> _CustLedgerEntry."Currency Code" then
                  Validate("Currency Code", _CustLedgerEntry."Currency Code");
              end else
                Validate("Currency Code");
              "Applies-to Doc. Type" := "Applies-to Doc. Type"::Invoice;
              "Applies-to Doc. No." := TrimInvoiceNo(COPYSTR(GetDataExch(_BankAccReconciliationLine, 29),19,8));
        
        
              // Process transaction of credit record
              if GetDataExch(_BankAccReconciliationLine, 10) = 'CRDT' then begin
                Description := Text020Lbl + ' ' + "Applies-to Doc. No.";
                Amount := -_BankAccReconciliationLine."Statement Amount";
              end;
              /*
              CASE Transaction OF
                Transaction::Credit:
                  begin
                    GenJournalLine.Description := Text020 + ' ' + InInvoiceNo;
                    GenJournalLine.Amount := -InvoiceAmt / 100;
                  end;
                Transaction::Cancellation:
                  begin
                    GenJournalLine."Document Type" := GenJournalLine."Document Type"::Invoice;
                    GenJournalLine."Applies-to Doc. Type" := GenJournalLine."Applies-to Doc. Type"::" ";
                    GenJournalLine."Applies-to Doc. No." := '';
                    GenJournalLine.Description := FORMAT(Text021 + ' ' + InInvoiceNo,-MAXSTRLEN(GenJournalLine.Description ));
                    GenJournalLine.Amount := InvoiceAmt / 100;
                  end;
                Transaction::Correction:
                  begin
                    GenJournalLine.Description := Text022 + ' ' + InInvoiceNo;
                    GenJournalLine.Amount := -InvoiceAmt / 100;
                  end;
              end;
              */
        
              "Source Code" := 'ESR';
              "Reason Code" := _GenJournalBatch."Reason Code";
              //_GenJournalLine."External Document No." := MicroFilmNo;
              //_GenJournalLine."ESR Information" := 'ESR ' + RefNo + '/' + PaymentCharges + '/' + ddVA + '.' + mmVA + '.' + yyVA + '/' + TA;
              "ESR Information" := Format(GetDataExch(_BankAccReconciliationLine, 13));
              Insert();
        
              Validate(Amount, Amount);
              Modify();
        
              // All lines same credit date? (one/multiple balance postings)
              if _FirstPostingDate = 0D then  // Save first
                _FirstPostingDate := "Posting Date";
              if _FirstPostingDate <> "Posting Date" then  // Compare subsequent
                _MultiplePostingDates := true;
        
              _NoRecords += 1;
              _TotalAmt -= Amount;
            UNTIL _BankAccReconciliationLine.Next() = 0;
        
        
          // *** Bal account per line or as combined entry
          if _MultiplePostingDates then begin
            // Bal Account per line
            if FindFirst() then
              repeat
                if _ESRSetup."Bal. Account Type" = _ESRSetup."Bal. Account Type"::"Bank Account" then
                  "Bal. Account Type" := "Bal. Account Type"::"Bank Account"
                else
                  "Bal. Account Type" := "Bal. Account Type"::"G/L Account";
                Validate("Bal. Account No.", _ESRSetup."Bal. Account No.");
                Modify()
              UNTIL Next() = 0;
          end else begin
            // Add bal. acc. line at end
            _GenJournalLine2.SetRange("Journal Template Name", "Journal Template Name");
            _GenJournalLine2.SetRange("Journal Batch Name", "Journal Batch Name");
            _GenJournalLine2.FindLast();
        
            Init();
            "Journal Template Name" := _GenJournalLine2."Journal Template Name";
            "Journal Batch Name" := _GenJournalLine2."Journal Batch Name";
            "Line No." := _GenJournalLine2."Line No." + 10000;
            "Document No." := _GenJournalLine2."Document No.";
            "Account Type" := _ESRSetup."Bal. Account Type";
        
            // Currency
            _GeneralLedgerSetup.Get();
            if _GeneralLedgerSetup."LCY Code" <> GetDataExch(_BankAccReconciliationLine, 11) then
              Validate("Currency Code", GetDataExch(_BankAccReconciliationLine, 11));
        
            if _ESRSetup."Bal. Account Type" = _ESRSetup."Bal. Account Type"::"Bank Account" then
              "Account Type" := "Bal. Account Type"::"Bank Account"
            else
              "Account Type" := "Bal. Account Type"::"G/L Account";
        
            "Posting Date" := _GenJournalLine2."Posting Date";
            "Source Code" := 'ESR';
        
            Validate("Account No.", _ESRSetup."Bal. Account No.");
            Description := Text025Lbl + ' ' + _ESRSetup."Bank Code";
            Validate("Document Type", "Document Type"::Payment);
            Validate(Amount, _TotalAmt);
            Insert()
          end;
        end;
        
        MESSAGE(Text036Lbl, _NoRecords, _TotalAmt);
        // ERPX/ChC/ X031 +

    end;

    local procedure GetDataExch(_BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line";_ColumnNo: Integer): Text[250]
    var
        _DataExchField: Record "Data Exch. Field";
    begin
        // ERPX/ChC/ X031 -
        _DataExchField.SetRange("Data Exch. No.", _BankAccReconciliationLine."Data Exch. Entry No.");
        _DataExchField.SetRange("Line No.", _BankAccReconciliationLine."Data Exch. Line No.");
        _DataExchField.SetRange("Column No.", _ColumnNo);
        if _DataExchField.FindFirst() then
          exit(_DataExchField.Value)
        else
          exit('');
        // ERPX/ChC/ X031 +
    end;

    local procedure TrimInvoiceNo(InvoiceNo: Code[10]) InInvoiceNo: Code[10]
    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntry2: Record "Cust. Ledger Entry";
        InvCount: Integer;
        TmpInvNo: Code[10];
        ReferenceNo: Code[10];
        Text042Lbl: Label 'More than one open invoice were found for the Reference No. %1.';
    begin
        // ERPX/ChC/ X031 -
        ReferenceNo := InvoiceNo;
        TmpInvNo := InvoiceNo;
        CustLedgEntry.SETCURRENTKEY("Document No.");
        CustLedgEntry.SetRange("Document Type",CustLedgEntry."Document Type"::Invoice);
        CustLedgEntry.SetRange(Open,true);
        while TmpInvNo[1] = '0' do begin
          CustLedgEntry.SetRange("Document No.",TmpInvNo);
          if CustLedgEntry.FindFirst() then begin
            InvCount := InvCount + 1;
            if InvCount > 1 then
              ERROR(Text042Lbl,ReferenceNo);
            InInvoiceNo := TmpInvNo;
          end;
          TmpInvNo := Format(CopyStr(TmpInvNo, 2));
        end;
        if InvCount = 0 then
          InInvoiceNo := TmpInvNo;

        if (TmpInvNo[1] <> '0') and (InvCount = 1) then begin
          CustLedgEntry2.SETCURRENTKEY("Document No.");
          CustLedgEntry2.SetRange("Document Type",CustLedgEntry2."Document Type"::Invoice);
          CustLedgEntry2.SetRange(Open,true);
          CustLedgEntry2.SetRange("Document No.",TmpInvNo);
          if CustLedgEntry2.FindFirst() then
            ERROR(Text042Lbl,ReferenceNo);
        end;
        // ERPX/ChC/ X031 +
    end;
}
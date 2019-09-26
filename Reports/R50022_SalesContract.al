report 50022 "ErpX_Sales - Contract"
{
    // SP05      07.03.17/ERPX/ChC- Copy from 204 Sales - Quote

    DefaultLayout = RDLC;
    RDLCLayout = './Reports/Sales - Contract.rdlc';
    Caption = 'Sales - Contract';
    PreviewMode = PrintLayout;
    Description = 'SP05';

    dataset
    {
        dataitem("Sales Header"; "Sales Header")
        {
            DataItemTableView = SORTING ("Document Type", "No.")
                                WHERE ("Document Type" = CONST (Quote));
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Sales Quote';
            column(DocType_SalesHeader; "Document Type")
            {
            }
            column(No_SalesHeader; "No.")
            {
            }
            column(SalesLineVATIdentifierCaption; SalesLineVATIdentifierCaptionLbl)
            {
            }
            column(CompanyInfoHomePageCaption; CompanyInfoHomePageCaptionLbl)
            {
            }
            column(CompanyInfoEmailCaption; CompanyInfoEmailCaptionLbl)
            {
            }
            column(DocumentDateCaption; DocumentDateCaptionLbl)
            {
            }
            column(SalesLineAllowInvoiceDiscCaption; SalesLineAllowInvoiceDiscCaptionLbl)
            {
            }
            // ERPX/ChC -
            column(ShowTopAddress; ErpXpertsFunctions.ShowTopAddress())
            {
            }
            column(ShowVATDetails; ErpXpertsFunctions.ShowVATDetails())
            {
            }
            column(BottomAddress1; ErpXpertsFunctions.GetBottomAddress(1, "Currency Code"))
            {
            }
            column(BottomAddress2; ErpXpertsFunctions.GetBottomAddress(2, "Currency Code"))
            {
            }
            column(HasLineDiscount; ErpXpertsFunctions.HasLineDiscount(36, "Document Type", "No."))
            {
            }
            column(FaxNoCaption; FaxNoCaptionLbl)
            {
            }
            column(CompanyInfoFaxNo; CompanyInfo."Fax No.")
            {
            }
            // ERPX/ChC +
            // ERPX/ChC/SP05 -
            column(WorkDescription_SalesHeader; TempBlobWorkDescription.ReadTextLine())
            {
            }
            column(Image_SalesPurchPerson; SalesPurchPerson.Image)
            {
            }
            // ERPX/ChC/SP05 +
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING (Number);
                dataitem(PageLoop; Integer)
                {
                    DataItemTableView = SORTING (Number)
                                        WHERE (Number = CONST (1));
                    column(CompanyInfo2Picture; CompanyInfo2.Picture)
                    {
                    }
                    column(CompanyInfo3Picture; CompanyInfo3.Picture)
                    {
                    }
                    column(CompanyInfo1Picture; CompanyInfo1.Picture)
                    {
                    }
                    column(SalesCopyText; StrSubstNo(Text004Lbl, CopyText))
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(HeaderLabel1; HeaderLabel[1])
                    {
                    }
                    column(HeaderLabel2; HeaderLabel[2])
                    {
                    }
                    column(HeaderLabel3; HeaderLabel[3])
                    {
                    }
                    column(HeaderLabel4; HeaderLabel[4])
                    {
                    }
                    column(HeaderTxt1; HeaderTxt[1])
                    {
                    }
                    column(HeaderTxt2; HeaderTxt[2])
                    {
                    }
                    column(HeaderTxt3; HeaderTxt[3])
                    {
                    }
                    column(HeaderTxt4; HeaderTxt[4])
                    {
                    }
                    column(FooterLabel1; FooterLabel[1])
                    {
                    }
                    column(FooterLabel2; FooterLabel[2])
                    {
                    }
                    column(FooterLabel3; FooterLabel[3])
                    {
                    }
                    column(FooterLabel4; FooterLabel[4])
                    {
                    }
                    column(FooterLabel5; FooterLabel[5])
                    {
                    }
                    column(FooterLabel6; FooterLabel[6])
                    {
                    }
                    column(FooterLabel7; FooterLabel[7])
                    {
                    }
                    column(FooterLabel8; FooterLabel[8])
                    {
                    }
                    column(FooterTxt1; FooterTxt[1])
                    {
                    }
                    column(FooterTxt2; FooterTxt[2])
                    {
                    }
                    column(FooterTxt3; FooterTxt[3])
                    {
                    }
                    column(FooterTxt4; FooterTxt[4])
                    {
                    }
                    column(FooterTxt5; FooterTxt[5])
                    {
                    }
                    column(FooterTxt6; FooterTxt[6])
                    {
                    }
                    column(FooterTxt7; FooterTxt[7])
                    {
                    }
                    column(FooterTxt8; FooterTxt[8])
                    {
                    }
                    column(CustomerNoCaption; CustomerNoCaptionLbl)
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CompanyInfoEmail; CompanyInfo."E-Mail")
                    {
                    }
                    column(CompanyInfoHomePage; CompanyInfo."Home Page")
                    {
                    }
                    column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
                    {
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
                    {
                    }
                    column(BilltoCustNo_SalesHeader; "Sales Header"."Bill-to Customer No.")
                    {
                    }
                    column(DocDate_SalesHeader; FORMAT("Sales Header"."Document Date", 0, '<Day,2>.<Month,2>.<Year4>'))
                    {
                    }
                    column(No1_SalesHeader; "Sales Header"."No.")
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(PricesIncludingVAT_SalesHdr; "Sales Header"."Prices Including VAT")
                    {
                    }
                    column(PageCaption; StrSubstNo(Text005Lbl, ''))
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(CompanyInfoPhoneNoCaption; CompanyInfoPhoneNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoVATRegNoCaption; CompanyInfoVATRegNoCaptionLbl)
                    {
                    }
                    column(CompanyInfoRegNo; CompanyInfo."Registration No.")
                    {
                    }
                    column(CompanyInfoRegNoCaption; CompanyInfoRegNoCaptionLbl)
                    {
                    }
                    // ERPX/ChC -
                    dataitem(HeaderText; "Sales Comment Line")
                    {
                        DataItemLink = "No." = FIELD ("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING ("Document Type", "No.", "Document Line No.", "Line No.")
                                            WHERE ("Document Type" = CONST (Quote),
                                                  "ErpX_Line Type" = CONST (Header));
                        column(HeaderText_Comment; Comment)
                        {
                        }
                    }
                    dataitem(FooterText; "Sales Comment Line")
                    {
                        DataItemLink = "No." = FIELD ("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING ("Document Type", "No.", "Document Line No.", "Line No.")
                                            WHERE ("Document Type" = CONST (Quote),
                                                  "ErpX_Line Type" = CONST (Footer));
                        column(FooterText_Comment; Comment)
                        {
                        }
                    }
                    // ERPX/ChC +
                    dataitem(DimensionLoop1; Integer)
                    {
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = FILTER (1 ..));
                        column(DimText; DimText)
                        {
                        }
                        column(HeaderDimensionsCaption; HeaderDimensionsCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then begin
                                if not DimSetEntry1.Findset() then
                                    CurrReport.Break();
                            end else
                                if not Continue then
                                    CurrReport.Break();

                            Clear(DimText);
                            Continue := false;
                            repeat
                                OldDimText := CopyStr(DimText, 1, MaxStrLen(OldDimText)); // ori OldDimText := DimText;
                                if DimText = '' then
                                    DimText := StrSubstNo('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText :=
                                      StrSubstNo(
                                        '%1, %2 %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                    DimText := OldDimText;
                                    Continue := true;
                                    EXIT;
                                end;
                            until DimSetEntry1.Next() = 0;

                            // ERPX/ChC/SP05 -
                            CLEAR(TempBlobWorkDescription);
                            "Sales Header".CalcFields("Work Description");
                            TempBlobWorkDescription.Blob := "Sales Header"."Work Description";
                            // ERPX/ChC/SP05 +
                        end;

                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then
                                CurrReport.Break();
                        end;
                    }
                    dataitem("Sales Line"; "Sales Line")
                    {
                        DataItemLink = "Document Type" = FIELD ("Document Type"),
                                       "Document No." = FIELD ("No.");
                        DataItemLinkReference = "Sales Header";
                        DataItemTableView = SORTING ("Document Type", "Document No.", "Line No.");

                        trigger OnPreDataItem()
                        begin
                            CurrReport.Break();
                        end;
                    }
                    dataitem(RoundLoop; Integer)
                    {
                        DataItemTableView = SORTING (Number);
                        column(LineAmt_SalesLine; SalesLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(No_SalesLine; "Sales Line"."No.")
                        {
                        }
                        column(Desc_SalesLine; "Sales Line".Description)
                        {
                        }
                        column(Quantity_SalesLine; "Sales Line".Quantity)
                        {
                        }
                        column(UnitofMeasure_SalesLine; "Sales Line"."Unit of Measure")
                        {
                        }
                        column(LineAmt1_SalesLine; "Sales Line"."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(UnitPrice_SalesLine; "Sales Line"."Unit Price")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 2;
                        }
                        column(LineDiscount_SalesLine; "Sales Line"."Line Discount %")
                        {
                        }
                        column(AllowInvoiceDisc_SalesLine; "Sales Line"."Allow Invoice Disc.")
                        {
                            IncludeCaption = false;
                        }
                        column(VATPercentage_SalesLine; "Sales Line"."VAT %")
                        {
                        }
                        column(SalesLineSubtotalNet; SalesLine."Subtotal Net")
                        {
                        }
                        column(Type_SalesLine; FORMAT("Sales Line".Type))
                        {
                        }
                        column(No1_SalesLine; "Sales Line"."Line No.")
                        {
                        }
                        column(AllowInvoiceDisYesNo; FORMAT("Sales Line"."Allow Invoice Disc."))
                        {
                        }
                        column(InvDiscountAmount_SalesLine; -SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(DiscountAmt_SalesLine; SalesLine."Line Amount" - SalesLine."Inv. Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtTxt; VATAmountLine.VATAmountText())
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(VATAmount; VATAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATDiscountAmount; -VATDiscountAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATBaseAmount; VATBaseAmount)
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(SalesLineLineDiscCaption; SalesLineLineDiscCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(SalesLineInvDiscAmtCaption; SalesLineInvDiscAmtCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(VATDiscountAmountCaption; VATDiscountAmountCaptionLbl)
                        {
                        }
                        column(No_SalesLineCaption; "Sales Line".FIELDCAPTION("No."))
                        {
                        }
                        column(Desc_SalesLineCaption; "Sales Line".FIELDCAPTION(Description))
                        {
                        }
                        column(Quantity_SalesLineCaption; "Sales Line".FIELDCAPTION(Quantity))
                        {
                        }
                        column(UnitofMeasure_SalesLineCaption; "Sales Line".FIELDCAPTION("Unit of Measure"))
                        {
                        }
                        column(VATPercentageCaption; VATAmountLineVATCaptionLbl)
                        {
                        }
                        column(IsVariant; IsVariant)
                        {
                        }
                        column(NewPageGroupNo; NewPageGroupNo)
                        {
                        }
                        column(NewPageLine; NewPageLine)
                        {
                        }
                        // ERPX/ChC -
                        column(TariffNo; ErpXpertsFunctions.GetTariffNo(SalesLine.Type, SalesLine."No."))
                        {
                        }
                        column(CrossReferenceNo; ErpXpertsFunctions.GetCrossReferenceNo(SalesLine.Type, SalesLine."No.", 1, SalesLine."Sell-to Customer No.", SalesLine."Cross-Reference No."))
                        {
                        }
                        column(Position_SalesLine; "Sales Line".Position)
                        {
                        }
                        // ERPX/ChC +
                        dataitem(DimensionLoop2; Integer)
                        {
                            DataItemTableView = SORTING (Number)
                                                WHERE (Number = FILTER (1 ..));
                            column(DimText_DimnLoop2; DimText)
                            {
                            }
                            column(LineDimensionsCaption; LineDimensionsCaptionLbl)
                            {
                            }

                            trigger OnAfterGetRecord()
                            begin
                                if Number = 1 then begin
                                    if not DimSetEntry2.Findset() then
                                        CurrReport.Break();
                                end else
                                    if not Continue then
                                        CurrReport.Break();

                                Clear(DimText);
                                Continue := false;
                                repeat
                                    OldDimText := CopyStr(DimText, 1, MaxStrLen(OldDimText)); // ori OldDimText := DimText;
                                    if DimText = '' then
                                        DimText := StrSubstNo('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText :=
                                          StrSubstNo(
                                            '%1, %2 %3', DimText,
                                            DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if STRLEN(DimText) > MAXSTRLEN(OldDimText) then begin
                                        DimText := OldDimText;
                                        Continue := true;
                                        EXIT;
                                    end;
                                until DimSetEntry2.Next() = 0;
                            end;

                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then
                                    CurrReport.Break();

                                DimSetEntry2.SetRange("Dimension Set ID", "Sales Line"."Dimension Set ID");
                            end;
                        }

                        trigger OnAfterGetRecord()
                        begin
                            if Number = 1 then
                                SalesLine.FIND('-')
                            else
                                SalesLine.Next();
                            "Sales Line" := SalesLine;

                            if not "Sales Header"."Prices Including VAT" and
                               (SalesLine."VAT Calculation Type" = SalesLine."VAT Calculation Type"::"Full VAT")
                            then
                                SalesLine."Line Amount" := 0;

                            if (SalesLine.Type = SalesLine.Type::"G/L Account") and (not ShowInternalInfo) then
                                "Sales Line"."No." := '';

                            NewPageLine := "Sales Line".Type = "Sales Line".Type::"New Page";
                            if NewPageLine then
                                NewPageGroupNo += 1;
                        end;

                        trigger OnPostDataItem()
                        begin
                            SalesLine.DeleteAll();
                            ;
                        end;

                        trigger OnPreDataItem()
                        begin
                            MoreLines := SalesLine.FIND('+');
                            WHILE MoreLines and (SalesLine.Description = '') and (SalesLine."Description 2" = '') and
                                  (SalesLine."No." = '') and (SalesLine.Quantity = 0) and
                                  (SalesLine.Amount = 0)
                            DO
                                MoreLines := SalesLine.Next(-1) <> 0;
                            if not MoreLines then
                                CurrReport.Break();
                            SalesLine.SetRange("Line No.", 0, SalesLine."Line No.");
                            SetRange(Number, 1, SalesLine.Count());

                            NewPageLine := false;
                        end;
                    }
                    dataitem(VATCounter; Integer)
                    {
                        DataItemTableView = SORTING (Number);
                        column(VATBase_VATAmtLine; VATAmountLine."VAT Base")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VATAmt_VATAmtLine; VATAmountLine."VAT Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(LineAmount_VATAmtLine; VATAmountLine."Line Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(InvDiscBaseAmt_VATAmtLine; VATAmountLine."Inv. Disc. Base Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(InvoiceDiscAmt_VATAmtLine; VATAmountLine."Invoice Discount Amount")
                        {
                            AutoFormatExpression = "Sales Header"."Currency Code";
                            AutoFormatType = 1;
                        }
                        column(VAT_VATAmtLine; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATIdentifier_VATAmtLine; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmountLineVATCaption; VATAmountLineVATCaptionLbl)
                        {
                        }
                        column(VATBaseCaption; VATBaseCaptionLbl)
                        {
                        }
                        column(VATAmtCaption; VATAmtCaptionLbl)
                        {
                        }
                        column(VATAmountSpecificationCaption; VATAmountSpecificationCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
                        {
                        }
                        column(InvoiceDiscBaseAmtCaption; InvoiceDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(InvoiceDiscAmtCaption; InvoiceDiscAmtCaptionLbl)
                        {
                        }
                        column(TotalCaption; TotalCaptionLbl)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                        end;

                        trigger OnPreDataItem()
                        begin
                            if VATAmount = 0 then
                                CurrReport.Break();
                            SetRange(Number, 1, VATAmountLine.Count());
                        end;
                    }
                    dataitem(VATCounterLCY; Integer)
                    {
                        DataItemTableView = SORTING (Number);
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                            AutoFormatType = 1;
                        }
                        column(VATCtrl_VATAmtLine; VATAmountLine."VAT %")
                        {
                            DecimalPlaces = 0 : 5;
                        }
                        column(VATIdentifierCtrl_VATAmtLine; VATAmountLine."VAT Identifier")
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(Number);
                            VALVATBaseLCY :=
                              VATAmountLine.GetBaseLCY(
                                "Sales Header"."Posting Date", "Sales Header"."Currency Code", "Sales Header"."Currency Factor");
                            VALVATAmountLCY :=
                              VATAmountLine.GetAmountLCY(
                                "Sales Header"."Posting Date", "Sales Header"."Currency Code", "Sales Header"."Currency Factor");
                        end;

                        trigger OnPreDataItem()
                        begin
                            if (not GLSetup."Print VAT specification in LCY") OR
                               ("Sales Header"."Currency Code" = '') OR
                               (VATAmountLine.GetTotalVATAmount() = 0)
                            then
                                CurrReport.Break();

                            SetRange(Number, 1, VATAmountLine.Count());
                            Clear(VALVATBaseLCY);
                            Clear(VALVATAmountLCY);

                            if GLSetup."LCY Code" = '' then
                                VALSpecLCYHeader := Text008Lbl + Text009Lbl
                            else
                                VALSpecLCYHeader := Text008Lbl + FORMAT(GLSetup."LCY Code");

                            CurrExchRate.FindCurrency("Sales Header"."Order Date", "Sales Header"."Currency Code", 1);
                            VALExchRate := StrSubstNo(Text010Lbl, CurrExchRate."Relational Exch. Rate Amount", CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; Integer)
                    {
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = CONST (1));
                    }
                    dataitem(Total2; Integer)
                    {
                        DataItemTableView = SORTING (Number)
                                            WHERE (Number = CONST (1));
                        column(SelltoCustNo_SalesHeader; "Sales Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShiptoAddressCaption; ShiptoAddressCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesHeaderCaption; "Sales Header".FIELDCAPTION("Sell-to Customer No."))
                        {
                        }

                        trigger OnPreDataItem()
                        begin
                            if not ShowShippingAddr then
                                CurrReport.Break();
                        end;
                    }
                }

                trigger OnAfterGetRecord()
                var
                    SalesPost: Codeunit "Sales-Post";
                begin
                    Clear(SalesLine);
                    Clear(SalesPost);
                    SalesLine.DeleteAll();
                    ;
                    VATAmountLine.DeleteAll();
                    SalesPost.GetSalesLines("Sales Header", SalesLine, 0);
                    SalesLine.CalcVATAmountLines(0, "Sales Header", SalesLine, VATAmountLine);
                    SalesLine.UpdateVATOnLines(0, "Sales Header", SalesLine, VATAmountLine);
                    VATAmount := VATAmountLine.GetTotalVATAmount();
                    VATBaseAmount := VATAmountLine.GetTotalVATBase();
                    VATDiscountAmount :=
                      VATAmountLine.GetTotalVATDiscount("Sales Header"."Currency Code", "Sales Header"."Prices Including VAT");
                    TotalAmountInclVAT := VATAmountLine.GetTotalAmountInclVAT();

                    if Number > 1 then begin
                        CopyText := FormatDocument.GetCOPYText();
                        OutputNo += 1;
                    end;
                    // ERPX/ChC -
                    //CurrReport.PAGENO := 1;
                    // ERPX/ChC +
                end;

                trigger OnPostDataItem()
                begin
                    if Print then
                        CODEUNIT.RUN(CODEUNIT::"Sales-Printed", "Sales Header");
                end;

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    CopyText := '';
                    SetRange(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");

                PrepareHeader();
                PrepareFooter();

                FormatAddressFields("Sales Header");
                FormatDocumentFields("Sales Header");

                DimSetEntry1.SetRange("Dimension Set ID", "Dimension Set ID");

                if Print then begin
                    if CurrReport.UseRequestPage() and ArchiveDocument OR
                       not CurrReport.UseRequestPage() and (SalesSetup."Archive Quotes" = SalesSetup."Archive Quotes"::Always)
                    then
                        ArchiveManagement.StoreSalesDocument("Sales Header", LogInteraction);

                    if LogInteraction then begin
                        CalcFields("No. of Archived Versions");
                        if "Bill-to Contact No." <> '' then
                            SegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Contact, "Bill-to Contact No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.")
                        else
                            SegManagement.LogDocument(
                              1, "No.", "Doc. No. Occurrence",
                              "No. of Archived Versions", DATABASE::Customer, "Bill-to Customer No.",
                              "Salesperson Code", "Campaign No.", "Posting Description", "Opportunity No.");
                    end;
                end;
                MARK(true);
            end;

            trigger OnPostDataItem()
            var
                Task: Record "To-do";
                FileManagement: Codeunit "File Management";
            begin
                MARKEDONLY := true;
                Commit();
                CurrReport.LANGUAGE := GlobalLanguage();
                if not FileManagement.IsWebClient() and GuiAllowed() then
                    if Find('-') and Task.WritePermission() then
                        if Print and (NoOfRecords = 1) then
                            if CONFIRM(Text007Lbl) then
                                CreateTask();

                OnAfterPostDataItem("Sales Header");
            end;

            trigger OnPreDataItem()
            begin
                NoOfRecords := Count();
                Print := Print OR not IsReportInPreviewMode();

                CurrPageHeaderHiddenFlag := 0;
                CurrPageFooterHiddenFlag := 0;
                CurrGroupPageNO := 0;
                InnerGroupPageNO := 1;
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
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'No. of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Internal Information';
                        ToolTip = 'Specifies if you want the printed report to show information that is only for internal use.';
                    }
                    field(ArchiveDocument; ArchiveDocument)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Archive Document';
                        ToolTip = 'Specifies if the document is archived after you print it.';

                        trigger OnValidate()
                        begin
                            if not ArchiveDocument then
                                LogInteraction := false;
                        end;
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies if you want to record the service quotes that you want to print as interactions and add them to the Interaction Log Entry table.';

                        trigger OnValidate()
                        begin
                            if LogInteraction then
                                ArchiveDocument := ArchiveDocumentEnable;
                        end;
                    }
                    // ERPX/ChC -
                    field(PrintLogo; PrintLogo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Logo';
                    }
                    // ERPX/ChC +
                }
            }
        }

        actions
        {
        }

        trigger OnInit()
        begin
            LogInteractionEnable := true;

            CASE SalesSetup."Archive Quotes" OF
                SalesSetup."Archive Quotes"::Never:
                    ArchiveDocument := false;
                SalesSetup."Archive Quotes"::Always:
                    ArchiveDocument := true;
            end;
        end;

        trigger OnOpenPage()
        begin
            InitLogInteraction();

            LogInteractionEnable := LogInteraction;
            // ERPX\ChC -
            case ErpXpertsFunctions.ShowLogo() of
                1:
                    PrintLogo := true;
                2:
                    PrintLogo := false;
            end;
            // ERPX\ChC +

        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        CompanyInfo.Get();
        SalesSetup.Get();
        FormatDocument.SetLogoPosition(SalesSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);

        OnAfterInitReport();
    end;

    trigger OnPreReport()
    begin
        // ERPX\ChC -
        if NOT CurrReport.UseRequestPage() then
            PrintLogo := ErpXpertsFunctions.ShowLogoInEmail();

        if PrintLogo then begin
            CompanyInfo1.Get();
            CompanyInfo1.CalcFields(Picture);
        end else
            clear(CompanyInfo1.Picture);
        // ERPX\ChC +
    end;

    var
        GLSetup: Record "General Ledger Setup";
        ShipmentMethod: Record "Shipment Method";
        PaymentTerms: Record "Payment Terms";
        SalesPurchPerson: Record "Salesperson/Purchaser";
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        SalesSetup: Record "Sales & Receivables Setup";
        VATAmountLine: Record "VAT Amount Line" temporary;
        SalesLine: Record "Sales Line" temporary;
        DimSetEntry1: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        RespCenter: Record "Responsibility Center";
        Language: Record "Language";
        CurrExchRate: Record "Currency Exchange Rate";
        // ERPX/ChC/SP05 -
        TempBlobWorkDescription: Record TempBlob;
        // ERPX/ChC/SP05 +
        FormatAddr: Codeunit "Format Address";
        SegManagement: Codeunit "SegManagement";
        ArchiveManagement: Codeunit ArchiveManagement;
        FormatDocument: Codeunit "Format Document";
        // ERPX/ChC -
        ErpXpertsFunctions: Codeunit "ErpXperts Functions";
        // ERPX/ChC +
        CustAddr: array[8] of Text[100];
        ShipToAddr: array[8] of Text[100];
        CompanyAddr: array[8] of Text[100];
        SalesPersonText: Text[50];
        VATNoText: Text[80];
        ReferenceText: Text[80];
        TotalText: Text[50];
        TotalExclVATText: Text[50];
        TotalInclVATText: Text[50];
        MoreLines: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        CopyText: Text[30];
        ShowShippingAddr: Boolean;
        DimText: Text[120];
        OldDimText: Text[75];
        ShowInternalInfo: Boolean;
        Continue: Boolean;
        ArchiveDocument: Boolean;
        LogInteraction: Boolean;
        VATAmount: Decimal;
        VATBaseAmount: Decimal;
        VATDiscountAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        NoOfRecords: Integer;
        VALVATBaseLCY: Decimal;
        VALVATAmountLCY: Decimal;
        VALSpecLCYHeader: Text[80];
        VALExchRate: Text[50];
        Text004Lbl: Label 'Sales - Quote %1', Comment = '%1 = Document No.';
        Text005Lbl: Label 'Page %1';
        Text007Lbl: Label 'Do you want to create a follow-up task?';
        Text008Lbl: Label 'VAT Amount Specification in ';
        Text009Lbl: Label 'Local Currency';
        Text010Lbl: Label 'Exchange rate: %1/%2';
        OutputNo: Integer;
        Print: Boolean;
        [InDataSet]
        ArchiveDocumentEnable: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        CompanyInfoPhoneNoCaptionLbl: Label 'Phone No.';
        CompanyInfoVATRegNoCaptionLbl: Label 'VAT Registration No.';
        HeaderDimensionsCaptionLbl: Label 'Header Dimensions';
        UnitPriceCaptionLbl: Label 'Unit Price';
        SalesLineLineDiscCaptionLbl: Label 'Discount %';
        AmountCaptionLbl: Label 'Amount';
        SalesLineInvDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        SubtotalCaptionLbl: Label 'Subtotal';
        VATDiscountAmountCaptionLbl: Label 'Payment Discount on VAT';
        LineDimensionsCaptionLbl: Label 'Line Dimensions';
        VATAmountLineVATCaptionLbl: Label 'VAT %';
        VATBaseCaptionLbl: Label 'VAT Base';
        VATAmtCaptionLbl: Label 'VAT Amount';
        VATAmountSpecificationCaptionLbl: Label 'VAT Amount Specification';
        LineAmtCaptionLbl: Label 'Line Amount';
        InvoiceDiscBaseAmtCaptionLbl: Label 'Invoice Discount Base Amount';
        InvoiceDiscAmtCaptionLbl: Label 'Invoice Discount Amount';
        TotalCaptionLbl: Label 'Total';
        ShiptoAddressCaptionLbl: Label 'Ship-to Address';
        SalesLineVATIdentifierCaptionLbl: Label 'VAT Identifier';
        HeaderLabel: array[20] of Text[30];
        HeaderTxt: array[20] of Text;
        FooterLabel: array[20] of Text[30];
        FooterTxt: array[20] of Text;
        CurrGroupPageNO: Integer;
        CurrPageFooterHiddenFlag: Integer;
        CurrPageHeaderHiddenFlag: Integer;
        InnerGroupPageNO: Integer;
        CompanyInfoHomePageCaptionLbl: Label 'Home Page';
        CompanyInfoEmailCaptionLbl: Label 'E-Mail';
        DocumentDateCaptionLbl: Label 'Document Date';
        SalesLineAllowInvoiceDiscCaptionLbl: Label 'Allow Invoice Discount';
        CustomerNoCaptionLbl: Label 'Customer No.';
        CompanyInfoRegNoCaptionLbl: Label 'Reg. No.';
        IsVariant: Boolean;
        NewPageGroupNo: Integer;
        NewPageLine: Boolean;
        // ERPX/ChC -
        PrintLogo: Boolean;
        ML_NoDocExternLbl: Label 'External Document No.';
        FaxNoCaptionLbl: Label 'Fax No.';
        ML_PmtTermsLbl: Label 'Payment Terms';
        ML_ShipCondLbl: Label 'Shipping Conditions';
        ML_SalesPersonLbl: Label 'Salesperson';
        ML_ReferenceLbl: Label 'Reference';
        //ML_ShipAdrLbl: Label 'Shipping Address';
        //ML_InvAdrLbl: Label 'Invoice Address';
        //ML_OrderAdrLbl: Label 'Order Address';
        //ML_ShipDateLbl: Label 'Shipping Date';
        // ERPX/ChC +

        // ERPX/ChC/SP05 -
        ML_CustomerLbl: Label 'Customer : %1';
        ML_PlaceAndDateLbl: Label 'Place and Date : Givisiez, the %1';
        // ERPX/ChC/SP05 +

    [Scope('Personalization')]
    procedure InitializeRequest(NoOfCopiesFrom: Integer; ShowInternalInfoFrom: Boolean; ArchiveDocumentFrom: Boolean; LogInteractionFrom: Boolean; PrintFrom: Boolean)
    begin
        NoOfCopies := NoOfCopiesFrom;
        ShowInternalInfo := ShowInternalInfoFrom;
        ArchiveDocument := ArchiveDocumentFrom;
        LogInteraction := LogInteractionFrom;
        Print := PrintFrom;
    end;

    local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        EXIT(CurrReport.Preview() or MailManagement.IsHandlingGetEmailBody());
    end;

    local procedure InitLogInteraction()
    begin
        LogInteraction := SegManagement.FindInteractTmplCode(1) <> '';
    end;

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    begin
        with SalesHeader do begin
            FormatDocument.SetTotalLabels("Currency Code", TotalText, TotalInclVATText, TotalExclVATText);
            FormatDocument.SetSalesPerson(SalesPurchPerson, "Salesperson Code", SalesPersonText);
            FormatDocument.SetPaymentTerms(PaymentTerms, "Payment Terms Code", "Language Code");
            FormatDocument.SetShipmentMethod(ShipmentMethod, "Shipment Method Code", "Language Code");

            ReferenceText := FormatDocument.SetText("Your Reference" <> '', Format(FieldCaption("Your Reference")));
            VATNoText := FormatDocument.SetText("VAT Registration No." <> '', Format(FieldCaption("VAT Registration No.")));
        end;
    end;

    local procedure FormatAddressFields(var SalesHeader: Record "Sales Header")
    begin
        FormatAddr.GetCompanyAddr(SalesHeader."Responsibility Center", RespCenter, CompanyInfo, CompanyAddr);
        FormatAddr.SalesHeaderBillTo(CustAddr, SalesHeader);
        ShowShippingAddr := FormatAddr.SalesHeaderShipTo(ShipToAddr, CustAddr, SalesHeader);
    end;

    procedure PrepareHeader()
    var
        //CHReportManagement: Codeunit "CH Report Management";
        RecRef: RecordRef;
    begin
        FormatAddr.SalesHeaderSellTo(CustAddr, "Sales Header");
        RecRef.GETTABLE("Sales Header");
        //CHReportManagement.PrepareHeader(RecRef, REPORT::"Sales - Quote", HeaderLabel, HeaderTxt);

        // ERPX/ChC -
        Clear(HeaderLabel);
        Clear(HeaderTxt);
        with "Sales Header" do begin

            if PaymentTerms.GET("Payment Terms Code") then begin
                HeaderLabel[1] := ML_PmtTermsLbl;
                PaymentTerms.TranslateDescription(PaymentTerms, "Language Code");
                HeaderTxt[1] := PaymentTerms.Description;
            end;

            if ShipmentMethod.GET("Shipment Method Code") then begin
                HeaderLabel[2] := ML_ShipCondLbl;
                ShipmentMethod.TranslateDescription(ShipmentMethod, "Language Code");
                HeaderTxt[2] := ShipmentMethod.Description;
            end;

            if "External Document No." <> '' then begin
                HeaderLabel[3] := ML_NoDocExternLbl;
                HeaderTxt[3] := "External Document No.";
            end;

            if SalesPurchPerson.GET("Salesperson Code") then begin
                HeaderLabel[4] := ML_SalesPersonLbl;
                HeaderTxt[4] := "Salesperson Code";
                if HeaderTxt[4] = '' then
                    HeaderTxt[4] := SalesPurchPerson.Name;
            end;

            if "Your Reference" <> '' then begin
                HeaderLabel[5] := ML_ReferenceLbl;
                HeaderTxt[5] := "Your Reference";
            end;
        end;
        CompressArray(HeaderLabel);
        CompressArray(HeaderTxt);
        // ERPX/ChC +

    end;

    procedure PrepareFooter()
    var
        //CHReportManagement: Codeunit "CH Report Management";
        RecRef: RecordRef;
    begin
        RecRef.GETTABLE("Sales Header");
        //CHReportManagement.PrepareFooter(RecRef, REPORT::"Sales - Quote", FooterLabel, FooterTxt);


        // ERPX/ChC -
        Clear(FooterLabel);
        Clear(FooterTxt);
        with "Sales Header" do begin

            // ERPX\ChC/SP05 -
            FooterTxt[1] := STRSUBSTNO(ML_PlaceAndDateLbl, FORMAT("Document Date", 0, '<Day,2>.<Month,2>.<Year4>'));
            FooterTxt[2] := STRSUBSTNO(ML_CustomerLbl, "Sell-to Customer Name");
            /*
            if "Ship-to Code" <> '' then begin
                FooterLabel[4] := ML_ShipAdrLbl;
                FooterTxt[4] := "Ship-to Name" + ' ' + "Ship-to City";
            end;

            if "Sell-to Customer No." <> "Bill-to Customer No." then begin
                FooterLabel[5] := ML_InvAdrLbl;
                FooterTxt[5] := "Bill-to Name" + ', ' + "Bill-to City";
                FooterLabel[6] := ML_OrderAdrLbl;
                FooterTxt[6] := "Sell-to Customer Name" + ', ' + "Sell-to City";
            end;

            if ("Shipment Date" <> "Document Date") and ("Shipment Date" <> 0D) then begin
                FooterLabel[7] := ML_ShipDateLbl;
                FooterTxt[7] := FORMAT("Shipment Date", 0, 4);
            end;
        end;
        CompressArray(FooterLabel);
        CompressArray(FooterTxt);
        // ERPX/ChC +
        */
        end;
        // ERPX\ChC/SP05 -



        // Reset the pagination variables
        CurrGroupPageNO += 1;
        CurrPageHeaderHiddenFlag := 0;
        CurrPageFooterHiddenFlag := 0;
        InnerGroupPageNO := 1;
    end;

    [IntegrationEvent(true, true)]
    local procedure OnAfterInitReport()
    begin
    end;

    [IntegrationEvent(true, true)]
    local procedure OnAfterPostDataItem(var SalesHeader: Record "Sales Header")
    begin
    end;
}


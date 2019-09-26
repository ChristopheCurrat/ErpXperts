pageextension 50010 "ErpX_Job Journal" extends "Job Journal"
{
    actions
    {
        addafter(SuggestLinesFromTimeSheets)
        {
            group("ErpXperts")
            {
                Caption = 'ErpXPerts';
                action(ErpX_SuggestLinesFromTimeSheets)
                {
                    Caption = 'Suggest Lines from Time Sheets';
                    ApplicationArea = Jobs;
                    Image = SuggestLines;
                    Promoted = true;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        SuggestJobJnlLines: Report "ErpX_Suggest Job Jnl. Lines";
                    begin
                        SuggestJobJnlLines.SetJobJnlLine(Rec);
                        SuggestJobJnlLines.RunModal();;
                    end;
                }
            }
        }

    }
}

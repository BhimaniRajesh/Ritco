<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Branch_Popup_Multi_Selection.aspx.cs" Inherits="Branch_Popup_Multi_Selection" %>
<%@ OutputCache Location="none" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

    <head id="Head1" runat="server">
    
        <title>
            Branch List - Multiple Selection
        </title>
        
        <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" 
            type="text/css" runat="server" />
        
        <script language="javascript" type="text/javascript">
            
            function disableenter()
        {
        
        }
            
            function SelectBranch(objBranch)
            {
                //Get count of records fetched
                var mTotalRecords = "<%=intTotalRecords %>"
                //Get the selected control Name
                //Normally, ID and Name values are same
                //Will store dynamically generated control name
                var mDerivedControlName = "";
                
                var mTotalCheckedBranches = 0;
                var mSelectedBranchCodes = "";
                
                //Loop through the records
                for (var i=0; i < mTotalRecords; i++)
                {
                    if(i < 10)
                    {
                        mDerivedControlName = "rptBranch_ctl" + "0" + i + "_chkSelBranch"
                    }
                    else
                    {
                        mDerivedControlName = "rptBranch_ctl" + i + "_chkSelBranch"
                    }
                    
                    //If different then, de-select the radio button
                    if(document.getElementById(mDerivedControlName))
                    {
                        if(document.getElementById(mDerivedControlName).checked == true)
                        {
                            mTotalCheckedBranches = mTotalCheckedBranches + 1;
                            
                            if (mSelectedBranchCodes == "")
                            {
                                mSelectedBranchCodes = document.getElementById(mDerivedControlName).value;        
                            }
                            else
                            {
                                mSelectedBranchCodes = mSelectedBranchCodes + "^|^" + document.getElementById(mDerivedControlName).value;
                            }
                            
                            if(mTotalCheckedBranches > 10)
                            {
                                break;
                            }
                        }
                    }
                }
                
                var mMode = "<%=strMode %>"
                
                if(mMode == "1")
                {
                    if(mTotalCheckedBranches == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow1From)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow1From.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow2From)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow2From.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow3From)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow3From.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow4From)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow4From.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow5From)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow5From.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow6From)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow6From.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow7From)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow7From.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow8From)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow8From.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow9From)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow9From.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow10From)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow10From.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelBranch = mSelectedBranchCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedBranches; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow1From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow1From.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow2From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow2From.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow3From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow3From.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow4From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow4From.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow5From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow5From.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow6From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow6From.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow7From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow7From.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow8From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow8From.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow9From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow9From.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow10From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow10From.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedBranches + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow1From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow1From.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow2From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow2From.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow3From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow3From.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow4From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow4From.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow5From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow5From.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow6From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow6From.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow7From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow7From.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow8From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow8From.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow9From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow9From.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow10From)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow10From.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "2")
                {
                    if(mTotalCheckedBranches == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow1To)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow1To.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow2To)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow2To.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow3To)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow3To.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow4To)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow4To.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow5To)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow5To.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow6To)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow6To.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow7To)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow7To.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow8To)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow8To.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow9To)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow9To.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow10To)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow10To.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelBranch = mSelectedBranchCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedBranches; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow1To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow1To.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow2To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow2To.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow3To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow3To.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow4To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow4To.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow5To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow5To.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow6To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow6To.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow7To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow7To.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow8To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow8To.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow9To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow9To.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow10To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow10To.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedBranches + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow1To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow1To.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow2To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow2To.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow3To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow3To.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow4To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow4To.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow5To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow5To.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow6To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow6To.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow7To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow7To.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow8To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow8To.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow9To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow9To.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow10To)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFreightMatrixRow10To.value = "";
                                }
                            }
                        }
                    }
                }
                if(mMode == "3")
                {
                    if(mTotalCheckedBranches == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelBranch = mSelectedBranchCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedBranches; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch1.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch2.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch3.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch4.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch5.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch6.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch7.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch8.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch9.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch10.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedBranches + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForBranch10.value = "";
                                }
                            }
                        }
                    }
                }
                if(mMode == "4")
                {
                    if(mTotalCheckedBranches == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelBranch = mSelectedBranchCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedBranches; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch1.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch2.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch3.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch4.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch5.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch6.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch7.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch8.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch9.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch10.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedBranches + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForBranch10.value = "";
                                }
                            }
                        }
                    }
                }
                if(mMode == "5")
                {
                    if(mTotalCheckedBranches == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelBranch = mSelectedBranchCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedBranches; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch1.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch2.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch3.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch4.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch5.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch6.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch7.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch8.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch9.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch10.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedBranches + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForBranch10.value = "";
                                }
                            }
                        }
                    }
                }
                if(mMode == "6")
                {
                    if(mTotalCheckedBranches == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelBranch = mSelectedBranchCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedBranches; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch1.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch2.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch3.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch4.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch5.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch6.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch7.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch8.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch9.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch10.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedBranches + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForBranch10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "8")
                {
                    if(mTotalCheckedBranches == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelBranch = mSelectedBranchCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedBranches; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch1.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch2.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch3.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch4.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch5.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch6.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch7.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch8.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch9.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch10.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedBranches + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForBranch10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "9")
                {
                    if(mTotalCheckedBranches == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelBranch = mSelectedBranchCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedBranches; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch1.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch2.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch3.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch4.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch5.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch6.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch7.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch8.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch9.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch10.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedBranches + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForBranch10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "10")
                {
                    if(mTotalCheckedBranches == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelBranch = mSelectedBranchCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedBranches; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch1.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch2.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch3.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch4.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch5.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch6.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch7.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch8.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch9.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch10.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedBranches + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForBranch10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "11")
                {
                    if(mTotalCheckedBranches == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelBranch = mSelectedBranchCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedBranches; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch1.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch2.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch3.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch4.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch5.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch6.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch7.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch8.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch9.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch10.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedBranches + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForBranch10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "12")
                {
                    if(mTotalCheckedBranches == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelBranch = mSelectedBranchCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedBranches; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch1.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch2.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch3.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch4.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch5.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch6.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch7.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch8.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch9.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch10.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedBranches + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForBranch10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "13")
                {
                    if(mTotalCheckedBranches == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelBranch = mSelectedBranchCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedBranches; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch1.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch2.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch3.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch4.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch5.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch6.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch7.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch8.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch9.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch10.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedBranches + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForBranch10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "14")
                {
                    if(mTotalCheckedBranches == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelBranch = mSelectedBranchCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedBranches; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch1.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch2.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch3.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch4.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch5.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch6.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch7.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch8.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch9.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch10.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedBranches + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForBranch10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "15")
                {
                    if(mTotalCheckedBranches == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelBranch = mSelectedBranchCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedBranches; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch1.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch2.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch3.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch4.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch5.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch6.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch7.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch8.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch9.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch10.value = mArrSelBranch[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedBranches + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForBranch10.value = "";
                                }
                            }
                        }
                    }
                }
            }

        </script>
        
    </head>

    <body>
        
        <form id="frmBranch" runat="server">
            
            <table border="0" width="100%" cellspacing="1" class="boxbg">
                <tr class="bgbluegrey">
                    <td style="width: 10%">
                        &nbsp;
                    </td>
                    
                    <td style="width: 15%" align="left">
                        &nbsp;
                        <label id="lblBranchCodeColHeader" class="blackfnt">
                            Branch Code
                        </label>
                    </td>
                    <td style="width: 35%" align="left">
                        &nbsp;
                        <label id="lblBranchNameColHeader" class="blackfnt">
                            Branch Name
                        </label>
                    </td>
                </tr>
                
                <asp:Repeater ID="rptBranch" runat="server">
                    <ItemTemplate>
                        <tr style="background-color: White">
                            <td style="width: 10%">
                                &nbsp;
                                <input id="chkSelBranch" type="checkbox" value=<%#DataBinder.Eval(Container.DataItem, "BranchCode")%> onclick="SelectBranch(this)" runat="server" />
                            </td>
                            
                            <td style="width: 30%" align="left">
                                <label id="lblRptBranchCode" class="blackfnt">
                                    &nbsp;
                                    <%#DataBinder.Eval(Container.DataItem, "BranchCode")%>
                                </label>
                            </td>
                            
                            <td align="left">
                                <label id="lblRptBranchName" class="blackfnt">
                                    &nbsp;
                                    <%#DataBinder.Eval(Container.DataItem, "BranchName")%>
                                </label>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
            
        </form>
        
    </body>

</html>

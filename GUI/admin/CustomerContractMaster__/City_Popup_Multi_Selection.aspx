<%@ Page Language="C#" AutoEventWireup="true" CodeFile="City_Popup_Multi_Selection.aspx.cs" Inherits="City_Popup_Multi_Selection" %>
<%@ OutputCache Location="none" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

    <head id="Head1" runat="server">
    
        <title>
            City List - Multiple Selection
        </title>
        
        <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" 
            type="text/css" runat="server" />
        
        <script language="javascript" type="text/javascript">
            
            function disableenter()
        {
        
        }
            
            function SelectCity(objCity)
            {
                //Get count of records fetched
                var mTotalRecords = "<%=intTotalRecords %>"
                //Get the selected control Name
                //Normally, ID and Name values are same
                //Will store dynamically generated control name
                var mDerivedControlName = "";
                
                var mTotalCheckedCityes = 0;
                var mSelectedCityCodes = "";
                
                //Loop through the records
                for (var i=0; i < mTotalRecords; i++)
                {
                    if(i < 10)
                    {
                        mDerivedControlName = "rptCity_ctl" + "0" + i + "_chkSelCity"
                    }
                    else
                    {
                        mDerivedControlName = "rptCity_ctl" + i + "_chkSelCity"
                    }
                    
                    //If different then, de-select the radio button
                    if(document.getElementById(mDerivedControlName))
                    {
                        if(document.getElementById(mDerivedControlName).checked == true)
                        {
                            mTotalCheckedCityes = mTotalCheckedCityes + 1;
                            
                            if (mSelectedCityCodes == "")
                            {
                                mSelectedCityCodes = document.getElementById(mDerivedControlName).value;        
                            }
                            else
                            {
                                mSelectedCityCodes = mSelectedCityCodes + "^|^" + document.getElementById(mDerivedControlName).value;
                            }
                            
                            if(mTotalCheckedCityes > 10)
                            {
                                break;
                            }
                        }
                    }
                }
                
                var mMode = "<%=strMode %>"
                
                if(mMode == "1")
                {
                    if(mTotalCheckedCityes == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelCity = mSelectedCityCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedCityes; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow1.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow2.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow3.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow4.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow5.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow6.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow7.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow8.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow9.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow10.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedCityes + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromCityRow10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "2")
                {
                    if(mTotalCheckedCityes == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelCity = mSelectedCityCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedCityes; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow1.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow2.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow3.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow4.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow5.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow6.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow7.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow8.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow9.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow10.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedCityes + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToCityRow10.value = "";
                                }
                            }
                        }
                    }                    
                }
                else if(mMode == "3")
                {
                    if(mTotalCheckedCityes == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelCity = mSelectedCityCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedCityes; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity1.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity2.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity3.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity4.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity5.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity6.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity7.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity8.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity9.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity10.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedCityes + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromRoadForCity10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "4")
                {
                    if(mTotalCheckedCityes == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelCity = mSelectedCityCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedCityes; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity1.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity2.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity3.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity4.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity5.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity6.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity7.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity8.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity9.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity10.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedCityes + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToRoadForCity10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "5")
                {
                    if(mTotalCheckedCityes == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelCity = mSelectedCityCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedCityes; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity1.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity2.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity3.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity4.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity5.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity6.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity7.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity8.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity9.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity10.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedCityes + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRFromExpressForCity10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "6")
                {
                    if(mTotalCheckedCityes == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelCity = mSelectedCityCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedCityes; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity1.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity2.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity3.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity4.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity5.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity6.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity7.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity8.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity9.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity10.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedCityes + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFRToExpressForCity10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "7")
                {
                    if(mTotalCheckedCityes == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelCity = mSelectedCityCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedCityes; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity1.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity2.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity3.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity4.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity5.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity6.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity7.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity8.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity9.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity10.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedCityes + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForRoadForCity10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "8")
                {
                    if(mTotalCheckedCityes == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelCity = mSelectedCityCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedCityes; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity1.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity2.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity3.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity4.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity5.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity6.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity7.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity8.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity9.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity10.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedCityes + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForRoadForCity10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "9")
                {
                    if(mTotalCheckedCityes == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelCity = mSelectedCityCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedCityes; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity1.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity2.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity3.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity4.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity5.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity6.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity7.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity8.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity9.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity10.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedCityes + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForExpressForCity10.value = "";
                                }
                            }
                        }
                    }    
                }
                else if(mMode == "10")
                {
                    if(mTotalCheckedCityes == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelCity = mSelectedCityCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedCityes; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity1.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity2.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity3.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity4.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity5.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity6.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity7.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity8.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity9.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity10.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedCityes + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForExpressForCity10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "11")
                {
                    if(mTotalCheckedCityes == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelCity = mSelectedCityCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedCityes; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity1.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity2.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity3.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity4.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity5.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity6.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity7.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity8.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity9.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity10.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedCityes + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForAirForCity10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "12")
                {
                    if(mTotalCheckedCityes == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelCity = mSelectedCityCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedCityes; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity1.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity2.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity3.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity4.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity5.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity6.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity7.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity8.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity9.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity10.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedCityes + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForAirForCity10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "13")
                {
                    if(mTotalCheckedCityes == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelCity = mSelectedCityCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedCityes; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity1.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity2.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity3.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity4.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity5.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity6.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity7.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity8.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity9.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity10.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedCityes + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtFromForTrainForCity10.value = "";
                                }
                            }
                        }
                    }
                }
                else if(mMode == "14")
                {
                    if(mTotalCheckedCityes == 0)
                    {
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity1)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity1.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity2)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity2.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity3)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity3.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity4)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity4.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity5)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity5.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity6)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity6.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity7)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity7.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity8)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity8.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity9)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity9.value = "";
                        }
                        if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity10)
                        {
                            window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity10.value = "";
                        }
                    }
                    else
                    {
                        var mArrSelCity = mSelectedCityCodes.split("^|^");
                            
                        for(var mLoopCounter = 1; mLoopCounter <= mTotalCheckedCityes; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity1.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity2.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity3.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity4.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity5.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity6.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity7.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity8.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity9.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity10.value = mArrSelCity[mLoopCounter-1];
                                }
                            }
                        }
                        
                        for(var mLoopCounter = mTotalCheckedCityes + 1; mLoopCounter <= 10; mLoopCounter++)
                        {
                            if(mLoopCounter == 1)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity1)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity1.value = "";
                                }
                            }
                            else if(mLoopCounter == 2)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity2)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity2.value = "";
                                }
                            }
                            else if(mLoopCounter == 3)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity3)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity3.value = "";
                                }
                            }
                            else if(mLoopCounter == 4)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity4)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity4.value = "";
                                }
                            }
                            else if(mLoopCounter == 5)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity5)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity5.value = "";
                                }
                            }
                            else if(mLoopCounter == 6)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity6)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity6.value = "";
                                }
                            }
                            else if(mLoopCounter == 7)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity7)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity7.value = "";
                                }
                            }
                            else if(mLoopCounter == 8)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity8)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity8.value = "";
                                }
                            }
                            else if(mLoopCounter == 9)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity9)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity9.value = "";
                                }
                            }
                            else if(mLoopCounter == 10)
                            {
                                if(window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity10)
                                {
                                    window.opener.document.forms[0].ctl00_MyCPH1_txtToForTrainForCity10.value = "";
                                }
                            }
                        }
                    }
                }
            }

        </script>
        
    </head>

    <body>
        
        <form id="frmCity" runat="server">
            
            <table border="0" width="100%" cellspacing="1" class="boxbg">
                <tr class="bgbluegrey">
                    <td style="width: 10%">
                        &nbsp;
                    </td>
                    
                    <td style="width: 35%" align="left">
                        &nbsp;
                        <label id="lblCityNameColHeader" class="blackfnt">
                            City Name
                        </label>
                    </td>
                </tr>
                
                <asp:Repeater ID="rptCity" runat="server">
                    <ItemTemplate>
                        <tr style="background-color: White">
                            <td style="width: 10%">
                                &nbsp;
                                <input id="chkSelCity" type="checkbox" value=<%#DataBinder.Eval(Container.DataItem, "CityName")%> onclick="SelectCity(this)" runat="server" />
                            </td>
                            
                            <td align="left">
                                <label id="lblRptCityName" class="blackfnt">
                                    &nbsp;
                                    <%#DataBinder.Eval(Container.DataItem, "CityName")%>
                                </label>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
            </table>
            
        </form>
        
    </body>

</html>

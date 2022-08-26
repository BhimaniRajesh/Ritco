<%@ Page Language="C#" AutoEventWireup="true" CodeFile="City_Popup.aspx.cs" Inherits="City_Popup" %>
<%@ OutputCache Location="none" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

    <head id="Head1" runat="server">
    
        <title>
            City List
        </title>
        
        <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" 
            type="text/css" runat="server" />
        
        <script language="javascript" type="text/javascript">
            
            function disableenter()
        {
        
        }
            
            function SelectCity(objCity)
            {
                var mMode = "<%=strMode %>"
                
                if(mMode == "1")
                {                
                    if(window.opener.document.getElementById("ctl00_MyCPH1_txtCity"))
                    {
                        window.opener.document.getElementById("ctl00_MyCPH1_txtCity").value = objCity.value
                    }
                }
                else if(mMode == "2")
                {
                    if(window.opener.document.getElementById("ctl00_MyCPH1_txtCityCodeRoad"))
                    {
                        window.opener.document.getElementById("ctl00_MyCPH1_txtCityCodeRoad").value = objCity.value
                    }
                }
                else if(mMode == "3")
                {
                    if(window.opener.document.getElementById("ctl00_MyCPH1_txtCityCodeExpress"))
                    {
                        window.opener.document.getElementById("ctl00_MyCPH1_txtCityCodeExpress").value = objCity.value
                    } 
                }
                else if(mMode == "4")
                {
                    if(window.opener.document.getElementById("ctl00_MyCPH1_txtCityCodeRoad"))
                    {
                        window.opener.document.getElementById("ctl00_MyCPH1_txtCityCodeRoad").value = objCity.value
                    } 
                }
                else if(mMode == "5")
                {
                    if(window.opener.document.getElementById("ctl00_MyCPH1_txtCityCodeExpress"))
                    {
                        window.opener.document.getElementById("ctl00_MyCPH1_txtCityCodeExpress").value = objCity.value
                    } 
                }
                else if(mMode == "6")
                {
                    if(window.opener.document.getElementById("ctl00_MyCPH1_txtCityCodeAir"))
                    {
                        window.opener.document.getElementById("ctl00_MyCPH1_txtCityCodeAir").value = objCity.value
                    } 
                }
                else if(mMode == "7")
                {
                    if(window.opener.document.getElementById("ctl00_MyCPH1_txtCityCodeTrain"))
                    {
                        window.opener.document.getElementById("ctl00_MyCPH1_txtCityCodeTrain").value = objCity.value
                    }
                }
                else if(mMode == "8")
                {
                    window.opener.document.forms[0].txtSubmittedAt.value = objCity.value
                }
                
                //Get count of records fetched
                var mTotalRecords = "<%=intTotalRecords %>"
                //Get the selected control Name
                //Normally, ID and Name values are same
                var mSelectedControlName = objCity.name;
                //Will store dynamically generated control name
                var mDerivedControlName = "";
                
                //Loop through the records
                for (var i=0; i < mTotalRecords; i++)
                {
                    if(i < 10)
                    {
                        mDerivedControlName = "rptCity_ctl" + "0" + i + "_"
                    }
                    else
                    {
                        mDerivedControlName = "rptCity_ctl" + i + "_"
                    }
                    
                    //Match the selected control name with derived control name
                    if (mSelectedControlName != mDerivedControlName)
                    {
                        //If different then, de-select the radio button
                        if(document.getElementById(mDerivedControlName))
                        {
                            document.getElementById(mDerivedControlName).checked = false;
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
                                <input id="radSelCity" type="radio" value=<%#DataBinder.Eval(Container.DataItem, "CityName")%> onclick="SelectCity(this)" runat="server" />
                            </td>
                            
                            <td style="width: 35%" align="left">
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

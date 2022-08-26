<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GetNextStep.aspx.cs" Inherits="GUI_Operations_LoadingSheet_GetNextStep" %>
<%@ OutputCache Location="none" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

    <head runat="server">
        
        <title>
            List of Locations
        </title>
        
        <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" 
            type="text/css" runat="server" />
        
        <script language="javascript" type="text/javascript">
            
            function disableenter()
            {
            
            }
            
            function SelectBranch(objBranch)
            {
                var mMode = "<%=strMode %>"
                
                if(mMode == "1")
                {                
                    if(window.opener.document.getElementById("ctl00_MyCPH1_txtNextStop"))
                    {
                        window.opener.document.getElementById("ctl00_MyCPH1_txtNextStop").value = objBranch.value
                    }
                }
                else if(mMode == "2")
                {
                    if(window.opener.document.getElementById("ctl00_MyCPH1_txtBookingLocation"))
                    {
                        window.opener.document.getElementById("ctl00_MyCPH1_txtBookingLocation").value = objBranch.value
                    }
                    
                }
                else if(mMode == "3")
                {
                    
                }
                else if(mMode == "4")
                {
                    
                }
                
                //Get count of records fetched
                var mTotalRecords = "<%=intTotalRecords %>"
                //Get the selected control Name
                //Normally, ID and Name values are same
                var mSelectedControlName = objBranch.name;
                //Will store dynamically generated control name
                var mDerivedControlName = "";
                
                //Loop through the records
                for (var i=0; i < mTotalRecords; i++)
                {
                    if(i < 10)
                    {
                        mDerivedControlName = "rptBranch_ctl" + "0" + i + "_"
                    }
                    else
                    {
                        mDerivedControlName = "rptBranch_ctl" + i + "_"
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
    
        <form id="frmGetNextStop" runat="server">
        
            <div>
                
                <table border="0" width="100%" cellspacing="1" class="boxbg">
                    <tr class="bgbluegrey">
                        <td style="width: 10%">
                            &nbsp;
                        </td>
                        
                        <td style="width: 15%" align="left">
                            &nbsp;
                            <label id="lblBranchCodeColHeader" class="blackfnt">
                                Location Code
                            </label>
                        </td>
                        <td style="width: 35%" align="left">
                            &nbsp;
                            <label id="lblBranchNameColHeader" class="blackfnt">
                                Location Name
                            </label>
                        </td>
                    </tr>
                    
                    <asp:Repeater ID="rptBranch" runat="server">
                        <ItemTemplate>
                            <tr style="background-color: White">
                                <td style="width: 10%">
                                    &nbsp;
                                    <input id="radSelBranch" type="radio" value=<%#DataBinder.Eval(Container.DataItem, "BranchCode")%> onclick="SelectBranch(this)" runat="server" />
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
                                        
            </div>
            
        </form>
        
    </body>
    
</html>

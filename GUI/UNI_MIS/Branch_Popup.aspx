<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Branch_Popup.aspx.cs" Inherits="Branch_Popup" %>
<%@ OutputCache Location="none" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

    <head runat="server">
    
        <title>
            Branch List
        </title>
        <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
        
        
        <script language="javascript" type="text/javascript">
        
            function SelectBranch(objBranch)
            {
                var mMode = "<%=strMode %>"
                
                if(mMode == "2")
                {
                    window.opener.document.getElementById("ctl00_MyCPH1_txtCollectionAt").value = objBranch.value
                    //window.opener.document.forms[0].txtCollectionAt.value = objBranch.value
                }
                else if(mMode == "7")
                {
                    window.opener.document.getElementById("ctl00_MyCPH1_txtBilledAt").value = objBranch.value
                    //window.opener.document.forms[0].txtBilledAt.value = objBranch.value
                }
                else if(mMode == "8")
                {
                    window.opener.document.getElementById("ctl00_MyCPH1_txtSubmittedAt").value = objBranch.value
                    //window.opener.document.forms[0].txtSubmittedAt.value = objBranch.value
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
                        mDerivedControlName = "rptBranch$ctl" + "0" + i + "$"
                    }
                    else
                    {
                        mDerivedControlName = "rptBranch$ctl" + i + "$"
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
            
        </form>
        
    </body>

</html>

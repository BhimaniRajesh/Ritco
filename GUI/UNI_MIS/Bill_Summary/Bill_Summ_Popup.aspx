<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Bill_Summ_Popup.aspx.cs" Inherits="GUI_UNI_MIS_Bill_Summary_Bill_Summ_Popup" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <br />
        <table border="1" cellspacing="1" class="boxbg" width="100%">
            <tr class="bgbluegrey">                
                <td align="left" style="width: 40%">
                    &nbsp;Branch Code<label id="lblCustCodeColHeader" class="blackfnt"><strong><span style="font-size: 8pt;
                        font-family: Verdana">&nbsp;</span></strong></label></td>
                <td align="left" style="font-weight: bold; font-size: 8pt; font-family: Verdana">
                    <label id="lblCustNameColHeader" class="blackfnt">
                        Branch Name
                    </label>
                </td>
            </tr>
            <asp:Repeater ID="rptCustomer" runat="server">
                <ItemTemplate>
                    <tr style="background-color: White">                        
                        <td align="left" style="width: 30%">
                            <label id="lblRptCustCode1" class="blackfnt">
                                &nbsp;
                                <%#DataBinder.Eval(Container.DataItem, "LocCode")%>
                            </label>
                        </td>
                        <td align="left">
                            <label id="lblRptCustName1" class="blackfnt">
                                &nbsp;
                                <%#DataBinder.Eval(Container.DataItem, "LocName")%>
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

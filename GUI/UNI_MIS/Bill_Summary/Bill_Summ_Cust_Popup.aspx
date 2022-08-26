<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Bill_Summ_Cust_Popup.aspx.cs" Inherits="GUI_UNI_MIS_Bill_Summary_Bill_Summ_Cust_Popup" %>

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
        <table border="1" cellpadding="2" cellspacing="1" style="font-weight: bold; font-size: 8pt;
            font-family: Verdana" width="85%">
            <tr class="bgbluegrey">
                <td align="center" colspan="2" style="height: 20px">
                    <label id="lblParameter" class="blackfnt">
                        Search by parameter
                    </label>
                </td>
            </tr>
            <tr>
                <td align="left">
                    <label id="lblCustCode" class="blackfnt">
                        Customer Code
                    </label>
                </td>
                <td align="left">
                    &nbsp;
                    <input id="txtVendorCode" runat="server" class="inp" onblur="ConvertToUpper(this)"
                        type="text" />
                </td>
            </tr>
            <tr>
                <td align="left">
                    <label id="lblCustName" class="blackfnt">
                        Customer Name
                    </label>
                </td>
                <td align="left">
                    &nbsp;
                    <input id="txtVendorName" runat="server" class="inp" onblur="ManageCustomerCodeName()"
                        type="text" />
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_OnClick" Text="Submit" />
                </td>
            </tr>
        </table>
        <br />
        <br />
        <table border="1" cellspacing="1" class="boxbg" style="font-weight: bold; font-size: 8pt;
            font-family: Verdana" width="100%">
            <tr class="bgbluegrey">                
                <td align="left" style="width: 30%">
                    &nbsp;<label id="lblCustCodeColHeader" class="blackfnt">Customer Code
                    </label>
                </td>
                <td align="left">
                    &nbsp;
                    <label id="lblCustNameColHeader" class="blackfnt">
                        Customer Name
                    </label>
                </td>
            </tr>
            <asp:Repeater ID="rptCustomer" runat="server">
                <ItemTemplate>
                    <tr style="background-color: White">                        
                        <td align="left" style="width: 30%">
                            <label id="lblRptCustCode1" class="blackfnt">                                
                                <%#DataBinder.Eval(Container.DataItem, "CustCode")%>
                            </label>
                        </td>
                        <td align="left">
                            <label id="lblRptCustName1" class="blackfnt">                                
                                <%#DataBinder.Eval(Container.DataItem, "CustName")%>
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

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup_docketno.aspx.cs" Inherits="GUI_Operation_Singlescreen_docketentry_popup_city1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>City</title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table border="0" width="100%" cellspacing="1" class="boxbg">
                <tr class="bgbluegrey">
                    <td style="width: 10%">
                        &nbsp;
                    </td>
                    
                    <td style="width: 15%" align="left">
                        &nbsp;
                        <asp:Label ID="lblCity" runat="server" CssClass="blackfnt"><%=sdkt_call %> 
                        </asp:Label>
                    </td>
                    
                </tr>
                
                <asp:Repeater ID="rptBranch" runat="server">
                    <ItemTemplate>
                        <tr style="background-color: White">
                            <td style="width: 10%">
                                &nbsp;
                                <input id="radSelBranch" type="radio" value="<%#DataBinder.Eval(Container.DataItem,"dockno")%>" onclick="SelectCustomer(this);" runat="server" />
                            </td>
                            
                            <td style="width: 30%" align="left">
                                <label id="lblBranchCode" class="blackfnt">
                                    &nbsp;
                                    <%#DataBinder.Eval(Container.DataItem, "dockno")%>
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

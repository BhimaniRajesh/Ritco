<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popup-branch_level4.aspx.cs" Inherits="GUI_Operation_Singlescreen_docketentry_popup_branch_level4" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
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
                        <asp:Label ID="lblLocationCode" runat="server" CssClass="blackfnt">Branch Code
                        </asp:Label>
                        <%--<label id="lblLocationCode" class="blackfnt">
                            Location Code
                        </label>--%>
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
                                <input id="radSelBranch" type="radio" value="<%#DataBinder.Eval(Container.DataItem,"LocCode")%>" onclick="SelectCustomer(this);" runat="server" />
                            </td>
                            
                            <td style="width: 30%" align="left">
                                <label id="lblBranchCode" class="blackfnt">
                                    &nbsp;
                                    <%#DataBinder.Eval(Container.DataItem, "LocCode")%>
                                </label>
                            </td>
                            
                            <td align="left">
                                <label id="lblRptBranchName" class="blackfnt">
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

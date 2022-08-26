<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopupEmployee.aspx.cs" Inherits="SFM_PopupEmployee" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Untitled Page</title>
    <link id="Link1" href="../../images/style.css" rel="Stylesheet" type="text/css" runat="server" />
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
                        <asp:Label ID="lblEmployeeCode" runat="server" CssClass="blackfnt">Employee Code
                        </asp:Label>
                        <%--<label id="lblLocationCode" class="blackfnt">
                            Location Code
                        </label>--%>
                    </td>
                    <td style="width: 35%" align="left">
                        &nbsp;
                        <label id="lblBranchNameColHeader" class="blackfnt">
                            Employee Name
                        </label>
                    </td>
                </tr>
                
                <asp:Repeater ID="rptBranch" runat="server">
                    <ItemTemplate>
                        <tr style="background-color: White">
                            <td style="width: 10%">
                                &nbsp;
                                <input id="radSelBranch" type="radio" value="<%#DataBinder.Eval(Container.DataItem,"UserId")%>" onclick="Done(this);" runat="server" />
                            </td>
                            
                            <td style="width: 30%" align="left">
                                <label id="lblBranchCode" class="blackfnt">
                                    &nbsp;
                                    <%#DataBinder.Eval(Container.DataItem, "UserId")%>
                                </label>
                            </td>
                            
                            <td align="left">
                                <label id="lblRptBranchName" class="blackfnt">
                                    &nbsp;
                                    <%#DataBinder.Eval(Container.DataItem, "Name")%>
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

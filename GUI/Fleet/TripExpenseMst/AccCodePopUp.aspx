<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AccCodePopUp.aspx.cs"
    Inherits="GUI_popups_popup_tyres" %>

<%--<%@ Register Src="~/GUI/usercontrol/javachild.ascx" TagName="JavaUpdate" TagPrefix="JU" %>
<%@ Reference Control="~/GUI/usercontrol/javachild.ascx"%>
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tyres</title>
    
    <script type="text/javascript" language="javascript" src="../../Js/querystring.js"></script>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
     <script type="text/javascript" language="javascript">
         function selectTyre(obj) 
         {
            var qs = new Querystring()
            var returnValue = obj.value.split("~");
            
            window.opener.document.getElementById(qs.get("AccCode")).value=returnValue[0];
            window.opener.document.getElementById(qs.get("AccDesc")).value=returnValue[1];
            
            window.close();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    
                    <asp:SqlDataSource ID="SqlConn" runat="server" ProviderName="System.Data.SqlClient"
                            SelectCommand="select distinct AccCode,Accdesc from webx_acctinfo  WITH(NOLOCK) where ACCCATEGORY='EXPENSE' and ActiveFlag='Y'">
                        </asp:SqlDataSource>
                        <asp:DataList ID="DataList1" 
                            HeaderStyle-CssClass="dgHeaderStyle"  runat="server" 
                            DataSourceID="SqlConn" Width="100%" DataKeyField="AccCode" Font-Names="Verdana" Font-Size="8pt">
                            <HeaderStyle CssClass="dgHeaderStyle" />
                            <HeaderTemplate>
                                 <table style="width: 95%" class="boxbg"  cellpadding="3" cellspacing="0" >
                                    <tr class="bgbluegrey">
                                        <td style="width: 10%">
                                            Select
                                        </td>
                                        <td style="width: 20%">
                                            <asp:Label ID="lbl_hdr_Acc_Code" runat="server" Text="Account Code"></asp:Label>
                                        </td>
                                        <td style="width: 70%">
                                            <asp:Label ID="lbl_hdr_AccDesc" runat="server" Text="Account Description"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </HeaderTemplate> 
                            <ItemTemplate>
                                <table style="width: 100%" cellpadding="0" cellspacing="1"  class="boxbg">
                                    <tr  style="background-color: white">
                                        <td style="width: 10%">
                                            <input type="radio" name="radSelect" onclick="javascript:selectTyre(this);" value='<%#Eval("AccCode")%>~<%#Eval("Accdesc")%>'  />
                                        </td>
                                        <td style="width: 20%">
                                            <asp:Label ID="lbl_TYRE_ID" runat="server" Text='<%#Eval("AccCode")%>'></asp:Label>
                                        </td>
                                        <td style="width: 70%">
                                            <asp:Label ID="TYRE_NO" runat="server" Text='<%#Eval("Accdesc")%>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                
                            </ItemTemplate>
                        </asp:DataList>

    </form>
</body>
</html>

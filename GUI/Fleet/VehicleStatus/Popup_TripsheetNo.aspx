<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Popup_TripsheetNo.aspx.cs" Inherits="GUI_Popups_Tripsheet" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
<script type="text/javascript" language="javascript">
    function getQuerystring(key, default_)
    {
        if (default_==null) default_="";
            key = key.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
            var regex = new RegExp("[\\?&]"+key+"=([^&#]*)");
            var qs = regex.exec(window.location.href);
        if(qs == null)
            return default_;
        else
            return qs[1];
    } 
    function selectTSNumber(obj) 
    {
        var returnValue = obj.value;
        
        window.opener.document.getElementById(getQuerystring("TsNo","")).value=returnValue;
        window.opener.document.getElementById(getQuerystring("lblErr","")).innerText="";

        window.close();
    }
</script>
</head>
<body>
    <form id="form1" runat="server">
      
                        
                           <asp:SqlDataSource ID="SqlConn" runat="server" ProviderName="System.Data.SqlClient">
                        </asp:SqlDataSource>
                        <asp:DataList ID="DataList1" 
                            HeaderStyle-CssClass="dgHeaderStyle"  runat="server" 
                            DataSourceID="SqlConn" Width="100%" DataKeyField="VslipNo" Font-Names="Verdana" Font-Size="8pt">
                            <HeaderStyle CssClass="dgHeaderStyle" />
                            <HeaderTemplate>
                                  <asp:Table ID="tblMain" runat="server" HorizontalAlign="center" CssClass="boxbg"
                        CellSpacing="1" BorderWidth="0" Width="100%" BorderStyle="Groove">
                        <asp:TableRow CssClass="bgbluegrey">
                            <asp:TableCell HorizontalAlign="center" ColumnSpan="2" CssClass="blackfnt" Style="height: 20px;">
                                <b>Select Vehicle</b></asp:TableCell>
                            </asp:TableRow>
                </asp:Table>
                            </HeaderTemplate> 
                            <ItemTemplate>
                                <table style="width: 100%" cellpadding="0" cellspacing="1"  class="boxbg">
                                    <tr  style="background-color: white">
                                        <td style="width: 20%">
                                            <input type="radio" name="radSelect" onclick="javascript:selectTSNumber(this);" value='<%#Eval("VslipNo")%>'  />
                                        </td>
                                        <td style="width: 80%">
                                            <asp:Label ID="Vehicle_Number" runat="server" Text='<%#Eval("VslipNo")%>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                
                            </ItemTemplate>
                        </asp:DataList>
             
    </form>
</body>
</html>

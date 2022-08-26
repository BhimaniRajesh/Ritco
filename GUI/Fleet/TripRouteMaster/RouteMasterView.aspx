<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RouteMasterView.aspx.cs"
    Inherits="GUI_admin_CustomerMaster_RouteMasterView" Title="Untitled Page" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>View Trip Route</title>
    <link href="../../../GUI/images/style.css" rel="stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">
     function printPage() 
     {
        var hdnflagprint = document.getElementById("hdnflagprint");   
         
        if(hdnflagprint.value == "Y")
        {
          window.print();
        }
        return false;
     }
     
     function popupPrint()
     {
            var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";                  
            window.open("RouteMasterView.aspx?routeCode=routeCode&print=Y","", winOpts);                        
            return false;
     }
    </script>

</head>
<body onload="javascript:return printPage()">
    <form id="form1" runat="server">
        <asp:Panel runat="server" HorizontalAlign="left" Style="width: 10in" ID="pnlMain">
            <table width="100%" align="center">
                <tr>
                    <td align="right">
                        <asp:LinkButton ID="lnkBtnPrint" runat="server" CssClass="blackfnt" Text="Print |"
                            OnClientClick="javascript:return popupPrint();"></asp:LinkButton>
                        <asp:LinkButton ID="lnkBtnDownloadXLS" runat="server" CssClass="blackfnt" OnClick="lnkBtnDownloadXLS_Click">Download XLS</asp:LinkButton>
                    </td>
                </tr>
            </table>
            

            <asp:Table ID="tblMain" runat="server" HorizontalAlign="center" 
                CellSpacing="1" BorderWidth="0" Width="100%" BorderStyle="Groove">
                <asp:TableRow VerticalAlign="Middle" ID="trRouteMaster"
                    runat="server">
                    <asp:TableCell HorizontalAlign="center" CssClass="blackfnt" ID="tdRouteMaster" runat="server"
                        ColumnSpan="4" Style="height: 20px;">
                                                        <b>TRIP ROUTE MASTER</b></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle" ID="trGroupCode" runat="server">
                    <asp:TableCell HorizontalAlign="left" Width="20%" CssClass="blackfnt" ID="tdGroupCode"
                        runat="server">
                                                                    Route Code</asp:TableCell>
                    <asp:TableCell HorizontalAlign="left" ID="tdlblGroupCode" runat="server">
                        <asp:Label ID="lblRouteCode" Font-Bold="true" runat="server" Text="Label" CssClass="blackfnt"></asp:Label></asp:TableCell>
                    <asp:TableCell HorizontalAlign="left" Width="20%" CssClass="blackfnt" ID="tdCustCode"
                        runat="server">
                                                                    Route Mode</asp:TableCell>
                    <asp:TableCell HorizontalAlign="left" ID="tdlblCustCode" runat="server">
                        <asp:Label ID="lblRouteMode" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle" ID="trCustomerName" runat="server">
                    <asp:TableCell HorizontalAlign="left" ID="tdSvcOptFor" CssClass="blackfnt" runat="server">
                                                                    Dist.(Km)/ Transit (HRS)</asp:TableCell>
                    <asp:TableCell HorizontalAlign="left" ID="tdlblSvcOptFor" runat="server">
                        <asp:Label ID="lblRouteDistance" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    
                     <asp:TableCell HorizontalAlign="left" ID="TableCell1" CssClass="blackfnt" runat="server">
                                                                   </asp:TableCell>
                    <asp:TableCell HorizontalAlign="left" ID="TableCell2" runat="server">
                        
                    </asp:TableCell>
                    
                    
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle" ID="trCustCat" runat="server">
                    <asp:TableCell HorizontalAlign="left" ID="tdCustCat" CssClass="blackfnt" runat="server">
                                                                   Departure Time</asp:TableCell>
                    <asp:TableCell HorizontalAlign="left" ID="tdlblCustCat" runat="server">
                        <asp:Label ID="lblRouteDepartureTime" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                    <asp:TableCell HorizontalAlign="left" ID="tdActiveFlag" CssClass="blackfnt" runat="server">
                                                                    Standard Rate</asp:TableCell>
                    <asp:TableCell HorizontalAlign="left" ID="tdlblActiveFlag" runat="server">
                        <asp:Label ID="lblStandardRate" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle" ID="trMobileService" runat="server">
                    <asp:TableCell HorizontalAlign="left" ID="tdMobileService" CssClass="blackfnt" runat="server">
                                                                    Controlling Location</asp:TableCell>
                    <asp:TableCell HorizontalAlign="left" ID="tdlblMobileService" runat="server">
                        <asp:Label ID="lblLocation" runat="server" CssClass="blackfnt"></asp:Label>
                    </asp:TableCell>
                    <asp:TableCell HorizontalAlign="left" ID="tdMobileNo" CssClass="blackfnt" runat="server">
                                                                    Active Flag</asp:TableCell>
                    <asp:TableCell HorizontalAlign="left" ID="tdlblMobileNo" runat="server">
                        <asp:Label ID="lblActiveFlag" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow CssClass="bgwhite" VerticalAlign="Middle" ID="trLastUpdateBY" runat="server">
                    <asp:TableCell HorizontalAlign="left" ID="tdLastUpdateBY" CssClass="blackfnt" runat="server">
                                                                    Last Update Location</asp:TableCell>
                    <asp:TableCell HorizontalAlign="left" ID="tdlblLastUpdateBY" runat="server">
                        <asp:Label ID="lblLastUpdateBy" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                    <asp:TableCell HorizontalAlign="left" ID="tdLastUpdateDate" CssClass="blackfnt" runat="server">
                                                                   Last Update Date</asp:TableCell>
                    <asp:TableCell HorizontalAlign="left" ID="tdlblLastUpdateDate" runat="server">
                        <asp:Label ID="lblLastUpdateDate" runat="server" CssClass="blackfnt"></asp:Label></asp:TableCell>
                </asp:TableRow>
            </asp:Table>
            <br />
            <asp:GridView ID="gvRoutePaid" BorderWidth="0" CellSpacing="1" runat="server" AutoGenerateColumns="false"
                Width="100%" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey" PagerSettings-Mode="NumericFirstLast"
                OnRowCreated="gvRoutePaid_RowCreated" PageSize="10" SelectedIndex="1">
                <Columns>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="bgwhite"
                        HeaderStyle-Font-Bold="true" HeaderText="Branch Name">
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                        <ItemTemplate>
                            <asp:Label ID="lblBranchName" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"LOCNAME") %>'
                                CssClass="blackfnt"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="bgwhite"
                        HeaderStyle-Font-Bold="true" HeaderText="Dist (In Km)">
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblDist" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"DIST_KM") %>'
                                CssClass="blackfnt"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="bgwhite"
                        HeaderStyle-Font-Bold="true" HeaderText="(Hours)">
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblttimehr" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"TRTIME_HR") %>'
                                CssClass="blackfnt"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="bgwhite"
                        HeaderStyle-Font-Bold="true" HeaderText="(Min)">
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="lblttimemn" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"TRTIME_MIN") %>'
                                CssClass="blackfnt"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="bgwhite"
                        HeaderStyle-Font-Bold="true" HeaderText="(Hours)">
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="txtstimehr" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"STTIME_HR") %>'
                                CssClass="blackfnt"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" ItemStyle-CssClass="bgwhite"
                        HeaderStyle-Font-Bold="true" HeaderText="(Mins)">
                        <HeaderStyle HorizontalAlign="Center" Wrap="True" CssClass="blackfnt" />
                        <ItemTemplate>
                            <asp:Label ID="txtstimehr" runat="server" Text='<%# DataBinder.Eval( Container.DataItem,"STTIME_MIN") %>'
                                CssClass="blackfnt"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </asp:Panel>
        <asp:HiddenField ID="hdnflagprint" runat="server" />
    </form>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopUp_Result.aspx.cs" Inherits="GUI_UNI_MIS_OPN_LIFE_CYCLE_PopUp_Result" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<link id="Link1" href="../../images/style.css" rel="stylesheet" type="text/css"
        runat="server" />
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <br />
    <br />
     <asp:GridView Visible="false" align="left" ID="dgLS" runat="server" BorderWidth="0"
        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
        AllowPaging="false" PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
         PagerSettings-FirstPageText="[First]"
        PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." >
        <Columns>
            <asp:TemplateField HeaderText="SR.NO."  ItemStyle-BackColor="white">
                    <ItemTemplate>
                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server">
                        </asp:Label>
                    </ItemTemplate>
                     <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
        <asp:BoundField DataField="tcno" HeaderText="LS No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="Manuallsno" HeaderText="Manual LS No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"   CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="tcdt" HeaderText="Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="tcbr" HeaderText="From ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"   CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="tobh_code" HeaderText="TO">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <%--<asp:BoundField DataField="nextloc" HeaderText="Next Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"   CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>--%>
                </Columns>
             <RowStyle />
        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
        <FooterStyle CssClass="boxbg" />
            </asp:GridView>
            
            
            <asp:GridView Visible="false" align="left" ID="dgMF" runat="server" BorderWidth="0"
        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
        AllowPaging="false" PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
         PagerSettings-FirstPageText="[First]"
        PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." >
        <Columns>
            <asp:TemplateField HeaderText="SR.NO."  ItemStyle-BackColor="white">
                    <ItemTemplate>
                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server">
                        </asp:Label>
                    </ItemTemplate>
                     <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
        <asp:BoundField DataField="tcno" HeaderText="MF No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="Manual_tcno" HeaderText="Manual MF No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"   CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="tcdt" HeaderText="Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="tcbr" HeaderText="From ">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"   CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="tobh_code" HeaderText="TO">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="Cancelled" HeaderText="Cancel">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                </Columns>
             <RowStyle />
        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
        <FooterStyle CssClass="boxbg" />
            </asp:GridView>
            
            <asp:GridView Visible="false" align="left" ID="dgTHC" runat="server" BorderWidth="0"
        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
        AllowPaging="false" PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
         PagerSettings-FirstPageText="[First]"
        PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." >
        <Columns>
            <asp:TemplateField HeaderText="SR.NO."  ItemStyle-BackColor="white">
                    <ItemTemplate>
                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server">
                        </asp:Label>
                    </ItemTemplate>
                     <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
        <asp:BoundField DataField="ThCNo" HeaderText="THC No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="ThCDT" HeaderText="THC Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"   CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="thcbr" HeaderText="From">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="tobh_code" HeaderText="To">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"   CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="routecd" HeaderText="Route Code">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="routename" HeaderText="Route">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"   CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="Cancelled" HeaderText="Cancel">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                </Columns>
             <RowStyle />
        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
        <FooterStyle CssClass="boxbg" />
            </asp:GridView>
            
            
            <asp:GridView Visible="false" align="left" ID="dgPRS" runat="server" BorderWidth="0"
        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
        AllowPaging="false" PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
         PagerSettings-FirstPageText="[First]"
        PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." >
        <Columns>
            <asp:TemplateField HeaderText="SR.NO."  ItemStyle-BackColor="white">
                    <ItemTemplate>
                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server">
                        </asp:Label>
                    </ItemTemplate>
                     <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
        <asp:BoundField DataField="pdcno" HeaderText="PRS No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="pdc_dt" HeaderText="PRS Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"   CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="pdcbr" HeaderText="Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                </Columns>
             <RowStyle />
        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
        <FooterStyle CssClass="boxbg" />
            </asp:GridView>
            <asp:GridView Visible="false" align="left" ID="dgDRS" runat="server" BorderWidth="0"
        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
        AllowPaging="false" PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
         PagerSettings-FirstPageText="[First]"
        PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." >
        <Columns>
            <asp:TemplateField HeaderText="SR.NO."  ItemStyle-BackColor="white">
                    <ItemTemplate>
                        <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                            runat="server">
                        </asp:Label>
                    </ItemTemplate>
                     <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                    <HeaderStyle CssClass="blackfnt" />
                </asp:TemplateField>
         <asp:BoundField DataField="pdcno" HeaderText="DRS No.">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                <asp:BoundField DataField="pdc_dt" HeaderText="DRS Date">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"   CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
                 <asp:BoundField DataField="pdcbr" HeaderText="Location">
                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  CssClass="blackfnt" />
                    <ItemStyle BackColor="white" Wrap="False" CssClass="blackfnt" HorizontalAlign="center" />
                </asp:BoundField>
              
                </Columns>
             <RowStyle />
        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
        <FooterStyle CssClass="boxbg" />
            </asp:GridView>
    </div>
    </form>
</body>
</html>

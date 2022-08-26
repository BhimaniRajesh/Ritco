
<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="result.aspx.cs" Inherits="GUI_UNI_MIS_Trip_stmt_result" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<p align="center">
        <label class="blackfnt">
            <b>You Selected </b>
        </label>
    </p>
    <%--<center>--%>
    <%--<table border="0" cellpadding="3" width="565" cellspacing="1" align="center" class="boxbg">
        <tr style="background-color: #ffffff">
            <td style="height: 10px">
                <label class="blackfnt">
                    Date :</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #FFFFFF">
            <td style="width: 205; height: 15px;">
                <label class="blackfnt">
                    RO :</label></td>
            <td style="width: 343; height: 15px;">
                &nbsp;
                <asp:Label ID="lblro" runat="server" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: #FFFFFF">
            <td style="width: 205">
                <label class="blackfnt">
                    Location :</label></td>
            <td style="width: 343">
                &nbsp;
                <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: #FFFFFF">
                <td style="width: 205; height: 6px;">
                    <label class="blackfnt">
                        Customer Code :</label></td>
                <td style="width: 343; height: 6px;">
                    &nbsp;
                    <asp:Label ID="lblcust" runat="server" CssClass="blackfnt"></asp:Label>
                </td>
            </tr>
         <tr style="background-color: #ffffff">
                <td style="height: 6px">
                    <label class="blackfnt">
                        Report Type :
                    </label>
                </td>
                <td style="height: 6px">
                    <asp:Label ID="lblflow" runat="server" CssClass="blackfnt"> 
                    </asp:Label></td>
            </tr>
    </table>--%>
    <br />

    <asp:GridView Visible="false" align="center" ID="dgDocket" runat="server" BorderWidth="0"
        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
        AllowPaging="true" PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" 
        EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
        <Columns>
           <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                <ItemTemplate>
                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                        runat="server">
                    </asp:Label>
                </ItemTemplate>
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt" />
            </asp:TemplateField>
            <asp:BoundField  DataField="ROUTECD" HeaderText="Route ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="ROUTENAMe" HeaderText="Route Name">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="rutmode" HeaderText="Mode">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
           
            
            <asp:BoundField  DataField="thcno" HeaderText="Doc. No">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="thcdt" HeaderText="Doc. Date">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="sch_dept" HeaderText="Schedule Departure">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="Act_dept" HeaderText="Actual Departure">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="late_early" HeaderText="Delay Hours">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="Vendor" HeaderText="Vendor">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="vehno" HeaderText="Vehicle No.">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="payload" HeaderText="Payload Of Vehicle (Ton)">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="right" BackColor="white" />
            </asp:BoundField>
                <asp:BoundField  DataField="actload" HeaderText="Actual Load Carried (Ton)">
                <HeaderStyle HorizontalAlign="Center" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="right" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="capacity_uty" HeaderText="Capacity Utilisation in %">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="right" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="routecost" HeaderText="Actual Route Cost as per THC">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="right" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="cost_kg" HeaderText="Actual Cost/kg">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="right" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="std_contamt" HeaderText="Standard Route Cost as per Route Master">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="right" BackColor="white" />
            </asp:BoundField>
                <asp:BoundField  DataField="std_cost_kg" HeaderText="Standard Cost/kg">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="Total_docket" HeaderText="Total Dockets Carried">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="right" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="Total_freight" HeaderText="Docket Freight">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="right" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="Total_freight_kg" HeaderText="Docket Freight/Kg.">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="right" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="thc_std_profit" HeaderText="THC Profit  (std. cost basis)">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="right" BackColor="white" />
            </asp:BoundField>
                <asp:BoundField  DataField="std_profit_per" HeaderText="Profit %">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="right" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="thc_act_profit" HeaderText="THC Profit     (actual cost basis) ">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="right" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="act_profit_per" HeaderText="Profit %">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="right" BackColor="white" />
            </asp:BoundField>
           <%-- <asp:BoundField  DataField="" HeaderText="Doc. Date">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="Doc. Date">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>--%>
           
        </Columns>
        <RowStyle />
        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
        <FooterStyle CssClass="boxbg" />
    </asp:GridView>
    
    <asp:GridView Visible="false" align="center" ID="dgMR" runat="server" BorderWidth="0"
         CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
        AllowPaging="true" PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]" 
        EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
        <Columns>
            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                <ItemTemplate>
                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                        runat="server">
                    </asp:Label>
                </ItemTemplate>
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt" />
            </asp:TemplateField>
            
          <asp:BoundField  DataField="vehno" HeaderText="Vehicle No">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="routecd" HeaderText="Route Code">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField  DataField="routename" HeaderText="Route">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
           
             <asp:BoundField  DataField="thcno" HeaderText="Doc. No">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="thcdt" HeaderText="Doc. Date">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField  DataField="coming_from" HeaderText="Last Location">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="depart" HeaderText="Departed at">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField  DataField="tobh_code" HeaderText="Next Location">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="PayLoad" HeaderText="PayLoad Of Vehicle">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField  DataField="actload" HeaderText="Actual Load Carried">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
             <asp:BoundField  DataField="complete" HeaderText="Status">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
        </Columns>
        <RowStyle />
        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
        <FooterStyle CssClass="boxbg" />
    </asp:GridView>
    
     <asp:GridView Visible="false" align="center" ID="DGTM" runat="server" BorderWidth="0"
         CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
        AllowPaging="true" PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
        PagerSettings-FirstPageText="[First]" PagerSettings-LastPageText="[Last]"  OnRowDataBound="DGTM_RowDataBound"
        EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
        <Columns>
            <asp:TemplateField HeaderText="SR.NO." ItemStyle-BackColor="white">
                <ItemTemplate>
                    <asp:Label CssClass="blackfnt" ID="lblsrnocomplainlist" Text="<%# Container.DataItemIndex+1 %>"
                        runat="server">
                    </asp:Label>
                </ItemTemplate>
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt" />
            </asp:TemplateField>
            
         
            <asp:BoundField  DataField="routecd" HeaderText="Route Code">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField  DataField="routename" HeaderText="Route">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="tr_time" HeaderText="Route">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField  DataField="thcno" HeaderText="Doc. No">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="thcdt" HeaderText="Doc. Date">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
             <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
             <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
             <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
             <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
             <asp:BoundField  DataField="" HeaderText="">
                <HeaderStyle HorizontalAlign="Center"  CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt"  HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
              </Columns>
        <RowStyle />
        <PagerStyle HorizontalAlign="Center" CssClass="bgbluegrey" />
        <HeaderStyle CssClass="bgbluegrey" />
        <PagerSettings FirstPageText="[First]" LastPageText="[Last]" Mode="NumericFirstLast" />
        <FooterStyle CssClass="boxbg" />
        </asp:GridView>
         <br />
    <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="center">
        <tr bgcolor="white">
            <td colspan="2" align="center">
                <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
            </td>
        </tr>
    </table>
</asp:Content>

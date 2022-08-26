<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="result.aspx.cs" Inherits="GUI_UNI_MIS_TRF_report_result" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <p align="center">
        <label class="blackfnt">
            <b>You Selected </b>
        </label>
    </p>
    <br />
    <asp:GridView Visible="false" align="center" ID="dgDocket" runat="server" BorderWidth="0"
        CellPadding="3" CellSpacing="1" HeaderStyle-CssClass="bgbluegrey" AllowSorting="true"
        AllowPaging="true" PageSize="25" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
        FooterStyle-CssClass="boxbg" PagerSettings-Mode="NumericFirstLast" AutoGenerateColumns="false"
        OnRowDataBound="dgDocket_RowDataBound" PagerSettings-FirstPageText="[First]"
        PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found..." OnPageIndexChanging="pgChange">
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
            <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="businesstype" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="dockcket" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="docket_dt" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="VENDTY" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="loadtype" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="vendor" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="vehno" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="capacity" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="vehtype" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="tripsheetno" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="truckno" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
            <asp:BoundField DataField="actuwt" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="Cnor" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="Cnee" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="orgncd" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="destcd" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
            <asp:BoundField DataField="from_loc" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="to_loc" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
             <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="openkm" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="closekm" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            <asp:BoundField DataField="dist" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="freight" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
             <asp:BoundField DataField="otchg" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="dkttot" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="thcfreight" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
            <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
            <asp:BoundField DataField="load_chrg" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
            <asp:BoundField DataField="unload_chrg" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
            <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
            <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
            <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="trp_cost" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
            <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
            <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
            <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
            <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
            <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
            <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
            
            <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
            </asp:BoundField>
             <asp:BoundField DataField="" HeaderText="Date ">
                <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                <ItemStyle CssClass="blackfnt" Wrap="False" HorizontalAlign="Center" BackColor="white" />
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

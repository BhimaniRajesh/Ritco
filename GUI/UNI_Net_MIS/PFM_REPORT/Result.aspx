<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Result.aspx.cs" Inherits="GUI_UNI_MIS_Reassign_Report_ReassignReportResult" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<br />
<div align="right" style="width: 10.0in;">
<a href="javascript:window.history.go(-1)" title="back"><IMG src="../../images/back.gif" border="0" /></a>
</div>
<div align="left" >
<table>
<tr>
<td>
        <table align="left" cellspacing="1" class="boxbg" style="width: 9in">
            <tr class="bgbluegrey">
                <td align="center" > 
                    <strong>PFM REPORT </strong>
                </td>
            </tr>
        </table>
        <br />
        </td>
    </tr>
    
    <tr>
    <td>

    <table align="left" border="0" cellpadding="3" cellspacing="1" class="boxbg" width="565">
        <tr style="background-color: #ffffff">
            <td colspan="2" style="height: 10px; text-align: center">
                <strong><span style="font-size: 8pt">You Selected</span></strong></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="height: 10px">
                <label class="blackfnt">
                    Date :</label></td>
            <td style="height: 10px">
                <asp:Label ID="lblseldet" runat="server" CssClass="blackfnt"></asp:Label></td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 205px; height: 15px">
                <label class="blackfnt">
                    RO :</label></td>
            <td style="font-weight: bold; width: 343px; height: 15px">
                <asp:Label ID="lblro" runat="server" CssClass="blackfnt" Font-Bold="False"></asp:Label>
            </td>
        </tr>
        <tr style="background-color: #ffffff">
            <td style="width: 205px">
                <label class="blackfnt">
                    Location :</label></td>
            <td style="width: 343px">
                <asp:Label ID="lblloc" runat="server" CssClass="blackfnt"></asp:Label>
            </td>
        </tr>
         <tr style="background-color: #ffffff">
                <td style="height: 6px">
                    <label class="blackfnt">
                        Type :
                    </label>
                </td>
                <td style="height: 6px">
                    <asp:Label ID="lblTypeD" runat="server" CssClass="blackfnt"> 
                    </asp:Label></td>
            </tr>
    </table>
    <br />
    </td>
    </tr>
   <tr>
   <td>
   <asp:GridView ID="dgDocket" runat="server" align="left"  AllowSorting="True"
        AutoGenerateColumns="False" BorderWidth="0px" CellPadding="2" CellSpacing="1"
        CssClass="boxbg" EmptyDataText="No Records Found..." FooterStyle-CssClass="boxbg"
        HeaderStyle-CssClass="bgbluegrey"  Visible="False">
        
        <FooterStyle CssClass="boxbg" />
        <Columns>
            <asp:TemplateField HeaderText="SR.NO.">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                <HeaderStyle CssClass="blackfnt" />
                <ItemTemplate>
                    <asp:Label ID="lblsrno" runat="server" CssClass="blackfnt" Text="<%# Container.DataItemIndex+1 %>">
                        </asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="locname" HeaderText="LOCATION">
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
            </asp:BoundField>
            
            <asp:HyperLinkField DataTextField="tot_dkt" HeaderText="TOTAL DOCKETS" DataNavigateUrlFields="loccode" DataNavigateUrlFormatString="ResultDetails.aspx?type=1&amp;location={0}" >
                <ItemStyle BackColor="White"  CssClass="blackfnt" HorizontalAlign="Center" Wrap="False"  />
                <ControlStyle Font-Underline="True"  />
                <HeaderStyle CssClass="blackfnt"  HorizontalAlign="Center" Wrap="True" />
            </asp:HyperLinkField>
            <asp:HyperLinkField DataTextField="tot_del" HeaderText="DELIVERED" DataNavigateUrlFields="loccode" DataNavigateUrlFormatString="ResultDetails.aspx?type=2&amp;location={0}" >
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                <ControlStyle Font-Underline="True"  />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
            </asp:HyperLinkField>
            <asp:HyperLinkField DataTextField="tot_not_del" HeaderText="NOT DELIVERED" DataNavigateUrlFields="loccode" DataNavigateUrlFormatString="ResultDetails.aspx?type=3&amp;location={0}" >
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                 <ControlStyle Font-Underline="True"  />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
            </asp:HyperLinkField>
            <asp:HyperLinkField DataTextField="tot_del_pfm_made" HeaderText="DELIVERED AND PFM MADE" DataNavigateUrlFields="loccode" DataNavigateUrlFormatString="ResultDetails.aspx?type=4&amp;location={0}" >
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                 <ControlStyle Font-Underline="True"  />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
            </asp:HyperLinkField>
            <asp:HyperLinkField DataTextField="tot_del_pfm_not_made" HeaderText="DELIVERED AND PFM NOT MADE" DataNavigateUrlFields="loccode" DataNavigateUrlFormatString="ResultDetails.aspx?type=5&amp;location={0}" >
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                 <ControlStyle Font-Underline="True"  />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
                
            </asp:HyperLinkField>
            <asp:HyperLinkField DataTextField="tot_del_pfm_made_rec" HeaderText="PFM MADE AND RECIEVED" DataNavigateUrlFields="loccode" DataNavigateUrlFormatString="ResultDetails.aspx?type=6&amp;location={0}" >
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                 <ControlStyle Font-Underline="True"  />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
            </asp:HyperLinkField>
            <asp:HyperLinkField DataTextField="tot_del_pfm_made_not_rec" HeaderText="PFM MADE AND NOT RECIEVED" DataNavigateUrlFields="loccode" DataNavigateUrlFormatString="ResultDetails.aspx?type=7&amp;location={0}" >
                <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                 <ControlStyle Font-Underline="True"  />
                <HeaderStyle CssClass="blackfnt" HorizontalAlign="Center" Wrap="True" />
            </asp:HyperLinkField>
        </Columns>
        
        <HeaderStyle CssClass="bgbluegrey" />
    </asp:GridView>
    <br />
    
    </td>
    </tr>
    <tr>
    <td>
     <table cellspacing="0" cellpadding="0"  align="center" bgColor="white" border="0">
    <tr bgColor="white"><td align="center" colspan="2"><asp:Button id="btn_csv" onclick="btn_csv_Click" runat="server" Text="DownLoad XLS" Width="170"></asp:Button> 
    </td></tr></table>
    </td>
    </tr>
    </table>
    
    </div>
    <br />
</asp:Content>


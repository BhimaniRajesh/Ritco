<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="FrmLoadUnloadTotal.aspx.cs" Inherits="FrmPaidFollowUp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
   <script language="javascript" type="text/jscript">
//    <link href="/aspnet_client/System_Web/2_0_50727/CrystalReportWebFormViewer3/css/default.css"
   </script>  
        
        <br />
        <br />
        <table style="width: 319px;height: 173px; z-index: 103; left: 232px; position: absolute; top: 159px;" title="Your Query Here" cellspacing="1" border="1">
      <tr> <td colspan="3" class="bgbluegrey" style="height: 23px">  <p align="center" style="background-color:#d4e0e7"><label class="blackfnt">Your Query Here</label></p>
     </td></tr>
            <tr>
                <td style="width: 319px; text-align: left; height: 33px;" colspan="2">
                    Date Ranges :&nbsp;
                    <asp:Label ID="lbldaterange" runat="server" Style="z-index: 100; left: 117px; position: absolute;
                        top: 50px" Text="Label" Width="197px"></asp:Label>
                    <asp:TextBox ID="TxtDateRange" runat="server" Width="237px" ReadOnly="True" Visible="False" style="z-index: 102; left: 158px; position: absolute; top: 171px"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" style="width: 319px">
                    RO :
                    <asp:Label ID="lblRO" runat="server" Style="z-index: 100; left: 116px; position: absolute;
                        top: 84px" Text="Label" Width="172px"></asp:Label>
                    <asp:TextBox ID="TxtRO" runat="server" Width="168px" ReadOnly="True" Visible="False" style="z-index: 102; left: 163px; position: absolute; top: 172px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="width: 319px">
                    Location :
                    <asp:Label ID="lblLocation" runat="server" Style="z-index: 100; left: 116px; position: absolute;
                        top: 117px" Text="Label" Width="173px"></asp:Label>
                    <asp:TextBox ID="txtLocation" runat="server" Width="168px" ReadOnly="True" Visible="False" style="z-index: 102; left: 160px; position: absolute; top: 170px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="width: 319px">
                    Customer Code :
                    <asp:Label ID="lblCCode" runat="server" Style="z-index: 100; left: 116px; position: absolute;
                        top: 147px" Text="Label" Width="175px"></asp:Label>
                    <asp:TextBox ID="TxtCCode" runat="server" Width="168px" ReadOnly="True" Visible="False" style="z-index: 102; left: 162px; position: absolute; top: 172px"></asp:TextBox>&nbsp;
                </td>
            </tr>
        </table>
        <asp:TextBox ID="TxtFDt" runat="server" Visible="False"></asp:TextBox>
        <asp:TextBox ID="TxtTDt" runat="server" Visible="False"></asp:TextBox><br />
        <br />
        <asp:datagrid ID="GrdPaidFollow" OnItemCommand="gotolink" OnItemDataBound="eventhandler" runat="server"  PagerStyle-Mode="NumericPages"
              PagerStyle-Position="Top"
              PagerStyle-HorizontalAlign="left"
              PagerStyle-CssClass="pageLinks"
              AllowPaging="True" HeaderStyle-CssClass="bgbluegrey" BackColor="white" FooterStyle-CssClass="boxbg" AllowSorting ="True" CssClass="boxbg" OnPageIndexChanged="PageIndexChanged_Click" OnSortCommand = "SortCommand_Click" AutoGenerateColumns="true" PagerSettings-FirstPageText="[First]" style="z-index: 100; left: 12px; position: absolute; top: 355px" PageSize="25">
            <FooterStyle CssClass="boxbg" />
            <PagerStyle CssClass="pageLinks" Position="Top" HorizontalAlign="Left" Mode="NumericPages" />
            <HeaderStyle CssClass="bgbluegrey" />
              
              
            <Columns>        
            <asp:TemplateColumn HeaderText="Sr.No">
                 <ItemTemplate>
                     <asp:Label ID="lblId" runat="server" CssClass="blackfnt"></asp:Label>
                 </ItemTemplate>  
              </asp:TemplateColumn>
            </Columns> 
       </asp:datagrid> &nbsp;<br />
        <br />
        <asp:Button ID="Button1" runat="server" BackColor="#C0C0FF" OnClick="Button1_Click" Text="Print" style="z-index: 102; left: 329px; position: absolute; top: 661px" Width="54px" />
        <asp:Button ID="cmdexcel" runat="server" BackColor="#C0C0FF" OnClick="cmdexcel_Click" Text="Excel" style="z-index: 102; left: 386px; position: absolute; top: 661px" Width="54px" />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
   </asp:Content>

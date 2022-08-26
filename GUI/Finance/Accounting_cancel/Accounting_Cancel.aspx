<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
     CodeFile="Accounting_Cancel.aspx.cs" Inherits="GUI_Finance_Accounts_Debit_Voucher_DebitVoucher"
    Title="Debit Voucher" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>

    <script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>


    <div style="width: 10.0in; text-align: right">
        <a href="javascript:window.history.go(-1)" title="back">
            <img alt="back" src="../../images/back.gif" border="0" /></a>
    </div>
    <div style="text-align: center; width: 10.0in">
        
        <asp:Label ID="lblMsg" runat="server" Text=""></asp:Label><br />
        <asp:UpdatePanel ID="UpdatePanel3" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
    <ContentTemplate>  
  <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
     <tr style="background-color: White"> 
       
      <td style="text-align: left" colspan="5" class="blackfnt"> <asp:Label ID="msgn" CssClass="blackfnt" Font-Bold="true" runat="server" Text="Click Submit TO Cancel Accounting Before 01 JULY 08"></asp:Label></td>
    </tr>
  </table>
 
        <br />
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
        <asp:Table ID="Table1" runat="server">
        <asp:TableRow>
        <asp:TableCell><asp:Image ID="imgwaiting" runat="server" ImageUrl="~/GUI/images/loading.gif" /></asp:TableCell>
        <asp:TableCell CssClass="blackfnt" Font-Bold="true">&nbsp; Please Wait</asp:TableCell>
        </asp:TableRow>
        </asp:Table>
        </ProgressTemplate>
        </asp:UpdateProgress>
        <br />
 
        <table cellspacing="1" class="boxbg" width="800">
            <tr class="bgbluegrey">
                <td align="center">
                    <asp:Button ID="btnSubmit" runat="server"  CssClass="blackfnt"   BorderStyle="Solid" BorderWidth="1px" Text="SUBMIT"
                        Width="150px" OnClick="btnSubmit_Click" /></td>
            </tr>
        </table>
         </ContentTemplate>
  </asp:UpdatePanel>
    </div>
    <br />
    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>

<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="doc_gen.aspx.cs" Inherits="octroi_OctCustBillStep2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">

function check(roww,btnAdd)
{

}

</script>
    <br />
     
     
     <br />
     <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:60%"  align="left">
    <tr class="bgbluegrey">
                                <td colspan="3" align="center" style="height: 21px">
                                    <asp:Label ID="lblQry" CssClass="bluefnt" 
                                        Font-Bold="True" runat="server" >Following Document has Successfully Generated/Updated</asp:Label>
                                </td>
                            </tr>
     <tr  bgcolor="white"  style="height:25px">
        <td style="width: 420px"><font class="blackfnt">Document Name</font></td>
        <td style="width: 188px"><font class="blackfnt">
            <p align="left">
                <font class="blackfnt">Document No.</font></p>
        </font></td>
        
     </tr>
     <tr  bgcolor="white" style="height:25px">
      <td style="width: 420px"><font class="blackfnt"><strong>Payment Voucher</strong></font></td>
        <td><asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="true">
                       
                                    </asp:Label></td>
      
     </tr>
         
     </table>
   
                 <br />  
    <br />
    <br /> <br />  
    <br />
    <br /> <br />  
   
    <br />
  
    <br />
    <a href="../octroi_menu2.aspx"><font class="blklnkund"><b>Return To Main Menu</b></font></a>
    </asp:Content>

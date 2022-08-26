<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="BOUNCE_Done.aspx.cs" Inherits="octroi_OctCustBillStep2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript">

function check(roww,btnAdd)
{

}

</script>
    <br />
     
     
     <br />
       <div align="left" style="width: 9.5in;">
     <table   border="0" cellpadding="1" cellspacing="1" class="boxbg" style="width:80%"  align="center">
    <tr class="bgbluegrey">
                                <td colspan="3" align="center" style="height: 21px">
                                    <asp:Label ID="lblQry" CssClass="blackfnt" 
                                        Font-Bold="True" runat="server" ForeColor="Red">Following Cheque has Successfully Bounced </asp:Label>
                                </td>
                            </tr>
     <tr  bgcolor="white"  style="height:25px">
        <td style="width: 120px"><font class="blackfnt">Cheque No.</font></td>
        <td style="width: 188px"><font class="blackfnt">
            <p align="left">
                <font class="blackfnt">Cheque Date</font></p>
        </font></td>
        
     </tr>
     <tr  bgcolor="white" style="height:25px">
      <td style="width:120px"><font class="blackfnt"><strong> <asp:Label ID="LblChqno" runat="server" CssClass="blackfnt" Font-Bold="true">
                       
                                    </asp:Label> </strong></font></td>
        <td><asp:Label ID="LblChqdate" runat="server" CssClass="blackfnt" Font-Bold="true">
                       
                                    </asp:Label></td>
      
     </tr>
         
     </table>
   
                  <center>
                      &nbsp;</center>
                      </div>
    </asp:Content>

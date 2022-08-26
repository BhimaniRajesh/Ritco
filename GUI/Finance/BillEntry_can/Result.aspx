<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="Result.aspx.cs" Inherits="octroi_OctCustBillStep2" %>

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
                                        Font-Bold="True" runat="server" ForeColor="Red">Following Document has Successfully Cancelled </asp:Label>
                                </td>
                            </tr>
     <tr  bgcolor="white"  style="height:25px">
        <td style="width: 120px"><font class="blackfnt">Document Name</font></td>
        <td style="width: 188px"><font class="blackfnt">
            <p align="left">
                <font class="blackfnt">Document No.</font></p>
        </font></td>
        
     </tr>
     <tr  bgcolor="white" style="height:25px">
      <td style="width:120px"><font class="blackfnt"><strong> Bill Entry </strong></font></td>
        <td><asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="true">
                       
                                    </asp:Label></td>
      
     </tr>
         
     </table>
   
                  <center>
                      &nbsp;</center>
                      </div>
    </asp:Content>

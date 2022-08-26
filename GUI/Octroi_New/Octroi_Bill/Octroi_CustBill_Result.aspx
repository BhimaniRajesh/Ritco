<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Octroi_CustBill_Result.aspx.cs" Inherits="GUI_Octroi_New_Octroi_Bill_Octroi_CustBill_Result" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script type="text/javascript" src="../../images/dropdowncontent.js"></script>
 <script language="javascript" type="text/javascript">
    function ViewPrint(arg1,arg2)
    {
        window.open("octroibill_viewprint.aspx?billno=" + arg1 + "&printyn=" + arg2 ,"es","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=650,height=290,status=no,left=60,top=125");
    }   
</script>
    <br />
    <table border="0" width="100%">
        <tr>
            <td width="10%">
            </td>
            <td width="90%" align="left">
                <table border="0" class="boxbg" cellpadding="1" cellspacing="1" width="650">
                    <tr class="bgbluegrey">
                        <td align="center" colspan="3">
                            <asp:Label ID="lblHeader" runat="server"  Font-Bold="true" Text="Following document has been successfully Generated / Updated" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color:White">
                        <td align="center"> 
                            <asp:Label ID="lblDocType" runat="server" Text="Document Name" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center"> 
                            <asp:Label ID="lblDocNo" runat="server" Text="Document No" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center"> 
                            <asp:Label ID="lblDocName" runat="server" Font-Bold="True" CssClass="blackfnt"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color:White">
                        <td align="center"> 
                            <asp:Label ID="lblDocNameVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center"> 
                            <asp:Label ID="lblDocNoVal" runat="server" Text="" CssClass="blackfnt"></asp:Label>
                        </td>
                        <td align="center"> 
                            <a href="javascript:ViewPrint('<%=Billno%>',0);"><font class="blackfnt">View</font></a>
                            <asp:Label ID="lblSep1" runat="server" Text="|" CssClass="blackfnt"></asp:Label>
                            <a href="javascript:ViewPrint('<%=Billno%>',0);"><font class="blackfnt">Print</font></a>
                        </td>
                    </tr>
                    <tr bgcolor="white" ><td colspan="4" align="left" style="height: 25px"   ><font class="blackfnt">
                   <a href="#" id="Href_Acct_Po" rel="Acct_Po"> 
                                  <b> Show Accounting Treatment For Document </b></a></font>
                                                     <div align="left"  id="Acct_Po" style='position:absolute; visibility: hidden; border: 1px solid black; background-color: AliceBlue; width: 600px; height: 200; padding: 1px;'>
                                                     <div >
                                                     <%=ToolTip_Str%>
                                                     </div>     </div> 
                            
                                                     <script type="text/javascript">
                                                           // alert(Href_Acct_Po)
                                                            dropdowncontent.init("Href_Acct_Po", "right-middle", 500, "mouseover")   
                                                           //alert(Href_Acct_Po)
                                                    </script>  
                   
             </td></tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>


<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="ReceiverMasterCriteria.aspx.cs" Inherits="GUI_admin_ReceiverMasterCriteria"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript" type="text/javascript">
function onSubmitCheckValue()
{    
    var ddlReceiver = document.getElementById("ctl00_MyCPH1_ddlReceiver");     
   
    if(ddlReceiver.value == "0")
    {
       alert("Please select Receiver.");
       ddlReceiver.focus();
       return false; 
    }   
    return true;  
}
</script>
    <br /><br /><br />
 <asp:Panel runat="server" Width="10in">
        <asp:Table Width="60%" ID="tblMain" CssClass="boxbg" HorizontalAlign="Center" CellSpacing="1" runat="server">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="center" Font-Bold="true" ColumnSpan="2">
                             Receiver Master Criteria
                </asp:TableCell>                
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left" Width="30%">
                                Select Receiver
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                    <asp:DropDownList ID="ddlReceiver" runat="server" Width="200px" CssClass="blackfnt">
                    </asp:DropDownList>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">                
                <asp:TableCell HorizontalAlign="center" ColumnSpan="2">
                     <asp:Button ID="btnEdit" runat="server" CssClass="blackfnt" Text="Edit" OnClick="btnEdit_Click"
                        Visible="false" OnClientClick="javascript:return onSubmitCheckValue()" />   
                        </asp:TableCell>               
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>

<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="StateMasterCriteria.aspx.cs" Inherits="GUI_admin_StateMaster_StateMasterCriteria"
     %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript" type="text/javascript">
function onSubmitCheckValue(Flag)
{
    var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
    var ddState = document.getElementById("ctl00_MyCPH1_ddState");     
   
    if(ddState.value == "0")
    {
       alert("Please select State.");
       ddState.focus();
       return false; 
    }  
    else
    {
        if(Flag == "View")
        {
           window.open("StateMasterView.aspx?state="+ ddState.value +"&print=N","", winOpts);         
           return false;
        }
    }
    return true;
}
</script>
    <br /><br /><br />
 <asp:Panel runat="server" Width="10in">
        <asp:Table Width="60%" ID="tblMain" CssClass="boxbg" HorizontalAlign="left" CellSpacing="1" runat="server">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="center" Font-Bold="true" ColumnSpan="2">
                             State Master Criteria
                </asp:TableCell>                
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left" Width="30%">
                                Select State
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                    <asp:DropDownList ID="ddState" runat="server" Width="300px" CssClass="blackfnt" TabIndex="1">
                    </asp:DropDownList>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">                
                <asp:TableCell HorizontalAlign="center" ColumnSpan="2">
                     <asp:Button ID="btnEdit" runat="server" CssClass="fbtn" Text="Edit" OnClick="btnEdit_Click"
                        Visible="false" OnClientClick="javascript:return onSubmitCheckValue('Edit')" />
                    <asp:Button ID="btnView" runat="server" CssClass="blackfnt" Text="View" OnClientClick="javascript:return onSubmitCheckValue('View')"
                        Visible="false" /></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>

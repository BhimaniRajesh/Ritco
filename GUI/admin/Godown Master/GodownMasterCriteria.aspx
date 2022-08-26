<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="GodownMasterCriteria.aspx.cs" Inherits="GUI_admin_VendorMaster_GodownMasterCriteria"
     %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <script language="javascript" type="text/javascript" src="../../../GUI/images/CommonJS.js"></script>
    <script language="javascript" type="text/javascript">

/*************************************************************************************************************
*   VALIDATION FOR ALL INPUT WHEN SUBMIT BUTTON CLICK
/*************************************************************************************************************/             
function onSubmitCheckValue(Flag)
{
          var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";     
          var ddlLocation = document.getElementById("ctl00_MyCPH1_ddlLocation"); 
 
                      
           if(ddlLocation.value == "0")
           {
               alert("Please select Warehouse Location.");              
               ddlLocation.focus();
               return false; 
           }
           else
           {  
                if(Flag == "View")
                {     
                   window.open("GodownMasterView.aspx?locCode="+ ddlLocation.value +"&print=N","", winOpts);         
                   return false;
                }
           }     
    
    return true;
}
    </script>
    <asp:Panel runat="server" HorizontalAlign="left" Style="width: 10in" ID="pnlMain">
        <br />
        <br />
        <asp:Table ID="tblMain" runat="server" HorizontalAlign="center" CssClass="boxbg"
            CellSpacing="1" BorderWidth="0" Width="60%" BorderStyle="Groove">
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="3" Style="height: 20px;">
                  <b>Select Warehouse Location For Edit</b>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgwhite">
                <asp:TableCell HorizontalAlign="left">                               
                          Warehouse Location Code                                       
                </asp:TableCell>
                <asp:TableCell HorizontalAlign="left">
                    <asp:DropDownList ID="ddlLocation" CssClass="blackfnt" runat="server" Width="175px"
                        TabIndex="1">
                    </asp:DropDownList>
                </asp:TableCell>
            </asp:TableRow>
            <asp:TableRow CssClass="bgbluegrey">
                <asp:TableCell HorizontalAlign="center" ColumnSpan="3">
                    <asp:Button ID="btnEdit" runat="server" Width="75px" CssClass="blackfnt" Text="Edit"
                        OnClientClick="javascript:return onSubmitCheckValue('Edit')" OnClick="btnEdit_Click"
                        Visible="false" />
                    <asp:Button ID="btnView" runat="server" Width="75px" CssClass="blackfnt" Text="View"
                        OnClientClick="javascript:return onSubmitCheckValue('View')" Visible="false" />
                </asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </asp:Panel>
</asp:Content>

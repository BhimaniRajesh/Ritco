<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Result.aspx.cs" Inherits="GUI_UNI_MIS_Monthly_Sales_Result" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
 <table HorizontalAlign="left" runat="server" CellPadding="3" CellSpacing="1" style="width:8.5in;" CssClass="boxbg">
 <tr>
 <td>

    <br />
    <br />
    <br />
    <asp:Table id="TBL_MonthlySales" border="0" HorizontalAlign="left" runat="server" CellPadding="3" CellSpacing="1" style="width:8.5in;" CssClass="boxbg"></asp:Table>
    <br />
    </td>
 </tr>
 
<tr>
 <td><br />
   
        <table border="0" cellpadding="0" width="565" bgcolor="white" cellspacing="0" align="left">
            
           
            <tr bgcolor="white">
                <td colspan="2" align="center">
                    <asp:Button ID="btn_csv" Text="DownLoad XLS" runat="server" Width="170" OnClick="btn_csv_Click" />
                </td>
            </tr>
        </table>
         </td>
 </tr>
 
 </table>
    
    
</asp:Content>

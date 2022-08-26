<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="JobsheetApproval.aspx.cs" Inherits="Issue_frmVehicleIssueSlip" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

 <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Jobsheet Approval</asp:Label>
               <%-- <hr align="center" size="1" color="#8ba0e5">--%>
            </td>
            
             <td align=right>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                    <font class="blackfnt" color=red><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>      
        </tr>
    </table>
    
    <hr align="center" size="1" color="#8ba0e5">
      <br> 
      <table cellspacing="1" style="width: 100%">
            <tr align="left">
                <td>  
                   <table cellspacing="1" cellpadding="2" style="width: 400px" class="boxbg">
                                    <tr class="bgbluegrey">
                                        <td colspan="4" align="center">
                                            <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Jobsheet Type</asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td valign=top align=center>
                                            <asp:RadioButtonList ID="radJobsheet"  runat=server CssClass="blackfnt" RepeatDirection=Horizontal CellPadding=8 CellSpacing=8 ValidationGroup="VGDtFromTo">
                                               <asp:ListItem Text="Generate" Value="G"></asp:ListItem>
                                               <asp:ListItem Text="Closure" Value="C"></asp:ListItem>
                                            </asp:RadioButtonList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="radJobsheet"
                                            ErrorMessage="Please select atleast Jobsheet Type !!!" ValidationGroup="VGDtFromTo" CssClass="redfnt" />
                                        </td>
                                    </tr>
                                    <tr style="background-color: white">
                                        <td colspan="4" align="right">
                                            <asp:Button ID="btnShowMultipleRequest" runat="server" Text="Submit" ValidationGroup="VGDtFromTo"  OnClick="btnShowMultipleRequest_Click" /> 
                                        </td>
                                    </tr>
                  </table>
                 </td>
             </tr>
      </table>                  


</asp:Content> 

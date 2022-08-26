<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="JSGenerateApproval.aspx.cs" Inherits="GUI_Fleet_Webadmin_Job_JSApprovalAmt" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
    <asp:UpdatePanel runat="server" ID="Up1" >
    <ContentTemplate>
    <table cellspacing="1" style="width: 800px ">
        <tr style="background-color: white">
            <td align="left" style="height: 26px">
                <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Jobsheet Generate Approved </asp:Label>
                <hr align="center" color="#8ba0e5" size="1" />
            </td>
            <td align="right">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                        <asp:Image ID="img1" runat="server" ImageUrl="~/GUI/images/indicator.gif" />
                        <font class="blackfnt" color="red"><b>Please wait...</b></font>
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </td>      
        </tr>
    </table>
    <br/>
    <br/>        
    <table  align="center"  class="boxbg" cellspacing="2" width="95%" >   
       <tr class="bgbluegrey">
                        <td colspan="4" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">Jobsheet Generate Approved</asp:Label>
                        </td>
                    </tr>
        <tr  style="background-color: white">
            <td colspan="4" align="left">
                <asp:GridView ID="gvJobSheet" runat="server">
                </asp:GridView>
            </td>
        </tr>
     
    </table>
    
     <table  align="center"   style="width: 100%"     >    
                       
                       <tr style="background-color: white" align="center">
                          <td  align="center" colspan="2">
                           <asp:Button ID="btnApproved" runat="server" Text="Approve"  /> 
                       </td>
                      </tr>
                     </table>
   
   
    
   </ContentTemplate>
                    <Triggers>
                     
                   
            <asp:AsyncPostBackTrigger ControlID="cmdSubmit" EventName="Click" />
 </Triggers>
   </asp:UpdatePanel>
</asp:Content>


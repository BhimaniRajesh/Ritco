<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"     CodeFile="FailureCodeMaster.aspx.cs" Inherits="GUI_Fleet_Job_FailureCodeMaster" %>

<asp:Content  ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">


    <asp:HiddenField ID="moreprod" runat="server" />
    <table cellspacing="1" width="100%" >
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Failure Code  Master</asp:Label>
                <hr align="center"  color="#8ba0e5">
            </td>
        </tr>
    </table>
    
    <br /><br /><br />
    <p align="center">
    
        
 
    
    
        <table  width="100%"     cellspacing="1" cellpadding="3" class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td colspan="2" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Failure Code Details"></asp:Label></td>
            </tr>
            
           
             <tr style="background-color: white">
               
                <td align="left" colspan="1">
                    <asp:Label ID="lblPno" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Failure Code"></asp:Label>  
     
                </td>
                <td align="left" colspan="1" >
        <asp:Label ID="Label12" runat="server" CssClass="redfnt" Text="System Gennerated."></asp:Label>
                      </td>
                     </tr>
        
            
          <tr style="background-color: white">
               
                <td align="left" colspan="1" >
                    <asp:Label ID="lblFailureReason" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Failure Reason "></asp:Label>
                   <asp:RequiredFieldValidator ID="ReqtxtFailureReason" runat="server" ControlToValidate="txtFailureReason"
                        ErrorMessage="*"></asp:RequiredFieldValidator> 
                </td>
                <td align="left" colspan="1" >
                     
               <asp:TextBox ID="txtFailureReason" runat="server" CssClass="input" Width="121px"></asp:TextBox> 
                   
                     
                    
                </td>
                 </tr>
                 
                 
                 
                 
                 
                 </table>
                 <br/>
                 
        <table  width="100%"     cellspacing="1" cellpadding="3" >
            <tr  style="background-color: white">
                <td  align="center">
                
                  <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" OnClick="cmdSubmit_Click"    />&nbsp;&nbsp;
                </td>
                </tr>
                </table>
                
                
                
                </asp:Content>

<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master" CodeFile="frmCloseJourneyQuery.aspx.cs" Inherits="Issue_frmCloseJourneyQuery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Close Journey >> Query</asp:Label>
             
            </td>
            
             <td align=right>
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" >
                    <ProgressTemplate>
                    <asp:Image ID="img1" runat="server" ImageUrl="~/images/indicator.gif" />
                    <font class="blackfnt" color=red><b>Please wait...</b></font>
            </ProgressTemplate>
          </asp:UpdateProgress>  
         
          </td>    
           
        </tr>
    </table>
<hr align="center" size="1" color="#8ba0e5">
 <br> 

 
 
 <asp:UpdatePanel ID="UpdatePanel1" RenderMode="Inline" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>
 <table cellspacing="1" style="width: 100%">
            <tr align="center">
                <td>  
                    <table cellspacing="1" cellpadding="2" style="width: 70%" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="4" align="center">
                                <asp:Label ID="Label3" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="left" width="20%">
                                <asp:Label ID="Label4" CssClass="blackfnt" runat="server" Font-Bold="True"> 
                                <asp:DropDownList ID=cboID runat=server OnSelectedIndexChanged="ClearData" AutoPostBack=true>
                                 <asp:ListItem Text="Vehicle Request Id" Value="VR"></asp:ListItem>
                                 <asp:ListItem Text="Vehicle Issue Slip Id" Value="VS"></asp:ListItem>
                                </asp:DropDownList>
                                :</asp:Label>
                            </td>
                            <td align="left" colspan="3">
                                <%--<asp:UpdatePanel ID="UpdatePanel4" RenderMode="Inline" UpdateMode="Conditional" runat="server">
                                    <ContentTemplate>--%>
                                        <asp:TextBox CssClass="input" ID="txtID" runat="Server" ValidationGroup="VGRequestID" BorderStyle="Groove" MaxLength=15 OnTextChanged="CheckValid" AutoPostBack=true></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtID"
                                            ErrorMessage="*"  />
                                        <asp:Label ID="lblError" runat="server" CssClass="blackfnt" ForeColor="red" Font-Bold="true" ></asp:Label> 
                                   <%-- </ContentTemplate>
                                </asp:UpdatePanel>--%>
                            </td>
                        </tr>
                         
                        <tr style="background-color: white">
                            <td colspan="4" align="right">
                                <%--<asp:UpdatePanel ID="UpdatePanel5" UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                    <ContentTemplate>--%>
                                        <asp:Button ID="btnShow" runat="server" Text="Submit" OnClick="btnShow_Click"/>
                                   <%-- </ContentTemplate>
                                </asp:UpdatePanel>--%>
                            </td>
                        </tr>
                        
                        
                    </table>
                          </td>
            </tr>
        </table>      
       </ContentTemplate>
                                </asp:UpdatePanel>
       

<br />

<br />
              


</asp:Content>  


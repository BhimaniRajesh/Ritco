<%@ Page Language="C#" AutoEventWireup="true"   MasterPageFile="~/GUI/MasterPage.master" CodeFile="TyreTypeDet.aspx.cs" Inherits="admin_TyreTypeDet" %>

 
 
<asp:Content  ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <asp:HiddenField ID="moreprod" runat="server" />
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Tyre Type Master</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    
    <br />
    <p align="center">
        <table cellspacing="1" cellpadding="3" style="width: 70%" class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Tyre Type Details"></asp:Label></td>
            </tr>
            <tr style="background-color: white">
                <td align="left" colspan="1" >
                    <asp:Label ID="lblTireID" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Type ID"></asp:Label>
                </td>
                <td align="left" colspan="1"  >
                    <asp:Label ID="lblDriverIDVal" runat="server" CssClass="bluefnt" Text="Sys. Generated"></asp:Label>
                    <asp:HiddenField ID="hPrevDriverCode" runat="server" />
                </td>
               
                
                
                
                </tr>
                
                 <tr style="background-color: white">
               
                <td align="left" colspan="1">
                    <asp:Label ID="lblManufactur" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Type Name"></asp:Label>
                    <asp:RequiredFieldValidator ID="RFVProductType" runat="server" ControlToValidate="txtTypeName"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
                <td align="left" colspan="1" >
                <asp:TextBox ID="txtTypeName" runat="server" CssClass="input">
                    </asp:TextBox>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
               
                
                
            </tr>
           
           
            

 




 <%--            <tr style="background-color: white">
               
                <td align="left" colspan="1" style="height: 28px" >
                    <asp:Label ID="lblMFGEntry" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Type Entry By:"></asp:Label>
                  
                </td>
                <td align="left" colspan="1" style="height: 28px">

                <asp:TextBox ID="txtTypeEntryBy" runat="server" CssClass="input" ></asp:TextBox>
                  </td>
                
            </tr>--%>
            <tr style="background-color: white">
                <td align="left" colspan="1" style="height: 26px">
                    <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Type Description"></asp:Label>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlTyreDescription"
                        ErrorMessage="*" Operator="NotEqual" SetFocusOnError="True" ValueToCompare="00"></asp:CompareValidator></td>
                <td align="left" colspan="1" style="height: 26px">
                    <asp:DropDownList ID="ddlTyreDescription" runat="server"   Width="89px">
                    </asp:DropDownList></td>
            </tr>
            
              <tr style="background-color: white">
               
                <td align="left" colspan="1" style="height: 28px" >
                    <asp:Label ID="lblStatus" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Active Flag"></asp:Label>
                  
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="cboActive"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
                <td align="left" colspan="1">
                    <asp:DropDownList ID="cboActive" runat="server"   Width="65px">
                     <asp:ListItem Text="Active" Value="Y"></asp:ListItem>
                                <asp:ListItem Text="Inactive" Value="N"></asp:ListItem>
                    </asp:DropDownList>
                  <%--  <asp:HiddenField ID="HiddenField1" runat="server" />--%>
                    
                </td>
                
                
                
                
            </tr>
       
              
              
           
                      
            
            <tr style="background-color: white">
                <td colspan="4" align="right">
                    <asp:Label ID="lblErrMsg" runat="server" Text="" CssClass="blackfnt" Font-Bold="true" ForeColor="red" Visible="false"></asp:Label>  
                    <asp:Button ID="cmdSubmit" runat="server" Text="Submit >>" OnClick="cmdSubmit_Click"  />&nbsp;&nbsp;
                </td>
            </tr>
        </table>
    </p>
 </asp:Content>
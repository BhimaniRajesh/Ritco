<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/GUI/MasterPage.master"  CodeFile="MFGDet.aspx.cs" Inherits="admin_MFGDet" %>

<%-- <%@ Register TagPrefix="DateCalendar" TagName="Header" Src="~/DateCalendar.ascx" %>--%>
<asp:Content  ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
  
      <asp:HiddenField ID="moreprod" runat="server" />
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="true" runat="server">Manufacture Master</asp:Label>
                <hr align="center" size="1" color="#8ba0e5">
            </td>
        </tr>
    </table>
    
    <br />
    <p align="left">
        <table cellspacing="1" cellpadding="3" style="width: 30%" class="boxbg" border="0">
            <tr class="bgbluegrey">
                <td colspan="4" align="center">
                    <asp:Label ID="lblHeader" runat="server" CssClass="blackfnt" Font-Bold="true" Text="Manufacture Details"></asp:Label></td>
            </tr>
            <tr style="background-color: white">
                <td align="left" colspan="1">
                    <asp:Label ID="lblTireID" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Manufacturer ID:"></asp:Label>
                </td>
                <td align="left" colspan="1" >
                    <asp:Label ID="lblDriverIDVal" runat="server" CssClass="bluefnt" Text="Sys. Generated"></asp:Label>
                    <asp:HiddenField ID="hPrevDriverCode" runat="server" />
                </td>
               
                
                
                
                </tr>
                
                 <tr style="background-color: white">
               
                <td align="left" colspan="1">
                    <asp:Label ID="lblManufactur" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Manufacturer Name:"></asp:Label>
                    <asp:RequiredFieldValidator ID="RFVProductType" runat="server" ControlToValidate="txtManufacturer"
                        ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
                <td align="left" colspan="1" >
                <asp:TextBox ID="txtManufacturer" runat="server" CssClass="input" MaxLength="100"></asp:TextBox>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
               
                
                
            </tr>
           
           
               <tr style="background-color: white">
               
                <td align="left" colspan="1">
                    <asp:Label ID="lblAddr" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Manufacturer Address:"></asp:Label>&nbsp;
                  <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtLocation"
                        ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                </td>
                <td align="left" colspan="1" >
                <asp:TextBox ID="txtMFGAddr" runat="server"  CssClass="input" TextMode="MultiLine" Width="124px"  ></asp:TextBox>
                    <%--<asp:ListBox ID="cboProductType" runat="server" DataSourceID="SqlDataSource2" DataTextField="ProdName"
                        DataValueField="ProdId" SelectionMode="Multiple"  OnSelectedIndexChanged="cboProductType_SelectedIndexChanged">
                    </asp:ListBox>--%>
                     
                    
                </td>
                
                
                     
                
                
            </tr>


    <tr style="background-color: white">
               
                <td align="left" colspan="1">
                    <asp:Label ID="lblTelNo" runat="server" CssClass="blackfnt" Font-Bold="True" Text="Manufacturer TelNo:"></asp:Label>
              
                </td>
                <td align="left"  colspan="1" >
                <asp:TextBox ID="txtMFGTelNo" runat="server" CssClass="input" Width="123px"></asp:TextBox>
                 
                     
                    
                </td>
                
                 
            </tr>





            <%-- <tr style="background-color: white">
               
                <td align="left" colspan="1" style="height: 28px" >
                    <asp:Label ID="lblMFGEntry" runat="server" CssClass="blackfnt" Font-Bold="true" Text="MFG.Entry By:"></asp:Label>
                  
                </td>
                <td align="left" colspan="1" style="height: 28px">

                <asp:TextBox ID="txtMFGEntry" runat="server" CssClass="input" ></asp:TextBox>
                  </td>
                
            </tr>--%>
            
              <tr style="background-color: white">
               
                <td align="left" colspan="1" >
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
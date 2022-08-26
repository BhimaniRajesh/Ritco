<%@ Page Language="C#"  AutoEventWireup="true" CodeFile="commonPopUp.aspx.cs" Inherits="GUI_admin_commonPopUp" Title="Untitled Page" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>WebXpress</title>
    <link id="Link1" href="~/GUI/images/style.css" rel="Stylesheet" type="text/css" runat="server" />
</head>
<body >
    <form id="form1" runat="server">
<asp:ScriptManager ID="ScriptManager" runat="server" EnablePartialRendering="true">
        </asp:ScriptManager>
<table border=0 width=99% cellspacing=1 cellpadding=0>
<tr><td>
<font class=blackfnt><b><u>Note:</u></b> 
<!--<br>- Please enter Customer Name start with 'S' as 'S'-->
<br>- For All <asp:Label ID="lblpoptype1" runat="server" Text=""></asp:Label> list,keep blank both the input box.
</font>
</td></tr>
</table>
<table border=1 width=85% cellspacing=1 cellpadding=2>
  <tr class="bgbluegrey">
     <td colspan=2 align=center><font class=blackfnt>Search by parameter</font></td>
  </tr>
  <tr>
   <td><font class=blackfnt><asp:Label ID="lblCode" runat="server" Text=""></asp:Label></font></td>
   <td><font class=blackfnt><asp:TextBox ID="txtCode" runat="server" BorderStyle="Groove" CssClass="input"
                    MaxLength="25"  Width="111px"></asp:TextBox></font></td>
  </tr>
  <tr>
   <td><font class=blackfnt>
       <asp:Label ID="lblName" runat="server" Text="Label">
           </asp:Label> </font></td>
   <td><font class=blackfnt><asp:TextBox ID="txtName" runat="server" BorderStyle="Groove" CssClass="input"
                    MaxLength="25"  Width="111px"></asp:TextBox></font></td>
  </tr>
<tr bgcolor="white">
            <td align="center" colspan="2">
                <asp:UpdatePanel ID="UPAddRow" runat="server"   UpdateMode="Conditional" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:LinkButton ID="cmdSubmit" runat="server" Text="Submit" CssClass="blackfnt" Font-Bold="true"
                            CausesValidation="false" OnClick="submitData">
                        </asp:LinkButton>&nbsp;
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
</table>
<table border=0 width=99% cellspacing=1 cellpadding=0>
<tr><td>
<font class=blackfnt><b><u>Note:</u></b> 
<br>- Click on radio buton to select <asp:Label ID="lblpoptype2" runat="server" Text=""></asp:Label>.
</font>
</td></tr>
</table>
<table cellspacing="1" style="width: 85%" align="left" >
<tr style="background-color: white">
            <td align="center" width="100%" >
                <asp:UpdatePanel ID="UpdatePanel1"  UpdateMode="Conditional" RenderMode="Inline" runat="server" >
                    <ContentTemplate>
                        <asp:GridView EnableViewState="true" ID="dgGeneral" runat="server" BorderWidth="1"
                            HeaderStyle-CssClass="dgHeaderStyle" AllowSorting="true" AutoGenerateColumns="false"
                            CssClass="dgRowStyle" EmptyDataText="No Records Found..." BorderColor="#8ba0e5"
                            CellSpacing="2" CellPadding="2"  Width="100%" DataKeyNames="Code" OnRowDataBound="dgGeneral_RowDataBound" >
                            <Columns>
                                <asp:TemplateField HeaderText="" ItemStyle-HorizontalAlign="center" ItemStyle-Wrap="false">
                                    <ItemTemplate>
                                       
                                        <asp:LinkButton ID="selectCode" runat="server" Text="Select"  ></asp:LinkButton> 
                                       
                                     </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:BoundField HeaderText="Code" DataField="code" HeaderStyle-HorizontalAlign="center">
                                     </asp:BoundField>
                                <asp:BoundField HeaderText="Name" DataField="Name" HeaderStyle-HorizontalAlign="center">
                                       </asp:BoundField>      
                                                                </Columns>
                            <RowStyle BorderColor="Black" BorderStyle="None" BorderWidth="1px" />
                            <HeaderStyle CssClass="dgHeaderStyle" />
                        </asp:GridView>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="cmdSubmit" EventName="Click" />
                    </Triggers>
                </asp:UpdatePanel>
                </td> 
                </tr> 
                </table>  
                </form> 
                </body> 
                </html> 



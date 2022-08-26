<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="OpBal_list.aspx.cs" Inherits="GUI_admin_setting_emp_opn_bal_OpBal_list" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript" type="text/javascript">
    function chk(obj,val)
    {
            if (parseFloat(obj.value) > 0 && parseFloat(val.value) > 0)
            {
                alert("Either 'Opening Credit' or 'Opening Debit' value should be Zero");
                document.getElementById(obj.name).value = "0.00"
                return false;
            }
    }
</script>

<div align="left">
    <br />
    <b><asp:Label ID="Label1" runat="server" CssClass="blackfnt" style="font-weight: bold; text-decoration: underline"></asp:Label></b>
    <br /><br />
    <table border="0" cellpadding="1" cellspacing="1" class="boxbg">
    <tr class="bgbluegrey">
        <td width="42"></td>
        <td width="203">
            <font class="blackfnt"><b>Account Code</b></font></td>
        <td width="170"><font class="blackfnt"><b>ASS0001:STAFF ADVANCE</b></font></td>
        <td width="146"><font class="blackfnt"><b>CA00016:STAFF LOAN</b></font></td>
        <td width="190"><font class="blackfnt"><b>EXP0005:STAFF IMPREST A/C</b></font></td>
    </tr>
    </table>
    
    <table border="0" cellpadding="1" cellspacing="1">
        <tr bgcolor="white">
            <td align="center">
                <asp:DataGrid ID="myGrid" runat="server" AutoGenerateColumns="False" HeaderStyle-CssClass="bgbluegrey" ItemStyle-CssClass="balckfnt" OnItemDataBound="myGrid_ItemDataBound" CssClass="blackfnt">
                    <Columns>
                       <asp:TemplateColumn HeaderText="Select">
                            <ItemTemplate>
                                <asp:CheckBox ID="chk" runat="server" Checked="false" />
                            </ItemTemplate>
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" Width="42px" />
                        </asp:TemplateColumn>
                       <asp:TemplateColumn HeaderText="Employee">
                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Left" />
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" Width="203px" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txtAccountCode" runat="server" BorderStyle="none" BorderColor="white" Width="200"></asp:TextBox>
                                </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Debit">
                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Left" />
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" Width="83px" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txt_Staff_Advance_Dr" runat="server" BorderStyle="Groove" Width="65" ></asp:TextBox>
                                </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Credit">
                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Left" Wrap="False" />
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" Width="83px" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txt_Staff_Advance_Cr" runat="server" BorderStyle="Groove" Width="65" ></asp:TextBox>
                                </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Debit">
                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" Wrap="False" />
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" Width="71px" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txt_Staff_Loan_Dr" runat="server" BorderStyle="Groove" Width="65"></asp:TextBox>
                                </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Credit">
                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Left" />
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" Width="71px" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txt_Staff_Loan_Cr" runat="server" BorderStyle="Groove" Width="65"></asp:TextBox>
                                </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Debit">
                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Left" />
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" Width="93px" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txt_Staff_Imprest_Dr" runat="server" BorderStyle="Groove" Width="65"></asp:TextBox>
                                </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="Credit">
                            <ItemStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Left" />
                            <HeaderStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False"
                                Font-Underline="False" HorizontalAlign="Center" Wrap="False" Width="93px" />
                                <ItemTemplate>
                                    <asp:TextBox ID="txt_Staff_Imprest_Cr" runat="server" BorderStyle="Groove" Width="65"></asp:TextBox>
                                </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                    <ItemStyle CssClass="balckfnt" />
                    <HeaderStyle CssClass="bgbluegrey" Font-Bold="False" Font-Italic="False" Font-Overline="False"
                        Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" />
                    
                </asp:DataGrid>
                <br />
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_onClick" /></td>
        </tr>
    </table>
    
    
</div>
    
</asp:Content>

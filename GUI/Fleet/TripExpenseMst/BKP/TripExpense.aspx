<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="TripExpense.aspx.cs" Inherits="GUI_Admin_TripExpense" Title="Average Diesel Rate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script type="text/javascript" language="javascript" src="AJAX_Validator/TripExpense.js"></script>

<%--<asp:UpdateProgress ID="uppMain" runat="server">
    <ProgressTemplate>
        <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px;
            -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
            <tr>
                <td align="right">
                    <img src="../../images/loading.gif" alt="" />
                </td>
                <td>
                    <font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font>
                </td>
            </tr>
        </table>
        <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px;
            background-color: #FFFFFF; width: 100%; height: 100%; filter: Alpha(Opacity=50);
            opacity: .50; -moz-opacity: .50;" runat="server">
            <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                left: 50%;" ID="Panel2" runat="server">
            </asp:Panel>
        </asp:Panel>
    </ProgressTemplate>
</asp:UpdateProgress>--%>

<div align="left">
    
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <br />
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="True" runat="server">Trip Expense Master</asp:Label>
                <hr />
                <br />    
            </td>
        </tr>
    </table>
    
    <asp:UpdatePanel ID="u1" runat ="server" UpdateMode="Always" RenderMode="Inline" >
        <ContentTemplate >
            <table id="tb_add" border="0" class="boxbg" cellpadding="1" cellspacing="1" border="1" width="550">
                <tr runat="server" bgcolor="white" visible="true" >
                    <td align="left" class="blackfnt" colspan="2" style="font-weight: bold; font-size: 8pt;
                        width: 20%; color: white; font-family: Verdana; height: 17px; background-color: #006699">
                        <asp:LinkButton ID="lnk_btn_Add" runat="server" CausesValidation="False" ForeColor="White"
                                        OnClick="lnk_btn_Add_Click" Text="Add New" Visible="true"  ></asp:LinkButton></td>
                    <td align="left" class="blackfnt" colspan="2" style="font-weight: bold; font-size: 8pt;
                        width: 30%; color: white; font-family: Verdana; height: 17px; background-color: #006699">
                        Trip Expense</td>
                    <td class="blackfnt" colspan="2" style="font-weight: bold; font-size: 8pt; width: 25%;
                        color: white; font-family: Verdana; height: 17px; background-color: #006699">
                        Polarity</td>
                    <td class="blackfnt" colspan="2" style="font-weight: bold; font-size: 8pt; width: 25%;
                        color: white; font-family: Verdana; height: 17px; background-color: #006699">
                        Active Flag</td>
                </tr>
                
                <tr id="RowNo" runat="server" bgcolor="white" visible="false" >
                                    <td align="left" class="blackfnt" colspan="2" style="width: 20%">
                        <asp:LinkButton ID="btn_Submit" runat="server"  OnClientClick="javascript:return CheckValidataion()"  OnClick="btn_Submit_Click" >Save</asp:LinkButton>
                        ||
                        <asp:LinkButton ID="btn_Cancel" runat="server" OnClick="btn_Cencel_Click" >Cancel</asp:LinkButton>
                    </td>

                    <td align="left" class="blackfnt" colspan="2" style="width: 30%">
                        <asp:TextBox ID="tb_Trip_Exp" runat="server"  onblur="CheckValidExp(this)" BorderStyle="Groove" />
                        <asp:Label ID="lbl_Trip_Exp_Err" runat="server" Text="" style="font-size: 8pt; color: red; font-family: Verdana"></asp:Label>
                        <asp:HiddenField ID="hfId" runat="server" />
                    </td>
                    <td class="blackfnt" colspan="2" style="width: 25%">
                        <asp:TextBox ID="tb_Polarity" Width="50px" MaxLength="1"   runat="server" onblur="PlusMinus(this,event)" BorderStyle="Groove" ></asp:TextBox>
                        <asp:Label ID="lbl_Polarity_Err" runat="server" Text="" style="font-size: 8pt; color: red; font-family: Verdana"></asp:Label>
                    </td>
                    <td class="blackfnt" colspan="2" style="width: 25%">
                        <asp:CheckBox ID="chk_Active_Flag" runat="server" /></td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel1" runat ="server" UpdateMode="Always" RenderMode="Inline" >
        <ContentTemplate >
            <table id="Table1" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="550">
             <tr id="Tr1" runat="server" bgcolor="white">
                <td class="blackfnt" colspan="2" style="width: 38%">
                    <asp:GridView ID="gv_Trip_Expense" runat="server" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Width="100%" AutoGenerateColumns="False" OnSelectedIndexChanged="gv_Trip_Expense_SelectedIndexChanged" AllowPaging="True" OnPageIndexChanged="gv_Trip_Expense_PageIndexChanged" OnPageIndexChanging="gv_Trip_Expense_PageIndexChanging" PageSize="15" ShowHeader="False">
                        <RowStyle ForeColor="#000066" />
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                        Text="Edit"></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Width="20%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Trip Expense">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_TripExpHdr" runat="server" Text='<%# Bind("Trip_Exp_Header") %>'></asp:Label>
                                    <asp:HiddenField ID="hfId" runat="server" Value='<%# Bind("ID") %>' /> 
                                </ItemTemplate>
                                <ItemStyle Width="30%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Polarity">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_Polarity" runat="server" Text='<%# Bind("Polarity") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="26%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Active Flag">
                                <ItemTemplate>
                                    <asp:Label ID="lbl_Active_Flag" runat="server" Text='<%# Bind("Active_Flag") %>'></asp:Label>
                                </ItemTemplate>
                                <ItemStyle Width="25%" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            </table>
            
              <left>
        <font class="blackfnt" style="color:Red;">
            <b><asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text=""></asp:Label></b>
        </font>
    </left>
            
            
        </ContentTemplate>
    </asp:UpdatePanel>
    
    
      
            
                
</div>
</asp:Content>


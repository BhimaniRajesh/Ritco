<%@ Page EnableEventValidation="false" Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="TripRouteExpMst.aspx.cs" Inherits="TripRouteExpMst" %>

<%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >

<script type="text/javascript" language="javascript" src="../../../GUI/Js/querystring.js"></script>
<script type="text/javascript" language="javascript" src="../../../GUI/Fleet/TripRouteExpense-Fuel/AJAX_Validator/TripRouteExp.js"></script>
    
<asp:UpdateProgress ID="uppMain" runat="server">
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
</asp:UpdateProgress>

<div align="left">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="True" runat="server">Trip Route Expense Master</asp:Label>
                
            </td>
        </tr>
    </table>

<asp:UpdatePanel ID="u1" runat ="server" UpdateMode="Always" RenderMode="Inline" >
                    <ContentTemplate >
    <table id="Table3" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="50%">
       
        <tr id="RowNo" runat="server" bgcolor="white">
            <td class="blackfnt" colspan="2"><strong>Enter Row No *</strong></td>
            <td align="left" class="blackfnt" colspan="2">
                
                <asp:TextBox ID="tb_Row_No" runat="server" Text="0" MaxLength="2" AutoPostBack="true"  BorderStyle="Groove" OnTextChanged="tb_Row_No_TextChanged"  ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfv_tb_Row_No" runat="server" ControlToValidate="tb_Row_No"  ErrorMessage="Required Field!"></asp:RequiredFieldValidator>
                 
            </td>
        </tr>
         <tr bgcolor="white">
            <td class="blackfnt" colspan="2">
                Select Route :</td>
            <td align="left" class="blackfnt" colspan="2">
                <asp:DropDownList ID="ddlRoute" runat="server" Width="343px" AutoPostBack="True" OnSelectedIndexChanged="ddlRoute_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:label id="lbl_Route_Err" runat="server" style="font-size: 8pt; color: red; font-family: Verdana;
                    text-align: left" text=""></asp:label>

                <asp:HiddenField ID="hfRS" runat="server" />
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" colspan="2">
                Average Diesel Rate :</td>
            <td align="left" class="blackfnt" colspan="2" >
                <asp:TextBox ID="tb_Avg_Diesel_Rate" runat="server" BorderStyle="Groove" onkeydown="return numeric(event)"
                    Text="0.00" Width="76px" style="text-align: right"></asp:TextBox>
                <asp:Label ID="lbl_Avg_Diesel_Rate_Err" runat="server" Style="font-size: 8pt; color: red;font-family: Verdana" Text=""></asp:Label>
                <asp:HiddenField ID="hfId" runat="server" />
            </td>
        </tr>
        
    </table>
       </ContentTemplate>
                </asp:UpdatePanel>
    
    <br />
    <table id="Table4" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="650">

        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" >
                <asp:UpdatePanel ID="u2" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                       
                        <asp:GridView ID="gvTripRouteExp" BorderWidth="0px" CellSpacing="1"
                                runat="server" AutoGenerateColumns="False" Width="100%" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey"
                                OnRowDataBound="gvTripRouteExp_RowDataBound"
                                PagerSettings-Mode="NumericFirstLast" SelectedIndex="1" >
                                
                                <Columns>
                                <asp:TemplateField HeaderText="SR.NO." >
                                      <HeaderStyle CssClass="blackfnt" />
                                    <ItemTemplate >
                                        <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server" ></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Center" VerticalAlign="Middle" CssClass="bgwhite"  />
                                </asp:TemplateField>
    
                                <asp:TemplateField HeaderText="Vehicle Type" >
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                           
                                         <asp:DropDownList ID="ddl_Vehicle_type" runat="server" Width="147px" >
                                        </asp:DropDownList>
                                        <asp:label id="lbl_FTLtype_Err" runat="server" style="font-size: 8pt; color: red; font-family: Verdana;
                    text-align: left" text=""></asp:label>
                                    </ItemTemplate>
                                    <ItemStyle Width="40%" HorizontalAlign="Left" VerticalAlign="Top" CssClass="bgwhite" />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="KMPL" >
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="tb_KMPL" onkeydown="return numeric(event)"  runat="server" BorderStyle="groove"   MaxLength="6" style="text-align: right"></asp:TextBox>
                                            <asp:label id="lbl_KMPL_Err" runat="server" style="font-size: 8pt; color: red; font-family: Verdana;
                    text-align: left" text=""></asp:label>
                                    </ItemTemplate>
                                    <ItemStyle Width="35%" HorizontalAlign="Right" VerticalAlign="Top" CssClass="bgwhite" />
                                    </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Active Flag" >
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  />
                                    <ItemTemplate>
                                       <asp:CheckBox ID="chk_Flag" runat="server" Checked="True" />
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Center"  VerticalAlign="Top" CssClass="bgwhite" />
                                </asp:TemplateField>
                            </Columns>
                            <PagerSettings Mode="NumericFirstLast"  />
                            <HeaderStyle CssClass="bgbluegrey" />
                        </asp:GridView>
                     </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" style="vertical-align: middle; text-align: center; height: 25px;">
                <asp:Button ID="btn_Submit" runat="server" Text="Submit" OnClientClick="javascript:return CheckValidataion()"  OnClick="btn_Submit_Click" /></td>
        </tr>
    </table>

    <br />
    
    <center>
        <font class="blackfnt" style="color:Red;">
            <b><asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text=""></asp:Label></b>
        </font>
    </center>
</div>
</asp:Content>
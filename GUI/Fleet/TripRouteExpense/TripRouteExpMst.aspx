<%@ Page EnableEventValidation="false" Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="TripRouteExpMst.aspx.cs" Inherits="TripRouteExpMst" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
    
<script type="text/javascript" language="javascript" src="../../../GUI/Js/Date.js"></script>
<script type="text/javascript" language="javascript" src="../../../GUI/Js/querystring.js"></script>
<script type="text/javascript" language="javascript" src="../../../GUI/Fleet/TripRouteExpense/AJAX_Validator/TripRouteExp.js"></script>

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

<%--<asp:Panel ID="Panel1" runat="server" Height="" Width="">--%>
<asp:UpdatePanel ID="u1" runat ="server" UpdateMode="Always" RenderMode="Inline" >
                    <ContentTemplate >
    <table id="Table3" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="50%">
       
        <tr id="RowNo" runat="server" bgcolor="white">
            <td class="blackfnt" colspan="2"><strong>Enter Row No *</strong></td>
            <td align="left" class="blackfnt" colspan="2">
                
                        <asp:TextBox ID="tb_Row_No" runat="server" Text="0" MaxLength="2" AutoPostBack="true"  BorderStyle="Groove" OnTextChanged="tb_Row_No_TextChanged" Width="60px"  ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_tb_Row_No" runat="server" ControlToValidate="tb_Row_No"  ErrorMessage="Required Field!"></asp:RequiredFieldValidator>
                 
            </td>
        </tr>
         <tr bgcolor="white">
            <td class="blackfnt" colspan="2">
                Select Route :</td>
            <td align="left" class="blackfnt" colspan="2">
                <asp:DropDownList ID="ddlRoute" runat="server" Width="343px">
                </asp:DropDownList>
                <asp:HiddenField ID="hfRS" runat="server" />
            </td>
        </tr>
    </table>
       </ContentTemplate>
                </asp:UpdatePanel>
    
    <%--</asp:Panel>--%>
    
    <table id="Table4" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="900">

        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" >
                <asp:UpdatePanel ID="u2" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                       <br />
                        <asp:GridView ID="gvTripRouteExp" BorderWidth="0" CellSpacing="1"
                                runat="server" AutoGenerateColumns="false" Width="100%" CssClass="boxbg" HeaderStyle-CssClass="bgbluegrey"
                                OnRowDataBound="gvTripRouteExp_RowDataBound"
                                PagerSettings-Mode="NumericFirstLast" PageSize="10" SelectedIndex="1" >
                            <PagerSettings Mode="NextPreviousFirstLast"  Position="Bottom"  />  
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
                                        
                                    </ItemTemplate>
                                    <ItemStyle Width="20%" HorizontalAlign="Left" VerticalAlign="Top" CssClass="bgwhite" />
                                </asp:TemplateField>
                                
                               <asp:TemplateField HeaderText ="Cost Head" >
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlFueExp" runat="server" Width="147px" >
                                        </asp:DropDownList>
                                        
                                    </ItemTemplate>
                                    <ItemStyle Width="20%" HorizontalAlign="Left" VerticalAlign="Top" CssClass="bgwhite" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Rate Type" Visible="False" >
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                       <asp:DropDownList ID="ddlRateType" runat="server" Width="147px" >
                                        </asp:DropDownList>
                                        
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="20%" VerticalAlign="Top" CssClass="bgwhite" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Standard Rate" >
                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtStandardRate" onkeydown="return numeric(event)"  runat="server" MaxLength="6" style="text-align: right" Width="106px"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="20%" HorizontalAlign="Left" VerticalAlign="Top" CssClass="bgwhite" />
                                    </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Active Flag" >
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  />
                                    <ItemTemplate>
                                       <asp:CheckBox ID="chk_Flag" runat="server" Checked="True" />
                                      
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Center"  VerticalAlign="Top" CssClass="bgwhite" />
                                </asp:TemplateField>
                            </Columns>
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
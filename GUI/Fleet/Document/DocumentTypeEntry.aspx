<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="DocumentTypeEntry.aspx.cs" Inherits="DocumentTypeEntry" %>


   <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
       <script type="text/javascript" language="javascript" src="AJAX_Validator/js_Document.js"></script>
<script type="text/javascript" language="JavaScript" src="../../Js/querystring.js"></script>
 <asp:UpdateProgress ID="uppMain" runat="server">
    <ProgressTemplate>
	    <iframe frameborder="0" src="about:blank" style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
	    <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
	    <img src="../../Images/indicator.gif" /><font class="blackfnt"><b>Please Wait...</b></font></div>
    </ProgressTemplate>
</asp:UpdateProgress>

<div align="left">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="True" runat="server">Document Type Entry</asp:Label>
                
            </td>
        </tr>
    </table>
<br>

    <table id="Table3" runat="server" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="30%">
        <tr bgcolor="white">
            <td class="blackfnt" colspan="2"><strong>Enter Row No *</strong></td>
            <td align="left" class="blackfnt" colspan="2">
                <asp:UpdatePanel ID="u1" runat ="server" UpdateMode="Always" RenderMode="Inline" >
                    <ContentTemplate >
                        <asp:TextBox ID="tb_Row_No" runat="server" Text="0" MaxLength="2" AutoPostBack="true"  BorderStyle="Groove" OnTextChanged="tb_Row_No_TextChanged"  ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_tb_Row_No" runat="server" ControlToValidate="tb_Row_No"  ErrorMessage="Required Field!"></asp:RequiredFieldValidator>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    <br>
    <br>
    <table id="Table4" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="60%">

        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" >
                <asp:UpdatePanel ID="u2" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                
                        <asp:GridView ID="gvDocuType" runat="server" CellPadding="3" CellSpacing="1" AutoGenerateColumns="False" SelectedIndex="1" OnRowDataBound="gvDocuType_RowDataBound" Width="100%">
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="whitefnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server" ></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Document Type">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtDocType"  CssClass="input" Width="130px" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="20%" />
                                </asp:TemplateField>
    
                                <asp:TemplateField HeaderText="Document Type Descrition">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                         <asp:TextBox ID="txtTypeDesc"  CssClass="input" Width="200px" runat="server"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="30%" />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Applicable&lt;br&gt;State Wise">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkApplicableStatus" runat="server" />
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="5%" />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Renewal Authority">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddlRenewqlAutu" runat="server" Width="156px">
                                        </asp:DropDownList>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" />
                                </asp:TemplateField>
                                
                                 
                                 <asp:TemplateField HeaderText="Cost&lt;br&gt;Captured">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                 <asp:CheckBox ID="chkCostCap" runat="server" />
                                    </ItemTemplate>
                                     <ItemStyle  Width="5%" HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                     </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>

    <br />

    <table id="Table5" border="0"  class="boxbg" cellpadding="1" cellspacing="1" width="60%">
        <tr bgcolor="#eeeeee">
            <td class="blackfnt" colspan="1" style="vertical-align: middle; height: 26px; text-align: center">
                   <asp:Button ID="btn_Submit" runat="server" Text="Submit" OnClientClick="javascript:return ValidationDocEntry()"  OnClick="btn_Submit_Click" />    
                           </td>
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
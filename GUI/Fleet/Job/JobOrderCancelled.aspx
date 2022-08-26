<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="JobOrderCancelled.aspx.cs" Inherits="GUI_Fleet_Operations_Issue_JobOrderCancelled" Title="Untitled Page" %>
<%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">

<script src="../../images/DateControl.js" language="javascript"  type="text/javascript"></script>
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>
<script language="javascript" type="text/javascript" src="AJAX_Validator/CancleJobOrder.js"> </script>

<script language="javascript" type="text/javascript">
var cal = new CalendarPopup("Div1"); 
cal.setCssPrefix("TEST");
cal.showNavigationDropdowns();


var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");

var FinYear="<%=Session["FinYear"]%>"
var FinYear_to=parseInt(FinYear)+1
	
if(FinYear_to<10)
{
    FinYear_to="0"+FinYear_to
}
var FinYear_fromdate="01/04/"+FinYear
var FinYear_todate="31/03/"+FinYear_to
var Sle_finyear=FinYear+"-"+FinYear_to

</script>

<asp:UpdateProgress ID="uppMain" runat="server">
    <ProgressTemplate>
	    <iframe frameborder="0" src="about:blank" style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
	    <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
	    <img src="../../Images/indicator.gif" /><font class="blackfnt"><b>Please Wait...</b></font></div>
    </ProgressTemplate>
</asp:UpdateProgress>

<div id="Div1" style="position: absolute; visibility: hidden; background-color: white;layer-background-color: white; z-index: 99;">
    </div>
<div >
    <table cellspacing="1" style="width: 200px">
        <tr style="background-color: white">
            <td align="left" style="height: 18px; width: 355px;">
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="True" runat="server">Job Order Cancelled Module</asp:Label>
                
            </td>
        </tr>
    </table>
    <br />
    
    <table id="Table3" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="25%">
        <tr  bgcolor="white">   
            <td width="40%" class="blackfnt"  colspan="2"><strong>Enter Row No *</strong></td>
            <td width="60%" align="left" class="blackfnt" colspan="2">
                <asp:UpdatePanel ID="u1" runat ="server" UpdateMode="Always" RenderMode="Inline" >
                    <ContentTemplate >
                        <asp:TextBox ID="tb_Row_No" runat="server" Text="0" MaxLength="2" AutoPostBack="true"  BorderStyle="Groove" OnTextChanged="tb_Row_No_TextChanged"  ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfv_tb_Row_No" runat="server" ControlToValidate="tb_Row_No"  ErrorMessage="Required Field!"></asp:RequiredFieldValidator>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    
    <table id="Table4" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="80%">

        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" >
                <asp:UpdatePanel ID="u2" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                     
                        
                         <asp:GridView ID="gvJobOrderCancel" runat="server" OnRowDataBound="gvJobOrderCancel_RowDataBound"
                            AutoGenerateColumns="False" BorderColor="#8BA0E5" BorderWidth="1px" CellPadding="5"
                            CellSpacing="1" CssClass="dgRowStyle" EmptyDataText="No Records Found..."
                            HeaderStyle-CssClass="dgHeaderStyle" DataKeyNames="JOB_ORDER_NO">
                            
                            <Columns>
                                <asp:TemplateField HeaderText="Sr. No.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt"/>                             
                                    <ItemTemplate>
                                       <%-- <asp:CheckBox ID="CheckBox1" Checked="false" Text="<%#Container.DataItemIndex + 1%>" runat="server"/>--%>
                                        <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server" ></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Job Order No">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtJob_Order_No"  CssClass="input" Width="110px" runat="server"></asp:TextBox>         
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="20%" />
                                </asp:TemplateField>
    
                                <asp:TemplateField HeaderText="Job Order Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                         <asp:TextBox ID="txtJob_Order_Date"  CssClass="input" Width="80px" runat="server" onfocus="this.blur()" ></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                </asp:TemplateField>
                                               
                                <asp:TemplateField HeaderText="Vehicle No">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                    <asp:TextBox runat="server" CssClass="input" Width="70px" Id="txtVehicle_No" onfocus="this.blur()">
                                    </asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                </asp:TemplateField>
                               
                                 <asp:TemplateField HeaderText="JobSheet Branch">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                    <asp:textbox id="txtJobSheet_Branch" runat="server" Width="60px" CssClass="input" onfocus="this.blur()"></asp:textbox>
                                    </ItemTemplate>
                                     <ItemStyle Width="20%" HorizontalAlign="Left" />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Order Status">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                    <asp:textbox id="txtOrder_Status" runat="server" Width="60px" CssClass="input" onfocus="this.blur()" ></asp:textbox>
                                    </ItemTemplate>
                                     <ItemStyle Width="20%" HorizontalAlign="Left" />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Vendor" Visible="false">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                    <asp:textbox id="txtVendor" runat="server" Width="150px" CssClass="input"  onfocus="this.blur()" TextMode="MultiLine" Height="30px"  ></asp:textbox>
                                    </ItemTemplate>
                                     <ItemStyle Width="20%" HorizontalAlign="Left" />
                                </asp:TemplateField>
                               
                                <asp:TemplateField HeaderText="Cancellation Date">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                    <asp:TextBox id="txtCancellation_Date" runat="server" onblur="javascript:ValidateDate(this)" Width="80px" CssClass="input"></asp:TextBox>
                                        <asp:Image ID="img_cal" ImageUrl="../../images/calendar.jpg"  runat="server" />
                                          <%--<a href="#" onclick="cal.select(ctl00_MyCPH1_gvJobOrderCancel_ctl02_txtCancellation_Date,'anchor22','dd/MM/yyyy'); return false;" id="a1" name="anchor22">
                                          <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>--%>
                                    </ItemTemplate>
                                     <ItemStyle Width="50%" HorizontalAlign="Left" />
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Cancel Reason">
                                    <HeaderStyle HorizontalAlign="Left" Wrap="False" />
                                    <ItemTemplate>
                                    <asp:textbox id="txtCancel_Reason" runat="server" Width="120px" CssClass="input"  ></asp:textbox>
                                    </ItemTemplate>
                                     <ItemStyle Width="20%" HorizontalAlign="Left" />
                                </asp:TemplateField>
                                
                            </Columns>
                        </asp:GridView>
                     </ContentTemplate>
                </asp:UpdatePanel>
                   </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" style="text-align: center; height: 26px;" >
                <asp:Button ID="btn_Submit" runat="server" Text="Submit" OnClientClick="javascript:return CheckSubmit()" OnClick="btn_Submit_Click" />
            </td>
            </tr>
    </table>
    
    <br />

    <br />
    
    
        <font class="blackfnt" style="color:Red;">
            <b><asp:Label ID="lbl_Page_Error" runat="server"  Font-Size="Small" Text=""></asp:Label></b>
        </font>

</asp:Content>


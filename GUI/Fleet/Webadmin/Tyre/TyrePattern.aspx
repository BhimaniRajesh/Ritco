<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="TyrePattern.aspx.cs" Inherits="Tyre_Pattern" %>


<%@ Register
    Assembly="AjaxControlToolkit"
    Namespace="AjaxControlToolkit"
    TagPrefix="ajaxToolkit" %>

   <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
   <script type="text/javascript" language="JavaScript" src="../../../Js/querystring.js"></script>
<script language="javascript">
    function createXMLHttpRequest()
    {
        // Mozilla, Safari,...
	    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	    // IE
	    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
    }
   function checkPatCode(row_Index,tb_tyrepat_code)
   {
        var qs = new Querystring()
        var qTyrePatId = qs.get("TyrePatId")
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        var str_Index = "";
        if (tb_tyrepat_code.value == "")
        {
            tb_tyrepat_code="";
            return;
        }

        for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gv_TyrePat").rows.length; intIndex++)
        {
            if (intIndex < 10)
            {
                str_Index = "0" + intIndex;
            }
            else
            {
                str_Index = intIndex;
            }
            if (row_Index == intIndex - 2)
            {
                continue;
            }
            if (document.getElementById("ctl00_MyCPH1_gv_TyrePat_ctl" + str_Index + "_tb_tyrepat_code").value == tb_tyrepat_code.value)
            {
                alert("This Part already exist at row " + (intIndex - 1));
                tb_tyrepat_code.value = "";
                tb_tyrepat_code.focus();
                return;
            }
        }
        
        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    if (returnValue[0] == "N") 
                    {
                        tb_tyrepat_code.value=tb_tyrepat_code.value;
                    }
                    else
                    {
                        alert("Already Exist !! ");
                        tb_tyrepat_code.focus();
                    }
                }
            }
            xmlHttpRequest.open("GET", "../../../Fleet/Tyre/wfrm_AJAX_Validator.aspx?Function=CheckValidTyrePatCode&datetime="+currentTime+"&TyrePatId="+qTyrePatId+"&TyrePatCode=" + tb_tyrepat_code.value+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }	
   }
   function SelectVehType()
   {
        for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gv_TyrePat").rows.length; intIndex++)
        {
            if (intIndex < 10)
            {
                str_Index = "0" + intIndex;
            }
            else
            {
                str_Index = intIndex;
            }
            if (document.getElementById("ctl00_MyCPH1_gv_TyrePat_ctl" + str_Index + "_tb_tyrepat_code").value == "")
            {
                alert("Enter Tyre Pattern Code!!!");
                document.getElementById("ctl00_MyCPH1_gv_TyrePat_ctl" + str_Index + "_tb_tyrepat_code").focus();
                return false;
            }
            if (document.getElementById("ctl00_MyCPH1_gv_TyrePat_ctl" + str_Index + "_ddl_Pos_Allowed").value == "Select")
            {
                alert("Select Tyre Postion Category!!!");
                document.getElementById("ctl00_MyCPH1_gv_TyrePat_ctl" + str_Index + "_ddl_Pos_Allowed").focus();
                return false;
            }
        }
       
   }
     
</script>
 <asp:UpdateProgress ID="uppMain" runat="server">
    <ProgressTemplate>
	    <iframe frameborder="0" src="about:blank" style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
	    <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
	    <img src="../../../Images/indicator.gif" /><font class="blackfnt"><b>Please Wait...</b></font></div>
    </ProgressTemplate>
</asp:UpdateProgress>

<div align="left">
    <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
            <td align="left">
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="True" runat="server">Tyre Pattern Master</asp:Label>
                
            </td>
        </tr>
    </table>

<asp:Panel ID="Panel1" runat="server" Height="" Width="">
    <table id="Table3" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="50%">
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
    
    </asp:Panel>
    
    <table id="Table4" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="60%">

        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" >
                <asp:UpdatePanel ID="u2" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                       
                        <asp:GridView ID="gv_TyrePat" runat="server" CellPadding="3" CellSpacing="1" AutoGenerateColumns="False" SelectedIndex="1" OnRowDataBound="gv_TyrePat_RowDataBound" Width="100%">
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="whitefnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server" ></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Center" VerticalAlign="Middle"  />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Tyre Pattern Code">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="tb_tyrepat_code"  CssClass="input" Width="130px" runat="server" MaxLength="20"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="20%" VerticalAlign="Top" />
                                </asp:TemplateField>
    
                                <asp:TemplateField HeaderText="Tyre Pattern Description">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                         <asp:TextBox ID="tb_tyrepat_desc"  CssClass="input" Width="312px" runat="server" MaxLength="250"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:TemplateField>
                                
                               <asp:TemplateField HeaderText ="Position Allowed">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Pos_Allowed" runat="server" Width="147px" >
                                        </asp:DropDownList>
                                        
                                    </ItemTemplate>
                                    <ItemStyle Width="20%" HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:TemplateField>
                        
                                 <asp:TemplateField HeaderText="Active Flag">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False"  />
                                    <ItemTemplate>
                                       <asp:CheckBox ID="chk_Flag" runat="server" Checked="True" />
                                      
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Center"  VerticalAlign="Top" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                     </ContentTemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" style="vertical-align: middle; text-align: center">
                <asp:Button ID="btn_Submit" runat="server" Text="Submit" OnClientClick="javascript:return SelectVehType()"  OnClick="btn_Submit_Click" /></td>
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
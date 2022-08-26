<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="TyrePosition.aspx.cs" Inherits="Tyre_Position" %>


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
   function CheckTyrePos(tb_tyrepos_code)
   {
        tb_tyrepos_code.value="";
   }
   function checkPosCode(row_Index,tb_tyrepos_code,ddl_Truck_Trailer)
   {
        var qs = new Querystring()
        var qTyrePosId = qs.get("TyrePosId")
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        var str_Index = "";
        if (tb_tyrepos_code.value == "")
        {
            tb_tyrepos_code.value="";
            return;
        }
        if (ddl_Truck_Trailer.value == "0")
        {
            alert("Select Vehicle Category!!!");
            ddl_Truck_Trailer.focus();
            tb_tyrepos_code.value="";
            return false;
        }
        for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gv_TyrePos").rows.length; intIndex++)
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
            if (document.getElementById("ctl00_MyCPH1_gv_TyrePos_ctl" + str_Index + "_tb_tyrepos_code").value == tb_tyrepos_code.value)
            {
                alert("This Part already exist at row " + (intIndex - 1));
                tb_tyrepos_code.value = "";
                tb_tyrepos_code.focus();
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
                    //alert(returnValue[0]);
                    if (returnValue[0] == "N") 
                    {
                        tb_tyrepos_code.value=tb_tyrepos_code.value;
                    }
                    else
                    {
                        alert("Already Exist !! ");
                        tb_tyrepos_code.value="";
                        tb_tyrepos_code.focus();
                    }
                }
            }
            xmlHttpRequest.open("GET", "../../../Fleet/Tyre/wfrm_AJAX_Validator.aspx?Function=CheckValidTyrePosCode&datetime="+currentTime+"&TyrePosCode=" + tb_tyrepos_code.value+"&TyrePosId="+qTyrePosId+"&VehicleCate="+ddl_Truck_Trailer.value+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }	
   }
   function SelectVehType()
   {
        for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gv_TyrePos").rows.length; intIndex++)
        {
            if (intIndex < 10)
            {
                str_Index = "0" + intIndex;
            }
            else
            {
                str_Index = intIndex;
            }
            if (document.getElementById("ctl00_MyCPH1_gv_TyrePos_ctl" + str_Index + "_ddl_Truck_Trailer").value == "0")
            {
                alert("Select Vehicle Category!!!");
                document.getElementById("ctl00_MyCPH1_gv_TyrePos_ctl" + str_Index + "_ddl_Truck_Trailer").focus();
                return false;
            }
            if (document.getElementById("ctl00_MyCPH1_gv_TyrePos_ctl" + str_Index + "_ddl_Pos_Allowed").value == "0")
            {
                alert("Select Tyre Position!!!");
                document.getElementById("ctl00_MyCPH1_gv_TyrePos_ctl" + str_Index + "_ddl_Pos_Allowed").focus();
                return false;
            }
            if (document.getElementById("ctl00_MyCPH1_gv_TyrePos_ctl" + str_Index + "_tb_tyrepos_code").value == "")
            {
                alert("Enter Tyre Position Code!!!");
                document.getElementById("ctl00_MyCPH1_gv_TyrePos_ctl" + str_Index + "_tb_tyrepos_code").focus();
                return false;
            }
            //if (document.getElementById("ctl00_MyCPH1_gv_TyrePos_ctl" + str_Index + "_ddl_Vehicel_type").value == "0")
            //{
            //    alert("Select Vehicel Type!!!");
            //    document.getElementById("ctl00_MyCPH1_gv_TyrePos_ctl" + str_Index + "_ddl_Vehicel_type").focus();
            //    return false;
            //}
            //alert(document.getElementById("ctl00_MyCPH1_gv_TyrePos_ctl" + str_Index + "_ddl_Pos_Allowed").value)
          
          
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
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="True" runat="server">Tyre Position</asp:Label>
                
            </td>
        </tr>
    </table>

<asp:Panel ID="Panel1" runat="server" Height="" Width="">
    <table id="Table3" border="0" class="boxbg" cellpadding="1" cellspacing="1" width="350px">
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
                       
                        <asp:GridView ID="gv_TyrePos" runat="server" CellPadding="3" CellSpacing="1" AutoGenerateColumns="False" SelectedIndex="1" OnRowDataBound="gv_TyrePos_RowDataBound" Width="100%">
                            <Columns>
                                <asp:TemplateField HeaderText="SR.NO.">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="whitefnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server" ></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Center" VerticalAlign="Middle"  />
                                </asp:TemplateField>
                                
                                 <asp:TemplateField HeaderText ="Vehicle Category">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Truck_Trailer" runat="server" Width="147px" DataTextField="Type_Name" DataValueField="VEHICLE_TYPE">
                                        </asp:DropDownList>
                                        
                                    </ItemTemplate>
                                    <ItemStyle Width="20%" HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText ="Position Category">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:DropDownList ID="ddl_Pos_Allowed" runat="server" Width="147px" DataTextField="Type_Name" DataValueField="VEHICLE_TYPE">
                                        </asp:DropDownList>
                                        
                                    </ItemTemplate>
                                    <ItemStyle Width="20%" HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Position Short Code">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                        <asp:TextBox ID="tb_tyrepos_code"  CssClass="input" Width="130px" runat="server"></asp:TextBox>
                                        <asp:HiddenField ID="hf_tyrepos_id"  runat="server"></asp:HiddenField>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Left" Width="20%" VerticalAlign="Top" />
                                </asp:TemplateField>
    
                                <asp:TemplateField HeaderText="Tyre Position Description">
                                    <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                    <ItemTemplate>
                                         <asp:TextBox ID="tb_tyrepos_desc"  CssClass="input" Width="312px" runat="server" MaxLength="250"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="30%" HorizontalAlign="Left" VerticalAlign="Top" />
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
                &nbsp;
              
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" style="vertical-align: middle; text-align: center">
                <asp:Button ID="btn_Submit" runat="server" Text="Submit" OnClientClick="javascript:return SelectVehType()"  OnClick="btn_Submit_Click" /></td>
        </tr>
    </table>
    
    <center>
        <font class="blackfnt" style="color:Red;">
            <b><asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text=""></asp:Label></b>
        </font>
    </center>
</div>
</asp:Content>
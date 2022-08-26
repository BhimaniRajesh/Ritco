<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/GUI/MasterPage.master"  CodeFile="WorkGroup.aspx.cs" Inherits="WorkGroup" %>


   <asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server" >
   <script type="text/javascript" language="JavaScript" src="../../../Js/querystring.js"></script>
<script language="javascript">

function AccBlur(row_Index,tb_AccCode,tb_Description,tb_workgroup_desc)
{
    var currentTime = new Date()
    var str_Index = "";
    var lbl_Error = document.getElementById("ctl00_MyCPH1_lbl_Error");
    
    if (tb_AccCode.value == ""){lbl_Error.innerText="";  return; }
    var gv_WorkGroup = document.getElementById("ctl00_MyCPH1_gv_WorkGroup");
    
    for (intIndex = 2; intIndex <= gv_WorkGroup.rows.length-1; intIndex++)
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
        if (document.getElementById("ctl00_MyCPH1_gv_WorkGroup_ctl" + str_Index + "_tb_workgroup_desc").value == tb_workgroup_desc.value &&
                document.getElementById("ctl00_MyCPH1_gv_WorkGroup_ctl" + str_Index + "_tb_AccCode").value == tb_AccCode.value )
        {
            lbl_Error.innerText = "Please check the Account code which is already assign to same workgroup!!!";
            tb_AccCode.value = "";
            tb_AccCode.focus();
            return;
        }
        else
        {
            lbl_Error.innerText="";
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
                    lbl_Error.innerText = "Account Code is not Valid... Please Enter Valid Account Code!!!";
                    //tb_AccCode.focus();
                    tb_Description.value="";
                    //return false;
                }
                else
                {
                    lbl_Error.innerText = "";
                    tb_Description.value=returnValue[1];
                }
            }
        }
        xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckValidAccCode&datetime="+currentTime+"&AccCode="+tb_AccCode.value, false);
        xmlHttpRequest.send(null);
    }
}
function createXMLHttpRequest()
{
    // Mozilla, Safari,...
    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
    // IE
    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
}
function checkWorkGroupCode(row_Index,tb_workgroup_desc)
{
    var qs = new Querystring()
    var qWorkGroupCode = qs.get("WorkGroupCode")
    var currentTime = new Date()
    var str_Index = "";
    if (tb_workgroup_desc.value == "")
    {
        tb_workgroup_desc.value="";
        return;
    }

    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gv_WorkGroup").rows.length-1; intIndex++)
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
//        if (document.getElementById("ctl00_MyCPH1_gv_WorkGroup_ctl" + str_Index + "_tb_workgroup_desc").value == tb_workgroup_desc.value)
//        {
//            alert("This Work Group already exist at row " + (intIndex - 1));
//            tb_workgroup_desc.value = "";
//            tb_workgroup_desc.focus();
//            return;
//        }
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
                    tb_workgroup_desc.value=tb_workgroup_desc.value;
                }
                else
                {
                    alert("Already Exist !! ");
                    tb_workgroup_desc.focus();
                }
            }
        }
        xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckValidWorkGroup&datetime="+currentTime+"&WorkGroupCode="+qWorkGroupCode+"&WorkGroupDesc=" + tb_workgroup_desc.value, false);
        xmlHttpRequest.send(null);
    }
}
function CheckValidData()
{
    for (intIndex = 2; intIndex <= document.getElementById("ctl00_MyCPH1_gv_WorkGroup").rows.length-1; intIndex++)
    {
        if (intIndex < 10)
        {
            str_Index = "0" + intIndex;
        }
        else
        {
            str_Index = intIndex;
        }
        if (document.getElementById("ctl00_MyCPH1_gv_WorkGroup_ctl" + str_Index + "_tb_workgroup_desc").value == "")
        {
            alert("Enter Work Group Description!!!");
            document.getElementById("ctl00_MyCPH1_gv_WorkGroup_ctl" + str_Index + "_tb_workgroup_desc").focus();
            return false;
        }
        if (document.getElementById("ctl00_MyCPH1_gv_WorkGroup_ctl" + str_Index + "_tb_AccCode").value == "")
        {
            alert("Enter Account Category!!!");
            document.getElementById("ctl00_MyCPH1_gv_WorkGroup_ctl" + str_Index + "_tb_AccCode").focus();
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
                <asp:Label ID="Label2" CssClass="blackfnt" Font-Bold="True" runat="server">Work Group Master</asp:Label>
                
            </td>
        </tr>
    </table>
    <hr size=-1>
<br>
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
    <br>
    <table id="Table4" border="0" cellpadding="1" cellspacing="1" width="80%">

        <tr bgcolor="white">
        <td class="blackfnt" colspan="1" >
            <asp:Label ID="lbl_Error" CssClass="redfnt" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr bgcolor="white">
            <td class="blackfnt" colspan="1" >
                
                <asp:UpdatePanel ID="u2" runat="server" UpdateMode="Always" RenderMode="Inline">
                    <ContentTemplate>
                        <asp:GridView ShowFooter="true" ID="gv_WorkGroup" BorderWidth="0" CellSpacing="1"
                                runat="server" AutoGenerateColumns="false" Width="100%" CssClass="boxbg" 
                                HeaderStyle-CssClass="bgbluegrey"
                                FooterStyle-CssClass="bgbluegrey" OnRowDataBound="gv_WorkGroup_RowDataBound"
                                PagerSettings-Mode="NumericFirstLast" PageSize="10" SelectedIndex="1">
                                <Columns>
                                <asp:TemplateField HeaderText="SR.NO."  ItemStyle-CssClass="bgwhite">
                                      <HeaderStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                        <asp:Label ID="lbl_Sr_No" Text="<%#Container.DataItemIndex + 1%>" runat="server" ></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="10%" HorizontalAlign="Center" VerticalAlign="Middle"  />
                                </asp:TemplateField>
                                
    
                                <asp:TemplateField HeaderText="Work Group Description"  ItemStyle-CssClass="bgwhite">
                                     <HeaderStyle CssClass="blackfnt" />
                                    <ItemTemplate>
                                         <asp:TextBox ID="tb_workgroup_desc" BorderStyle="Groove" CssClass="input" Width="312px" runat="server" MaxLength="250"></asp:TextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="40%" HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:TemplateField>
                            <asp:TemplateField HeaderText="Account Code">
                                    <ItemStyle BackColor="White" CssClass="blackfnt" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#D4E0E7" CssClass="blackfnt" HorizontalAlign="Center" Wrap="False" />
                                        <ItemTemplate>
                                        <asp:TextBox ID="tb_AccCode" runat="server" BorderStyle="Groove" CssClass="input"
                                            Enabled="true" Width="100px"></asp:TextBox>
                                        <asp:Button ID="btnAccCode" runat="server" Text="..." />
                                        <asp:TextBox ID="tb_Description" runat="server" BorderStyle="None" 
                                            Width="200px" ReadOnly="true"></asp:TextBox>
                                        </ItemTemplate>
                                        <ItemStyle Width="50%" HorizontalAlign="Left" VerticalAlign="Top" />
                                </asp:TemplateField>
                                        
                                 <asp:TemplateField HeaderText="Active Flag"  ItemStyle-CssClass="bgwhite">
                                     <HeaderStyle CssClass="blackfnt" />
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
                <asp:Button ID="btn_Submit" runat="server" Text="Submit" OnClientClick="javascript:return CheckValidData()"  OnClick="btn_Submit_Click" /></td>
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

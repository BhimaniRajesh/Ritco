<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="ChqDepositVoucher_step1.aspx.cs" Inherits="GUI_Finance_Cheque_Deposit_ChqDepositVoucher_step1" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
<script language="javascript" type="text/javascript">
    var cal = new CalendarPopup("Div1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
    var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
    var client_name="<%=Session["Client"]%>"
	var FinYear="<%=Session["FinYear"]%>"
	var FinYear_to=parseInt(FinYear)+1
	if(FinYear_to<10)
	{
	FinYear_to="0"+FinYear_to
	}
	var FinYear_fromdate="01/04/"+FinYear
	var FinYear_todate="31/03/"+FinYear_to
	var Sle_finyear=FinYear+"-"+FinYear_to
	
function ChqBlur(id)
{   
    //debugger;
    var txt=document.getElementById(id);
    if(txt.value=="")
        return false;
    txt.value=txt.value.toUpperCase();
    
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="ChequeCheckExist.aspx?chqno=" + txt.value + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                       var res=findobj.responseText.split(",");
                       if(res[0]=="Y")
                       {
                            alert("Cheque No Is not Valid..Enter Valid Cheque No....");
                            txt.value="";
                            return false;
                       }
                       else
                       {
                            var HdnChqDt = document.getElementById("ctl00_MyCPH1_HdnChqDt");
                            HdnChqDt.value = res[1];
                       }
                }
          }
        findobj.send(null);
    }
}
function CheckFinacialYear(date,voucher)
{
    //debugger;
    var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>"
    var dt =date.value
    var dt_dd=dt.substring(0,2)
    var dt_mm=dt.substring(3,5)
    var dt_yy=dt.substring(6,10)
    var sdt =server_dt
    var sdt_dd=sdt.substring(0,2)
    var sdt_mm=sdt.substring(3,5)
    var sdt_yy=sdt.substring(6,10)

    dt=new Date(months[parseFloat(dt_mm)] + " " + parseFloat(dt_dd) + ", " + parseFloat(dt_yy))
    server_dt=new Date(months[parseFloat(sdt_mm)] + " " + parseFloat(sdt_dd) + ", " + parseFloat(sdt_yy))
            
    var FinYear_fromdate_dd=FinYear_fromdate.substring(0,2)
    var FinYear_fromdate_mm=FinYear_fromdate.substring(3,5)
    var FinYear_fromdate_yy=FinYear_fromdate.substring(6,10)
    FinYear_fromdate1=new Date(months[parseFloat(FinYear_fromdate_mm)] + " " + parseFloat(FinYear_fromdate_dd) + ", " + parseFloat(FinYear_fromdate_yy))
	
    var FinYear_todate_dd=FinYear_todate.substring(0,2)
    var FinYear_todate_mm=FinYear_todate.substring(3,5)
    var FinYear_todate_yy=FinYear_todate.substring(6,10)
    FinYear_todate1=new Date(months[parseFloat(FinYear_todate_mm)] + " " + parseFloat(FinYear_todate_dd) + ", " + parseFloat(FinYear_todate_yy))
		
    if (dt>FinYear_todate1 || dt<FinYear_fromdate1)
    {
	    alert( "You have Selected Finacial Year as "+ Sle_finyear +" , SO  Voucher Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
	    date.focus();
	    return false;
    }
	
    if (dt>server_dt)
     {
        alert( voucher + " Date should not be greater than today's date !!!")
        date.focus();
        return false;
     }
     return true;
}
	    
function checkData()
{
    //debugger;
    var ddrdatemode = document.getElementById("ctl00_MyCPH1_ddrdatemode");
    var txtChqNo = document.getElementById("ctl00_MyCPH1_txtChqNo");
    var txtDateFrom = document.getElementById("ctl00_MyCPH1_txtDateFrom");
    var txtDateTo = document.getElementById("ctl00_MyCPH1_txtDateTo");
    if(txtChqNo.value == "" && txtDateTo.value == "")
    {
        alert("Please Enter Cheque No or Select Date Range");
        txtChqNo.focus();
        return false;
    }
    if(ddrdatemode.value == "")
    {
        alert("Please Select Date Type");
        ddrdatemode.focus();
        return false;
    }
    var DateFromflag = CheckFinacialYear(txtDateFrom,"From");
    if(!DateFromflag)
        return false;
    
    var DateToflag = CheckFinacialYear(txtDateTo,"To");
    if(!DateToflag)
        return false;   
    
    return true;
}
</script>	
<div style="width: 10.0in; text-align: right">
    <a href="javascript:window.history.go(-1)" title="back">
    <img alt="back" src="../../images/back.gif" border="0" /></a>
</div>
<div style="text-align: center; width: 10.0in">
    <table cellspacing="1" class="boxbg" width="800">
        <tr class="bgbluegrey">
            <td align="center" style="text-align: left; height: 20px;">
                <strong>Cheque Management</strong>
            </td>
        </tr>
    </table>
    <br />
        <asp:UpdateProgress ID="uppMain" runat="server">
            <ProgressTemplate>
                <iframe frameborder="1" src="about:blank" style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
                <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../images/loading.gif" /><font face=verdana color=red size=1>&nbsp;<b>Please Wait...</b></font></div>
            </ProgressTemplate>
        </asp:UpdateProgress>
    <br />        

    <asp:UpdatePanel ID="UpdatePanel3" runat="server"    UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
                <tr class="bgbluegrey">
                    <td align="center" colspan="4">
                        <strong>Search Criteria</strong>
                    </td>
                </tr>
                <tr style="background-color: White"> 
                    <td width="151" class="blackfnt" nowrap style="text-align: left; width: 151px;"> 
                        &nbsp;Cheque No</td>
                    <td width="151" colspan="2" class="blackfnt" style="text-align: left">
                        <asp:TextBox ID="txtChqNo" runat="server"></asp:TextBox>
                        <asp:HiddenField ID="HdnChqDt" runat="server" />
                    </td>
                    <%--<td width="151" class="blackfnt" style="text-align: left">
                        <asp:Button ID="adv_submit_1" runat="server" OnClick="adv_submitclick_1" Text="Submit" />
                    </td>--%>
                </tr>
                <tr style="background-color: White"> 
                    <td width="151" class="blackfnt" nowrap style="text-align: left; width: 151px;"> 
                        &nbsp;Date Type</td>
                    <td width="151" colspan="2" class="blackfnt" style="text-align: left">
                        <asp:DropDownList ID="ddrdatemode" runat="server">
                            <asp:ListItem Value="">--Select--</asp:ListItem>
                            <asp:ListItem Value="chqdt">Cheque Date</asp:ListItem>
                            <asp:ListItem Value="transdate">Transcation Date</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <%--<td width="151" class="blackfnt" style="text-align: left">
                        <asp:Button ID="Button1" runat="server" OnClick="adv_submitclick_1" Text="Submit" />
                    </td>--%>
                </tr>
                <tr style="background-color: White"> 
                    <td class="blackfnt" colspan="4"><strong>OR</strong></td>
                </tr>
                <tr style="background-color: White"> 
                        <td valign="top" width="20%" >
                            <asp:Label ID="lblDateRange1" CssClass="blackfnt" runat="server" Font-Bold="True">Select Date</asp:Label>
                        </td>
                        <td align="left" valign="top">
                            <asp:UpdatePanel ID="UpdatePanel1"   UpdateMode="Conditional" RenderMode="Inline" runat="server">
                                <ContentTemplate>
                                    <asp:RadioButtonList ID="radDate" runat="server" CssClass="blackfnt"
                                        AutoPostBack="true" OnSelectedIndexChanged="radDate_OnSelectedIndexChange" >
                                        <asp:ListItem Selected="True" Value="0" Text=" Date Range [dd/mm/yyyy]"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="1" Text=" Today:"></asp:ListItem>
                                        <asp:ListItem Selected="false" Value="2" Text=" Last Week (Including Today)"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                        <td valign="top" align="left" >
                            <asp:UpdatePanel ID="UpdatePanel2" RenderMode="Inline"  UpdateMode="Conditional" runat="server">
                                <ContentTemplate>
                                    <asp:Label ID="lblFrom" CssClass="blackfnt" runat="server" Text=" From: "></asp:Label>
                                    <asp:TextBox CssClass="input" ID="txtDateFrom" runat="Server" ValidationGroup="VGDtFromTo" Width="76px" BorderStyle="Groove"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateFrom,'anchor11','dd/MM/yyyy'); return false;" id="a1" name="anchor11">
                                        <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                                    <asp:Label ID="lblTo" CssClass="blackfnt" runat="server" Text=" To: "></asp:Label>
                                    <asp:TextBox CssClass="input" ID="txtDateTo" runat="Server" ValidationGroup="VGDtFromTo" Width="76px" BorderStyle="Groove"></asp:TextBox>
                                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDateTo,'anchor12','dd/MM/yyyy'); return false;" id="a2" name="anchor12">
                                        <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RFVFromDate" runat="server" ControlToValidate="txtDateFrom" CssClass="blackfnt"
                                        ErrorMessage="Date From cannot be blank :(" ValidationGroup="VGDtFromTo" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Invalid Date From  :("
                                        ControlToValidate="txtDateFrom" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                    <br />
                                    <asp:RequiredFieldValidator ID="RFVToDate" runat="server" ControlToValidate="txtDateTo"
                                        ErrorMessage="Date To cannot be blank :(" ValidationGroup="VGDtFromTo" />
                                    <br />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Invalid Date To  :(" CssClass="blackfnt"
                                        ControlToValidate="txtDateTo" ValidationGroup="VGDtFromTo" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))"></asp:RegularExpressionValidator>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="radDate" EventName="SelectedIndexChanged" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                   </tr>
                   <tr style="background-color: White"> 
                     <td class="blackfnt" colspan="4">
                        <asp:Button ID="adv_submit_2" runat="server" OnClick="adv_submitclick_2" OnClientClick="javascript:return checkData()" Text="Submit" ValidationGroup="VGDtFromTo" />
                     </td>
                   </tr>     
            </table>   
            <div id="Div1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;"></div>    
        </ContentTemplate>
    </asp:UpdatePanel>
</div>        
</asp:Content>


<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Advice.aspx.cs" Inherits="GUI_Finance_Advice_Generation_Advice" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"></script>
<script language="javascript" type="text/javascript" src="../../images/DateControl.js"></script>
<script language="javascript" type="text/javascript">
var cal = new CalendarPopup("Div1"); 
cal.setCssPrefix("TEST");
cal.showNavigationDropdowns();

var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
var client_name="<%=Session["Client"]%>"
var FinYear="<%=Session["FinYear"]%>"

var brcd="<%=Session["brcd"]%>";
var client="<%=Session["Client"]%>";
//var empcd="<%=Session["empcd"]%>";

var FinYear_to=parseInt(FinYear)+1
	
if(FinYear_to<10)
{
FinYear_to="0"+FinYear_to
}
var FinYear_fromdate="01/04/"+FinYear
var FinYear_todate="31/03/"+FinYear_to
var Sle_finyear=FinYear+"-"+FinYear_to
	
function myFunc(obj)
{   
    var temp  = obj.value.toUpperCase()
    document.getElementById(obj.name).value = temp;
}
function popuplist(mode,ctlid,tbl)
 { 
      //debugger;
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl ;
            confirmWin=window.open(url,"",winOpts);
      return false;
 }
function test()
{   
    window.open("popup-branch.aspx","pbr","menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,width=387,height=220,status=no,left=220,top=70");
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
		alert( "You have Selected Finacial Year as "+ Sle_finyear +" , SO Journal Voucher  Date Should Be Between  "+ FinYear_fromdate +" to "+ FinYear_todate +" !!!")
		date.focus();
		return false;
	}
	if (dt>server_dt)
	 {
        alert( voucher + " Date should not be Greater than today's date !!!")
        date.focus();
        return false;
	 }
	 return true;   
}   
function CheckData()
{
    //debugger;
    var Frame = "ctl00_MyCPH1_";
    var txtAdviceDate=document.getElementById(Frame + "txtAdviceDate");
    var txtChqDate=document.getElementById(Frame + "txtChqDate");
    var txtRaisedOn=document.getElementById(Frame + "txtRaisedOn");
    var txtReason=document.getElementById(Frame + "txtReason");
    var txtEnclosedDoc=document.getElementById(Frame + "txtEnclosedDoc");
    var txtPaymentAmt=document.getElementById(Frame + "txtPaymentAmt");
    var txtCashAmt=document.getElementById(Frame + "txtCashAmt");
    var txtChqAmt=document.getElementById(Frame + "txtChqAmt");
    var txtChqNo=document.getElementById(Frame + "txtChqNo");
    var txtChqDate=document.getElementById(Frame + "txtChqDate");
    var ddlPayMode=document.getElementById(Frame + "ddlPayMode");
    var ddrCashcode=document.getElementById(Frame + "ddrCashcode");
    var ddrBankaccode=document.getElementById(Frame + "ddrBankaccode");
    var server_dt="<%=System.DateTime.Now.ToString("dd/MM/yyyy")%>";
    var click_count=parseFloat(document.getElementById(Frame + "click_count").value);
    
    txtPaymentAmt.disabled=false;
        
    if(!isValidDate(txtAdviceDate.value,"AdviceDate"))
    {
        txtAdviceDate.focus();
        return false;
     }
    var Advicedateflag = CheckFinacialYear(txtAdviceDate,"Advice")
    if(!Advicedateflag)
        return false; 
    if(txtRaisedOn.value == "")
    {
        alert("Raised On Can't Be Blank...");
        txtRaisedOn.focus();
        return false;
    }
    if(txtReason.value == "")
    {
        alert("Plz Enter The Reason...");
        txtReason.focus();
        return false;
    }
    if(ddlPayMode.value == "")
    {
        alert("Plz Select The Payment Mode...");
        ddlPayMode.focus();
        return false;
    }  
    if(txtPaymentAmt.value == "")
    {
        alert("Plz Enter The Payment Amount...");
        txtPaymentAmt.focus();
        return false;
    }
    if(parseFloat(txtPaymentAmt.value) <= 0)
    {
        alert("Plz Enter The Payment Amount Greater Than Zero");
        txtPaymentAmt.focus();
        return false;
     } 
    if(ddlPayMode.value == "Cash")
    {
        txtCashAmt.disabled=false;
        if(ddrCashcode.value == "")
        {
            alert("Plz Select the Cash Account Code");
            ddrCashcode.focus();
            return false;
        }
        if(txtCashAmt.value == "")
        {   
            txtPaymentAmt.focus();
            return false;
        }
        if(parseFloat(txtCashAmt.value) != parseFloat(txtPaymentAmt.value))
        {
            alert("Cash and Payment Amount Must Be Equal");
            txtPaymentAmt.focus();
            return false;
        }
     }  
     if(ddlPayMode.value == "Bank")
     {  
        txtChqAmt.disabled=false;
        txtChqNo.disabled=false;
        txtChqDate.disabled=false;
    
        if(ddrBankaccode.value == "")
        {
            alert("Plz Select the Bank Account Code");
            ddrBankaccode.focus();
            txtChqAmt.disabled=true;
            return false;
        }
        if(txtChqAmt.value == "")
        {   
            txtPaymentAmt.focus();
            txtChqAmt.disabled=true;
            return false;
        }
        //debugger;
        if(parseFloat(txtChqAmt.value) != parseFloat(txtPaymentAmt.value))
        {
            alert("Bank and Payment Amount Must Be Equal");
            txtPaymentAmt.focus();
            txtChqAmt.disabled=true;
            return false;
        }
        if(txtChqNo.value == "")
        {
            alert("Plz Enter the Cheque No");
            txtChqNo.focus();
            txtChqAmt.disabled=true;
            return false;
        }
        if(txtChqDate.value == "")
        {
            alert("Plz Enter the Cheque Date");
            txtChqDate.focus();
            txtChqAmt.disabled=true;
            return false;
        }
        if(!isValidDate(txtChqDate.value,"ChequeDate"))
        {
            alert("Plz Enter the Valid Cheque Date");
            txtChqDate.focus();
            txtChqAmt.disabled=true;
            return false;
        }
        var Chequedateflag = CheckFinacialYear(txtChqDate,"Cheque")
        if(!Chequedateflag)
            return false;
     }
    if(click_count > 0)
    {
        alert("Sorry... You cannot click twice !!!")
        return false;
    }
    else
    {
        click_count=click_count+1;
        document.getElementById("ctl00_MyCPH1_click_count").value=click_count;
    }
}   
function LocBlur(id)
 {
    
    var str="";
    for(var i=0;i<id.length-14;i++)
    {
        str+=id.charAt(i);
    }
    document.getElementById(id).value=document.getElementById(id).value.toUpperCase()
    var txtRaisedOn=document.getElementById(id);
    var lbllocname=document.getElementById("ctl00_MyCPH1_lbllocname");
   
    var Location=txtRaisedOn.value;
    if(Location=="")
        return false;
 
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="CheckExist.aspx?mode=LocCode&Code=" + Location + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert("Location Code is not Valid... Please Enter Valid Location Code");
                        txtRaisedOn.value="";
                        lbllocname.innerText = "";
                        txtRaisedOn.focus();
                        return false;
                    }
                    else
                    {
                        lbllocname.innerText = res[1];
                    }
                   
                }
         }
    findobj.send(null);
    }
    return false;
}
function ChequeBlur(id)
 {
    
    var str="";
    for(var i=0;i<id.length-14;i++)
    {
        str+=id.charAt(i);
    }
    document.getElementById(id).value=document.getElementById(id).value.toUpperCase()
    var txtChqDate=document.getElementById(id);
    var txtChqNo=document.getElementById("ctl00_MyCPH1_txtChqNo");
    
   
    var txtChqNumber=txtChqNo.value;
    if(txtChqNumber=="")
        return false;
 
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
     var strpg="CheckExist.aspx?mode=chq&chqdt=" + txtChqDate.value + "&code=" + txtChqNumber + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
             if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="true")
                    {
                        alert("Duplicate Chque Number Entered");
                        txtChqNo.value="";
                        txtChqDate.value="";
                        txtChqNo.focus();
                        return false;
                    }
                    
                }
         }
        findobj.send(null);
    }
    return false;
}
function Nagative_Chk_wDecimal(obj)
{
	var temp
	temp=obj.value; 
	var txtPaymentAmt=document.getElementById("ctl00_MyCPH1_txtPaymentAmt");
    var txtCashAmt=document.getElementById("ctl00_MyCPH1_txtCashAmt");
    var txtChqAmt=document.getElementById("ctl00_MyCPH1_txtChqAmt");
    var ddlPayMode=document.getElementById("ctl00_MyCPH1_ddlPayMode");
    
	//alert(temp)					
	if (temp=="")	
	{
		alert("Value can not be blank")
		obj.focus();
        obj.value="0.0";
		return false;
	}
	if(isNaN(temp))
	{
		alert("Value should be Numeric")
		obj.value="0.0";
		obj.focus();
		return false;
	} 					  
	if(parseFloat(temp)<0)
	{
		alert("Value should be greater than zero")
		obj.value="0.0";
		obj.focus();
		return false;
	}
	obj.value=roundit(temp) 
	
    
    if(ddlPayMode.value == "Cash")
    {
        txtCashAmt.value = txtPaymentAmt.value
    }
    if(ddlPayMode.value == "Bank")
    {
        txtChqAmt.value = txtPaymentAmt.value        
    }
	return true;					   
}     
function roundit(Num)
	{
	    //debugger;
	    //var Num = document.getElementById("ctl00_MyCPH1_txtPaymentAmt").value;
	    
		Places=2
		if (Places > 0) 
			{
			if ((Num.toString().length - Num.toString().lastIndexOf('.')) > (Places+1)) 
			{
				if (Num.toString().lastIndexOf('.') < 0) 
				{
					return Num.toString() +'.00';
				}
				var Rounder = Math.pow(10, Places);
				return Math.round(Num * Rounder) / Rounder;
			}
			else 
			{
				if (Num.toString().lastIndexOf('.') < 0) 
				{
					return Num.toString() +'.00';
				}
				else
				{  
					if (Num.toString().lastIndexOf('.')+1==Num.toString().length-1)
						return Num.toString() +'0';	
					else
						return Num.toString();				   

				}
			}
			}
		else return Math.round(Num);
	}
</script>
<div style="width: 10.0in; text-align: right">
    <a href="javascript:window.history.go(-1)" title="back">
    <img alt="back" src="../../images/back.gif" border="0" /></a>
</div>
<div style="text-align: center; width: 10.0in">
    <table cellspacing="1" class="boxbg" width="800">
        <tr class="bgbluegrey">
            <td align="center">
                <strong>Advice Generation</strong>
            </td>
        </tr>
    </table>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server"  UpdateMode="Conditional" RenderMode="Inline">
        <ContentTemplate>
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
                <tr style="background-color: White"> 
                    <td width="151" class="blackfnt" nowrap style="text-align: left; width: 151px;"> 
                        &nbsp;Advice No</td>
                    <td width="151" class="blackfnt" style="text-align: left"> <span style="color: #ff0000">&nbsp;&lt;System 
                        Generated&gt;</span></td>
                    <td width="130" class="blackfnt" style="text-align: left"> &nbsp;Advice Type</td>
                    <td colspan="2" width="135" class="blackfnt"  nowrap style="text-align: left"> &nbsp; 
                        <asp:DropDownList ID="dlstAdviceType" runat="server">
                            <asp:ListItem Selected="True" Value="D">Debit Advice</asp:ListItem>
                            <asp:ListItem  Value="C">Credit Advice</asp:ListItem>
                        </asp:DropDownList>    
                    </td>
                </tr>
                <tr style="background-color: White"> 
                    <td width="151" class="blackfnt" nowrap style="text-align: left; width: 151px;"> 
                        &nbsp;Advice Date</td>
                    <td class="blackfnt"  nowrap style="text-align: left">
                        <asp:TextBox ID="txtAdviceDate" runat="server" 
                        Width="80px" BorderStyle="Groove" CssClass="input" MaxLength="10"></asp:TextBox> 
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtAdviceDate,'anchor1','dd/MM/yyyy'); return false;"
                            id="anchor1" name="anchor1"> <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
                    </td>
                    <td width="130" class="blackfnt" nowrap  style="text-align: left"> &nbsp;Generated By</td>
                    <td colspan="2" width="130" class="blackfnt"  nowrap style="text-align: left"> &nbsp; 
                        <strong><asp:Label ID="lblgeneratedby" runat="server"></asp:Label></strong>
                    </td>
                </tr>
                <tr style="background-color: White"> 
                    <td width="151" class="blackfnt" nowrap style="text-align: left; width: 151px;"> 
                        &nbsp;Raised By</td>
                    <td class="blackfnt"  nowrap style="text-align: left">
                        <strong><asp:Label ID="lblraisedby" runat="server"></asp:Label></strong>
                    </td>
                    <td width="130" class="blackfnt" nowrap  style="text-align: left"> &nbsp;Raised On Branch</td>
                    <td colspan="2" width="130" class="blackfnt"  nowrap style="text-align: left"> &nbsp; 
                        <asp:TextBox ID="txtRaisedOn" runat="server" Width="50px"></asp:TextBox>
                        <asp:Button ID="btnRaisedLoc" runat="server" Text="..." />
                        </br>
                         <span style="color: #ff0000"><asp:Label ID="lbllocname" runat="server"></asp:Label></span>
                    </td>
                </tr>
                <tr style="background-color: White"> 
                    <td width="151" class="blackfnt" nowrap style="text-align: left; width: 151px;"> 
                        &nbsp;Reason</td>
                    <td class="blackfnt"  nowrap style="text-align: left" colspan="4">
                        <asp:TextBox ID="txtReason" runat="server" MaxLength="200" TextMode="MultiLine" Width="250px"></asp:TextBox>
                    </td>
                </tr>
                <tr style="background-color: White"> 
                    <td width="151" class="blackfnt" nowrap style="text-align: left; width: 151px;"> 
                        &nbsp;Enclosed Documents</td>
                    <td class="blackfnt"  nowrap style="text-align: left" colspan="4">
                        <asp:TextBox ID="txtEnclosedDoc" runat="server" MaxLength="200" TextMode="MultiLine" Width="250px"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <br />
            <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                <ProgressTemplate>
                    <table style="border: solid #8ba0e5 2px; z-index: 98; position: fixed; width: 200px; -left: -60px; top: 50%; left: 40%;" width="190px" cellpadding="0" bgcolor="white">
                        <tr>
                            <td align="right"><img src="../../images/loading.gif" alt="" /></td>
                            <td><font face="verdana" color="#0000ff" size="2">&nbsp;&nbsp;&nbsp;<b>Please Wait ...</b></font></td>
                        </tr>
                    </table>
                    <asp:Panel ID="Panel1" Style="position: fixed; z-index: 97; top: 0px; left: 0px; background-color: #FFFFFF;
                        width: 100%; height: 100%; filter: Alpha(Opacity=50); opacity: .50; -moz-opacity: .50;"
                        runat="server">
                        <asp:Panel Style="z-index: 98; position: fixed; width: 120px; -left: -60px; top: 50%;
                            left: 50%;" ID="Panel2" runat="server">
                        </asp:Panel>
                    </asp:Panel>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <br />
            <asp:HiddenField ID="click_count" runat="server" Value="0" />
            <strong><asp:Label ID="Label1" runat="server" Text="Note : Please enter the payment details if payment amount >0 "></asp:Label></strong>
            </br>
            </br>
            <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
                <tr class="bgbluegrey">
                    <td align="center" colspan="4">
                        <strong>Payment Details</strong>
                    </td>
                </tr>
                <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Payment Mode
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:DropDownList ID="ddlPayMode" runat="server" Width="87px" AutoPostBack="True" CssClass="blackfnt"
                                OnSelectedIndexChanged="ddlPayMode_SelectedIndexChanged">
                                <asp:ListItem Value="">--Select--</asp:ListItem>
                                <asp:ListItem>Cash</asp:ListItem>
                                <asp:ListItem>Bank</asp:ListItem>
                            </asp:DropDownList></td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Payment Amount
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox style="text-align:right" ID="txtPaymentAmt" runat="server" BorderStyle="Groove" CssClass="Blackfnt" Width="80px" onkeypress="javascript:validInt(event);" onchange="javascript:Nagative_Chk_wDecimal(this)" Enabled="false" Text="0"></asp:TextBox></td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cash Amount
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox style="text-align:right" ID="txtCashAmt" runat="server" BorderStyle="Groove" CssClass="input" Text="0" Width="80px" Enabled="false"></asp:TextBox></td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cash Account
                        </td>
                        <td style="text-align: left" class="blackfnt"> 
                            &nbsp;<asp:DropDownList ID="ddrCashcode" runat="server"   CssClass="Blackfnt" >
                                  </asp:DropDownList>
                                &nbsp;
                        </td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cheque Amount
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox style="text-align:right" ID="txtChqAmt" runat="server"  BorderStyle="Groove" CssClass="input" Text="0" Width="80px" Enabled="False"></asp:TextBox></td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Bank Account
                        </td>
                        <td style="text-align: left" class="blackfnt">
                             &nbsp;<asp:DropDownList ID="ddrBankaccode" runat="server"   CssClass="Blackfnt" >
                             </asp:DropDownList>
                       </td>
                    </tr>
                    <tr style="background-color: White">
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cheque No.
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtChqNo" MaxLength="6" runat="server" BorderStyle="Groove" style="text-align:right" CssClass="input"  Columns="6" Enabled="False"></asp:TextBox></td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;Cheque date
                        </td>
                        <td style="text-align: left" class="blackfnt">
                            &nbsp;<asp:TextBox ID="txtChqDate" runat="server" style="text-align:right"
                                BorderStyle="Groove" CssClass="input" MaxLength="10" Width="80px"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtChqDate,'anchor11','dd/MM/yyyy'); return false;"
                                id="a1" name="anchor11">
                                <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a></td>
                    </tr>
            </table>
            <br />
            <table cellspacing="1" class="boxbg" width="800">
                <tr class="bgbluegrey">
                    <td align="center">
                        <asp:Button ID="btnSubmit" runat="server" OnClientClick="javascript:return CheckData();" BorderStyle="Solid" BorderWidth="1px" Text="SUBMIT"
                            Width="150px" OnClick="btnSubmit_Click" /></td>
                </tr>
            </table>
            <div id="Div1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;"></div>    
        </ContentTemplate>
    </asp:UpdatePanel>    
</div>    
</asp:Content>


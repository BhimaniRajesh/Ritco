<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true" CodeFile="Octroi_Agent_Bill.aspx.cs" Inherits="GUI_Octroi_New_Octroi_Bill_Octroi_Agent_Bill" Title="Untitled Page" %>
<%@ Register TagName="OctDetail" TagPrefix="Oct" Src="~/GUI/Octroi_New/OctroiDocketDetails.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" Runat="Server">
<script language="javascript" type="text/javascript" src="../../images/CalendarPopup.js"> </script>
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript">
    var cal = new CalendarPopup("Div1"); 
	cal.setCssPrefix("TEST");
	cal.showNavigationDropdowns();
	var months = new Array("","January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December");
    var FinYear="<%=Session["FinYear"]%>";
	var FinYear_to=parseInt(FinYear)+1;
	if(FinYear_to<10)
	{
		FinYear_to="0"+FinYear_to;
	}
	var FinYear_fromdate="01/04/"+FinYear;
	var FinYear_todate="31/03/"+FinYear_to;
	var Sle_finyear=FinYear+"-"+FinYear_to;
function ValidateDate(obj)
{
  if (obj.value!="")
  { 
    if (isDate(obj.value)==false)
    {
	    obj.focus()
	    return false
    }
    return true
  }
}
var dtCh= "/";
var minYear="1900";
var maxYear="2100";
function DaysArray(n) 
{
    for (var i = 1; i <= n; i++) 
    {
	    this[i] = 31
	    if (i==4 || i==6 || i==9 || i=="11") {this[i] = 30}
	    if (i==2) {this[i] = 29}
   } 
    return this
}
function isDate(dtStr)
{
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strDay=dtStr.substring(0,pos1)
	var strMonth=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1){
		alert("The date format should be : dd/mm/yyyy")
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
		alert("Please enter a valid month")
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		alert("Please enter a valid day")
		return false
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		alert("Please enter a valid 4 digit year between "+minYear+" and "+maxYear)
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		alert("Please enter a valid date")
		return false
	}
	return true
}
function DocketCheck(Obj)
 {
    //debugger;
    var txtDockno = Obj.id;
    var txtOctAmt = Obj.id;
    var txtRecpno = Obj.id;
    var txtRecpdt = Obj.id;
    
    txtOctAmt=txtOctAmt.replace( "txtDockno", "txtOctAmt");
    txtRecpno=txtRecpno.replace( "txtDockno", "txtRecpno");
    txtRecpdt=txtRecpdt.replace( "txtDockno", "txtRecpdt");
    
    txtDockno = document.getElementById(txtDockno);
    txtOctAmt = document.getElementById(txtOctAmt);
    txtRecpno = document.getElementById(txtRecpno);
    txtRecpdt = document.getElementById(txtRecpdt);
        
    if(txtDockno.value == "")
        return false;
        
    var DocketNo = txtDockno.value;
    var PartyCode = "";
   
    
    var tbl=document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols");
    var r=tbl.rows.length;
   
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
        var strpg="../CheckExist.aspx?DocketNo=" + DocketNo + "&PartyCode=" + PartyCode + "&sid=" + Math.random();
        findobj.open("GET",strpg,true);
        findobj.onreadystatechange=function()
        { 
             if(findobj.readyState==4 && findobj.status==200)
                {
                    
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        alert("Invalid Docket No");
                        Obj.value="";
                        Obj.focus();
                        return false;
                    }
                    else
                    {
                        //debugger;
                        if(res[0] == "true")
                        {   
                            txtOctAmt.value = res[2];
                            txtRecpno.value = res[3];
                            txtRecpdt.value = res[4];   
                        }
                        else
                        {
                            alert(res[0]);
                            Obj.value="";
                            Obj.focus();
                            return false;
                        }
                        
                    }
                }
         }
      findobj.send(null);
    }
    return false;
}
function rounditn(Num,decplaces)
{
    Places=decplaces
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
            //alert("Hi")
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
<br />
<table border="0" cellpadding="1" cellspacing="1" width="800">
    <tr>
        <td align="left">
            <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                <b>Finance</b></font> </a><b>&gt; </b><a><font class="blklnkund"><b>Octroi</b></font>
                    <b>&gt; </b></a><a><font class="bluefnt"><b>Enter Octroi Agent Bills</b></font></a>
        </td>
    </tr>
</table>
<br />	
<div style="text-align: left; width: 9.5in">
<table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="100%">
    <tr class="bgbluegrey">
            <td align="center">
                <strong>Agent Bill Summary</strong>
            </td>
    </tr>
</table>
<table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="100%">
    <tr style="background-color: White"> 
        <td class="blackfnt" > 
            &nbsp;Bill Entry Number</td>
        <td class="blackfnt" > 
            &nbsp;<span style="color: #ff0000">&lt;System Generated&gt;</span></td>
        <td class="blackfnt" > &nbsp;Bill Date</td>
        <td colspan="2" class="blackfnt">
            &nbsp;<asp:TextBox ID="txtBillDate" runat="server" onblur="javascript:ValidateDate(this)" Width="80px" BorderStyle="Groove" CssClass="blackfnt" MaxLength="10"></asp:TextBox> 
            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtBillDate,'anchor1','dd/MM/yyyy'); return false;" id="anchor1" name="anchor1"> <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
        </td>
    </tr>
    <tr style="background-color: White"> 
        <td class="blackfnt" >&nbsp;Octroi Agent</td>
        <td class="blackfnt" >&nbsp;<asp:DropDownList ID="ddlOctAgnLst" runat="server"></asp:DropDownList></td>
        <td class="blackfnt" >&nbsp;Agent Bill number</td>
        <td colspan="2" class="blackfnt"> 
            &nbsp;<asp:TextBox ID="txtAgnBillno" runat="server" Width="80px"></asp:TextBox>
        </td>    
    </tr>
    <tr style="background-color: White"> 
        <td class="blackfnt" >&nbsp;Octroi paid by Agent Rs.</td>
        <td class="blackfnt" > 
            &nbsp;<asp:TextBox ID="txtOctPaidByAgn" Enabled="false" runat="server" style="text-align:right" Width="80px" Text="0.00"></asp:TextBox></td>
        <td class="blackfnt" > &nbsp;Agent Bill date</td>
        <td colspan="2" class="blackfnt">
            &nbsp;<asp:TextBox ID="txtAgnBilldt" runat="server" onblur="javascript:ValidateDate(this)" Width="80px" BorderStyle="Groove" CssClass="blackfnt" MaxLength="10"></asp:TextBox> 
            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtAgnBilldt,'anchor1','dd/MM/yyyy'); return false;" id="a2" name="anchor1"> <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
        </td>    
    </tr>        
    <tr style="background-color: White"> 
      <td class="blackfnt" style="height: 26px" > &nbsp;Agent service Charge</td>
      <td class="blackfnt" style="height: 26px" > 
            &nbsp;<asp:TextBox ID="txtAgnSrvChrg" runat="server" Width="80px" style="text-align:right" Text="0.00"></asp:TextBox></td>
      <td class="blackfnt" style="height: 26px" > &nbsp;Service Charg (%)</td>
      <td colspan="2" class="blackfnt" style="height: 26px"> 
            &nbsp;<asp:TextBox ID="txtSvrChrgPer" Enabled="false" runat="server" Width="80px" style="text-align:right" Text="0"></asp:TextBox></td>
    </tr>
    <tr style="background-color: White"> 
      <td class="blackfnt" > &nbsp;Other Charges</td>
      <td class="blackfnt" > 
            &nbsp;<asp:TextBox ID="txtOctChrg" runat="server" Width="80px" style="text-align:right" Text="0.00"></asp:TextBox></td>
      <td class="blackfnt" > &nbsp;Service Tax Charged</td>
      <td class="blackfnt"> 
            &nbsp;<asp:TextBox ID="txtSvrTaxChrg" Enabled="false" runat="server" Width="80px" style="text-align:right" Text="0.00"></asp:TextBox></td>
    </tr>
    <tr style="background-color: White"> 
      <td class="blackfnt" > &nbsp;Form charges</td>
      <td align="left" >
        &nbsp;<asp:TextBox ID="txtFormChrg" runat="server" Width="80px" MaxLength="10" Text="0.00" style="text-align:right"></asp:TextBox></td>
      <td align="left" >&nbsp;Sundry Charges</td>
      <td class="blackfnt"> 
            &nbsp;<asp:TextBox ID="txtSunChrg" runat="server" Width="80px" style="text-align:right"></asp:TextBox>
      </td>
    </tr>
    <tr style="background-color: White"> 
      <td class="blackfnt" > &nbsp;Clearance charges</td>
      <td align="left" >
        &nbsp;<asp:TextBox ID="txtClrChrg" runat="server" Width="80" MaxLength="10" Text="0.00" style="text-align:right"></asp:TextBox></td>
      <td align="left" ></td>
      <td class="blackfnt"> 
      </td>
    </tr>
    <tr style="background-color: White"> 
        <td class="blackfnt" >&nbsp;Total Due</td>
        <td class="blackfnt" > 
            &nbsp;<asp:TextBox ID="TextBox1" Enabled="false" runat="server" Width="80px" style="text-align:right" Text="0.00"></asp:TextBox></td>
        <td class="blackfnt" > &nbsp;Due date</td>
        <td colspan="2" class="blackfnt">
            &nbsp;<asp:TextBox ID="txtDueDate" runat="server" onblur="javascript:ValidateDate(this)" Width="80px" BorderStyle="Groove" CssClass="blackfnt" MaxLength="10"></asp:TextBox> 
            <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDueDate,'anchor1','dd/MM/yyyy'); return false;" id="a1" name="anchor1"> <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
        </td>    
    </tr>    
    <tr style="background-color: White"> 
      <td colspan="5" class="blackfnt" >
            <Oct:OctDetail ID="OctDetails" runat="server"/>
      </td>
    </tr>
    <tr style="background-color: White"> 
      <td class="blackfnt" >&nbsp;Remarks</td>
      <td colspan="4" class="blackfnt">&nbsp;<asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" MaxLength="250" Width="250"></asp:TextBox></td>
    </tr>
</table> 
</div>
<div id="Div1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;"> </div>   
</asp:Content>


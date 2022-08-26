<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="Octroi_CustBill_step_1.aspx.cs" Inherits="GUI_Octroi_New_Octroi_Bill_Octroi_CustBill_step_1"
    Title="Untitled Page" %>

<%@ Register TagName="OctDetail" TagPrefix="Oct" Src="~/GUI/Octroi_New/OctroiBillDetailsControl.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

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
   function isDate(dtStr){
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
function PartyLocBlur(Obj,Type)
 {
    //debugger;
    
    document.getElementById(Obj).value=document.getElementById(Obj).value.toUpperCase();
    var txtPartyLocId=document.getElementById(Obj);
    if(txtPartyLocId.value == "")
        return false;
    
    var Search_Char="~";        
    if (txtPartyLocId.value.indexOf(Search_Char)==-1)
    {
       alert("Invalid  "+ Type +"  Name~Code Format");
       txtPartyLocId.focus();
       return false;
    }
    
    //Obj.value=Obj.value.toUpperCase()
    var Code_ID=document.getElementById(Obj);
    
    var Code_Value=Code_ID.value;
    Code_Value_Arr=Code_Value.split("~");
    
    var Code_Value_0=Code_Value_Arr[0];
    var Code_Value_1=Code_Value_Arr[1];
    
    if(Code_Value_1=="")
    return false;
    
    if(Type == "Party")
        var txtPartyCode = txtPartyLocId;
    else if(Type == "SubLoc")
        var txtBillSubAt = txtPartyLocId; 
    else if(Type == "ColLoc")
        var txtBillColAt = txtPartyLocId; 
        
    var lblPartyAdd = document.getElementById("ctl00_MyCPH1_lblPartyAdd");
    var lblPartyName = document.getElementById("ctl00_MyCPH1_lblPartyName");
    //var lblBillSubAt = document.getElementById("ctl00_MyCPH1_lblBillSubAt");
    //var lblBillColAt = document.getElementById("ctl00_MyCPH1_lblBillColAt");
        
    var findobj=false;
    findobj=GetXMLHttpObject();
    if(findobj)
    {
        var strpg="../CheckPartyLocExist.aspx?mode=" + Type + "&Code=" + Code_Value_1 + "&sid=" + Math.random();
        findobj.open("GET",strpg,true);
        findobj.onreadystatechange=function()
        { 
            if(findobj.readyState==4 && findobj.status==200)
                {
                    var res=findobj.responseText.split("|");
                    if(res[0]=="false")
                    {
                        if(Type == "Party")
                        {
                            alert("Party Code Is Not Valid For This Location... Plz Enter Valid Party Code");
                            txtPartyLocId.value="";
                            txtPartyLocId.focus();
                            return false;
                        }
                        else
                        {
                            alert("Location Code Is Not Valid... Plz Enter Valid Location Code");
                            txtPartyLocId.value="";
                            txtPartyLocId.focus();
                            return false;
                        }
                    }
                    else
                    {
                        if(Type == "Party")
                        {   
                            lblPartyName.innerText = res[1];
                            lblPartyAdd.innerText = res[2];
                        }
                        /*else if(Type == "SubLoc")
                        {
                            lblBillSubAt.innerText = res[3];
                        }
                        else if(Type == "ColLoc")
                        {
                            lblBillColAt.innerText = res[3];
                        }*/
                    }
                    
                }
         }
         
    findobj.send(null);
    }
    return false;
}
function DocketCheck(Obj)
 {
    //debugger;
    var txtDockno = Obj.id;
    var txtDelVal = Obj.id;
    var txtOctAmt = Obj.id;
    var txtRecpno = Obj.id;
    var txtRecpdt = Obj.id;
    
    txtDelVal=txtDelVal.replace( "txtDockno", "txtDelVal");
    txtOctAmt=txtOctAmt.replace( "txtDockno", "txtOctAmt");
    txtRecpno=txtRecpno.replace( "txtDockno", "txtRecpno");
    txtRecpdt=txtRecpdt.replace( "txtDockno", "txtRecpdt");
    
    txtDockno = document.getElementById(txtDockno);
    txtDelVal = document.getElementById(txtDelVal);
    txtOctAmt = document.getElementById(txtOctAmt);
    txtRecpno = document.getElementById(txtRecpno);
    txtRecpdt = document.getElementById(txtRecpdt);
    
    txtPartyCode = document.getElementById("ctl00_MyCPH1_txtPartyCode");
    
    if(txtDockno.value == "")
        return false;
        
    var DocketNo = txtDockno.value;
    var PartyCode = txtPartyCode.value;
    
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
                        alert("Invalid Docket No For This Customer");
                        Obj.value="";
                        Obj.focus();
                        return false;
                    }
                    else
                    {
                        //debugger;
                        if(res[0] == "true")
                        {
                            txtDelVal.value = res[1];
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
function validInt(event)
{
    if(event.keyCode==13)
        {
            return true;
        }
    if(event.keyCode<48 || event.keyCode>57)
    {
        event.keyCode=0;return false;
    }
}
function validFloat(event,txtid)
{
    var tb=document.getElementById(txtid);
    var txt=tb.value;
    if(event.keyCode==13)
    return true;

    if(event.keyCode==46)
    if(txt.indexOf('.')!=-1)
    event.keyCode=0;

    if((event.keyCode<46 || event.keyCode>57) || event.keyCode==47)
    {event.keyCode=0;return false;}
}
function popuplist(mode,ctlid,tbl)
 {    
      var winOpts="scrollbars=yes,resizable=yes,width="+500+",height="+400+"";
      var url="";
            url="../DataPopUp.aspx?mode=" + mode + "&ctlid=" + ctlid + "&tbl=" + tbl ;
            confirmWin=window.open(url,"",winOpts);
      return false;
 }
 function LocBlur(id)
 {
    
    var str="";
    for(var i=0;i<id.length-14;i++)
    {
        str+=id.charAt(i);
    }
    document.getElementById(id).value=document.getElementById(id).value.toUpperCase()
    var txtLocation=document.getElementById(id);
   
    var Location=txtLocation.value;
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
                        txtLocation.value="";
                        txtLocation.focus();
                        return false;
                    }
                   
                }
         }
    findobj.send(null);
    }
    return false;
}
function calc()
    {
        var grid=document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols");
        var norows=grid.rows.length;
        var pref="";
        var grandtotal2=0.00;
        var pref="";
        var octamt=0.00;
        var processchrg=0.00;
        var stax=0.00;
        var cess=0.00;
        var hcess=0.00;
        var othr=0.00;
        var forsvc=0.00;
        for(var i=2;i<=norows;i++)
        {
            var grandtotal=0.00;
            if(i<10)
                pref="ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_";
            else
                pref="ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_";
                
            var txtoctamt=document.getElementById(pref+"txtOctAmt");
            var txtoctper=document.getElementById(pref+"txtOctper");
            var txtclearchrg=document.getElementById(pref+"txtClearChrg");
            var txtprochrg_per=document.getElementById(pref+"txtProPercent");
            var txtprochrg=document.getElementById(pref+"txtProChrg");
            var txtstax=document.getElementById(pref+"txtSvrTax");
            var txtcess=document.getElementById(pref+"txtCess");
            var txthcess=document.getElementById(pref+"txtHEduCess");
            var txtotchg=document.getElementById(pref+"txtOtrChrg");
            var txttotalamt=document.getElementById(pref+"txtTotal");
            var txtdeclval=document.getElementById(pref+"txtDelVal");
            octamt=parseFloat(txtoctamt.value);
            if(octamt==0)
            {}
            else
            {
                //debugger;
                var perct = parseFloat(txtoctamt.value) * 100 / parseFloat(txtdeclval.value);
                txtoctper.value = rounditn(perct,2);
                grandtotal=grandtotal + octamt;  // Assigning Octroi Amount to Grand Total
                grandtotal=grandtotal + parseFloat(txtclearchrg.value); // Adding Cleasrance Charges to Grand Total
                processchrg=parseFloat(txtoctamt.value) * parseFloat(txtprochrg_per.value) / 100;
                grandtotal = grandtotal + processchrg; // Adding Processing Charges to Grand Total
                txtprochrg.value=rounditn(processchrg,2);
                forsvc = parseFloat(txtclearchrg.value)+processchrg+parseFloat(txtotchg.value);
                if(document.getElementById("ctl00_MyCPH1_OctDetails_svrtax_yn").checked==false)
                {
                    stax = (forsvc * 12) / 100;
                    txtstax.value=rounditn(stax,2);
                    grandtotal = grandtotal + stax; // Adding STAX to Grand Total
                    // Calculating CESS = 2 % of STAX
                        cess=(stax*2)/100;
                        txtcess.value=rounditn(cess,2);
                        grandtotal = grandtotal + cess;
            
                    //Calculating HCESS = 1 % of STAX
                        hcess=(stax*1)/100;
                        txthcess.value=rounditn(hcess,2);
                        grandtotal = grandtotal + hcess;
                }
                else
                {
                    txtstax.value="0.00"
                    txtcess.value="0.00"
                    txthcess.value="0.00"
                 }
                othr=parseFloat(txtotchg.value);
                grandtotal = grandtotal+othr;
                txttotalamt.value=rounditn(grandtotal,2);
                grandtotal2+=grandtotal;
                document.getElementById("ctl00_MyCPH1_txtBillAmt").value =rounditn(grandtotal2,2);
                //document.getElementById("ctl00_MyCPH1_h11").value = rounditn(grandtotal2,2);
             }
          }
     }
function Customer_Location_Blur(Obj,Mode,Acct_Y_N)
 {  
    if(Obj.value=="")
    {
            return false;
    }
    var Search_Char="~"
    if (Obj.value.indexOf(Search_Char)==-1)
    {
       alert("Invalid  "+ Mode +"  Name~Code Format");
       Obj.focus();
       return false
    }
    Obj.value=Obj.value.toUpperCase()
    var Code_ID=Obj;
   
    var Code_Value=Code_ID.value;
    Code_Value_Arr=Code_Value.split("~");
    
    var Code_Value_0=Code_Value_Arr[0]
    var Code_Value_1=Code_Value_Arr[1]
    
    if(Code_Value_1=="")
    return false;
    
    var findobj=false;
    findobj=GetXMLHttpObject();
   
    if(findobj)
    {
    //alert("Hi..1")
    //alert(Code_Value_1)
    //alert(Mode)
     var strpg="../CheckExist.aspx?Mode="+Mode+"&Code=" + Code_Value_1 + "&sid=" + Math.random();
     findobj.open("GET",strpg,true);
     findobj.onreadystatechange=function()
         {
            // alert("Hi..2")
            // alert(findobj.readyState)
             // alert(findobj.status)
             if(findobj.readyState==4 && findobj.status==200)
                {
                    //alert(findobj.responseText)
                    var res=findobj.responseText.split("|");
                    
                    if(res[0]=="false")
                    {
                        alert(Mode + "  Code is not Valid... Please Enter Valid "+ Mode +" Code");
                        Code_ID.value="";
                        Code_ID.focus();
                        return false;
                    }
                    
                }
         }
    findobj.send(null);
    }
    return false;
}     
function CheckData()
{
    var prefix = "ctl00_MyCPH1_";
    var txtBillDate = document.getElementById(prefix + "txtBillDate");
    var txtPartyCode = document.getElementById(prefix + "txtPartyCode");
    var txtBillSubAt = document.getElementById(prefix + "txtBillSubAt");
    var txtBillColAt = document.getElementById(prefix + "txtBillColAt");
    var txtDueDate = document.getElementById(prefix + "txtDueDate");
    var txtRemarks = document.getElementById(prefix + "txtRemarks");
    
    if(txtBillDate.value == "")
    {
        alert("Plz Enter The Bill Date");
        txtBillDate.focus();
        return false;
    }
    if(txtPartyCode.value == "")
    {
        alert("Plz Enter The Party Code");
        txtPartyCode.focus();
        return false;
    }
    if(txtBillSubAt.value == "")
    {
        alert("Plz Enter Bill The Submission Location");
        txtBillSubAt.focus();
        return false;
    }
    if(txtBillColAt.value == "")
    {
        alert("Plz Enter Bill The Collection Location");
        txtBillColAt.focus();
        return false;
    }
    if(txtDueDate.value == "")
    {
        alert("Plz Enter The Due Date");
        txtDueDate.focus();
        return false;
    }
    if(txtRemarks.value == "")
    {
        alert("Plz Enter The Remarks");
        txtRemarks.focus();
        return false;
    }
    //Code For Disable Text boxes
    document.getElementById("ctl00_MyCPH1_txtBillAmt").disabled=false;
    
    var tbl=document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols");
    var rows=tbl.rows.length;
    for(i = 2; i <= rows ; i++)
    {
        if(i<10)
        {
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_txtOctper").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_txtProChrg").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_txtSvrTax").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_txtCess").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_txtHEduCess").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl0" + i + "_txtTotal").disabled=false;
        }
        else
        {
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_txtOctper").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_txtProChrg").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_txtSvrTax").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_txtCess").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_txtHEduCess").disabled=false;
            document.getElementById("ctl00_MyCPH1_OctDetails_grvcontrols_ctl" + i + "_txtTotal").disabled=false;
        }
    }
    // End
    return true;
}      
    </script>

    <br />
    <%--<div style="width: 10.0in; text-align: right">
    <a href="javascript:window.history.go(-1)" title="back">
        <img alt="back" src="../../images/back.gif" border="0" />
    </a>
</div>   --%>
    <table border="0" cellpadding="1" cellspacing="1" width="800">
        <tr>
            <td align="left">
                <a><font class="blklnkund"><b>Module</b></font></a> <b>&gt; </b><a><font class="blklnkund">
                    <b>Finance</b></font> </a><b>&gt; </b><a><font class="blklnkund"><b>Octroi</b></font>
                        <b>&gt; </b></a><a><font class="bluefnt"><b>Prepare Octroi Bill </b></font>
                </a>
            </td>
        </tr>
    </table>
    <br />
    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="908">
        <tr class="bgbluegrey">
            <td align="center">
                <strong>Prepare Octroi Bill</strong>
            </td>
        </tr>
    </table>
    <br />
    <table border="0" cellpadding="1" cellspacing="1" class="boxbg" width="800">
        <tr style="background-color: White">
            <td class="blackfnt" nowrap style="text-align: left; width: 133px;">
                &nbsp;Bill No
            </td>
            <td class="blackfnt" nowrap style="text-align: left; width: 228px;">
                <span style="color: #ff0000">&nbsp;&lt;System Generated&gt;</span>
            </td>
            <td class="blackfnt" nowrap style="text-align: left; width: 118px;">
                &nbsp;Bill Date
            </td>
            <td colspan="2" width="130" class="blackfnt" nowrap style="text-align: left">
                &nbsp;<asp:TextBox ID="txtBillDate" runat="server" onblur="javascript:ValidateDate(this)"
                    Width="80px" BorderStyle="Groove" CssClass="blackfnt" MaxLength="10"></asp:TextBox>
                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtBillDate,'anchor1','dd/MM/yyyy'); return false;"
                    id="anchor1" name="anchor1">
                    <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
            </td>
        </tr>
        <tr style="background-color: White">
            <td class="blackfnt" nowrap style="text-align: left; width: 133px;">
                &nbsp;Billing Party Code
            </td>
            <%--<td class="blackfnt"  nowrap style="text-align: left; width: 141px;">
            &nbsp;<asp:TextBox ID="txtPartyCode" runat="server" BorderStyle="Groove" CssClass="blackfnt" Width="80px"></asp:TextBox>
            <input id="btnPartyCode"  nowrap  type="button" value="..." runat="server" />
        </td>--%>
            <td nowrap style="text-align: left; width: 228px;">
                &nbsp;<asp:TextBox ID="txtPartyCode" runat="server" Width="200" BorderStyle="Groove"
                    CssClass="blackfnt" onblur="javascript:Customer_Location_Blur(this,'Customer','N')"></asp:TextBox>
                <!--onblur="javascript:VenDor_Vechicle_Blur(this,'Vendor','N')"-->
                <div id="Abc" runat="server" class="boxbg" />
                <%-- <atlas:AutoCompleteExtender ID="Ext1" runat="server"  DropDownPanelID="Abc" >
            <atlas:AutoCompleteProperties TargetControlID="txtPartyCode" ServicePath="../AtlasAutoComplete.asmx"                                         
            ServiceMethod="GetCustomer" MinimumPrefixLength="1" Enabled="true" />
            </atlas:AutoCompleteExtender>--%>
                <ajaxToolkit:AutoCompleteExtender ID="Ext1" runat="server" Enabled="True" MinimumPrefixLength="1"
                    ServiceMethod="GetCustomer" CompletionListItemCssClass="autocomplete_listItem"
                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../AtlasAutoComplete.asmx"
                    TargetControlID="txtPartyCode">
                </ajaxToolkit:AutoCompleteExtender>
                <%--<font class="redfnt" >Plz Type Initial Character OF Customer Name </font>--%>
            </td>
            <td class="blackfnt" nowrap style="text-align: left; width: 118px;">
                &nbsp;Billing Party Name
            </td>
            <td colspan="2" class="blackfnt" nowrap style="text-align: left">
                &nbsp;<strong><asp:Label ID="lblPartyName" nowrap runat="server"></asp:Label></strong>
            </td>
        </tr>
        <tr style="background-color: White">
            <td class="blackfnt" nowrap style="text-align: left; width: 133px;">
                &nbsp;Billing Party Address
            </td>
            <td colspan="4" class="blackfnt" nowrap style="text-align: left">
                &nbsp;<strong><asp:Label ID="lblPartyAdd" runat="server"></asp:Label></strong>
            </td>
        </tr>
        <tr style="background-color: White">
            <td style="text-align: left; width: 133px;" nowrap class="blackfnt">
                &nbsp;Prepared at location
            </td>
            <td class="blackfnt" style="text-align: left; width: 228px;">
                &nbsp;<strong><asp:Label ID="lblPreparedLoc" runat="server"></asp:Label></strong>
            </td>
            <td style="text-align: left; width: 118px;" nowrap class="blackfnt">
                &nbsp;Bill Submission At
            </td>
            <%--<td colspan="2" style="text-align: left"  nowrap  class="blackfnt"> 
            &nbsp;<asp:TextBox ID="txtBillSubAt" runat="server" MaxLength="10" Width="80"></asp:TextBox>
            <input id="btnBillSubAt" type="button" value="..." runat="server" />
            &nbsp;<span style="color: #ff0000"><asp:Label ID="lblBillSubAt" runat="server"></asp:Label></span>
      </td>--%>
            <td>
                &nbsp;<asp:TextBox ID="txtBillSubAt" runat="server" Width="200" BorderStyle="Groove"
                    CssClass="blackfnt"></asp:TextBox>
                <!--onblur="javascript:VenDor_Vechicle_Blur(this,'Vendor','N')"-->
                <div id="Div2" runat="server" class="boxbg" />
                <%--<atlas:autocompleteextender id="AutoCompleteExtender1" runat="server" dropdownpanelid="Abc">
            <atlas:AutoCompleteProperties TargetControlID="txtBillSubAt" ServicePath="../AtlasAutoComplete.asmx" 
                                ServiceMethod="GetLocation" MinimumPrefixLength="1" Enabled="true" />
            </atlas:autocompleteextender>--%>
                <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" Enabled="True"
                    MinimumPrefixLength="1" ServiceMethod="GetLocation" CompletionListItemCssClass="autocomplete_listItem"
                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../AtlasAutoComplete.asmx"
                    TargetControlID="txtBillSubAt">
                </ajaxToolkit:AutoCompleteExtender>
            </td>
        </tr>
        <tr style="background-color: White">
            <td style="text-align: left; width: 133px;" class="blackfnt">
                &nbsp;Prepared For Location
            </td>
            <td style="text-align: left; width: 228px;" class="blackfnt">
                &nbsp;<strong><asp:Label ID="lblPreparedFor" runat="server"></asp:Label></strong>
            </td>
            <td style="text-align: left; width: 118px;" class="blackfnt">
                &nbsp;Bill Collection At
            </td>
            <%--<td colspan="2" style="text-align: left" class="blackfnt"> 
            &nbsp;<asp:TextBox ID="txtBillColAt" runat="server" MaxLength="10" Width="80"></asp:TextBox>
            <input id="btnBillColAt" type="button" value="..." runat="server" />
            &nbsp;<span style="color: #ff0000"><asp:Label ID="lblBillColAt" runat="server"></asp:Label></span>
      </td>--%>
            <td>
                &nbsp;<asp:TextBox ID="txtBillColAt" runat="server" Width="200" BorderStyle="Groove"
                    CssClass="blackfnt"></asp:TextBox>
                <!--onblur="javascript:VenDor_Vechicle_Blur(this,'Vendor','N')"-->
                <div id="Div3" runat="server" class="boxbg" />
               <%-- <atlas:autocompleteextender id="AutoCompleteExtender2" runat="server" dropdownpanelid="Abc">
            <atlas:AutoCompleteProperties TargetControlID="txtBillColAt" ServicePath="../AtlasAutoComplete.asmx" 
                                ServiceMethod="GetLocation" MinimumPrefixLength="1" Enabled="true" />
            </atlas:autocompleteextender>--%>
            
            <ajaxToolkit:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" Enabled="True"
                    MinimumPrefixLength="1" ServiceMethod="GetLocation" CompletionListItemCssClass="autocomplete_listItem"
                    CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem" ServicePath="../AtlasAutoComplete.asmx"
                    TargetControlID="txtBillColAt">
                </ajaxToolkit:AutoCompleteExtender>
            
            </td>
        </tr>
        <tr style="background-color: White">
            <td class="blackfnt" style="text-align: left; width: 133px;">
                &nbsp;Bill Amount
            </td>
            <td align="left" style="width: 228px">
                &nbsp;<asp:TextBox ID="txtBillAmt" runat="server" Enabled="false" Width="80" MaxLength="10"
                    Text="0.00"></asp:TextBox>
            </td>
            <td align="left" style="width: 118px">
                &nbsp;Due Date
            </td>
            <td colspan="2" align="left">
                &nbsp;<asp:TextBox ID="txtDueDate" runat="server" onblur="javascript:ValidateDate(this)"
                    Width="80"></asp:TextBox>
                <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDueDate,'anchor2','dd/MM/yyyy'); return false;"
                    id="a1" name="anchor2">
                    <img alt="Cal" border="0" src="../../images/calendar.jpg" /></a>
            </td>
        </tr>
        <tr style="background-color: White">
            <td colspan="5" class="blackfnt" style="text-align: left; width: 186px;">
                <Oct:OctDetail ID="OctDetails" runat="server" />
            </td>
        </tr>
        <tr style="background-color: White">
            <td class="blackfnt" style="text-align: left; width: 133px;">
                &nbsp;Remarks
            </td>
            <td colspan="4" class="blackfnt" style="text-align: left;">
                &nbsp;<asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" MaxLength="250"
                    Width="250"></asp:TextBox>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <table cellspacing="1" class="boxbg" width="907">
        <tr class="bgbluegrey">
            <td align="center">
                <asp:Button ID="btnSubmit" runat="server" CssClass="blackfnt" OnClientClick="javascript:return CheckData();"
                    BorderStyle="Solid" BorderWidth="1px" Text="Confirm Bill Generation" Width="150px"
                    OnClick="btnSubmit_Click" />
            </td>
        </tr>
    </table>
    <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>
</asp:Content>

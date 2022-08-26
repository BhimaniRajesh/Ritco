<%@ Page Title="" Language="C#" MasterPageFile="~/GUI/MasterPage.master" AutoEventWireup="true"
    CodeFile="GRN_DetailList.aspx.cs" Inherits="GUI_Finance_GeneralizedPO_GRNGeneration_GRN_DetailList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">

    <script type="text/javascript" language="JavaScript" src="./../../../Images/CalendarPopup.js"></script>

    <script language="JavaScript" type="text/javascript">
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
function getDateDiff(fromDate, toDate, DateParam) 
{
    var retVal = 0;
    if (DateParam.toUpperCase() == "DAY") 
    {
        var day = 1000 * 60 * 60 * 24;
        retVal = Math.ceil((fromDate.getTime() - toDate.getTime()) / (day));
    }
    else if (DateParam.toUpperCase() == "HH") 
    {
        var hours = 1000 * 60 * 60;
        retVal = Math.floor((fromDate.getTime() - toDate.getTime()) / (hours));
    }
    else if (DateParam.toUpperCase() == "MM") 
    {
        var mins = 1000 * 60;
        retVal = Math.floor((fromDate.getTime() - toDate.getTime()) / (mins));
    }
    else if (DateParam.toUpperCase() == "SS") 
    {
        var secs = 1000;
        retVal = Math.floor((fromDate.getTime() - toDate.getTime()) / (secs));
    }
    return retVal;
}    		
function Submit()
{    
    var grid=document.getElementById("ctl00_MyCPH1_GV_Booking");
    var rows=grid.rows.length;      // "ctl00$MyCPH1$GV_Booking"
    var arrstr="";
    var q ="n";
//    var Check_One="Y"
    for(var b=2;b<=rows;b++)
    {
        if(b<10)
        {
            GV_FRM_NM="ctl00_MyCPH1_GV_Booking_ctl0" + b + "_";
        }
        else
        {
             GV_FRM_NM="ctl00_MyCPH1_GV_Booking_ctl" + b + "_";
        }
//        if(document.getElementById(GV_FRM_NM+"chksrno").checked)
//        {
//            Check_One="Y"
//        }
    }
    if(!BalanceCheck())
    {
        return false;
    }
//    if(Check_One=="N")
//    {
//       alert("Select atleast One Record")
//       return false;
//    }
    if(document.getElementById("ctl00_MyCPH1_txtChallandt").value== "")
    {
        alert("Please Enter GRN date")
        document.getElementById("ctl00_MyCPH1_txtChallandt").focus();
        return false;
    }
    if(document.getElementById("ctl00_MyCPH1_txtReceiveDt").value== "")
    {
        alert("Please Enter Received date")
        document.getElementById("ctl00_MyCPH1_txtReceiveDt").focus();
        return false;
    }
//    if(!BalanceCheck())
//    {
//        return false;
//    }               
    document.getElementById("ctl00_MyCPH1_ON_Submit").style.display="none"		
    return true
}

function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}
function ENABLED_WT(chkpkg)
{
    rowid=chkpkg.getAttribute('ID').substring(27,29)
    HidQty=document.getElementById("ctl00_MyCPH1_GV_Booking_ctl" + rowid +"_HidQty");    
    TxtQty=document.getElementById("ctl00_MyCPH1_GV_Booking_ctl" + rowid +"_txtQty");
    TxtBalQty=document.getElementById("ctl00_MyCPH1_GV_Booking_ctl" + rowid +"_txtBalQty");
    
    if (parseFloat(TxtQty.value)>=0)
    {
        if(parseFloat(HidQty.value)< parseFloat(TxtQty.value))
        {
            alert("Received Qty is not More then Ordered Qty ")
            TxtQty.disabled=false;                  
            TxtQty.value=HidQty.value;            
        }
        else 
        {
            TxtBalQty.value = HidQty.value - TxtQty.value
            TxtQty.disabled=false;
        }        
    }
    else 
    {
        alert("Received Qty Can Be Greater then Zero")                          
        TxtQty.value=HidQty.value;                
    }
}
function getDateObj(strDate) 
{
    var arrDT = strDate.split('/');
    var nDate = parseDate(arrDT[1] + "/" + arrDT[0] + "/" + arrDT[2]);
    return nDate;
}
function ValidateDate(obj)
{
    if (obj.value!="")
    {        
	    if (isDate(obj.value)==false)
	    {   	
		    obj.focus()
		    return false
	    }
	    var SelectedEDDDate = getDateObj(obj.value);
	    var SysDate=document.getElementById("ctl00_MyCPH1_HidSysDate").value;
	    var SysDT= getDateObj(SysDate);
	    var gvList=document.getElementById("ctl00_MyCPH1_GV_Booking")
	    var eDate=document.getElementById("ctl00_MyCPH1_txtReceiveDt")
	    var gvList_id="ctl00_MyCPH1_GV_Booking"
	    for (i = 2; i <= gvList.rows.length; i++) 
        {
            var str_Index = "";
            if (i < 10) 
                str_Index = "0" + i; 
            else 
                str_Index = i;
            
            var pref = gvList_id + "_ctl" + str_Index + "_";
            var HidPdate = getDateObj(document.getElementById(pref + "HidPdate").value);            
            if (getDateDiff(SelectedEDDDate, HidPdate, "DAY") < 0) 
            {
                alert("Recevied Date Should be Greater then PO Date:" + HidPdate.localeFormat("dd/MM/yyyy"));
                eDate.value = SysDate;
                eDate.focus();
                return false;
            }
            if (getDateDiff(SelectedEDDDate, SysDT, "DAY") > 0) 
            {
                alert("Recevied Date Should be Less then System Date: " + SysDT.localeFormat("dd/MM/yyyy"));
                eDate.value = SysDate;
                eDate.focus();
                return false;
            }           
        }
        return true
    }
}    
function ValidateGRNDate(obj)
{
    if (obj.value!="")
    {        
	    if (isDate(obj.value)==false)
	    {   	
		    obj.focus()
		    return false
	    }
	    var SelectedEDDDate = getDateObj(obj.value);
	    var SysDate=document.getElementById("ctl00_MyCPH1_HidSysDate").value;
	    var SysDT= getDateObj(SysDate);
	    var gvList=document.getElementById("ctl00_MyCPH1_GV_Booking")
	    var eDate=document.getElementById("ctl00_MyCPH1_txtChallandt")
	    var gvList_id="ctl00_MyCPH1_GV_Booking"
	    for (i = 2; i <= gvList.rows.length; i++) 
        {
            var str_Index = "";
            if (i < 10) 
                str_Index = "0" + i; 
            else 
                str_Index = i;
            
            var pref = gvList_id + "_ctl" + str_Index + "_";
            var HidPdate = getDateObj(document.getElementById(pref + "HidPdate").value);            
            if (getDateDiff(SelectedEDDDate, HidPdate, "DAY") < 0) 
            {
                alert("GRN Date Should be Greater then PO Date: " + HidPdate.localeFormat("dd/MM/yyyy"));
                eDate.value = SysDate;
                eDate.focus();
                return false;
            }
            if (getDateDiff(SelectedEDDDate, SysDT, "DAY") > 0) 
            {
                alert("GRN Date Should be Less then System Date: " + SysDT.localeFormat("dd/MM/yyyy"));
                eDate.value = SysDate;
                eDate.focus();
                return false;
            }           
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

function closeAlert()
{
    document.getElementById("ctl00_MyCPH1_progressBackgroundFilter").style.display="none";
    document.getElementById("ctl00_MyCPH1_processMessage").style.display="none";
    return false;
}
function BalanceCheck() 
{
    var dgGeneral = document.getElementById("ctl00_MyCPH1_GV_Booking");
    var rows, Prefix, chkRights,hidQty,EditQty,ctlhidQty,ctlEditQty ;
    
    if (dgGeneral != null) 
    {
        rows = dgGeneral.rows.length;
        for (i = 0; i < rows - 1; i++) 
        {
            j = i + 2;
            if (j < 10) 
            {
                Prefix = "ctl00_MyCPH1_GV_Booking_ctl0" + j;
            }
            else 
            {
                Prefix = "ctl00_MyCPH1_GV_Booking_ctl" + j;
            }
            //chkSelect = document.getElementById(Prefix + "_chksrno");
//            if (chkSelect.checked)
//            {
                ctlhidQty = document.getElementById(Prefix+"_HidQty");
                ctlEditQty = document.getElementById(Prefix+"_txtQty");
                if (parseFloat(ctlhidQty.value) < parseFloat(ctlEditQty.value))
                {                    
                    alert("You can not enter Quantity more then Balance Quantity");
                    ctlEditQty.value = ctlhidQty.value;
                    ctlEditQty.focus();
                    return false;
                }
//            }                
        }
    }
    return true;
}
function ENABLED_ALLFIELDS(chkval)
{
    rowid=chkval.getAttribute('ID').substring(27,29)
    arpkg=document.getElementById("ctl00_MyCPH1_GV_Booking_ctl" + rowid +"_txtQty");    
    if(chkval.checked==true)
    {
        arpkg.disabled=false;
    }
    else
    {
        arpkg.disabled=true;        
    }
}
    </script>

    <%--<asp:UpdateProgress ID="uppMain" runat="server">
        <ProgressTemplate>
            <iframe frameborder="0" src="about:blank" style="border: 0px; position: absolute;
                z-index: 9; left: 0px; top: 0px; width: expression(this.offsetParent.scrollWidth);
                height: expression(this.offsetParent.scrollHeight); filter: progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);">
            </iframe>
            <div style="position: absolute; z-index: 10; left: expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);
                top: expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);">
                <img src="../../../images/loading.gif" alt="" /><font face="verdana" color="blue"
                    size="4">&nbsp;<b>Please Wait...</b></font>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>--%>
    <%--<asp:UpdatePanel ID="up3" runat="server">
        <ContentTemplate>--%>
            <br />
            <div align="left" style="width: 9.5in;">
                <table cellspacing="1" width="100%" class="boxbg" border="0">
                    <tr class="bgbluegrey">
                        <td colspan="6" align="center">
                            <asp:Label ID="lblQry" CssClass="blackfnt" Font-Bold="true" runat="server">
                                Update GRN Details
                            </asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left">
                            <asp:Label ID="Label4" CssClass="blackfnt" Text="GRN Number" runat="server" ></asp:Label>
                        </td>
                        <td align="left">
                            <asp:Label ID="Label5" CssClass="redfnt" Font-Bold="true" Text="<..System Generated..>" runat="server" ></asp:Label>
                        </td>
                        <td align="left" >
                            <asp:Label ID="lblChallanNo" CssClass="blackfnt" Text="GRN Location" runat="server"></asp:Label>
                        </td>
                        <td align="left" >
                            <asp:Label ID="lblGRNLoc" runat="server" Font-Bold="true"></asp:Label>
                        </td>
                        <td align="left" >
                            <asp:Label ID="lbl" CssClass="blackfnt" Text="GRN Date" runat="server"></asp:Label>
                        </td>
                        <td align="left" >
                            <asp:HiddenField ID="HidSysDate" runat="server" />
                            <asp:TextBox ID="txtChallandt" Width="70px" runat="server" onblur="javascript:return ValidateGRNDate(this);"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00_MyCPH1_txtChallandt, 'alnkdt', 'dd/MM/yyyy'); return false;"
                                id="alnkdt">
                                <img src="../../../images/calendar.jpg" border="0" alt="" />
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" >
                            <asp:Label ID="Label1" CssClass="blackfnt" Text="PO Number" runat="server"></asp:Label>
                        </td>
                        <td align="left" >
                            <asp:Label ID="LblPONo" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:Label>
                        </td>
                        <td align="left"  >
                            <asp:Label ID="Label7" CssClass="blackfnt" Text="PO Date" runat="server"></asp:Label>
                        </td>
                        <td align="left" >
                            <asp:Label ID="LblPODate" runat="server" Font-Bold="true"></asp:Label>
                        </td>
                        <td align="left"  >
                            <asp:Label ID="Label9" CssClass="blackfnt" Text="Vendor" runat="server" ></asp:Label>
                        </td>
                        <td align="left" >
                            <asp:Label ID="LblVendor" runat="server" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <tr style="background-color: white">
                        <td align="left" >
                            <asp:Label ID="Label6" CssClass="blackfnt" Text="Manual PO Number" runat="server"></asp:Label>
                        </td>
                        <td align="left" >
                            <asp:Label ID="LblManualPONo" CssClass="blackfnt" Font-Bold="true" runat="server"></asp:Label>
                        </td>
                        <td align="left"  >
                            <asp:Label ID="Label10" CssClass="blackfnt" Text="PO Type" runat="server" ></asp:Label>
                        </td>
                        <td align="left" >
                            <asp:Label ID="LblPOType" runat="server" Font-Bold="true"></asp:Label>
                        </td>
                        <td align="left"  >
                            <asp:Label ID="Label12" CssClass="blackfnt" Text="PO Amount" runat="server" ></asp:Label>
                        </td>
                        <td align="left" >
                            <asp:Label ID="LblPOAmount" runat="server" Font-Bold="true"></asp:Label>
                        </td>
                    </tr>
                    <%--<tr style="background-color: white">
                        <td align="left" width="15%">
                            <asp:Label ID="LblReceivedDT" CssClass="blackfnt" Text="Received Date" Visible="true" runat="server"
                                ></asp:Label>
                        </td>
                        <td width="45%">
                            <asp:TextBox ID="txtReceiveDt" Width="80px" runat="server" onblur="javascript:return ValidateDate(this);"></asp:TextBox>
                            <a href="#" onclick="cal.select(ctl00_MyCPH1_txtReceiveDt, 'a1', 'dd/MM/yyyy'); return false;"
                                id="a1">
                                <img src="../../../images/calendar.jpg" border="0" alt="" />
                        </td>
                    </tr>--%>
                    <tr style="background-color: white">
                        <td >
                            <asp:Label ID="Label2" CssClass="blackfnt" Text="Manual GRN No" runat="server"></asp:Label>
                        </td>
                        <td  >
                            <asp:TextBox ID="txtMNGRNno" MaxLength="6" Width="100px" runat="server"></asp:TextBox>
                        </td>
                        <td  >
                            <asp:Label ID="Label3" CssClass="blackfnt" Text="Remark" runat="server"></asp:Label>
                        </td>
                        <td colspan="3">
                            <asp:TextBox ID="txtRemark" runat="server" TextMode="MultiLine" Width="300px"></asp:TextBox>
                        </td>
                    </tr>
                    <%--<tr style="background-color: white">
                        <td align="left" >
                            <asp:Label ID="lblGateEntryNo" CssClass="blackfnt" Text="Payment Locaiton" runat="server"
                                ></asp:Label>
                        </td>
                        <td align="left" >
                            <asp:TextBox ID="txtPayLoc" Width="80px" runat="server" ></asp:TextBox>
                            <ajaxToolkit:AutoCompleteExtender ID="extLocation" runat="server" Enabled="True"
                                CompletionListItemCssClass="autocomplete_listItem" CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                                MinimumPrefixLength="1" ServiceMethod="GetLocation" ServicePath="../AtlasAutoComplete.asmx"
                                TargetControlID="txtPayLoc">
                            </ajaxToolkit:AutoCompleteExtender>
                        </td>
                    </tr>--%>
                </table>
                <br />
                <asp:GridView ID="GV_Booking" runat="server" align="left" BorderWidth="1" CellPadding="2"
                    HeaderStyle-CssClass="bgbluegrey" PagerStyle-HorizontalAlign="left" CssClass="boxbg"
                    BackColor="white" FooterStyle-CssClass="boxbg" AllowPaging="true" PageSize="25"
                    AllowSorting="false" AutoGenerateColumns="false" ShowFooter="false" PagerSettings-FirstPageText="[First]"
                    PagerSettings-LastPageText="[Last]" EmptyDataText="No Records Found...">
                    <PagerStyle VerticalAlign="Bottom" />
                    <Columns>
                        <asp:BoundField DataField="Item_Code" ItemStyle-Wrap="true" HeaderText="Material Details"
                            HeaderStyle-Font-Bold="true">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Item_Desc" ItemStyle-Wrap="true" HeaderText="Description"
                            HeaderStyle-Font-Bold="true">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="OrderQTY" ItemStyle-Wrap="true" HeaderText="PO Quantity"
                            HeaderStyle-Font-Bold="true">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="rate" ItemStyle-Wrap="true" HeaderText="Rate" HeaderStyle-Font-Bold="true">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ReceivedQTY" ItemStyle-Wrap="true" HeaderText="Received Qty (Till Date)"
                            HeaderStyle-Font-Bold="true">
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" CssClass="blackfnt" />
                            <ItemStyle Width="150" Wrap="False" HorizontalAlign="Center" CssClass="blackfnt" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderStyle-Font-Bold="true" HeaderText="Received Qty (Current GRN)"
                            HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:TextBox ID="txtQty" runat="server" Enabled="true" OnChange="Javascript:return ENABLED_WT(this);"
                                    Text='<%#DataBinder.Eval(Container.DataItem, "BalanceQty") %>' Width="50"></asp:TextBox>
                                <asp:HiddenField ID="HidQty" runat="server" Value='<%#DataBinder.Eval(Container.DataItem, "BalanceQty") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-Font-Bold="true" HeaderText="Pending Qty" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:TextBox ID="txtBalQty" runat="server" Enabled="False" Text="0" Width="50"></asp:TextBox>
                                <asp:HiddenField ID="HDNNarration" runat="server" Value='<%#DataBinder.Eval(Container.DataItem, "narration") %>' />
                                <asp:HiddenField ID="HidPoSrno" runat="server" Value='<%#DataBinder.Eval(Container.DataItem, "srno") %>' />
                                <asp:HiddenField ID="HidPdate" runat="server" Value='<%#DataBinder.Eval(Container.DataItem, "Pdate") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
            <br />
            <div align="left" style="width: 9.5in;">
                <table border="0" cellpadding="1" width="100%" cellspacing="0" align="center"
                    id="ON_Submit" runat="server">
                    <tr class="bgbluegrey">
                        <td align="center">
                            <asp:Button ID="btn_csv" Text="Submit" CssClass="blackfnt" runat="server" Width="170"
                                OnClick="btn_csv_Click" OnClientClick="javascript:return Submit();" />
                        </td>
                    </tr>
                </table>
            </div>
            <div align="left" id="progressBackgroundFilter" runat="server" class="progressBackgroundFilter">
                <br />
            </div>
            <div id="processMessage" runat="server" class="processMessage" align="left">
                <div style="width: 6in; height: 4in;">
                    <table class="boxbg" cellspacing="0" width="100%">
                        <tr class="bgbluegrey">
                            <td>
                                Message
                            </td>
                        </tr>
                        <tr class="blackfnt">
                            <td>
                                <table width="100%">
                                    <tr bgcolor="white">
                                        <td>
                                            <asp:Label ID="lblalert" runat="server" CssClass="blackfnt"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr bgcolor="white">
                                        <td align="center">
                                            <asp:Button ID="btnalertclose" Font-Bold="true" onmouseover="this.style.cursor='pointer'"
                                                runat="server" OnClientClick="javascript:return closeAlert();" Width="50px" Text="OK"
                                                CssClass="ebtn"></asp:Button>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
                z-index: 99;">
            </div>
            <div id="Div1" style="position: absolute; visibility: hidden; background-color: white;
                layer-background-color: white; z-index: 99;">
            </div>
        <%--</ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>

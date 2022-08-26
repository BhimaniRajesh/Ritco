<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="TreadDepthVehicleWise.aspx.cs" Inherits="TYRE1_MountTyre" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<script language="javascript">
    function numeric(e) 
    {
        return ((e.keyCode == 8) || (e.keyCode == 110) || (e.keyCode == 190) || (e.keyCode > 47 && e.keyCode <58)||(e.keyCode > 95 && e.keyCode <106) || (e.keyCode == 9) || (e.keyCode == 46));  
    }
    function func()
    {
    }
    function toFixed(value, precision)
    {
        var power = Math.pow(10, precision || 0);
        return String(Math.round(value * power) / power);
    }
    function CalculateAvg1(txtTWI1,txtTWI2,txtTWI3,lblAvgTWI,hfTyreNo,hfOldTDMAvg)
    {
        var avg = "";
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        var str_Index = "";
        if (txtTWI1.value == "")
        {
            txtTWI1.value="";
            return;
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
                            avg = ((parseFloat(txtTWI1.value) + parseFloat(txtTWI2.value) + parseFloat(txtTWI3.value)) / 3).toFixed(2);
                            if(avg > parseFloat(hfOldTDMAvg.value))
                            {
                                alert("Average TWI should be less than Purchase  Average TWI.");
                                lblAvgTWI.value="0.00";
                                txtTWI1.value="0.00";
                                txtTWI1.focus();
                                return false;
                            }
                            //else
                            {
                                txtTWI1.value=(parseFloat(txtTWI1.value)).toFixed(2);
                                txtTWI2.value=(parseFloat(txtTWI2.value)).toFixed(2);
                                txtTWI3.value=(parseFloat(txtTWI3.value)).toFixed(2);
                                lblAvgTWI.innerText = avg.toString();
                            }
                    }
                    else
                    {
                        if(parseFloat(txtTWI1.value) >= parseFloat(returnValue[1]))
                        {
                           alert("TWI1 is must be less than previous TWI1 for the Tyre Number : " +hfTyreNo.value); 
                           txtTWI1.value = "0.00";
                           txtTWI1.focus();
                           return false;
                        }
                        else
                        {
                            avg = ((parseFloat(txtTWI1.value) + parseFloat(txtTWI2.value) + parseFloat(txtTWI3.value)) / 3).toFixed(2);
                            lblAvgTWI.innerText = avg.toString();
                        }
                        if(parseFloat(txtTWI2.value) >= parseFloat(returnValue[2]))
                        {
                           alert("TWI2 is must be less than previous TWI2 for the Tyre Number : " +hfTyreNo.value); 
                           txtTWI2.value = "0.00";
                           txtTWI2.focus();
                           return false;
                        }
                        else
                        {
                            avg = ((parseFloat(txtTWI1.value) + parseFloat(txtTWI2.value) + parseFloat(txtTWI3.value)) / 3).toFixed(2);
                            lblAvgTWI.innerText = avg.toString();
                        }
                        if(parseFloat(txtTWI3.value) >= parseFloat(returnValue[3]))
                        {
                           alert("TWI3 is must be less than previous TWI3 for the Tyre Number : " +hfTyreNo.value); 
                           txtTWI3.value = "0.00";
                           txtTWI3.focus();
                           return false;
                        }
                        else
                        {
                            avg = ((parseFloat(txtTWI1.value) + parseFloat(txtTWI2.value) + parseFloat(txtTWI3.value)) / 3).toFixed(2);
                            lblAvgTWI.innerText = avg.toString();
                        }
                        txtTWI1.value=(parseFloat(txtTWI1.value)).toFixed(2);
                        txtTWI2.value=(parseFloat(txtTWI2.value)).toFixed(2);
                        txtTWI3.value=(parseFloat(txtTWI3.value)).toFixed(2);
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckTWI&datetime="+currentTime+"&TyreID=" + hfTyreNo.value+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }
    }
    function CalculateAvg3(txtTWI1,txtTWI2,txtTWI3,lblAvgTWI,hfTyreNo,hfOldTDMAvg)
    {
        var avg = "";
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        var str_Index = "";
        if (txtTWI1.value == "")
        {
            txtTWI1.value="";
            return;
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
                            avg = ((parseFloat(txtTWI1.value) + parseFloat(txtTWI2.value) + parseFloat(txtTWI3.value)) / 3).toFixed(2);
                            if(avg > parseFloat(hfOldTDMAvg.value))
                            {
                                alert("Average TWI should be less than Purchase  Average TWI.");
                                lblAvgTWI.value="0.00";
                                txtTWI3.value="0.00";
                                txtTWI3.focus();
                                return false;
                            }
                            //else
                            {
                                txtTWI1.value=(parseFloat(txtTWI1.value)).toFixed(2);
                                txtTWI2.value=(parseFloat(txtTWI2.value)).toFixed(2);
                                txtTWI3.value=(parseFloat(txtTWI3.value)).toFixed(2);
                                lblAvgTWI.innerText = avg.toString();
                            }
                    }
                    else
                    {
                        if(parseFloat(txtTWI1.value) >= parseFloat(returnValue[1]))
                        {
                           alert("TWI1 is must be less than previous TWI1 for the Tyre Number : " +hfTyreNo.value); 
                           txtTWI1.value = "0.00";
                           txtTWI1.focus();
                           return false;
                        }
                        else
                        {
                            avg = ((parseFloat(txtTWI1.value) + parseFloat(txtTWI2.value) + parseFloat(txtTWI3.value)) / 3).toFixed(2);
                            lblAvgTWI.innerText = avg.toString();
                        }
                        if(parseFloat(txtTWI2.value) >= parseFloat(returnValue[2]))
                        {
                           alert("TWI2 is must be less than previous TWI2 for the Tyre Number : " +hfTyreNo.value); 
                           txtTWI2.value = "0.00";
                           txtTWI2.focus();
                           return false;
                        }
                        else
                        {
                            avg = ((parseFloat(txtTWI1.value) + parseFloat(txtTWI2.value) + parseFloat(txtTWI3.value)) / 3).toFixed(2);
                            lblAvgTWI.innerText = avg.toString();
                        }
                        if(parseFloat(txtTWI3.value) >= parseFloat(returnValue[3]))
                        {
                           alert("TWI3 is must be less than previous TWI3 for the Tyre Number : " +hfTyreNo.value); 
                           txtTWI3.value = "0.00";
                           txtTWI3.focus();
                           return false;
                        }
                        else
                        {
                            avg = ((parseFloat(txtTWI1.value) + parseFloat(txtTWI2.value) + parseFloat(txtTWI3.value)) / 3).toFixed(2);
                            lblAvgTWI.innerText = avg.toString();
                        }
                        txtTWI1.value=(parseFloat(txtTWI1.value)).toFixed(2);
                        txtTWI2.value=(parseFloat(txtTWI2.value)).toFixed(2);
                        txtTWI3.value=(parseFloat(txtTWI3.value)).toFixed(2);
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckTWI&datetime="+currentTime+"&TyreID=" + hfTyreNo.value+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }
    }
    function CalculateAvg2(txtTWI1,txtTWI2,txtTWI3,lblAvgTWI,hfTyreNo,hfOldTDMAvg)
    {
        var avg = "";
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        var str_Index = "";
        if (txtTWI1.value == "")
        {
            txtTWI1.value="";
            return;
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
                            avg = ((parseFloat(txtTWI1.value) + parseFloat(txtTWI2.value) + parseFloat(txtTWI3.value)) / 3).toFixed(2);
                            if(avg > parseFloat(hfOldTDMAvg.value))
                            {
                                
                                alert("Average TWI should be less than Purchase  Average TWI.");
                                lblAvgTWI.value="0.00";
                                txtTWI2.value="0.00";
                                txtTWI2.focus();
                                return false;
                            }
                            //else
                            {
                                txtTWI1.value=(parseFloat(txtTWI1.value)).toFixed(2);
                                txtTWI2.value=(parseFloat(txtTWI2.value)).toFixed(2);
                                txtTWI3.value=(parseFloat(txtTWI3.value)).toFixed(2);
                                lblAvgTWI.innerText = avg.toString();
                            }
                    }
                    else
                    {
                        if(parseFloat(txtTWI1.value) >= parseFloat(returnValue[1]))
                        {
                           alert("TWI1 is must be less than previous TWI1 for the Tyre Number : " +hfTyreNo.value); 
                           txtTWI1.value = "0.00";
                           txtTWI1.focus();
                           return false;
                        }
                        else
                        {
                            avg = ((parseFloat(txtTWI1.value) + parseFloat(txtTWI2.value) + parseFloat(txtTWI3.value)) / 3).toFixed(2);
                            lblAvgTWI.innerText = avg.toString();
                        }
                        if(parseFloat(txtTWI2.value) >= parseFloat(returnValue[2]))
                        {
                           alert("TWI2 is must be less than previous TWI2 for the Tyre Number : " +hfTyreNo.value); 
                           txtTWI2.value = "0.00";
                           txtTWI2.focus();
                           return false;
                        }
                        else
                        {
                            avg = ((parseFloat(txtTWI1.value) + parseFloat(txtTWI2.value) + parseFloat(txtTWI3.value)) / 3).toFixed(2);
                            lblAvgTWI.innerText = avg.toString();
                        }
                        if(parseFloat(txtTWI3.value) >= parseFloat(returnValue[3]))
                        {
                           alert("TWI3 is must be less than previous TWI3 for the Tyre Number : " +hfTyreNo.value); 
                           txtTWI3.value = "0.00";
                           txtTWI3.focus();
                           return false;
                        }
                        else
                        {
                            avg = ((parseFloat(txtTWI1.value) + parseFloat(txtTWI2.value) + parseFloat(txtTWI3.value)) / 3).toFixed(2);
                            lblAvgTWI.innerText = avg.toString();
                        }
                        txtTWI1.value=(parseFloat(txtTWI1.value)).toFixed(2);
                        txtTWI2.value=(parseFloat(txtTWI2.value)).toFixed(2);
                        txtTWI3.value=(parseFloat(txtTWI3.value)).toFixed(2);
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckTWI&datetime="+currentTime+"&TyreID=" + hfTyreNo.value+"&ConnStr="+ConnStr, false);
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
    function checkVehNo(txtVehNo,hfVehIntId,txtKm)
    {
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        var str_Index = "";
        if (txtVehNo.value == "")
        {
            txtVehNo.value="";
            hfVehIntId.value="";
            txtKm.value="";
            return;
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
                        alert("Invalid Vehicle Number");
                        txtVehNo.value="";
                        hfVehIntId.value="";
                        txtKm.value="";
                        txtVehNo.focus();
                    }
                    else
                    {
                        txtVehNo.value=returnValue[1];
                        hfVehIntId.value=returnValue[2];
                        txtKm.value=returnValue[3];
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckValidVehNoRotate&datetime="+currentTime+"&VehNo=" + txtVehNo.value+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }	
    }
    function CheckValidShow()
    {
        if(document.getElementById("<%=txtVehNo.ClientID %>").value =="")
        {
            alert("Enter Vehicle Number !!!");
            document.getElementById("<%=txtVehNo.ClientID %>").focus();
            return false;
        }
    }
    
    function CheckValid()
    {
        var date = new Date()
        date = date.getDate()+ "/" + (parseInt(date.getMonth())+ 1).toString() + "/"+ date.getFullYear();
        var controlIdPrefix = "ctl00_MyCPH1_";
        var txtTDMDate=document.getElementById(controlIdPrefix + "txtTDMDate");
        var tot_rows=document.getElementById(controlIdPrefix + "gvTreadDepth").rows.length;
        var txtTWI1="";
        var txtTWI2="";
        var txtTWI3="";
        if(txtTDMDate.value == "")
        {
            alert("Enter Tread Depth Measurement Date !!!");
            txtTDMDate.focus();
            return false;
        }
        else
        {
            if(!isDate(txtTDMDate.value,"dd/mm/yyyy"))
            {
                alert("Please Enter Valid date !!!");
                txtTDMDate.value="";
                txtTDMDate.focus();
                return false;
            }
            else
            {
                if(compareDates(txtTDMDate.value,"dd/mm/yyyy",date,"d/m/yyyy") == "1")
                {
                    alert("Tread Depth Measurement date should not be greater than today date !!!");
                    txtTDMDate.focus();
                    return false;
                }
            }
        }
        
        if(tot_rows>0)
        {
            for(i=0;i< tot_rows-1;i++)
            {  
                j=i+2
                var pref="";
                if(j<10)
                {
                    pref = "ctl00_MyCPH1_gvTreadDepth_ctl0" + j + "_";
                }                                       
                else
                {         
                    pref = "ctl00_MyCPH1_gvTreadDepth_ctl" + j + "_";
                }   
                
                txtTWI1=document.getElementById(pref + "txtTWI1");
                if(txtTWI1.value=="0.00")
                {
                    alert("TWI1 value must be greater than 0 at row no " + j + " !!!");
                    txtTWI1.focus();
                    return false;
                }
                txtTWI2=document.getElementById(pref + "txtTWI2");
                if(txtTWI2.value=="0.00")
                {
                    alert("TWI2 value must be greater than 0 at row no " + j + " !!!");
                    txtTWI2.focus();
                    return false;
                }
                txtTWI3=document.getElementById(pref + "txtTWI3");
                if(txtTWI3.value=="0.00")
                {
                    alert("TWI3 value must be greater than 0 at row no " + j + " !!!");
                    txtTWI3.focus();
                    return false;
                }
            }
        }
    }
</script>

<script language="javascript">
  function ValidateDate(obj) 
    {
        if (obj.value != "") 
        {
            if (isDate(obj.value) == false) 
            {
                obj.focus();
                return false;
            }
            return true;
        }
    }
    var dtCh = "/";
    var minYear = "1900";
    var maxYear = "2100";
    function DaysArray(n)
    {
        for (var i = 1; i <= n; i++) 
        {
            this[i] = 31
            if (i == 4 || i == 6 || i == 9 || i == "11") { this[i] = 30 }
            if (i == 2) { this[i] = 29 }
        }
        return this;
    }
    function isDate(dtStr) 
    {
        var daysInMonth = DaysArray(12)
        var pos1 = dtStr.indexOf(dtCh)
        var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
        var strDay = dtStr.substring(0, pos1)
        var strMonth = dtStr.substring(pos1 + 1, pos2)
        var strYear = dtStr.substring(pos2 + 1)
        strYr = strYear
        if (strDay.charAt(0) == "0" && strDay.length > 1) strDay = strDay.substring(1)
        if (strMonth.charAt(0) == "0" && strMonth.length > 1) strMonth = strMonth.substring(1)
        for (var i = 1; i <= 3; i++) {
            if (strYr.charAt(0) == "0" && strYr.length > 1) strYr = strYr.substring(1)
        }

        month = parseInt(strMonth)
        day = parseInt(strDay)
        year = parseInt(strYr)
        if (pos1 == -1 || pos2 == -1) {
            alert("The date format should be : dd/mm/yyyy");
            return false;
        }
        if (strMonth.length < 1 || month < 1 || month > 12) {
            alert("Please enter a valid month");
            return false;
        }
        if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) {
            alert("Please enter a valid day");
            return false;
        }
        if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) {
            alert("Please enter a valid 4 digit year between " + minYear + " and " + maxYear);
            return false;
        }

        if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
            alert("Please enter a valid date");
            return false;
        }
        return true;
    }
</script>
<asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
                    <table cellspacing="1" class="boxbg" style="width: 60%">
                        <tr style="background-color: white">
                            <td align="right" colspan="3" style="text-align: right; height: 31px;">
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/GUI/images/back.gif"
                                    OnClick="ImageButton1_Click" /></td>
                        </tr>
                        <tr >
                            <td align="right" colspan="3" style="font-weight: bold; height: 27px; text-align: left">
                                Tread Depth Measurement</td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="right" style="width: 17%; text-align: left; vertical-align: top; height: 41px;">
                <asp:Label ID="Label1" runat="server" Text="Enter Vehicle Number:"></asp:Label></td>
                            <td align="left" colspan="2" style="width: 75%; vertical-align: bottom; height: 41px;">
                <asp:TextBox ID="txtVehNo" CssClass="input" runat="server" Width="140px" AutoCompleteType="Notes"></asp:TextBox>
                <asp:Button ID="btnPopupVehno" runat="server" Text="..." Width="21px" />
                <asp:Panel ID="Panel1" runat="server" Height="1px" ScrollBars="Both" Width="1px">
                                </asp:Panel>
                <ajaxToolkit:AutoCompleteExtender
                runat="server" 
                BehaviorID="AutoCompleteEx"
                ID="autoComplete1" 
                TargetControlID="txtVehNo"
                ServicePath="~/GUI/services/WebService.asmx" 
                ServiceMethod="GetVehNo"
                MinimumPrefixLength="1" 
                CompletionInterval="1000"
                EnableCaching="true"
                CompletionSetCount="20"
                CompletionListCssClass="autocomplete_completionListElement" 
                CompletionListItemCssClass="autocomplete_listItem" 
                CompletionListHighlightedItemCssClass="autocomplete_highlightedListItem"
                DelimiterCharacters=";, :"
                ShowOnlyCurrentWordInCompletionListItem="true" >
                <Animations>
                    <OnShow>
                        <Sequence>
                            <%-- Make the completion list transparent and then show it --%>
                            <OpacityAction Opacity="0" />
                            <HideAction Visible="true" />
                            
                            <%--Cache the original size of the completion list the first time
                                the animation is played and then set it to zero --%>
                            <ScriptAction Script="
                                // Cache the size and setup the initial size
                                var behavior = $find('AutoCompleteEx');
                                if (!behavior._height) {
                                    var target = behavior.get_completionList();
                                    behavior._height = target.offsetHeight - 2;
                                    target.style.height = '0px';
                                }" />
                            
                            <%-- Expand from 0px to the appropriate size while fading in --%>
                            <Parallel Duration=".4">
                                <FadeIn />
                                <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx')._height" />
                            </Parallel>
                        </Sequence>
                    </OnShow>
                    <OnHide>
                        <%-- Collapse down to 0px and fade out --%>
                        <Parallel Duration=".4">
                            <FadeOut />
                            <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx')._height" EndValue="0" />
                        </Parallel>
                    </OnHide>
                </Animations>
            </ajaxToolkit:AutoCompleteExtender>
                
                <asp:HiddenField ID="hfVehIntId" runat="server" />
                <asp:HiddenField ID="hfVehcate" runat="server" />
                                <asp:HiddenField ID="hfKm" runat="server" />
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="right" style="vertical-align: top; width: 17%; text-align: left">
                            </td>
                            <td align="left" colspan="2" style="vertical-align: bottom; width: 75%; text-align: right">
                                <asp:Button ID="btnShow" OnClientClick="javascript:return CheckValidShow()"  runat="server" Text="Show" OnClick="btnShow_Click" /></td>
                        </tr>
                        <tr runat="server" id="DateRow"  style="background-color: white">
                            <td align="right" style="vertical-align: top; width: 17%; text-align: left">
                                <asp:Label ID="Label2" runat="server" Text="Enter Date:"></asp:Label></td>
                            <td align="left" colspan="2" style="vertical-align: bottom; width: 75%">
                                <asp:TextBox ID="txtTDMDate" runat="server" BorderStyle="Groove" Columns="6" CssClass="input" MaxLength="10"
                                Width="69px" onblur= "javascript:ValidateDate(this)"></asp:TextBox>
                                <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" 
                                        Format="dd/MM/yyyy"
                                        TargetControlID="txtTDMDate" runat="server" />
                              <%--  <asp:Image ID="img_CalendarDate" runat="server" BackColor="White" BorderColor="White"
                                    ForeColor="White" ImageUrl="~/GUI/images/calendar.jpg" />--%>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="right" colspan="3" style="width: 100%; text-align: left">
                <asp:GridView ID="gvTreadDepth" runat="server" AutoGenerateColumns="False" CellPadding="5" Width="100%" OnRowDataBound="gvTreadDepth_RowDataBound" EmptyDataText="No Record Found..." CssClass="dgRowStyle" OnRowCreated="gvTreadDepth_RowCreated">
                    <Columns>
                        <asp:BoundField DataField="TYRE_NO" HeaderText="Tyre Number" />
                        <asp:BoundField DataField="KM_RUN" HeaderText="KM. Run" />
                        <asp:BoundField DataField="POSITION" HeaderText="Position" />
                        <asp:BoundField DataField="TYRE_TREAD_DEPTH_32NDS" HeaderText="Tread Depth on purchase" />
                        <asp:BoundField DataField="MFG" HeaderText="Manufacturer" />
                        <asp:BoundField DataField="MODEL" HeaderText="Model" />
                        <asp:TemplateField HeaderText="Last Measured Tread Depth in mm- Avg TWI">
                            <ItemTemplate>
                                <asp:HiddenField ID="hfTyreNo" runat="server" Value='<%# Eval("TYRE_NO") %>'></asp:HiddenField>
                                
                                 <asp:Label ID="lblLastAvgTWI" Text='<%# Eval("AVG_TWI") %>'  runat="server"></asp:Label>
                                <asp:HiddenField ID="hfOldTDMAvg" runat="server" Value='<%# Eval("TYRE_TREAD_DEPTH_32NDS") %>' />
                                <br />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="TWI 1">
                            <ItemTemplate>
                                <asp:TextBox ID="txtTWI1" Text="0.00" CssClass="input"  onkeydown="return numeric(event)" runat="server" Width="53px" style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="TWI 2">
                            <ItemTemplate>
                                <asp:TextBox ID="txtTWI2" Text="0.00" CssClass="input"  onkeydown="return numeric(event)" runat="server" Width="53px" style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="TWI 3">
                            <ItemTemplate>
                                <asp:TextBox ID="txtTWI3" Text="0.00" CssClass="input"  onkeydown="return numeric(event)" runat="server" Width="53px" style="text-align: right"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Avg TWI">
                            <ItemTemplate>
                                <asp:TextBox ID="lblAvgTWI" Text="0.00" runat="server" Width="53px" style="text-align: right; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-style: none;"></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                       
                    </Columns>
                </asp:GridView>
                            </td>
                        </tr>
                        <tr style="background-color: white">
                            <td align="center"  colspan="3" style="width: 100%; text-align: right; height: 26px;">
                <asp:Button ID="btnSubmit" OnClientClick="javascript:return CheckValid()"  runat="server" Text="Submit" OnClick="btnSubmit_Click" Visible="False" /></td>
                        </tr>
                           <tr style="background-color: white">
                            <td align="center"  colspan="3" style="width: 100%; text-align: right; height: 26px;">
                             <center>
        <font class="blackfnt" style="color:Red;">
            <b><asp:Label ID="lbl_Page_Error" runat="server" Font-Size="Small" Text=""></asp:Label></b>
        </font>
    </center>
                            </td>
                        </tr>
                    </table>
  
</ContentTemplate>
    
    </asp:UpdatePanel>
 
</asp:Content>

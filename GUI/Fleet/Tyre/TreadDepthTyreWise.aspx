<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="TreadDepthTyreWise.aspx.cs" Inherits="TYRE1_MountTyre" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<script type="text/javascript" language="javascript" src="../../Js/Date.js"></script>
<script language="javascript" type="text/javascript" src="../../images/commonJs.js"></script>
<script language="javascript">
  
    function func()
    {

    }
    function createXMLHttpRequest()
    {
        // Mozilla, Safari,...
	    if (window.XMLHttpRequest){xmlHttpRequest=new XMLHttpRequest();if(xmlHttpRequest.overrideMimeType)xmlHttpRequest.overrideMimeType("text/xml");}
	    // IE
	    else if(window.ActiveXObject){try{xmlHttpRequest=new ActiveXObject("Msxml2.XMLHTTP");}catch(e){try{xmlHttpRequest=new ActiveXObject("Microsoft.XMLHTTP");}catch(e){}}}
    }
    function FillTreadDepth()
    {
        var currentTime = new Date()
        
        var txtTyreNo=document.getElementById("<%=txtTyreNo.ClientID %>"); 
        var txtTreadDepth=document.getElementById("<%=txtTreadDepth.ClientID %>"); 
        var txtLastAvgTWI=document.getElementById("<%=txtLastAvgTWI.ClientID %>"); 
      
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
                        txtLastAvgTWI.value = txtTreadDepth.value;
                    }
                    else
                    {
                        txtLastAvgTWI.value = returnValue[1];
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=FillTreadDepth&datetime="+currentTime+"&TyreNo=" + txtTyreNo.value, false);
            xmlHttpRequest.send(null);
        }	
    }
    
    function GetTyreDetails(txtTyreNo,txtKMRun,txtTreadDepth,txtTyrePosition,txtVehNumber,txtManufacturer,txtModel,hfTyreId,txtLastAvgTWI,hfVehId)
    {
        var currentTime = new Date()
        if(txtTyreNo.value=="")
        {
            txtTyreNo.value="";
            txtKMRun.value="";
            txtTreadDepth.value="";
            txtTyrePosition.value="";
            txtVehNumber.value="";
            txtManufacturer.value="";
            txtModel.value="";
            hfTyreId.value="";
            txtLastAvgTWI.value="";
            hfVehId.value="";
            return true;
        }
        
        createXMLHttpRequest();
        if (xmlHttpRequest)
        {
            xmlHttpRequest.onreadystatechange = function()
            {
                if (xmlHttpRequest.readyState == 4)
                {
                    var returnValue=xmlHttpRequest.responseText.split("~");
                    alert(xmlHttpRequest.responseText)
                    if (returnValue[0] == "N")
                    {
                        txtTyreNo.value="";
                        txtKMRun.value="";
                        txtTreadDepth.value="";
                        txtTyrePosition.value="";
                        txtVehNumber.value="";
                        txtManufacturer.value="";
                        txtModel.value="";
                        hfTyreId.value="";
                        txtLastAvgTWI.value="";
                        hfVehId.value="";
                        alert("Invalid Tyre Number!!!");
                        txtTyreNo.focus();
                        return false;
                    }
                    else
                    {
                        if(returnValue[11]=="Scrapped")
                        {
                            txtTyreNo.value="";
                            txtKMRun.value="";
                            txtTreadDepth.value="";
                            txtTyrePosition.value="";
                            txtVehNumber.value="";
                            txtManufacturer.value="";
                            txtModel.value="";
                            hfTyreId.value="";
                            txtLastAvgTWI.value="";
                            hfVehId.value="";
                            alert("Tyre was scrapped, hence tread depth can not be possible!!!");
                            txtTyreNo.focus();
                            return false;
                        }
                        else
                        {
                            txtTyreNo.value=returnValue[1];
                            txtKMRun.value=returnValue[2];
                            txtTreadDepth.value=returnValue[5];
                            txtTyrePosition.value=returnValue[4];
                            txtVehNumber.value=returnValue[3];
                            txtManufacturer.value=returnValue[6];
                            txtModel.value=returnValue[7];
                            hfTyreId.value=returnValue[9];
                            txtLastAvgTWI.value=returnValue[8];
                            hfVehId.value=returnValue[10];
                            FillTreadDepth();
                        }
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=GetTyreDetailsTDM&datetime="+currentTime+"&TyreNo=" + txtTyreNo.value, false);
            xmlHttpRequest.send(null);
        }	
    }
    function numeric(e) { return ((e.keyCode == 8) || (e.keyCode == 110) || (e.keyCode == 190) || (e.keyCode > 47 && e.keyCode <58)||(e.keyCode > 95 && e.keyCode <106) || (e.keyCode == 9) || (e.keyCode == 46));  }
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
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckTWI&datetime="+currentTime+"&TyreID=" + hfTyreNo.value+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }
    }     
    function CheckValid()
    {
        var date = new Date()
        date = date.getDate()+ "/" + (parseInt(date.getMonth())+ 1).toString() + "/"+ date.getFullYear();
        var controlIdPrefix = "ctl00_MyCPH1_";
        var txtTDMDate=document.getElementById(controlIdPrefix + "txtTDMDate");
        var txtTWI1="";
        var txtTWI2="";
        var txtTWI3="";
        var txtTyreNo=document.getElementById(controlIdPrefix + "txtTyreNo");
        if(txtTyreNo.value=="")
        {
            alert("Enter Tyre Number !!!");
            txtTyreNo.focus();
            return false;
        }
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
        txtTWI1=document.getElementById(controlIdPrefix + "txtTWI1");
        if(txtTWI1.value=="0.00")
        {
            alert("TWI1 value must be greater than 0 !!!");
            txtTWI1.focus();
            return false;
        }
        txtTWI2=document.getElementById(controlIdPrefix + "txtTWI2");
        if(txtTWI2.value=="0.00")
        {
            alert("TWI2 value must be greater than 0 !!!");
            txtTWI2.focus();
            return false;
        }
        txtTWI3=document.getElementById(controlIdPrefix + "txtTWI3");
        if(txtTWI3.value=="0.00")
        {
            alert("TWI3 value must be greater than 0 !!!");
            txtTWI3.focus();
            return false;
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
    
    
    
     <table border="0" class="boxbg" cellpadding="4" cellspacing="1" style="width: 600px">
         <tr bgcolor="white">
             <td colspan="4" style="height: 14px; text-align: right; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-style: none;">
                 &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/GUI/images/back.gif"
                     OnClick="ImageButton1_Click" /></td>
         </tr>
                  <tr >
                      <td style="height: 14px" colspan="4">
                          <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Tyre wise tread depth measurement</asp:Label><br />
                      </td>
                  </tr>
                  <tr bgcolor="white">
                      <td style="width: 25%;">
                          <asp:Label ID="Label1" runat="server" Text="Enter Tyre No. :"></asp:Label></td>
                      <td style="width: 20%;">
                          <asp:TextBox ID="txtTyreNo" runat="server" CssClass="input" AutoCompleteType="Office" Width="90px" ></asp:TextBox>
                          <asp:Button ID="btnPopupTyre" runat="server" Text="..." />
                          <ajaxToolkit:AutoCompleteExtender
                            runat="server" 
                            BehaviorID="AutoCompleteEx"
                            ID="autoComplete1" 
                            TargetControlID="txtTyreNo"
                            ServicePath="~/GUI/services/WebService.asmx" 
                            ServiceMethod="GetTyreNumber"
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
                      </td>
                      
                      <td style="width: 25%;">
                          <asp:Label ID="Label2" runat="server" Text="KM  Run :"></asp:Label></td>
                      <td style="width: 20%;">
                          <asp:TextBox ID="txtKMRun" runat="server" BorderStyle="None"></asp:TextBox></td>
                  </tr>
                  <tr bgcolor="white">
                      <td style="width: 25%;">
                          <asp:Label ID="Label5" runat="server" Text="Tread Depth on Purchase:"></asp:Label></td>
                      <td style="width: 20%;">
                          <asp:TextBox ID="txtTreadDepth" runat="server" BorderStyle="None"></asp:TextBox></td>
                      <td style="width: 25%;">
                          &nbsp;<asp:Label ID="Label3" runat="server" Text="Tyre Position :"></asp:Label></td>
                      <td style="width: 20%;">
                          <asp:TextBox ID="txtTyrePosition" runat="server" BorderStyle="None"></asp:TextBox></td>
                  </tr>
                  <tr bgcolor="white">
                      <td style="width: 25%;">
                          <asp:Label ID="Label4" runat="server" Text="Vehilcle Number:"></asp:Label></td>
                      <td style="width: 20%;">
                          <asp:TextBox ID="txtVehNumber" runat="server" BorderStyle="None"></asp:TextBox></td>
                      <td style="width: 25%;">
                          <asp:Label ID="Label7" runat="server" Text="Manufacturer :"></asp:Label></td>
                      <td style="width: 20%;">
                          <asp:TextBox ID="txtManufacturer" runat="server" BorderStyle="None"></asp:TextBox></td>
                  </tr>
         <tr bgcolor="white">
             <td style="width: 25%">
                 <asp:Label ID="Label6" runat="server" Text="Model :"></asp:Label></td>
             <td style="width: 20%">
                 <asp:TextBox ID="txtModel" runat="server" BorderStyle="None"></asp:TextBox></td>
             <td style="width: 25%">
                 <asp:Label ID="Label8" runat="server" Text="Last Measured Tread Depth in mm- Avg TWI:"></asp:Label></td>
             <td style="width: 20%">
                 <asp:TextBox ID="txtLastAvgTWI" runat="server" BorderStyle="None"></asp:TextBox></td>
         </tr>
         <tr bgcolor="white">
             <td style="width: 25%">
                 <asp:Label ID="Label13" runat="server" Text="Date :"></asp:Label></td>
             <td style="width: 20%">
                <asp:TextBox ID="txtTDMDate" runat="server" BorderStyle="Groove" Columns="6" CssClass="input" MaxLength="10"
                Width="69px" onblur= "javascript:ValidateDate(this)"></asp:TextBox>
                                <%-- <asp:Image ID="img_CalendarDate" runat="server" BackColor="White" BorderColor="White"
                                    ForeColor="White" ImageUrl="~/cal/cal.gif" />--%>
                 <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" 
                                        Format="dd/MM/yyyy"
                                        TargetControlID="txtTDMDate" runat="server" />
             </td>
             <td style="width: 25%">
             </td>
             <td style="width: 20%; text-align: right">
             </td>
         </tr>
         <tr bgcolor="white">
             <td style="width: 25%;">
                 <asp:Label ID="Label9" runat="server" Text="TWI 1:"></asp:Label></td>
             <td style="width: 20%;">
                 <asp:TextBox ID="txtTWI1" onkeydown="return numeric(event)"  runat="server" CssClass="input" style="text-align: right" Width="60px">0.00</asp:TextBox></td>
             <td style="width: 25%;">
             </td>
             <td style="width: 20%; text-align: right">
                 <asp:HiddenField ID="hfTyreId" runat="server" />
                 &nbsp;
             </td>
         </tr>
         <tr bgcolor="white">
             <td style="width: 25%;">
                 <asp:Label ID="Label10" runat="server" Text="TWI 2:"></asp:Label></td>
             <td style="width: 20%;">
                 <asp:TextBox ID="txtTWI2" onkeydown="return numeric(event)" runat="server" CssClass="input" style="text-align: right" Width="60px">0.00</asp:TextBox></td>
             <td style="width: 25%;">
             </td>
             <td style="width: 20%; text-align: right">
                 <asp:HiddenField ID="hfVehId" runat="server" />
                 &nbsp;
             </td>
         </tr>
         <tr bgcolor="white">
             <td style="width: 25%;">
                 <asp:Label ID="Label11" runat="server" Text="TWI 3:"></asp:Label></td>
             <td style="width: 20%;">
                 <asp:TextBox ID="txtTWI3" onkeydown="return numeric(event)" runat="server" CssClass="input" style="text-align: right"  Width="60px">0.00</asp:TextBox></td>
             <td style="width: 25%;">
             </td>
             <td style="width: 20%; text-align: right">
             </td>
         </tr>
         <tr bgcolor="white">
             <td style="width: 25%">
                 <asp:Label ID="Label12" runat="server" Text="Average TWI:"></asp:Label></td>
             <td style="width: 20%">
                 <asp:TextBox ID="txtAvgTWI" onkeydown="return numeric(event)" runat="server" style="text-align: right" Width="60px">0.00</asp:TextBox></td>
             <td style="width: 25%">
             </td>
             <td style="width: 20%; text-align: right">
             </td>
         </tr>
         <tr bgcolor="white">
             <td style="height: 15px; text-align: center;" colspan="4">
                 <asp:Button ID="btnSubmit" runat="server"  OnClientClick="javascript:return CheckValid()" OnClick="btnSubmit_Click" Text="Submit" /></td>
         </tr>
         <tr bgcolor="white">
             <td colspan="4" style="height: 15px; text-align: center">
                 <asp:Label ID="lbl_Page_Error" runat="server" ForeColor="Red"></asp:Label></td>
         </tr>
              </table>
        </ContentTemplate>
    </asp:UpdatePanel>
  
</asp:Content>

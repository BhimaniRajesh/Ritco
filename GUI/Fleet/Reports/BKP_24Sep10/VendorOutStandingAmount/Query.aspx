<%@ Page Language="C#" MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="Query.aspx.cs" Inherits="GUI_Fleet_Reports_OutStanding_Amount_Query" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MyCPH1" runat="Server">
<%@ Register Assembly="AtlasControlToolkit" Namespace="AtlasControlToolkit" TagPrefix="cc1" %>

 <script language="javascript" type="text/javascript" src="../../../images/calendar.jpg"> </script>
<script language="javascript" type="text/javascript" src="../../../images/commonJs.js"></script>
<script language="javascript" type="text/javascript" src="../../../images/CalendarPopup.js"></script>


<script language="javascript" type="text/javascript">
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
function CheckData()
	{
	    
	    var ddlBusinessDiv =  document.getElementById("ctl00_MyCPH1_ddlBusinessDiv");
        var txtVoucherDate = document.getElementById("ctl00_MyCPH1_txtVoucherDate");
         if(txtVoucherDate.value == "")
        {
            alert("Please Enter Voucher Date");
            return false;
        }
        if(ddlBusinessDiv.value == "-1")
	    {
	        alert("Please Selet Business Division");
	        ddlBusinessDiv.focus();
	        return false;
	    }   
 }

               var client_name="<%=Session["client_name"]%>"
        FRM_Name="ctl00_MyCPH1_"
        function OnSubmit()
        { 
        
                                 if(document.getElementById(FRM_Name+'txtVendor').value=="")
                                {
                                        alert("Plz Select Enter Vendor Name~Code Format")
                                        document.getElementById(FRM_Name+'txtVendor').focus();
                                        return false;
                                }
				                
                                var Search_Char="~"
		                        if (document.getElementById(FRM_Name+'txtVendor').value.indexOf(Search_Char)==-1)
		                        {
		                           alert("Invalid Vendor Name~Code Format");
		                           document.getElementById(FRM_Name+'txtVendor').focus();
		                           return false
		                        } 
		                  }	
		                          </script>
   <div id="testdiv1" style="position: absolute; visibility: hidden; background-color: white;
        layer-background-color: white; z-index: 99;">
    </div>

<%--<asp:UpdateProgress ID="uppMain" runat="server">
<ProgressTemplate>
    <iframe frameborder="0" src="about:blank"
        style="border:0px;position:absolute;z-index:9;left:0px;top:0px;width:expression(this.offsetParent.scrollWidth);height:expression(this.offsetParent.scrollHeight);filter:progid:DXImageTransform.Microsoft.Alpha(Opacity=75, FinishOpacity=0, Style=0, StartX=0, FinishX=100, StartY=0, FinishY=100);"></iframe>
        <div style="position:absolute;z-index:10;left:expression((this.offsetParent.clientWidth/2)-(this.clientWidth/2)+this.offsetParent.scrollLeft);top:expression((this.offsetParent.clientHeight/2)-(this.clientHeight/2)+this.offsetParent.scrollTop);"><img src="../../images/loading.gif" /><font face=verdana color=blue size=4>&nbsp;<b>Please Wait...</b></font></div>
</ProgressTemplate>
</asp:UpdateProgress>--%>
     <table cellspacing="1" style="width: 100%">
        <tr style="background-color: white">
    <td align="left">
                <asp:Label ID="lblPageHead" CssClass="blackfnt" Font-Bold="True" runat="server">Fleet Module  > Reports >Vendor OutStanding Bill</asp:Label>
            </td> 
            
             <td align="right">

          </td>      
        </tr>
    </table>
        <hr align="center" size="1" color="#8ba0e5">
      <br> 
       
               
         <table cellspacing="1" cellpadding="2" style="width: 75%" class="boxbg">
                        <tr class="bgbluegrey">
                            <td colspan="6" align="center">
                                <asp:Label ID="Label4" CssClass="blackfnt" Font-Bold="true" runat="server">Search Criteria</asp:Label>
                            </td>
                        </tr>
                        
                          <tr style="background-color: white">
                        <td align="Left" valign="center" width="24%">
                         <asp:Label ID="Label2" runat="server" CssClass="blackfnt" Font-Bold="True">Bill Date:</asp:Label></td>
                         <td align="left" colspan="5" width="76%" >
                         <asp:HiddenField ID="hfFinancialYr" runat="server" />
                           <asp:TextBox ID="txtDate" Enabled="true" runat="server" 
                            Width="80px" BorderStyle="Groove" CssClass="input" MaxLength="10"></asp:TextBox> 
                        <a href="#" onclick="cal.select(ctl00$MyCPH1$txtDate,'anchor1','dd/MM/yyyy'); return false;"
                            id="anchor1" name="anchor1"> <img alt="Cal" border="0" src="../../../images/calendar.jpg" /></a>
                        </td>
                    </tr>       
        
               <tr style="background-color: White"> 
               <td align="right" style="vertical-align: top; width: 17%; text-align: left">
                <asp:Label ID="Label3" runat="server" CssClass="blackfnt" Font-Bold="True">Vendor Name:</asp:Label></td>
                 <td align="left" colspan="5" width="76%" >
                    <asp:TextBox ID="txtVendor" runat="server" CssClass="blackfnt" BorderStyle="Groove" onblur="return checkVendorCode(this.getAttribute('id'));"
                        Width="270px"></asp:TextBox>
                    <div class="blackfnt">
                       <%-- <ajaxtoolkit:autocompleteextender id="extLocation" runat="server" enabled="True"
                                    completionlistitemcssclass="autocomplete_listItem" completionlisthighlighteditemcssclass="autocomplete_highlightedListItem"
                                    minimumprefixlength="1" servicemethod="GetVendor" servicepath="../AtlasAutoComplete.asmx"
                                    targetcontrolid="txtVendor">
                                </ajaxtoolkit:autocompleteextender>--%>
                                
                                <ajaxToolkit:AutoCompleteExtender
                                    runat="server"
                                    BehaviorID="AutoCompleteEx2"
                                    ID="autoComplete5"
                                    TargetControlID="txtVendor"
                                    ServicePath="~/services/FleetAutoComplet.asmx"
                                    ServiceMethod="GetVendorName"
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
                                    var behavior = $find('AutoCompleteEx2');
                                    if (!behavior._height) {
                                    var target = behavior.get_completionList();
                                    behavior._height = target.offsetHeight - 2;
                                    target.style.height = '0px';
                                    }" />

                                    <%-- Expand from 0px to the appropriate size while fading in --%>
                                    <Parallel Duration=".4">
                                    <FadeIn />
                                    <Length PropertyKey="height" StartValue="0" EndValueScript="$find('AutoCompleteEx2')._height" />
                                    </Parallel>
                                    </Sequence>
                                    </OnShow>
                                    <OnHide>
                                    <%-- Collapse down to 0px and fade out --%>
                                    <Parallel Duration=".4">
                                    <FadeOut />
                                    <Length PropertyKey="height" StartValueScript="$find('AutoCompleteEx2')._height" EndValue="0" />
                                    </Parallel>
                                    </OnHide>
                                    </Animations>
                                    </ajaxToolkit:AutoCompleteExtender>

                                 
                                <font class="redfnt">Plz Type Initial Character OF Vendor Name </font>
                    </div>
                    </td>
                    </tr>
              
                 <tr style="background-color: white">
               <td align="right" style="vertical-align: top; width: 17%; text-align: left">
                   <asp:Label ID="Label1" runat="server" CssClass="blackfnt" Font-Bold="True">Select Bill Type:</asp:Label></td>
               <td align="left" colspan="5" style="width: 76%">
                   <asp:DropDownList ID="ddlBillType"  runat="server" Font-Names="Verdana" Font-Size="8pt"
                       Width="146px" AutoPostBack="True" >
                   </asp:DropDownList></td>
             
           </tr>
            <tr style="background-color: white">
                            <td align="center" colspan="6">
                             <asp:UpdatePanel ID="UpdatePanel3" UpdateMode="Conditional" RenderMode="Inline" 
                    runat="server">
                <ContentTemplate>
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClientClick="Javascript:return OnSub_DATACHECK();"
                                    OnClick="btnSubmit_OnClick" Width="75px" />
                             </ContentTemplate>
            </asp:UpdatePanel>
                            </td>
                        </tr>
                        
                    </table>
              
         <div id="Div1" style="position: absolute; visibility: hidden; background-color: white; layer-background-color: white; z-index: 99;">
    </div>        
                    </asp:Content>
<%@ Page Language="C#"  MasterPageFile="~/GUI/MasterPage.master"   AutoEventWireup="true" CodeFile="Warranty.aspx.cs" Inherits="Tyre_Warranty" %>

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
    function checkTyreNo(txtTyreNo)
    {
        var qTyreid = "undefined";
    
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        
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
                       txtTyreNo.value=txtTyreNo.value;
                    }
                    else
                    {
                        alert("Tyre No is Already Exist !");
                        txtTyreNo.value="";
                        txtTyreNo.focus();
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=CheckValidTyreNo&datetime="+currentTime+"&TyreNo=" + txtTyreNo.value+"&TyreId="+qTyreid+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }	
    }
    function GetTyreDetails(txtTyreNo,hfTyreId,txtManufacturer,txtPurchasePrice,txtKMRun,txtModel,txtTreadDepth,hfVehId,txtTotalCost)
    {
        var currentTime = new Date()
        var ConnStr="<%= Session["SqlProvider"] %>";
        if(txtTyreNo.value=="")
        {
            txtTyreNo.value="";
            hfTyreId.value="";
            txtManufacturer.value="";
            txtPurchasePrice.value="";
            txtKMRun.value="";
            txtModel.value="";
            txtTreadDepth.value="";
            hfVehId.value="";
            txtTotalCost.value="";
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
                    if (returnValue[0] == "N")
                    {
                        txtTyreNo.value="";
                        hfTyreId.value="";
                        txtManufacturer.value="";
                        txtPurchasePrice.value="";
                        txtKMRun.value="";
                        txtModel.value="";
                        txtTreadDepth.value="";
                        hfVehId.value="";
                        txtTotalCost.value="";
                        alert("Invalid Tyre Number!!!");
                    }
                    else
                    {
                        txtTyreNo.value=returnValue[1];
                        hfTyreId.value=returnValue[2];
                        txtManufacturer.value=returnValue[3];
                        txtPurchasePrice.value=returnValue[4];
                        txtKMRun.value=returnValue[5];
                        txtModel.value=returnValue[6];
                        txtTreadDepth.value=returnValue[7];
                        hfVehId.value=returnValue[8];
                        txtTotalCost.value=returnValue[9];
                    }
                }
            }
            xmlHttpRequest.open("GET", "wfrm_AJAX_Validator.aspx?Function=GetTyreDetailsWarranty&datetime="+currentTime+"&TyreNo=" + txtTyreNo.value+"&ConnStr="+ConnStr, false);
            xmlHttpRequest.send(null);
        }	
    }
    function numeric(e) { return ((e.keyCode == 8) || (e.keyCode > 47 && e.keyCode <58)||(e.keyCode > 95 && e.keyCode <106) || (e.keyCode == 9) || (e.keyCode == 46));  }
    function CheckValid()
    {
        var date = new Date()
        date = date.getDate()+ "/" + (parseInt(date.getMonth())+ 1).toString() + "/"+ date.getFullYear();
        var controlIdPrefix = "ctl00_MyCPH1_";
        
        var txtWarrantyDate=document.getElementById(controlIdPrefix + "txtWarrantyDate");

        var txtTyreNo=document.getElementById(controlIdPrefix + "txtTyreNo");
        if(txtTyreNo.value=="")
        {
            alert("Enter Tyre Number !!!");
            txtTyreNo.focus();
            return false;
        }
        var txtUsedCost=document.getElementById(controlIdPrefix + "txtUsedCost");
        if(txtUsedCost.value == "0")
        {
            alert("Enter Used Cost !!!");
            txtUsedCost.focus();
            return false;
        }
        if(txtWarrantyDate.value == "")
        {
            alert("Enter Warranty Date !!!");
            txtWarrantyDate.focus();
            return false;
        }
        else
        {
            if(!isDate(txtWarrantyDate.value,"dd/mm/yyyy"))
            {
                alert("Please Enter Valid date !!!");
                txtWarrantyDate.value="";
                txtWarrantyDate.focus();
                return false;
            }
            else
            {
                if(compareDates(date,"d/m/yyyy",txtWarrantyDate.value,"dd/mm/yyyy") == "1")
                {
                    alert("Warranty date should be greater than today date !!!");
                    txtWarrantyDate.focus();
                    return false;
                }
            }
        }
        txtWarrantyKM=document.getElementById(controlIdPrefix + "txtWarrantyKM");
        if(txtWarrantyKM.value=="0")
        {
            alert("Enter Warranty KM !!!");
            txtWarrantyKM.focus();
            return false;
        }
        txtClaimWarrantyDate=document.getElementById(controlIdPrefix + "txtClaimWarrantyDate");
        if(txtClaimWarrantyDate.value == "")
        {
            alert("Enter Claiming Warranty Date !!!");
            txtClaimWarrantyDate.focus();
            return false;
        }
        else
        {
            if(!isDate(txtClaimWarrantyDate.value,"dd/mm/yyyy"))
            {
                alert("Please Enter Valid date !!!");
                txtClaimWarrantyDate.value="";
                txtClaimWarrantyDate.focus();
                return false;
            }
            else
            {
                if(compareDates(date,"d/m/yyyy",txtClaimWarrantyDate.value,"dd/mm/yyyy") == "1")
                {
                    alert("Claiming Warranty date should be greater than today date !!!");
                    txtClaimWarrantyDate.focus();
                    return false;
                }
            }
        }
        txtReplaceTyreNo=document.getElementById(controlIdPrefix + "txtReplaceTyreNo");
        if(txtReplaceTyreNo.value=="")
        {
            alert("Enter Tyre No !!!");
            txtReplaceTyreNo.focus();
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
             <td colspan="3" style="height: 14px; text-align: right; border-top-style: none; border-right-style: none; border-left-style: none; border-bottom-style: none;">
                 &nbsp;</td>
         </tr>
                  <tr >
                      <td style="height: 14px" colspan="3">
                          <asp:Label ID="lblPageHead" runat="server" CssClass="blackfnt" Font-Bold="True">Tyre Warranty Module</asp:Label><br />
                      </td>
                  </tr>
                  <tr bgcolor="white">
                      <td style="width: 25%;">
                          <asp:Label ID="Label1" runat="server" Text="Enter Tyre No. :"></asp:Label></td>
                      <td style="width: 40%;">
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
                      
                      <td style="width: 35%;">
                 <asp:HiddenField ID="hfTyreId" runat="server" />
                 <asp:HiddenField ID="hfVehId" runat="server" />
                          </td>
                  </tr>
         <tr bgcolor="white">
             <td style="width: 25%">
                          <asp:Label ID="Label7" runat="server" Text="Manufacturer :"></asp:Label></td>
             <td style="width: 40%">
                          <asp:TextBox ID="txtManufacturer" runat="server" BorderStyle="None"></asp:TextBox></td>
             <td style="width: 35%">
             </td>
         </tr>
         <tr bgcolor="white">
             <td style="width: 25%">
                 <asp:Label ID="Label6" runat="server" Text="Model :"></asp:Label></td>
             <td style="width: 40%">
                 <asp:TextBox ID="txtModel" runat="server" BorderStyle="None"></asp:TextBox></td>
             <td style="width: 35%">
             </td>
         </tr>
         <tr bgcolor="white">
             <td style="width: 25%">
                 <asp:Label ID="Label13" runat="server" Text="Purchase Price:"></asp:Label></td>
             <td style="width: 40%">
                 <asp:TextBox ID="txtPurchasePrice" runat="server" BorderStyle="None"></asp:TextBox></td>
             <td style="width: 35%">
             </td>
         </tr>
                  <tr bgcolor="white">
                      <td style="width: 25%;">
                          <asp:Label ID="Label2" runat="server" Text="Current KM Run :"></asp:Label></td>
                      <td style="width: 40%;">
                          <asp:TextBox ID="txtKMRun" runat="server" BorderStyle="None"></asp:TextBox></td>
                      <td style="width: 35%;">
                          </td>
                  </tr>
         <tr bgcolor="white">
             <td style="width: 25%">
                          <asp:Label ID="Label3" runat="server" Text="Cost:"></asp:Label></td>
             <td style="width: 40%">
                 <asp:TextBox ID="txtTotalCost" runat="server" BorderStyle="None"></asp:TextBox></td>
             <td style="width: 35%">
                 &nbsp;</td>
         </tr>
         <tr bgcolor="white">
             <td style="width: 25%">
                 <asp:Label ID="Label5" runat="server" Text="Last Tread Depth Reading :" Width="178px"></asp:Label></td>
             <td style="width: 40%">
                          <asp:TextBox ID="txtTreadDepth" runat="server" BorderStyle="None"></asp:TextBox></td>
             <td style="width: 35%">
                 &nbsp;</td>
         </tr>
         <tr bgcolor="white">
             <td style="width: 25%;">
                 <asp:Label ID="Label9" runat="server" Text="Used Cost Equivalent :"></asp:Label></td>
             <td style="width: 40%;">
                 <asp:TextBox ID="txtUsedCost" onkeydown="return numeric(event)"  runat="server" CssClass="input" style="text-align: right" Width="60px">0</asp:TextBox></td>
             <td style="width: 35%;">
             </td>
         </tr>
         <tr bgcolor="white">
             <td style="width: 25%;">
                 <asp:Label ID="Label10" runat="server" Text="Warranty Date :"></asp:Label></td>
             <td style="width: 40%;">
             <asp:TextBox ID="txtWarrantyDate" runat="server" BorderStyle="Groove" Columns="6" CssClass="input" MaxLength="10"
             Width="69px" onblur= "javascript:ValidateDate(this)"></asp:TextBox>
                <%--<asp:Image id="img_CalendarDate" runat="server" ImageUrl="~/cal/cal.gif" BackColor="White" BorderColor="White" ForeColor="White"></asp:Image></td>--%>
                <ajaxToolkit:CalendarExtender ID="calExtenderStatrtDt" 
                                        Format="dd/MM/yyyy"
                                        TargetControlID="txtWarrantyDate" runat="server" />
             <td style="width: 35%;">
                 
             </td>
         </tr>
         <tr bgcolor="white">
             <td style="width: 25%;">
                 <asp:Label ID="Label11" runat="server" Text="Warranty Km. :"></asp:Label></td>
             <td style="width: 40%;">
                 <asp:TextBox ID="txtWarrantyKM" onkeydown="return numeric(event)" runat="server" CssClass="input" style="text-align: right"  Width="60px">0</asp:TextBox></td>
             <td style="width: 35%;">
             </td>
         </tr>
         <tr bgcolor="white">
             <td style="width: 25%;">
                 <asp:Label ID="Label12" runat="server" Text="Date of Claiming Warranty :"></asp:Label></td>
             <td style="width: 40%;">
                 <asp:TextBox ID="txtClaimWarrantyDate" runat="server" BorderStyle="Groove" Columns="6" CssClass="input" MaxLength="10"
                 Width="69px" onblur= "javascript:ValidateDate(this)"></asp:TextBox>&nbsp;
                 <%--<asp:Image ID="img_Calendar" runat="server" BackColor="White" BorderColor="White" ForeColor="White"
                     ImageUrl="~/cal/cal.gif" />--%>
                 <ajaxToolkit:CalendarExtender ID="CalendarExtender1" 
                                        Format="dd/MM/yyyy"
                                        TargetControlID="txtClaimWarrantyDate" runat="server" />
                     </td>
             <td style="width: 35%;">
             </td>
         </tr>
         <tr bgcolor="white">
             <td style="width: 25%; height: 24px;">
                 <asp:Label ID="Label4" runat="server" Text="Replacement Tyre Serial No : " Width="184px"></asp:Label>
             </td>
             <td style="width: 40%; height: 24px;">
                 <asp:TextBox ID="txtReplaceTyreNo" runat="server" CssClass="input" Width="128px"></asp:TextBox></td>
             <td style="width: 35%; height: 24px;">
             </td>
         </tr>
         <tr bgcolor="white">
             <td style="height: 15px; text-align: center;" colspan="3">
                 <asp:Button ID="btnSubmit" runat="server" OnClientClick="javascript:return CheckValid()"  OnClick="btnSubmit_Click" Text="Submit" /></td>
         </tr>
         <tr bgcolor="white">
             <td colspan="3" style="height: 15px; text-align: center">
                 <asp:Label ID="lbl_Page_Error" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label></td>
         </tr>
              </table>
        </ContentTemplate>
    </asp:UpdatePanel>
  
</asp:Content>
